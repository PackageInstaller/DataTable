using System;
using UnityEngine;
using UnityEngine.Rendering;

[DisallowMultipleComponent]
[RequireComponent(typeof(Collider2D))]
public class SummerRaceColliderOutline : MonoBehaviour
{
	private static Material sharedLineMaterial;

	[SerializeField]
	private Color lineColor = new Color(0.15f, 1f, 0.55f, 0.9f);

	[SerializeField]
	[Range(0.002f, 0.08f)]
	private float lineWidth = 0.02f;

	[SerializeField]
	[Range(8f, 48f)]
	private int circleSegments = 20;

	[SerializeField]
	private int sortingOrder = 180;

	[SerializeField]
	private bool drawDebugLinesInPlay = true;

	private Collider2D targetCollider;

	private LineRenderer line;

	private Vector3[] pointCache;

	public static SummerRaceColliderOutline Ensure(GameObject target, Color color, float width = 0.02f, int order = 180)
	{
		if (target == null)
		{
			return null;
		}
		if (target.GetComponent<Collider2D>() == null)
		{
			return null;
		}
		SummerRaceColliderOutline summerRaceColliderOutline = target.GetComponent<SummerRaceColliderOutline>();
		if (summerRaceColliderOutline == null)
		{
			summerRaceColliderOutline = target.AddComponent<SummerRaceColliderOutline>();
		}
		summerRaceColliderOutline.lineColor = color;
		summerRaceColliderOutline.lineWidth = Mathf.Clamp(width, 0.002f, 0.08f);
		summerRaceColliderOutline.sortingOrder = order;
		summerRaceColliderOutline.RefreshImmediately();
		return summerRaceColliderOutline;
	}

	private void Awake()
	{
		EnsureRefs();
	}

	private void OnEnable()
	{
		RefreshImmediately();
	}

	private void LateUpdate()
	{
		RefreshShape();
	}

	public void RefreshImmediately()
	{
		EnsureRefs();
		RefreshShape();
	}

	private void EnsureRefs()
	{
		if (targetCollider == null)
		{
			targetCollider = GetComponent<Collider2D>();
		}
		if (line != null)
		{
			line.startColor = lineColor;
			line.endColor = lineColor;
			line.startWidth = lineWidth;
			line.endWidth = lineWidth;
			line.sortingOrder = sortingOrder;
			return;
		}
		line = GetComponent<LineRenderer>();
		if (line == null)
		{
			line = base.gameObject.AddComponent<LineRenderer>();
		}
		if (sharedLineMaterial == null)
		{
			Shader shader = Shader.Find("Sprites/Default");
			if (shader != null)
			{
				sharedLineMaterial = new Material(shader)
				{
					name = "SummerRace_ColliderOutlineMat"
				};
			}
		}
		line.sharedMaterial = sharedLineMaterial;
		line.loop = false;
		line.useWorldSpace = true;
		line.alignment = LineAlignment.View;
		line.textureMode = LineTextureMode.Stretch;
		line.numCapVertices = 0;
		line.numCornerVertices = 0;
		line.shadowCastingMode = ShadowCastingMode.Off;
		line.receiveShadows = false;
		line.motionVectorGenerationMode = MotionVectorGenerationMode.ForceNoMotion;
		line.lightProbeUsage = LightProbeUsage.Off;
		line.reflectionProbeUsage = ReflectionProbeUsage.Off;
		line.startColor = lineColor;
		line.endColor = lineColor;
		line.startWidth = lineWidth;
		line.endWidth = lineWidth;
		line.sortingOrder = sortingOrder;
	}

	private void RefreshShape()
	{
		if (targetCollider == null || line == null || !targetCollider.enabled || !base.isActiveAndEnabled)
		{
			if (line != null)
			{
				line.enabled = false;
			}
			return;
		}
		line.enabled = true;
		line.startColor = lineColor;
		line.endColor = lineColor;
		line.startWidth = lineWidth;
		line.endWidth = lineWidth;
		line.sortingOrder = sortingOrder;
		if (targetCollider is CircleCollider2D circleCollider2D)
		{
			int num = Mathf.Max(8, circleSegments) + 1;
			EnsurePointCapacity(num);
			Bounds bounds = circleCollider2D.bounds;
			float num2 = Mathf.Max(0.0001f, Mathf.Max(bounds.extents.x, bounds.extents.y));
			Vector3 center = bounds.center;
			for (int i = 0; i < num; i++)
			{
				float f = (float)i / (float)(num - 1) * MathF.PI * 2f;
				float x = Mathf.Cos(f) * num2;
				float y = Mathf.Sin(f) * num2;
				pointCache[i] = center + new Vector3(x, y, 0f);
			}
			line.positionCount = num;
			line.SetPositions(pointCache);
			DrawDebugLines(num);
		}
		else if (targetCollider is PolygonCollider2D polygonCollider2D)
		{
			if (polygonCollider2D.pathCount <= 0)
			{
				line.positionCount = 0;
				return;
			}
			Vector2[] path = polygonCollider2D.GetPath(0);
			int num3 = ((path != null) ? path.Length : 0);
			if (num3 <= 0)
			{
				line.positionCount = 0;
				return;
			}
			int num4 = num3 + 1;
			EnsurePointCapacity(num4);
			Transform transform = polygonCollider2D.transform;
			for (int j = 0; j < num3; j++)
			{
				pointCache[j] = transform.TransformPoint(path[j]);
			}
			pointCache[num4 - 1] = pointCache[0];
			line.positionCount = num4;
			line.SetPositions(pointCache);
			DrawDebugLines(num4);
		}
		else if (targetCollider is BoxCollider2D boxCollider2D)
		{
			int num5 = 5;
			EnsurePointCapacity(num5);
			Transform transform2 = boxCollider2D.transform;
			Vector2 vector = boxCollider2D.size * 0.5f;
			Vector2 offset = boxCollider2D.offset;
			pointCache[0] = transform2.TransformPoint(offset + new Vector2(0f - vector.x, 0f - vector.y));
			pointCache[1] = transform2.TransformPoint(offset + new Vector2(vector.x, 0f - vector.y));
			pointCache[2] = transform2.TransformPoint(offset + new Vector2(vector.x, vector.y));
			pointCache[3] = transform2.TransformPoint(offset + new Vector2(0f - vector.x, vector.y));
			pointCache[4] = pointCache[0];
			line.positionCount = num5;
			line.SetPositions(pointCache);
			DrawDebugLines(num5);
		}
		else
		{
			Bounds bounds2 = targetCollider.bounds;
			int num6 = 5;
			EnsurePointCapacity(num6);
			pointCache[0] = new Vector3(bounds2.min.x, bounds2.min.y, 0f);
			pointCache[1] = new Vector3(bounds2.max.x, bounds2.min.y, 0f);
			pointCache[2] = new Vector3(bounds2.max.x, bounds2.max.y, 0f);
			pointCache[3] = new Vector3(bounds2.min.x, bounds2.max.y, 0f);
			pointCache[4] = pointCache[0];
			line.positionCount = num6;
			line.SetPositions(pointCache);
			DrawDebugLines(num6);
		}
	}

	private void EnsurePointCapacity(int count)
	{
		if (pointCache == null || pointCache.Length < count)
		{
			pointCache = new Vector3[count];
		}
	}

	private void DrawDebugLines(int count)
	{
		if (drawDebugLinesInPlay && count > 1)
		{
			for (int i = 1; i < count; i++)
			{
				Debug.DrawLine(pointCache[i - 1], pointCache[i], lineColor, 0f, depthTest: false);
			}
		}
	}
}
