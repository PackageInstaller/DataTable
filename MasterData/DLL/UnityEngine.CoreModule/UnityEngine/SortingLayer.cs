using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/BaseClasses/TagManager.h")]
public struct SortingLayer
{
	private int m_Id;

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GetTagManager().GetSortingLayerValueFromUniqueID")]
	public static extern int GetLayerValueFromID(int id);
}
