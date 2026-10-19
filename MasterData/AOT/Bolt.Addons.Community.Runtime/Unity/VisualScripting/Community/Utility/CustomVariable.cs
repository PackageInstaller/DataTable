using System;
using UnityEngine;

namespace Unity.VisualScripting.Community.Utility;

[Serializable]
[Inspectable]
[IncludeInSettings(true)]
[RenamedFrom("Bolt.Addons.Community.Utility.Editor.CustomVariable")]
public sealed class CustomVariable
{
	[InspectorLabel(null)]
	[Serialize]
	[Inspectable]
	[InspectorWide]
	[SerializeField]
	public string name;

	[Inspectable]
	[SerializeReference]
	[Serialize]
	[InspectorLabel(null)]
	[InspectorWide]
	public object value;
}
