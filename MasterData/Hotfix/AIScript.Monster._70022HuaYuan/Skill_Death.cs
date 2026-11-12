using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70022HuaYuan;

public class Skill_Death : SkillSimpleBase
{
	private List<LogicEntity> _entities = new List<LogicEntity>();

	protected override void OnSkillEnable()
	{
		_entities.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		_entities.AddRange(GetTargetsByFaction(isFriend: true));
		if (_entities.Count > 0)
		{
			ClearActors(_entities);
		}
		int keyIndex = 0;
		string actionKey = "Death";
		BeginAttack(keyIndex, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		SendDeclareDeadEvent();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(1);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (comboIndex == 0 && eventName == "HYDeath")
		{
			TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, -1));
			PlayEffect("fx_70022_base_Kagebunsin_Flash", 1f, default, position, default, 2.5f);
			SetHideModelEnable();
		}
	}
}
