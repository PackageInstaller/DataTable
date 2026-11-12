using System.Collections;
using System.Runtime.CompilerServices;

namespace AIScript.Monster._10003ShuZhuangShu;

public class Skill_NormalAttack_Daily : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKeys;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKeys);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	public Skill_NormalAttack_Daily()
	{
		//IL_000d: Field data (rva=0x698) could not be found in any section!
		//IL_000d: Field data (rva=0x698) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._2AFC299AE2C44DBAD6B479482D2D7467D7DEFD66041659ED28CA5E8D83236E82));
		_actionKeys = array;
		base._002Ector();
	}
}
