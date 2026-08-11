using System;
using System.Diagnostics;
using UnityEngine;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = false)]
[Conditional("UNITY_EDITOR")]
public class TableListAttribute : Attribute
{
	public int NumberOfItemsPerPage;

	public bool IsReadOnly;

	public int DefaultMinColumnWidth = 40;

	public bool ShowIndexLabels;

	public bool DrawScrollView = true;

	public int MinScrollViewHeight = 350;

	public int MaxScrollViewHeight;

	public bool AlwaysExpanded;

	public bool HideToolbar;

	public int CellPadding = 2;

	[SerializeField]
	[HideInInspector]
	private bool showPagingHasValue;

	[SerializeField]
	[HideInInspector]
	private bool showPaging;

	public bool ShowPaging
	{
		get
		{
			return showPaging;
		}
		set
		{
			showPaging = value;
			showPagingHasValue = true;
		}
	}

	public bool ShowPagingHasValue => showPagingHasValue;

	public int ScrollViewHeight
	{
		get
		{
			return Math.Min(MinScrollViewHeight, MaxScrollViewHeight);
		}
		set
		{
			MinScrollViewHeight = (MaxScrollViewHeight = value);
		}
	}
}
