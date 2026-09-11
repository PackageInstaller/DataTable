using System;
using System.Collections.Generic;
using System.Linq;
using Pathfinding;
using Sirenix.OdinInspector;
using UnityEngine;

namespace P08.SimBusiness.Pathfinding;

[AddComponentMenu("P08_Pathfinding/PathfindingSeeker")]
public class PathfindingSeeker : SerializedMonoBehaviour
{
	public enum ModifierPass
	{
		PreProcess = 0,
		PostProcess = 2
	}

	public bool drawGizmos = true;

	public bool detailedGizmos;

	[HideInInspector]
	public StartEndModifier startEndModifier = new StartEndModifier();

	[HideInInspector]
	public int traversableTags = -1;

	[HideInInspector]
	public int[] tagPenalties = new int[32];

	[HideInInspector]
	public int graphMask = -1;

	public OnPathDelegate pathCallback;

	public OnPathDelegate preProcessPath;

	public OnPathDelegate postProcessPath;

	[NonSerialized]
	private List<Vector3> lastCompletedVectorPath;

	[NonSerialized]
	private List<GraphNode> lastCompletedNodePath;

	[NonSerialized]
	protected Path path;

	[NonSerialized]
	private Path prevPath;

	private readonly OnPathDelegate onPathDelegate;

	private readonly OnPathDelegate onPartialPathDelegate;

	private OnPathDelegate tmpPathCallback;

	protected uint lastPathID;

	private readonly List<IPathModifier> modifiers = new List<IPathModifier>();

	public PathfindingSeeker()
	{
		onPathDelegate = OnPathComplete;
		onPartialPathDelegate = OnPartialPathComplete;
	}

	private void Awake()
	{
		startEndModifier.Awake(this);
	}

	public Path GetCurrentPath()
	{
		return path;
	}

	public void CancelCurrentPathRequest(bool pool = true)
	{
		if (!IsDone())
		{
			path.LogError("Canceled by script (Seeker.CancelCurrentPathRequest)");
			if (pool)
			{
				path.Claim(path);
				path.Release(path);
			}
		}
	}

	public void OnDestroy()
	{
		ReleaseClaimedPath();
		startEndModifier.OnDestroy(this);
	}

	public void ReleaseClaimedPath()
	{
		if (prevPath != null)
		{
			prevPath.Release(this, silent: true);
			prevPath = null;
		}
	}

	public void RegisterModifier(IPathModifier modifier)
	{
		modifiers.Add(modifier);
		modifiers.Sort((IPathModifier a, IPathModifier b) => a.Order.CompareTo(b.Order));
	}

	public void DeregisterModifier(IPathModifier modifier)
	{
		modifiers.Remove(modifier);
	}

	public void PostProcess(Path path)
	{
		RunModifiers(ModifierPass.PostProcess, path);
	}

	public void RunModifiers(ModifierPass pass, Path path)
	{
		switch (pass)
		{
		case ModifierPass.PreProcess:
		{
			if (preProcessPath != null)
			{
				preProcessPath(path);
			}
			for (int j = 0; j < modifiers.Count; j++)
			{
				modifiers[j].PreProcess(path);
			}
			break;
		}
		case ModifierPass.PostProcess:
		{
			if (postProcessPath != null)
			{
				postProcessPath(path);
			}
			for (int i = 0; i < modifiers.Count; i++)
			{
				modifiers[i].Apply(path);
			}
			break;
		}
		}
	}

	public bool IsDone()
	{
		if (path != null)
		{
			return path.PipelineState >= PathState.Returned;
		}
		return true;
	}

	private void OnPathComplete(Path path)
	{
		OnPathComplete(path, runModifiers: true, sendCallbacks: true);
	}

	private void OnPathComplete(Path p, bool runModifiers, bool sendCallbacks)
	{
		if (((p != null && p != path) & sendCallbacks) || this == null || p == null || p != path)
		{
			return;
		}
		if (!path.error & runModifiers)
		{
			RunModifiers(ModifierPass.PostProcess, path);
		}
		if (sendCallbacks)
		{
			p.Claim(this);
			lastCompletedNodePath = p.path;
			lastCompletedVectorPath = p.vectorPath;
			if (tmpPathCallback != null)
			{
				tmpPathCallback(p);
			}
			if (pathCallback != null)
			{
				pathCallback(p);
			}
			if (prevPath != null)
			{
				prevPath.Release(this, silent: true);
			}
			prevPath = p;
			if (!drawGizmos)
			{
				ReleaseClaimedPath();
			}
		}
	}

