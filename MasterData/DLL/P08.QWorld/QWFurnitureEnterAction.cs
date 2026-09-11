public class QWFurnitureEnterAction : QWAgentAction
{
	public QWAgent target;

	public bool isEnter;

	public QWFurnitureEnterAction()
		: base(E_Type.Furniture_Enter)
	{
	}

	public override void Reset()
	{
		base.Reset();
		isEnter = false;
		target = null;
	}
}
