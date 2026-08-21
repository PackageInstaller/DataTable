using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[DontApplyToListElements]
public class SearchableAttribute : Attribute
{
	public bool FuzzySearch = true;

	public SearchFilterOptions FilterOptions = SearchFilterOptions.All;

	public bool Recursive = true;
}