	private void OnPartialPathComplete(Path p)
	{
		OnPathComplete(p, runModifiers: true, sendCallbacks: false);
	}

	private void OnMultiPathComplete(Path p)
	{
		OnPathComplete(p, runModifiers: false, sendCallbacks: true);
	}

	public Path StartPath(Vector3 start, Vector3 end)
	{
		return StartPath(start, end, null);
	}

	public Path StartPath(Vector3 start, Vector3 end, OnPathDelegate callback)
	{
		return StartPath(ABPath.Construct((Int3)start, (Int3)end), callback);
	}

	public Path StartPath(Vector3 start, Vector3 end, OnPathDelegate callback, int graphMask)
	{
		return StartPath(ABPath.Construct((Int3)start, (Int3)end), callback, graphMask);
	}

	public Path StartPath(Path p, OnPathDelegate callback = null)
	{
		if (p.nnConstraint.graphMask == -1)
		{
			p.nnConstraint.graphMask = graphMask;
		}
		StartPathInternal(p, callback);
		return p;
	}

	public Path StartPath(Path p, OnPathDelegate callback, int graphMask)
	{
		p.nnConstraint.graphMask = graphMask;
		StartPathInternal(p, callback);
		return p;
	}

	private void StartPathInternal(Path p, OnPathDelegate callback)
	{
		if (p is MultiTargetPath multiTargetPath)
		{
			OnPathDelegate[] array = new OnPathDelegate[multiTargetPath.targetPoints.Length];
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = onPartialPathDelegate;
			}
			multiTargetPath.callbacks = array;
			p.callback = (OnPathDelegate)Delegate.Combine(p.callback, new OnPathDelegate(OnMultiPathComplete));
		}
		else
		{
			p.callback = (OnPathDelegate)Delegate.Combine(p.callback, onPathDelegate);
		}
		p.enabledTags = traversableTags;
		p.tagPenalties = tagPenalties;
		if (path != null && path.PipelineState <= PathState.Processing && path.CompleteState != PathCompleteState.Error)
		{
			path.LogError("Canceled path because a new one was requested.\nThis happens when a new path is requested from the seeker when one was already being calculated.\nFor example if a unit got a new order, you might request a new path directly instead of waiting for the now invalid path to be calculated. Which is probably what you want.\nIf you are getting this a lot, you might want to consider how you are scheduling path requests.");
		}
		path = p;
		tmpPathCallback = callback;
		RunModifiers(ModifierPass.PreProcess, path);
		AstarPath.StartPath(path);
	}

	public MultiTargetPath StartMultiTargetPath(Vector3 start, Vector3[] endPoints, bool pathsForAll, OnPathDelegate callback = null, int graphMask = -1)
	{
		MultiTargetPath multiTargetPath = MultiTargetPath.Construct((Int3)start, endPoints.Select((Vector3 v) => (Int3)v).ToArray(), null);
		multiTargetPath.pathsForAll = pathsForAll;
		StartPath(multiTargetPath, callback, graphMask);
		return multiTargetPath;
	}

	public MultiTargetPath StartMultiTargetPath(Vector3[] startPoints, Vector3 end, bool pathsForAll, OnPathDelegate callback = null, int graphMask = -1)
	{
		MultiTargetPath multiTargetPath = MultiTargetPath.Construct(startPoints.Select((Vector3 v) => (Int3)v).ToArray(), (Int3)end, null);
		multiTargetPath.pathsForAll = pathsForAll;
		StartPath(multiTargetPath, callback, graphMask);
		return multiTargetPath;
	}

	public void OnDrawGizmos()
	{
		if (lastCompletedNodePath == null || !drawGizmos)
		{
			return;
		}
		if (detailedGizmos)
		{
			Gizmos.color = new Color(0.7f, 0.5f, 0.1f, 0.5f);
			if (lastCompletedNodePath != null)
			{
				for (int i = 0; i < lastCompletedNodePath.Count - 1; i++)
				{
					Gizmos.DrawLine((Vector3)lastCompletedNodePath[i].position, (Vector3)lastCompletedNodePath[i + 1].position);
				}
			}
		}
		Gizmos.color = new Color(0f, 1f, 0f, 1f);
		if (lastCompletedVectorPath != null)
		{
			for (int j = 0; j < lastCompletedVectorPath.Count - 1; j++)
			{
				Gizmos.DrawLine(lastCompletedVectorPath[j], lastCompletedVectorPath[j + 1]);
			}
		}
	}
}
