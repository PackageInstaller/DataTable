using System;
using System.Collections.Generic;
using Spine;
using Spine.Unity;
using UnityEngine;

public static class SummerRaceBodyLayoutMapper
{
	public readonly struct BodySkeletonBounds(Vector2 center, Vector2 size)
	{
		public readonly Vector2 Center = center;

		public readonly Vector2 Size = size;
	}

	private static readonly string[] DefaultBodySkinStack = new string[3] { "default", "car/che_1", "car/che_2" };

	public static BodySkeletonBounds ResolveBodySkeletonBounds(SummerRaceBodyDefSO bodyDef, string skeletonDataPath = null)
	{
		if (bodyDef == null)
		{
			throw new InvalidOperationException("[SummerRace][BodyLayout] bodyDef is null.");
		}
		string text = (string.IsNullOrWhiteSpace(skeletonDataPath) ? bodyDef.battleBodySkeletonDataPath : skeletonDataPath);
		if (string.IsNullOrWhiteSpace(text))
		{
			throw new InvalidOperationException("[SummerRace][BodyLayout] missing body skeleton path: " + bodyDef.name);
		}
		SkeletonDataAsset skeletonDataAsset = SummerRaceConfigLoader.LoadSkeletonDataAssetOrThrow(text, "bodyLayout body=" + bodyDef.name + " skeletonDataPath=" + text);
		SkeletonData skeletonData = ((skeletonDataAsset != null) ? skeletonDataAsset.GetSkeletonData(quiet: false) : null);
		if (skeletonData == null)
		{
			throw new InvalidOperationException("[SummerRace][BodyLayout] missing skeleton data: " + bodyDef.name);
		}
		Skeleton skeleton = new Skeleton(skeletonData);
		skeleton.SetSkin(BuildRuntimeSkinStack(skeletonData));
		skeleton.SetSlotsToSetupPose();
		skeleton.UpdateWorldTransform();
		float x = 0f;
		float y = 0f;
		float width = 0f;
		float height = 0f;
		float[] vertexBuffer = null;
		skeleton.GetBounds(out x, out y, out width, out height, ref vertexBuffer);
		if (width <= 0.0001f || height <= 0.0001f)
		{
			throw new InvalidOperationException("[SummerRace][BodyLayout] invalid skeleton bounds: body=" + bodyDef.name + " size=(" + width + "," + height + ")");
		}
		return new BodySkeletonBounds(new Vector2(x + width * 0.5f, y + height * 0.5f), new Vector2(width, height));
	}

	public static Vector2 AuthoringToBodySkeletonLocal(Vector2 authoringLocalPosition, IReadOnlyList<Vector2> authoringColliderPath, BodySkeletonBounds bounds)
	{
		return bounds.Center + AuthoringToCenteredDisplayLocal(authoringLocalPosition, authoringColliderPath, bounds);
	}

	public static Vector2 AuthoringToCenteredDisplayLocal(Vector2 authoringLocalPosition, IReadOnlyList<Vector2> authoringColliderPath, BodySkeletonBounds bounds)
	{
		return authoringLocalPosition - bounds.Center;
	}

	public static Vector2 AuthoringToDisplaySkeletonLocal(Vector2 authoringLocalPosition, Vector3 bodyVisualLocalPosition, Vector3 bodyVisualLocalScale)
	{
		float num = ((Mathf.Abs(bodyVisualLocalScale.x) > 0.0001f) ? bodyVisualLocalScale.x : 1f);
		float num2 = ((Mathf.Abs(bodyVisualLocalScale.y) > 0.0001f) ? bodyVisualLocalScale.y : 1f);
		return new Vector2((authoringLocalPosition.x - bodyVisualLocalPosition.x) / num, (authoringLocalPosition.y - bodyVisualLocalPosition.y) / num2);
	}

	public static Vector2 AuthoringToFittedBodySkeletonLocal(Vector2 authoringLocalPosition, IReadOnlyList<Vector2> authoringColliderPath, BodySkeletonBounds bounds)
	{
		ComputePathBounds(authoringColliderPath, out var center, out var size);
		return new Vector2(bounds.Center.x + (authoringLocalPosition.x - center.x) * bounds.Size.x / size.x, bounds.Center.y + (authoringLocalPosition.y - center.y) * bounds.Size.y / size.y);
	}

	public static Vector2 ResolveRuntimeLocalFromBodyVisual(Transform bodyVisualRoot, Vector2 bodyAuthoringLocalPosition, Vector3 bodyAuthoringVisualLocalPosition, Vector3 bodyAuthoringVisualLocalScale, string context)
	{
		if (bodyVisualRoot == null)
		{
			throw new InvalidOperationException("[SummerRace][BodyLayout] missing BodyVisual. context=" + context);
		}
		Transform parent = bodyVisualRoot.parent;
		if (parent == null)
		{
			throw new InvalidOperationException("[SummerRace][BodyLayout] BodyVisual has no parent. context=" + context);
		}
		Vector2 vector = AuthoringToDisplaySkeletonLocal(bodyAuthoringLocalPosition, bodyAuthoringVisualLocalPosition, bodyAuthoringVisualLocalScale);
		Vector3 position = bodyVisualRoot.TransformPoint(new Vector3(vector.x, vector.y, 0f));
		Vector3 vector2 = parent.InverseTransformPoint(position);
		return new Vector2(vector2.x, vector2.y);
	}

	private static Skin BuildRuntimeSkinStack(SkeletonData skeletonData)
	{
		Skin skin = new Skin("SummerRaceBodyLayoutSkin");
		for (int i = 0; i < DefaultBodySkinStack.Length; i++)
		{
			string text = DefaultBodySkinStack[i];
			Skin skin2 = skeletonData.FindSkin(text);
			if (skin2 == null)
			{
				throw new InvalidOperationException("[SummerRace][BodyLayout] missing body skin: " + text);
			}
			skin.AddSkin(skin2);
		}
		return skin;
	}

	private static void ComputePathBounds(IReadOnlyList<Vector2> path, out Vector2 center, out Vector2 size)
	{
		if (path == null || path.Count < 3)
		{
			throw new InvalidOperationException("[SummerRace][BodyLayout] invalid authoring collider path.");
		}
		float num = path[0].x;
		float num2 = path[0].x;
		float num3 = path[0].y;
		float num4 = path[0].y;
		for (int i = 1; i < path.Count; i++)
		{
			Vector2 vector = path[i];
			num = Mathf.Min(num, vector.x);
			num2 = Mathf.Max(num2, vector.x);
			num3 = Mathf.Min(num3, vector.y);
			num4 = Mathf.Max(num4, vector.y);
		}
		size = new Vector2(num2 - num, num4 - num3);
		if (size.x <= 0.0001f || size.y <= 0.0001f)
		{
			Vector2 vector2 = size;
			throw new InvalidOperationException("[SummerRace][BodyLayout] invalid authoring collider bounds: size=" + vector2.ToString());
		}
		center = new Vector2((num + num2) * 0.5f, (num3 + num4) * 0.5f);
	}
}
