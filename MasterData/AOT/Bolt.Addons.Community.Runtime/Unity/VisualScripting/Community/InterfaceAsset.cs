using System;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[Serializable]
[RenamedFrom("Bolt.Addons.Community.Code.InterfaceAsset")]
[CreateAssetMenu(fileName = "New Interface", menuName = "Visual Scripting/Community/Code/Interface")]
public sealed class InterfaceAsset : CodeAsset
{
	[Inspectable]
	[InspectorWide]
	public List<InterfacePropertyItem> variables = new List<InterfacePropertyItem>();

	[Inspectable]
	[InspectorWide]
	public List<InterfaceMethodItem> methods = new List<InterfaceMethodItem>();
}
