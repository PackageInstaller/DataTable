public class QWFurnitureAttachToAction : QWAgentAction
{
	public bool isAttach = true;

	public QWAgent acquireAgent;

	public string attachPoint;

	public bool setAsChild;

	public int deAttachItem;

	public bool resetFaceDir;

	public QWFurnitureAttachToAction()
		: base(E_Type.Furniture_AttachTo)
	{
	}

	public override void Reset()
	{
		base.Reset();
		isAttach = true;
		acquireAgent = null;
		setAsChild = false;
		deAttachItem = -1;
		resetFaceDir = false;
	}
}
