namespace AIScript;

public class RequestComboAttack
{
	public int comboIndex;

	public bool isAnticipationEnd;

	public bool isActivationEnd;

	public bool isRecoveryBegin;

	public bool isComboFinish;

	public ComboAttackType comboAttackType;

	public void Reset()
	{
		comboIndex = -1;
		isAnticipationEnd = false;
		isActivationEnd = false;
		isRecoveryBegin = false;
		isComboFinish = false;
		comboAttackType = ComboAttackType.None;
	}
}
