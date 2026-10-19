using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI.CommonComponent.Layout;

[RequireComponent(typeof(GridLayoutGroup))]
[ExecuteAlways]
public class GridSpacingFitter : MonoBehaviour
{
	[Header("列数范围")]
	[SerializeField]
	private int maxColumns = 9;

	[SerializeField]
	private int minColumns = 8;

	[Header("横向间距允许范围")]
	[Tooltip("间距下限：低于此值宁可减一列（给得稍小可优先保住大列数，如 84 档 9 列需 11.5）")]
	[SerializeField]
	private float minSpacingX = 10f;

	[Tooltip("间距上限：超出部分留白。想完全消除 40 档的 52px 空隙可调到 23")]
	[SerializeField]
	private float maxSpacingX = 16f;

	private GridLayoutGroup _grid;

	private RectTransform _rect;

	private void Awake()
	{
		_grid = GetComponent<GridLayoutGroup>();
		_rect = GetComponent<RectTransform>();
		Apply();
	}

	private void OnEnable()
	{
		Apply();
	}

	private void OnRectTransformDimensionsChange()
	{
		if (isActiveAndEnabled)
		{
			Apply();
		}
	}

	public void Apply()
	{
		if (_grid == null || _rect == null)
		{
			return;
		}
		float width = _rect.rect.width;
		float x = _grid.cellSize.x;
		float num = width - (float)_grid.padding.left - (float)_grid.padding.right;
		int constraintCount = minColumns;
		float a = minSpacingX;
		bool flag = false;
		for (int num2 = maxColumns; num2 >= minColumns; num2--)
		{
			float num3 = (num - x * (float)num2) / (float)(num2 - 1);
			if (num3 >= minSpacingX)
			{
				constraintCount = num2;
				a = num3;
				flag = true;
				break;
			}
		}
		if (!flag)
		{
			constraintCount = minColumns;
			a = minSpacingX;
		}
		a = Mathf.Min(a, maxSpacingX);
		_grid.constraint = GridLayoutGroup.Constraint.FixedColumnCount;
		_grid.constraintCount = constraintCount;
		Vector2 spacing = _grid.spacing;
		spacing.x = a;
		_grid.spacing = spacing;
	}
}
