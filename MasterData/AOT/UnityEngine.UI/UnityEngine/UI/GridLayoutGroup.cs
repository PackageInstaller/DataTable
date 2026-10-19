namespace UnityEngine.UI;

[AddComponentMenu("Layout/Grid Layout Group", 152)]
public class GridLayoutGroup : LayoutGroup
{
	public enum Corner
	{
		UpperLeft,
		UpperRight,
		LowerLeft,
		LowerRight
	}

	public enum Axis
	{
		Horizontal,
		Vertical
	}

	public enum Constraint
	{
		Flexible,
		FixedColumnCount,
		FixedRowCount
	}

	[SerializeField]
	protected Corner m_StartCorner;

	[SerializeField]
	protected Axis m_StartAxis;

	[SerializeField]
	protected Vector2 m_CellSize = new Vector2(100f, 100f);

	[SerializeField]
	protected Vector2 m_Spacing = Vector2.zero;

	[SerializeField]
	protected Constraint m_Constraint;

	[SerializeField]
	protected int m_ConstraintCount = 2;

	public Corner startCorner
	{
		get
		{
			return m_StartCorner;
		}
		set
		{
			SetProperty(ref m_StartCorner, value);
		}
	}

	public Axis startAxis
	{
		get
		{
			return m_StartAxis;
		}
		set
		{
			SetProperty(ref m_StartAxis, value);
		}
	}

	public Vector2 cellSize
	{
		get
		{
			return m_CellSize;
		}
		set
		{
			SetProperty(ref m_CellSize, value);
		}
	}

	public Vector2 spacing
	{
		get
		{
			return m_Spacing;
		}
		set
		{
			SetProperty(ref m_Spacing, value);
		}
	}

	public Constraint constraint
	{
		get
		{
			return m_Constraint;
		}
		set
		{
			SetProperty(ref m_Constraint, value);
		}
	}

	public int constraintCount
	{
		get
		{
			return m_ConstraintCount;
		}
		set
		{
			SetProperty(ref m_ConstraintCount, Mathf.Max(1, value));
		}
	}

	protected GridLayoutGroup()
	{
	}

	public override void CalculateLayoutInputHorizontal()
	{
		base.CalculateLayoutInputHorizontal();
		int num = 0;
		int num2 = 0;
		if (m_Constraint == Constraint.FixedColumnCount)
		{
			num = (num2 = m_ConstraintCount);
		}
		else if (m_Constraint == Constraint.FixedRowCount)
		{
			num = (num2 = Mathf.CeilToInt((float)rectChildren.Count / (float)m_ConstraintCount - 0.001f));
		}
		else
		{
			num = 1;
			num2 = Mathf.CeilToInt(Mathf.Sqrt(rectChildren.Count));
		}
		SetLayoutInputForAxis((float)padding.horizontal + (cellSize.x + spacing.x) * (float)num - spacing.x, (float)padding.horizontal + (cellSize.x + spacing.x) * (float)num2 - spacing.x, -1f, 0);
	}

	public override void CalculateLayoutInputVertical()
	{
		int num = 0;
		if (m_Constraint == Constraint.FixedColumnCount)
		{
			num = Mathf.CeilToInt((float)rectChildren.Count / (float)m_ConstraintCount - 0.001f);
		}
		else if (m_Constraint == Constraint.FixedRowCount)
		{
			num = m_ConstraintCount;
		}
		else
		{
			float width = rectTransform.rect.width;
			int num2 = Mathf.Max(1, Mathf.FloorToInt((width - (float)padding.horizontal + spacing.x + 0.001f) / (cellSize.x + spacing.x)));
			num = Mathf.CeilToInt((float)rectChildren.Count / (float)num2);
		}
		float num3 = (float)padding.vertical + (cellSize.y + spacing.y) * (float)num - spacing.y;
		SetLayoutInputForAxis(num3, num3, -1f, 1);
	}

	public override void SetLayoutHorizontal()
	{
		SetCellsAlongAxis(0);
	}

	public override void SetLayoutVertical()
	{
		SetCellsAlongAxis(1);
	}

