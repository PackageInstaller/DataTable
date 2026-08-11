using System;
using System.Diagnostics;
using System.Linq;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
public class AssetSelectorAttribute : Attribute
{
	public bool IsUniqueList = true;

	public bool DrawDropdownForListElements = true;

	public bool DisableListAddButtonBehaviour;

	public bool ExcludeExistingValuesInList;

	public bool ExpandAllMenuItems = true;

	public bool FlattenTreeView;

	public int DropdownWidth;

	public int DropdownHeight;

	public string DropdownTitle;

	public string[] SearchInFolders;

	public string Filter;

	public string Paths
	{
		get
		{
			if (SearchInFolders != null)
			{
				return string.Join(",", SearchInFolders);
			}
			return null;
		}
		set
		{
			SearchInFolders = (from x in value.Split(new char[1] { '|' })
				select x.Trim().Trim('/', '\\')).ToArray();
		}
	}
}
