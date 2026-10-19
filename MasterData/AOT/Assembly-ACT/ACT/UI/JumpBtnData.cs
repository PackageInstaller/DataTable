namespace ACT.UI;

public abstract class JumpBtnData : OperateBtnData
{
	public override CustomUICompType btnType => CustomUICompType.JumpBtn;

	public OperateBtnFormDataManager formDataManager => _formDataManager;
}
