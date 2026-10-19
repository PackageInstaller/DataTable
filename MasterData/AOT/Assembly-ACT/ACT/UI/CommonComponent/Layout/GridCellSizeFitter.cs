using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI.CommonComponent.Layout;

[RequireComponent(typeof(GridLayoutGroup))]
[ExecuteAlways]
public class GridCellSizeFitter : MonoBehaviour
{
	public enum FitMode
	{
		Unconstrained,
		FitToParent
	}

	[SerializeField]
	private FitMode horizontalFit = FitMode.FitToParent;

	[SerializeField]
	private FitMode verticalFit = FitMode.FitToParent;

	private GridLayoutGroup gridLayoutGroup;

	private RectTransform rectTransform;

	private void Awake()
	{
		gridLayoutGroup = GetComponent<GridLayoutGroup>();
		rectTransform = GetComponent<RectTransform>();
		CalculateCellSize();
	}

	private void OnEnable()
	{
		CalculateCellSize();
	}

	private void OnRectTransformDimensionsChange()
	{
		if (isActiveAndEnabled)
		{
			CalculateCellSize();
		}
	}

	public void CalculateCellSize()
	{
		if (gridLayoutGroup == null || this.rectTransform == null)
		{
			return;
		}
		Vector2 cellSize = gridLayoutGroup.cellSize;
		RectTransform rectTransform = this.rectTransform;
		if (horizontalFit == FitMode.FitToParent && rectTransform != null)
		{
			float width = rectTransform.rect.width;
			float num = gridLayoutGroup.padding.left + gridLayoutGroup.padding.right;
			float x = gridLayoutGroup.spacing.x;
			int columnCount = GetColumnCount();
			if (columnCount > 0)
			{
				cellSize.x = (width - num - x * (float)(columnCount - 1)) / (float)columnCount;
			}
		}
		if (verticalFit == FitMode.FitToParent && rectTransform != null)
		{
			float height = rectTransform.rect.height;
			float num2 = gridLayoutGroup.padding.top + gridLayoutGroup.padding.bottom;
			float y = gridLayoutGroup.spacing.y;
			int rowCount = GetRowCount();
			if (rowCount > 0)
			{
				cellSize.y = (height - num2 - y * (float)(rowCount - 1)) / (float)rowCount;
			}
		}
		gridLayoutGroup.cellSize = cellSize;
	}

	private int GetColumnCount()
	{
		if (gridLayoutGroup.constraint == GridLayoutGroup.Constraint.FixedColumnCount)
		{
			return gridLayoutGroup.constraintCount;
		}
		if (gridLayoutGroup.constraint == GridLayoutGroup.Constraint.FixedRowCount)
		{
			int childCount = rectTransform.childCount;
			int constraintCount = gridLayoutGroup.constraintCount;
			return Mathf.CeilToInt((float)childCount / (float)constraintCount);
		}
		return 1;
	}

	private int GetRowCount()
	{
		if (gridLayoutGroup.constraint == GridLayoutGroup.Constraint.FixedRowCount)
		{
			return gridLayoutGroup.constraintCount;
		}
		if (gridLayoutGroup.constraint == GridLayoutGroup.Constraint.FixedColumnCount)
		{
			int childCount = rectTransform.childCount;
			int constraintCount = gridLayoutGroup.constraintCount;
			return Mathf.CeilToInt((float)childCount / (float)constraintCount);
		}
		return 1;
	}
}
