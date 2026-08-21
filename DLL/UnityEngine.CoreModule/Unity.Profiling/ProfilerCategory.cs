using System.Runtime.InteropServices;
using Unity.Profiling.LowLevel.Unsafe;
using UnityEngine;
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

	public Color32 Color => ProfilerUnsafeUtility.GetCategoryDescription(m_CategoryId).Color;

	public static ProfilerCategory Render => new ProfilerCategory(0);

	public static ProfilerCategory Scripts => new ProfilerCategory(1);

	public static ProfilerCategory Gui => new ProfilerCategory(4);

	public static ProfilerCategory Physics => new ProfilerCategory(5);

	public static ProfilerCategory Physics2D => new ProfilerCategory(33);

	public static ProfilerCategory Animation => new ProfilerCategory(6);

	public static ProfilerCategory Ai => new ProfilerCategory(7);

	public static ProfilerCategory Audio => new ProfilerCategory(8);

	public static ProfilerCategory Video => new ProfilerCategory(11);

	public static ProfilerCategory Particles => new ProfilerCategory(12);

	public static ProfilerCategory Lighting => new ProfilerCategory(13);

	public static ProfilerCategory Network => new ProfilerCategory(14);

	public static ProfilerCategory Loading => new ProfilerCategory(15);

	public static ProfilerCategory Vr => new ProfilerCategory(22);

	public static ProfilerCategory Input => new ProfilerCategory(30);

	public static ProfilerCategory Memory => new ProfilerCategory(23);

	public static ProfilerCategory VirtualTexturing => new ProfilerCategory(31);

	public static ProfilerCategory FileIO => new ProfilerCategory(25);

	public static ProfilerCategory Internal => new ProfilerCategory(24);

	internal static ProfilerCategory Any => new ProfilerCategory(ushort.MaxValue);

	internal static ProfilerCategory GPU => new ProfilerCategory(32);

	public ProfilerCategory(string categoryName)
	{
		m_CategoryId = ProfilerUnsafeUtility.CreateCategory(categoryName, ProfilerCategoryColor.Scripts);
	}

	public ProfilerCategory(string categoryName, ProfilerCategoryColor color)
	{
		m_CategoryId = ProfilerUnsafeUtility.CreateCategory(categoryName, color);
	}

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
