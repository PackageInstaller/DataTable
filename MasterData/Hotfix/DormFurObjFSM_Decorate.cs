public class DormFurObjFSM_Decorate : DormFurObjFSM
{
	public DormFurObjFSM_Decorate(DormFurObj furObj, int state)
		: base(furObj, state)
	{
	}

	public override void OnEnter(object data = null)
	{
		base.OnEnter(data);
		furObj.PlayIdleAnim();
		furObj.ActiveHighlightDisplay(outline: true);
		furObj.SetAllInteractivePointVisible(bVisible: true);
	}

	public override void OnExit()
	{
		furObj.DeactiveHighlightDisplay();
		furObj.SetAllInteractivePointVisible(bVisible: false);
		base.OnExit();
	}
}
