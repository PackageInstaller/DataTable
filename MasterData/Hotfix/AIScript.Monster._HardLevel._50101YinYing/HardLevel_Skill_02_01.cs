using System.Collections;
using System.Runtime.CompilerServices;

namespace AIScript.Monster._HardLevel._50101YinYing;

public class HardLevel_Skill_02_01 : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] Attack;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true);
		BeginLookAt_NotWait(GetAttackTarget(), 0.8, 250);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	public HardLevel_Skill_02_01()
	{
		//IL_000d: Field data (rva=0x740) could not be found in any section!
		//IL_000d: Field data (rva=0x740) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._326BDEC1E9B2516102A309A80336E11AD1C2BE8731440B66CC06D58A2273DAE4));
		Attack = array;
		base._002Ector();
	}
}
