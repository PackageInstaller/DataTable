using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
[Conditional("UNITY_EDITOR")]
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
