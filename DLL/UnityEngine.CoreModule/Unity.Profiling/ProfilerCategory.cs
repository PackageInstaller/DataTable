using System.Runtime.InteropServices;
using Unity.Profiling.LowLevel.Unsafe;
using UnityEngine.Scripting;

namespace Unity.Profiling;

[StructLayout(LayoutKind.Explicit, Size = 2)]
[UsedByNativeCode]
public readonly struct ProfilerCategory
{
	[FieldOffset(0)]
	private readonly ushort m_CategoryId;

	public unsafe string Name
	{
		get
		{
			ProfilerCategoryDescription categoryDescription = ProfilerUnsafeUtility.GetCategoryDescription(m_CategoryId);
			return ProfilerUnsafeUtility.Utf8ToString(categoryDescription.NameUtf8, categoryDescription.NameUtf8Len);
		}
	}

	public static ProfilerCategory Scripts => new ProfilerCategory(1);

	internal ProfilerCategory(ushort category)
	{
		m_CategoryId = category;
	}

	public override string ToString()
	{
		return Name;
	}

	public static implicit operator ushort(ProfilerCategory category)
	{
		return category.m_CategoryId;
	}
}
