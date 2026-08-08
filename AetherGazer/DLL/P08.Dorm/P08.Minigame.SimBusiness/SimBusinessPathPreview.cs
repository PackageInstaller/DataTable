using System;
using System.Collections.Generic;
using Pathfinding;
using Sirenix.OdinInspector;
using UnityEngine;

namespace P08.Minigame.SimBusiness;

public class SimBusinessPathPreview : SerializedMonoBehaviour
{
	public Transform destination;

	public LineRenderer lineRenderer;

	private void OnEnable()
	{
		AstarPath.OnGraphsUpdated = (OnScanDelegate)Delegate.Combine(AstarPath.OnGraphsUpdated, new OnScanDelegate(RefreshPathPreview));
	}

	private void OnDisable()
	{
		AstarPath.OnGraphsUpdated = (OnScanDelegate)Delegate.Remove(AstarPath.OnGraphsUpdated, new OnScanDelegate(RefreshPathPreview));
	}

	private void RefreshPathPreview(AstarPath astar)
	{
		if (!(destination == null))
		{
			SimBusinessMgr.CalcPreviewPathToTarget(astar, base.transform.position, destination, OnPreviewPathFind);
		}
	}

	private void OnPreviewPathFind()
	{
		List<Vector3> previewPathPoints = SimBusinessMgr.instance.previewPathPoints;
		if (previewPathPoints != null)
		{
			lineRenderer.enabled = true;
			lineRenderer.positionCount = previewPathPoints.Count;
			lineRenderer.SetPositions(previewPathPoints.ToArray());
		}
		else
		{
			lineRenderer.enabled = false;
			lineRenderer.positionCount = 0;
		}
	}
}
