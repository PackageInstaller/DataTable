using System;
using UnityEngine;

namespace PathFinding2D.Components;

public class GizmoHelper : MonoBehaviour
{
	private static GizmoHelper instance;

	public Action drawGizmosCallback;

	public static GizmoHelper Instance => Get();

	private static GizmoHelper Get()
	{
		if (instance == null)
		{
			GizmoHelper gizmoHelper = UnityEngine.Object.FindObjectOfType<GizmoHelper>();
			if ((object)gizmoHelper != null)
			{
				instance = gizmoHelper;
			}
			else
			{
				GameObject gameObject = new GameObject("(Won't Save) Navigation: GizmoHelper");
				instance = gameObject.AddComponent<GizmoHelper>();
				gameObject.hideFlags = HideFlags.HideInInspector | HideFlags.DontSaveInEditor | HideFlags.DontSaveInBuild;
			}
		}
		return instance;
	}

	public static void Remove()
	{
		UnityEngine.Object.DestroyImmediate(instance.gameObject);
	}
}
