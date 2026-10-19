using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Code.EnumAsset")]
[CreateAssetMenu(menuName = "Visual Scripting/Community/Code/Enum")]
public class EnumAsset : CodeAsset
{
	[Inspectable]
	public bool useIndex;

	public bool itemsOpen;

	[Inspectable]
	public List<EnumItem> items = new List<EnumItem>();
}
