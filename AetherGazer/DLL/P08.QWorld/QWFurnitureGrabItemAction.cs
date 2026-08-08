public class QWFurnitureGrabItemAction : QWAgentAction
{
	public bool isGrab;

	public QWAgent target;

	public string itemPart;

	public string attachPoint;

	public QWFurnitureGrabItemAction()
		: base(E_Type.Furniture_GrabItem)
	{
	}

	public override void Reset()
	{
		base.Reset();
		target = null;
		isGrab = false;
	}
}
