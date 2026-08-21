namespace UnityEngine.UI;

[AddComponentMenu("Layout/Vertical Layout Group", 151)]
public class VerticalLayoutGroup : HorizontalOrVerticalLayoutGroup
{
	protected VerticalLayoutGroup()
	{
	}

	public override void CalculateLayoutInputHorizontal()
	{
		base.CalculateLayoutInputHorizontal();
		CalcAlongAxis(0, isVertical: true);
	}

	public override void CalculateLayoutInputVertical()
	{
		CalcAlongAxis(1, isVertical: true);
	}

	public override void SetLayoutHorizontal()
	{
		SetChildrenAlongAxis(0, isVertical: true);
	}

	public override void SetLayoutVertical()
	{
		SetChildrenAlongAxis(1, isVertical: true);
	}
}
