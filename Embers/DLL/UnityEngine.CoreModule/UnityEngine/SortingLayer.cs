using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/BaseClasses/TagManager.h")]
public struct SortingLayer
{
	private int m_Id;

	public int id => m_Id;

	public int value => GetLayerValueFromID(m_Id);

	public static SortingLayer[] layers
	{
		get
		{
			int[] sortingLayerIDsInternal = GetSortingLayerIDsInternal();
			SortingLayer[] array = new SortingLayer[sortingLayerIDsInternal.Length];
			for (int i = 0; i < sortingLayerIDsInternal.Length; i++)
			{
				array[i].m_Id = sortingLayerIDsInternal[i];
			}
			return array;
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GetTagManager().GetSortingLayerIDs")]
	private static extern int[] GetSortingLayerIDsInternal();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GetTagManager().GetSortingLayerValueFromUniqueID")]
	public static extern int GetLayerValueFromID(int id);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GetTagManager().GetSortingLayerNameFromUniqueID")]
	public static extern string IDToName(int id);
}
