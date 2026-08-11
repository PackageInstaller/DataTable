using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[DontApplyToListElements]
[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = true)]
public sealed class ListDrawerSettingsAttribute : Attribute
{
	public bool HideAddButton;

	public bool HideRemoveButton;

	public string ListElementLabelName;

	public string CustomAddFunction;

	public string CustomRemoveIndexFunction;

	public string CustomRemoveElementFunction;

	public string OnBeginListElementGUI;

	public string OnEndListElementGUI;

	public bool AlwaysAddDefaultValue;

	public bool AddCopiesLastElement;

	public string ElementColor;

	private string onTitleBarGUI;

	private int numberOfItemsPerPage;

	private bool paging;

	private bool draggable;

	private bool isReadOnly;

	private bool showItemCount;

	private bool pagingHasValue;

	private bool draggableHasValue;

	private bool isReadOnlyHasValue;

	private bool showItemCountHasValue;

	private bool numberOfItemsPerPageHasValue;

	private bool showIndexLabels;

	private bool showIndexLabelsHasValue;

	private bool defaultExpandedStateHasValue;

	private bool defaultExpandedState;

	public bool ShowFoldout = true;

	public bool ShowPaging
	{
		get
		{
			return paging;
		}
		set
		{
			paging = value;
			pagingHasValue = true;
		}
	}

	public bool DraggableItems
	{
		get
		{
			return draggable;
		}
		set
		{
			draggable = value;
			draggableHasValue = true;
		}
	}

	public int NumberOfItemsPerPage
	{
		get
		{
			return numberOfItemsPerPage;
		}
		set
		{
			numberOfItemsPerPage = value;
			numberOfItemsPerPageHasValue = true;
		}
	}

	public bool IsReadOnly
	{
		get
		{
			return isReadOnly;
		}
		set
		{
			isReadOnly = value;
			isReadOnlyHasValue = true;
		}
	}

	public bool ShowItemCount
	{
		get
		{
			return showItemCount;
		}
		set
		{
			showItemCount = value;
			showItemCountHasValue = true;
		}
	}

	[Obsolete("Use ShowFoldout instead, which is what Expanded has always done. If you want to control the default expanded state, use DefaultExpandedState. Expanded has been implemented wrong for a long time.")]
	public bool Expanded
	{
		get
		{
			return !ShowFoldout;
		}
		set
		{
			ShowFoldout = !value;
		}
	}

	public bool DefaultExpandedState
	{
		get
		{
			return defaultExpandedState;
		}
		set
		{
			defaultExpandedStateHasValue = true;
			defaultExpandedState = value;
		}
	}

	public bool ShowIndexLabels
	{
		get
		{
			return showIndexLabels;
		}
		set
		{
			showIndexLabels = value;
			showIndexLabelsHasValue = true;
		}
	}

	public string OnTitleBarGUI
	{
		get
		{
			return onTitleBarGUI;
		}
		set
		{
			onTitleBarGUI = value;
		}
	}

	public bool PagingHasValue => pagingHasValue;

	public bool ShowItemCountHasValue => showItemCountHasValue;

	public bool NumberOfItemsPerPageHasValue => numberOfItemsPerPageHasValue;

	public bool DraggableHasValue => draggableHasValue;

	public bool IsReadOnlyHasValue => isReadOnlyHasValue;

	public bool ShowIndexLabelsHasValue => showIndexLabelsHasValue;

	public bool DefaultExpandedStateHasValue => defaultExpandedStateHasValue;
}
