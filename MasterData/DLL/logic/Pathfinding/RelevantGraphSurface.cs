using UnityEngine;

namespace Pathfinding;

[HelpURL("http://arongranberg.com/astar/docs/class_pathfinding_1_1_relevant_graph_surface.php")]
[AddComponentMenu("Pathfinding/Navmesh/RelevantGraphSurface")]
public class RelevantGraphSurface : VersionedMonoBehaviour
{
	private static RelevantGraphSurface root;

	public float maxRange = 1f;

	private RelevantGraphSurface prev;

	private RelevantGraphSurface next;

	private Vector3 position;

	public Vector3 Position
	{
		get
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return position;
		}
	}

	public RelevantGraphSurface Next => next;

	public RelevantGraphSurface Prev => prev;

	public static RelevantGraphSurface Root => root;

	public void UpdatePosition()
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		position = ((Component)this).transform.position;
	}

	private void OnEnable()
	{
		UpdatePosition();
		if ((Object)(object)root == (Object)null)
		{
			root = this;
			return;
		}
		next = root;
		root.prev = this;
		root = this;
	}

	private void OnDisable()
	{
		if ((Object)(object)root == (Object)(object)this)
		{
			root = next;
			if ((Object)(object)root != (Object)null)
			{
				root.prev = null;
			}
		}
		else
		{
			if ((Object)(object)prev != (Object)null)
			{
				prev.next = next;
			}
			if ((Object)(object)next != (Object)null)
			{
				next.prev = prev;
			}
		}
		prev = null;
		next = null;
	}

	public static void UpdateAllPositions()
	{
		RelevantGraphSurface relevantGraphSurface = root;
		while ((Object)(object)relevantGraphSurface != (Object)null)
		{
			relevantGraphSurface.UpdatePosition();
			relevantGraphSurface = relevantGraphSurface.Next;
		}
	}

	public static void FindAllGraphSurfaces()
	{
		RelevantGraphSurface[] array = Object.FindObjectsOfType(typeof(RelevantGraphSurface)) as RelevantGraphSurface[];
		for (int i = 0; i < array.Length; i++)
		{
			array[i].OnDisable();
			array[i].OnEnable();
		}
	}

	public void OnDrawGizmos()
	{
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_0034: Unknown result type (might be due to invalid IL or missing references)
		//IL_0039: Unknown result type (might be due to invalid IL or missing references)
		//IL_0044: Unknown result type (might be due to invalid IL or missing references)
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		//IL_0059: Unknown result type (might be due to invalid IL or missing references)
		Gizmos.color = new Color(19f / 85f, 0.827451f, 0.18039216f, 0.4f);
		Gizmos.DrawLine(((Component)this).transform.position - Vector3.up * maxRange, ((Component)this).transform.position + Vector3.up * maxRange);
	}

	public void OnDrawGizmosSelected()
	{
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		//IL_002f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0034: Unknown result type (might be due to invalid IL or missing references)
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0044: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		Gizmos.color = new Color(19f / 85f, 0.827451f, 0.18039216f);
		Gizmos.DrawLine(((Component)this).transform.position - Vector3.up * maxRange, ((Component)this).transform.position + Vector3.up * maxRange);
	}
}
