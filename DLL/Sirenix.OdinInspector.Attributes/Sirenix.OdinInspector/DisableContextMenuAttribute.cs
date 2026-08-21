using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
[DontApplyToListElements]
public sealed class DisableContextMenuAttribute : Attribute
{
	public bool DisableForMember;

	public bool DisableForCollectionElements;

	public DisableContextMenuAttribute(bool disableForMember = true, bool disableCollectionElements = false)
	{
		DisableForMember = disableForMember;
		DisableForCollectionElements = disableCollectionElements;
	}
}
