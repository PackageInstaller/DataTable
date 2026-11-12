public class DormFurObjFSM_Idle : DormFurObjFSM
{
	public DormFurObjFSM_Idle(DormFurObj furObj, int state)
		: base(furObj, state)
	{
	}

	public override void OnEnter(object data = null)
	{
		base.OnEnter(data);
		furObj.PlayIdleAnim();
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		if (furObj.HasAnyOccupiedInteractivePoint)
		{
			furObj.SwitchToInteractive();
		}
	}
}
