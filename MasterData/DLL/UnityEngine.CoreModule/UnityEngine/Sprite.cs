using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[ExcludeFromPreset]
[NativeHeader("Runtime/2D/Common/SpriteDataAccess.h")]
[NativeType("Runtime/Graphics/SpriteFrame.h")]
[NativeHeader("Runtime/Graphics/SpriteUtility.h")]
[NativeHeader("Runtime/2D/Common/ScriptBindings/SpritesMarshalling.h")]
public sealed class Sprite : Object
{
	public Bounds bounds
	{
		get
		{
			get_bounds_Injected(out var ret);
			return ret;
		}
	}

	public Rect rect
	{
		get
		{
			get_rect_Injected(out var ret);
			return ret;
		}
	}

	public Vector4 border
	{
		get
		{
			get_border_Injected(out var ret);
			return ret;
		}
	}

	public extern Texture2D texture
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public extern float pixelsPerUnit
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("GetPixelsToUnits")]
		get;
	}

	public extern float spriteAtlasTextureScale
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("GetSpriteAtlasTextureScale")]
		get;
	}

	public extern Texture2D associatedAlphaSplitTexture
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("GetAlphaTexture")]
		get;
	}

	public Vector2 pivot
	{
		[NativeMethod("GetPivotInPixels")]
		get
		{
			get_pivot_Injected(out var ret);
			return ret;
		}
	}

	public bool packed => GetPacked() == 1;

	public SpritePackingMode packingMode => (SpritePackingMode)GetPackingMode();

	public SpritePackingRotation packingRotation => (SpritePackingRotation)GetPackingRotation();

	public Rect textureRect => GetTextureRect();

	public Vector2 textureRectOffset => GetTextureRectOffset();

	public extern Vector2[] vertices
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("SpriteAccessLegacy::GetSpriteVertices", HasExplicitThis = true)]
		get;
	}

	public extern ushort[] triangles
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("SpriteAccessLegacy::GetSpriteIndices", HasExplicitThis = true)]
		get;
	}

	public extern Vector2[] uv
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("SpriteAccessLegacy::GetSpriteUVs", HasExplicitThis = true)]
		get;
	}

	[RequiredByNativeCode]
	private Sprite()
	{
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal extern int GetPackingMode();

	[MethodImpl((MethodImplOptions)4096)]
	internal extern int GetPackingRotation();

	[MethodImpl((MethodImplOptions)4096)]
	internal extern int GetPacked();

	internal Rect GetTextureRect()
	{
		GetTextureRect_Injected(out var ret);
		return ret;
	}

	internal Vector2 GetTextureRectOffset()
	{
		GetTextureRectOffset_Injected(out var ret);
		return ret;
	}

	internal Vector4 GetInnerUVs()
	{
		GetInnerUVs_Injected(out var ret);
		return ret;
	}

	internal Vector4 GetOuterUVs()
	{
		GetOuterUVs_Injected(out var ret);
		return ret;
	}

	internal Vector4 GetPadding()
	{
		GetPadding_Injected(out var ret);
		return ret;
	}

	[FreeFunction("SpritesBindings::CreateSpriteWithoutTextureScripting")]
	internal static Sprite CreateSpriteWithoutTextureScripting(Rect rect, Vector2 pivot, float pixelsToUnits, Texture2D texture)
	{
		return CreateSpriteWithoutTextureScripting_Injected(ref rect, ref pivot, pixelsToUnits, texture);
	}

	[FreeFunction("SpritesBindings::CreateSprite", ThrowsException = true)]
	internal static Sprite CreateSprite(Texture2D texture, Rect rect, Vector2 pivot, float pixelsPerUnit, uint extrude, SpriteMeshType meshType, Vector4 border, bool generateFallbackPhysicsShape, [Unmarshalled] SecondarySpriteTexture[] secondaryTexture)
	{
		return CreateSprite_Injected(texture, ref rect, ref pivot, pixelsPerUnit, extrude, meshType, ref border, generateFallbackPhysicsShape, secondaryTexture);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal extern Texture2D GetSecondaryTexture(int index);

	[MethodImpl((MethodImplOptions)4096)]
	public extern int GetSecondaryTextureCount();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("SpritesBindings::GetSecondaryTextures", ThrowsException = true, HasExplicitThis = true)]
	public extern int GetSecondaryTextures([NotNull("ArgumentNullException")][Unmarshalled] SecondarySpriteTexture[] secondaryTexture);

	[MethodImpl((MethodImplOptions)4096)]
	public extern int GetPhysicsShapeCount();

	public int GetPhysicsShapePointCount(int shapeIdx)
	{
		int physicsShapeCount = GetPhysicsShapeCount();
		if (shapeIdx < 0 || shapeIdx >= physicsShapeCount)
		{
			throw new IndexOutOfRangeException($"Index({shapeIdx}) is out of bounds(0 - {physicsShapeCount - 1})");
		}
		return Internal_GetPhysicsShapePointCount(shapeIdx);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("GetPhysicsShapePointCount")]
	private extern int Internal_GetPhysicsShapePointCount(int shapeIdx);

	public int GetPhysicsShape(int shapeIdx, List<Vector2> physicsShape)
	{
		int physicsShapeCount = GetPhysicsShapeCount();
		if (shapeIdx < 0 || shapeIdx >= physicsShapeCount)
		{
			throw new IndexOutOfRangeException($"Index({shapeIdx}) is out of bounds(0 - {physicsShapeCount - 1})");
		}
		GetPhysicsShapeImpl(this, shapeIdx, physicsShape);
		return physicsShape.Count;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("SpritesBindings::GetPhysicsShape", ThrowsException = true)]
	private static extern void GetPhysicsShapeImpl(Sprite sprite, int shapeIdx, [NotNull("ArgumentNullException")] List<Vector2> physicsShape);

	public void OverridePhysicsShape(IList<Vector2[]> physicsShapes)
	{
		if (physicsShapes == null)
		{
			throw new ArgumentNullException("physicsShapes");
		}
		for (int i = 0; i < physicsShapes.Count; i++)
		{
			Vector2[] array = physicsShapes[i];
			if (array == null)
			{
				throw new ArgumentNullException("physicsShape", $"Physics Shape at {i} is null.");
			}
			if (array.Length < 3)
			{
				throw new ArgumentException($"Physics Shape at {i} has less than 3 vertices ({array.Length}).");
			}
		}
		OverridePhysicsShapeCount(this, physicsShapes.Count);
		for (int j = 0; j < physicsShapes.Count; j++)
		{
			OverridePhysicsShape(this, physicsShapes[j], j);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("SpritesBindings::OverridePhysicsShapeCount")]
	private static extern void OverridePhysicsShapeCount(Sprite sprite, int physicsShapeCount);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("SpritesBindings::OverridePhysicsShape", ThrowsException = true)]
	private static extern void OverridePhysicsShape(Sprite sprite, [Unmarshalled] Vector2[] physicsShape, int idx);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("SpritesBindings::OverrideGeometry", HasExplicitThis = true)]
	public extern void OverrideGeometry([Unmarshalled][NotNull("ArgumentNullException")] Vector2[] vertices, [NotNull("ArgumentNullException")][Unmarshalled] ushort[] triangles);

	internal static Sprite Create(Rect rect, Vector2 pivot, float pixelsToUnits, Texture2D texture)
	{
		return CreateSpriteWithoutTextureScripting(rect, pivot, pixelsToUnits, texture);
	}

	internal static Sprite Create(Rect rect, Vector2 pivot, float pixelsToUnits)
	{
		return CreateSpriteWithoutTextureScripting(rect, pivot, pixelsToUnits, null);
	}

	public static Sprite Create(Texture2D texture, Rect rect, Vector2 pivot, float pixelsPerUnit, uint extrude, SpriteMeshType meshType, Vector4 border, bool generateFallbackPhysicsShape)
	{
		return Create(texture, rect, pivot, pixelsPerUnit, extrude, meshType, border, generateFallbackPhysicsShape, null);
	}

	public static Sprite Create(Texture2D texture, Rect rect, Vector2 pivot, float pixelsPerUnit, uint extrude, SpriteMeshType meshType, Vector4 border, bool generateFallbackPhysicsShape, SecondarySpriteTexture[] secondaryTextures)
	{
		if (texture == null)
		{
			return null;
		}
		if (rect.xMax > (float)texture.width || rect.yMax > (float)texture.height)
		{
			throw new ArgumentException($"Could not create sprite ({rect.x}, {rect.y}, {rect.width}, {rect.height}) from a {texture.width}x{texture.height} texture.");
		}
		if (pixelsPerUnit <= 0f)
		{
			throw new ArgumentException("pixelsPerUnit must be set to a positive non-zero value.");
		}
		if (secondaryTextures != null)
		{
			for (int i = 0; i < secondaryTextures.Length; i++)
			{
				SecondarySpriteTexture secondarySpriteTexture = secondaryTextures[i];
				if (secondarySpriteTexture.texture == texture)
				{
					throw new ArgumentException($"{secondarySpriteTexture.name} is using source Texture as Secondary Texture.");
				}
			}
		}
		return CreateSprite(texture, rect, pivot, pixelsPerUnit, extrude, meshType, border, generateFallbackPhysicsShape, secondaryTextures);
	}

	public static Sprite Create(Texture2D texture, Rect rect, Vector2 pivot, float pixelsPerUnit, uint extrude, SpriteMeshType meshType, Vector4 border)
	{
		return Create(texture, rect, pivot, pixelsPerUnit, extrude, meshType, border, generateFallbackPhysicsShape: false);
	}

	public static Sprite Create(Texture2D texture, Rect rect, Vector2 pivot, float pixelsPerUnit, uint extrude, SpriteMeshType meshType)
	{
		return Create(texture, rect, pivot, pixelsPerUnit, extrude, meshType, Vector4.zero);
	}

	public static Sprite Create(Texture2D texture, Rect rect, Vector2 pivot, float pixelsPerUnit, uint extrude)
	{
		return Create(texture, rect, pivot, pixelsPerUnit, extrude, SpriteMeshType.Tight);
	}

	public static Sprite Create(Texture2D texture, Rect rect, Vector2 pivot, float pixelsPerUnit)
	{
		return Create(texture, rect, pivot, pixelsPerUnit, 0u);
	}

	public static Sprite Create(Texture2D texture, Rect rect, Vector2 pivot)
	{
		return Create(texture, rect, pivot, 100f);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern void GetTextureRect_Injected(out Rect ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void GetTextureRectOffset_Injected(out Vector2 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void GetInnerUVs_Injected(out Vector4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void GetOuterUVs_Injected(out Vector4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void GetPadding_Injected(out Vector4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern Sprite CreateSpriteWithoutTextureScripting_Injected(ref Rect rect, ref Vector2 pivot, float pixelsToUnits, Texture2D texture);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern Sprite CreateSprite_Injected(Texture2D texture, ref Rect rect, ref Vector2 pivot, float pixelsPerUnit, uint extrude, SpriteMeshType meshType, ref Vector4 border, bool generateFallbackPhysicsShape, SecondarySpriteTexture[] secondaryTexture);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_bounds_Injected(out Bounds ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_rect_Injected(out Rect ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_border_Injected(out Vector4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_pivot_Injected(out Vector2 ret);
}