	private void SetCellsAlongAxis(int axis)
	{
		int count = rectChildren.Count;
		if (axis == 0)
		{
			for (int i = 0; i < count; i++)
			{
				RectTransform rectTransform = rectChildren[i];
				m_Tracker.Add(this, rectTransform, DrivenTransformProperties.Anchors | DrivenTransformProperties.AnchoredPosition | DrivenTransformProperties.SizeDelta);
				rectTransform.anchorMin = Vector2.up;
				rectTransform.anchorMax = Vector2.up;
				rectTransform.sizeDelta = cellSize;
			}
			return;
		}
		float x = base.rectTransform.rect.size.x;
		float y = base.rectTransform.rect.size.y;
		int num = 1;
		int num2 = 1;
		if (m_Constraint == Constraint.FixedColumnCount)
		{
			num = m_ConstraintCount;
			if (count > num)
			{
				num2 = count / num + ((count % num > 0) ? 1 : 0);
			}
		}
		else if (m_Constraint != Constraint.FixedRowCount)
		{
			num = ((!(cellSize.x + spacing.x <= 0f)) ? Mathf.Max(1, Mathf.FloorToInt((x - (float)padding.horizontal + spacing.x + 0.001f) / (cellSize.x + spacing.x))) : int.MaxValue);
			num2 = ((!(cellSize.y + spacing.y <= 0f)) ? Mathf.Max(1, Mathf.FloorToInt((y - (float)padding.vertical + spacing.y + 0.001f) / (cellSize.y + spacing.y))) : int.MaxValue);
		}
		else
		{
			num2 = m_ConstraintCount;
			if (count > num2)
			{
				num = count / num2 + ((count % num2 > 0) ? 1 : 0);
			}
		}
		int num3 = (int)startCorner % 2;
		int num4 = (int)startCorner / 2;
		int num5;
		int num6;
		int num7;
		if (startAxis == Axis.Horizontal)
		{
			num5 = num;
			num6 = Mathf.Clamp(num, 1, count);
			num7 = ((m_Constraint != Constraint.FixedRowCount) ? Mathf.Clamp(num2, 1, Mathf.CeilToInt((float)count / (float)num5)) : Mathf.Min(num2, count));
		}
		else
		{
			num5 = num2;
			num7 = Mathf.Clamp(num2, 1, count);
			num6 = ((m_Constraint != Constraint.FixedColumnCount) ? Mathf.Clamp(num, 1, Mathf.CeilToInt((float)count / (float)num5)) : Mathf.Min(num, count));
		}
		Vector2 vector = new Vector2((float)num6 * cellSize.x + (float)(num6 - 1) * spacing.x, (float)num7 * cellSize.y + (float)(num7 - 1) * spacing.y);
		Vector2 vector2 = new Vector2(GetStartOffset(0, vector.x), GetStartOffset(1, vector.y));
		int num8 = 0;
		if (count > m_ConstraintCount && Mathf.CeilToInt((float)count / (float)num5) < m_ConstraintCount)
		{
			num8 = m_ConstraintCount - Mathf.CeilToInt((float)count / (float)num5);
			num8 += Mathf.FloorToInt((float)num8 / ((float)num5 - 1f));
			if (count % num5 == 1)
			{
				num8++;
			}
		}
		for (int j = 0; j < count; j++)
		{
			int num9;
			int num10;
			if (startAxis == Axis.Horizontal)
			{
				if (m_Constraint == Constraint.FixedRowCount && count - j <= num8)
				{
					num9 = 0;
					num10 = m_ConstraintCount - (count - j);
				}
				else
				{
					num9 = j % num5;
					num10 = j / num5;
				}
			}
			else if (m_Constraint == Constraint.FixedColumnCount && count - j <= num8)
			{
				num9 = m_ConstraintCount - (count - j);
				num10 = 0;
			}
			else
			{
				num9 = j / num5;
				num10 = j % num5;
			}
			if (num3 == 1)
			{
				num9 = num6 - 1 - num9;
			}
			if (num4 == 1)
			{
				num10 = num7 - 1 - num10;
			}
			SetChildAlongAxis(rectChildren[j], 0, vector2.x + (cellSize[0] + spacing[0]) * (float)num9, cellSize[0]);
			SetChildAlongAxis(rectChildren[j], 1, vector2.y + (cellSize[1] + spacing[1]) * (float)num10, cellSize[1]);
		}
	}
}
