using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[DontApplyToListElements]
[Conditional("UNITY_EDITOR")]
public class SearchableAttribute : Attribute
{
	public bool FuzzySearch = true;

	public SearchFilterOptions FilterOptions = SearchFilterOptions.All;

	public bool Recursive = true;
}
