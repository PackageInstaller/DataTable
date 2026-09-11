public class QWFurnitureVisibleAction : QWAgentAction
{
	public bool visible;

	public int target;

	public QWFurnitureVisibleAction()
		: base(E_Type.Furniture_Visible)
	{
	}

	public override void Reset()
	{
		base.Reset();
	}
}
