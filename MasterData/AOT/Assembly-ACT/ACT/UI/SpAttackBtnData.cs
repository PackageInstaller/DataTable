namespace ACT.UI;

public abstract class SpAttackBtnData : OperateBtnData
{
	public override CustomUICompType btnType => CustomUICompType.SpAttackBtn;

	public OperateBtnFormDataManager formDataManager => _formDataManager;
}
