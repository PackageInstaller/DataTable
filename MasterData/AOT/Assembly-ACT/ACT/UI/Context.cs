using System;
using ACT.UI.CommonComponent.FancyScrollView.Scroller;

namespace ACT.UI;

public class Context
{
	public int MinIndex = -1;

	public int MaxLevel = -1;

	public int SelectedIndex = -1;

	public int TotalCount = -1;

	public ScrollDirection ScrollDirection = ScrollDirection.Horizontal;

	public Action<int> OnCellClicked;

	public Cell CurrSelectedCell;
}
