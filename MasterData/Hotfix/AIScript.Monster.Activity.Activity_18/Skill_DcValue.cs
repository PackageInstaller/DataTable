using System.Collections;

namespace AIScript.Monster.Activity.Activity_18;

public class Skill_DcValue : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1];

	public const string message_DcValue = "DcValue";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SendMessageToGroupController();
	}

	private void SendMessageToGroupController()
	{
		if (!(_actor == null))
		{
			AdventureMonsterToGroupControllerMessage adventureMonsterToGroupControllerMessage = AdventureMonsterToGroupControllerMessage.Generate();
			adventureMonsterToGroupControllerMessage.monsterId = _actor.Id;
			adventureMonsterToGroupControllerMessage.operationType = "DcValue";
			ModuleController<AdventureModuleController>.Instance?.DispatchEvent(adventureMonsterToGroupControllerMessage);
		}
	}
}
