using System;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;

namespace UnityEngine.Rendering;

public struct RendererListParams : IEquatable<RendererListParams>
{
	public static readonly RendererListParams Invalid = default(RendererListParams);

	public CullingResults cullingResults;

	public DrawingSettings drawSettings;

	public FilteringSettings filteringSettings;

	public ShaderTagId tagName;

	public bool isPassTagName;

	public NativeArray<ShaderTagId>? tagValues;

	public NativeArray<RenderStateBlock>? stateBlocks;

	internal int numStateBlocks
	{
		get
		{
			if (tagValues.HasValue)
			{
				return tagValues.Value.Length;
			}
			return 0;
		}
	}

	internal unsafe IntPtr stateBlocksPtr
	{
		get
		{
			if (!stateBlocks.HasValue)
			{
				return IntPtr.Zero;
			}
			return (IntPtr)stateBlocks.Value.GetUnsafeReadOnlyPtr();
		}
	}

	internal unsafe IntPtr tagsValuePtr
	{
		get
		{
			if (!tagValues.HasValue)
			{
				return IntPtr.Zero;
			}
			return (IntPtr)tagValues.Value.GetUnsafeReadOnlyPtr();
		}
	}

	internal void Dispose()
	{
		if (stateBlocks.HasValue)
		{
			stateBlocks.Value.Dispose();
			stateBlocks = null;
		}
		if (tagValues.HasValue)
		{
			tagValues.Value.Dispose();
			tagValues = null;
		}
	}

	internal void Validate()
	{
		if (tagValues.HasValue && stateBlocks.HasValue)
		{
			if (tagValues.Value.Length != stateBlocks.Value.Length)
			{
				throw new ArgumentException(string.Format("Arrays {0} and {1} should have same length, but {2} had length {3} while {4} had length {5}.", "tagValues", "stateBlocks", "tagValues", tagValues.Value.Length, "stateBlocks", stateBlocks.Value.Length));
			}
		}
		else if ((tagValues.HasValue && !stateBlocks.HasValue) || (!tagValues.HasValue && stateBlocks.HasValue))
		{
			throw new ArgumentException(string.Format("Arrays {0} and {1} should have same length, but one of them is null ({2} : {3}, {4} : {5}).", "tagValues", "stateBlocks", "tagValues", tagValues.HasValue, "stateBlocks", stateBlocks.HasValue));
		}
	}

	public bool Equals(RendererListParams other)
	{
		return cullingResults == other.cullingResults && drawSettings == other.drawSettings && filteringSettings == other.filteringSettings && tagName == other.tagName && isPassTagName == other.isPassTagName && tagValues == other.tagValues && stateBlocks == other.stateBlocks;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		return obj is RendererListParams && Equals((RendererListParams)obj);
	}

	public override int GetHashCode()
	{
		int hashCode = cullingResults.GetHashCode();
		hashCode = (hashCode * 397) ^ drawSettings.GetHashCode();
		hashCode = (hashCode * 397) ^ filteringSettings.GetHashCode();
		hashCode = (hashCode * 397) ^ tagName.GetHashCode();
		hashCode = (hashCode * 397) ^ ((!isPassTagName) ? 1 : 0);
		hashCode = (hashCode * 397) ^ tagValues.GetHashCode();
		return (hashCode * 397) ^ stateBlocks.GetHashCode();
	}
}
