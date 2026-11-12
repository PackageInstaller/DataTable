using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class SkillScript_DustSpraying : SkillScript_MagicBase
{
	private readonly string comboTag = "Skill_3";

	private readonly Dictionary<int, string> areaEffectKeyDic = new Dictionary<int, string>
	{
		[0] = "Area_30931HaSaNa_SandSpray_1",
		[1] = "Area_30931HaSaNa_SandSpray_1",
		[2] = "Area_30931HaSaNa_SandSpray_2",
		[3] = "Area_30931HaSaNa_SandSpray_2",
		[4] = "Area_30931HaSaNa_SandSpray_3"
	};

	private readonly FP duration = 4;

	private readonly FP rotationSpeed = 60;

	private long StartFX;

	protected override IEnumerator SkillLogic()
	{
		SetBlockPriorityToStatic();
		AddBuffToTarget(_actor, 990020140);
		BeginAttack(1, comboTag, flushInputedKeys: true);
		yield return BeginLookAtMonsterTarget(0.1, 9999);
		BeginLookAtMonsterTarget(0.25, 240);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		long areaEffectId = 0L;
		if (areaEffectKeyDic.TryGetValue(_chargeCount, out var areaEffecyKey))
		{
			FP fP = 0;
			switch (_chargeCount)
			{
			case 0:
			case 1:
				fP = 0.8f;
				break;
			case 2:
			case 3:
				fP = 1.2f;
				break;
			case 4:
				fP = 1.6f;
				break;
			}
			SkillScript_DustSpraying skillScript_DustSpraying = this;
			TSVector2 position = GetPosition();
			FP rotation = GetRotation();
			float spawnSize = (float)fP;
			skillScript_DustSpraying.PlayEarlyWarningEffect("fx_warning_square_3side_2_5x30", 1f, default, position, rotation, spawnSize);
			yield return WaitTime(1);
			areaEffectId = PlayAreaEffect(areaEffecyKey, GetPosition(), GetRotation());
		}
		yield return WaitTime(1);
		if (!GetLogicTagToggleValue(_actor, "IsMainline"))
		{
			yield return BeginLookAtMonsterTarget(duration - 1, rotationSpeed);
		}
		else
		{
			yield return BeginLookAtMonsterTarget(duration - 1, 90);
		}
		if (areaEffectId > 0)
		{
			StopAreaEffect(areaEffectId);
		}
		CancelAttack();
		StopEffect(StartFX);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ResetBlockPriority();
		RemoveBuffFromTarget(_actor, 990020140);
		StopEffect(StartFX);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		base.OnCustomEvent(comboIndex, eventName);
		if (string.Equals(eventName, "StartFX"))
		{
			TSVector2 position = GetPosition();
			FP rotation = GetRotation();
			StartFX = PlayEffect("fx_m30931_loop_Skill03_sand_launch", 1f, default, position, rotation);
		}
	}
}
