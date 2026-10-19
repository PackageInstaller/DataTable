namespace ACT.UI;

public abstract class AttackBtnData : OperateBtnData
{
	public override CustomUICompType btnType => CustomUICompType.AttackBtn;

	public OperateBtnFormDataManager formDataManager => _formDataManager;
}
