using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine.Rendering;

[NativeType(Header = "Runtime/2D/Sorting/SortingGroup.h")]
[RequireComponent(typeof(Transform))]
public sealed class SortingGroup : Behaviour
{
	[StaticAccessor(/*Could not decode attribute arguments.*/)]
	internal static extern int invalidSortingGroupID
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public extern int sortingLayerID
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public extern int sortingOrder
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[StaticAccessor(/*Could not decode attribute arguments.*/)]
	internal static extern SortingGroup GetSortingGroupByIndex(int index);
}
