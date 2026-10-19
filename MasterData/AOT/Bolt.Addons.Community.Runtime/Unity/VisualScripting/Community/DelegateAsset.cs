using System;
using System.Collections.Generic;
using Unity.VisualScripting.Community.Libraries.CSharp;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[Serializable]
[RenamedFrom("Bolt.Addons.Community.Code.DelegateAsset")]
[CreateAssetMenu(menuName = "Visual Scripting/Community/Code/Delegate")]
public sealed class DelegateAsset : CodeAsset
{
	[Inspectable]
	[SerializeField]
	public SystemType type = new SystemType
	{
		type = typeof(Action)
	};

	[Inspectable]
	public List<GenericDeclaration> generics = new List<GenericDeclaration>();

	[Inspectable]
	public string displayName;
}
