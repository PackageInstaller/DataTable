using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine.Rendering;

[RequireComponent(typeof(Transform))]
[NativeType(Header = "Runtime/2D/Sorting/SortingGroup.h")]
public sealed class SortingGroup : Behaviour
{
	[StaticAccessor("SortingGroup", StaticAccessorType.DoubleColon)]
	internal static extern int invalidSortingGroupID
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public extern string sortingLayerName
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern int sortingLayerID
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern int sortingOrder
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern bool sortAtRoot
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	internal extern int sortingGroupID
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	internal extern int sortingGroupOrder
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	internal extern int index
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	internal extern uint sortingKey
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[StaticAccessor("SortingGroup", StaticAccessorType.DoubleColon)]
	public static extern void UpdateAllSortingGroups();

	[MethodImpl((MethodImplOptions)4096)]
	[StaticAccessor("SortingGroup", StaticAccessorType.DoubleColon)]
	internal static extern SortingGroup GetSortingGroupByIndex(int index);
}
