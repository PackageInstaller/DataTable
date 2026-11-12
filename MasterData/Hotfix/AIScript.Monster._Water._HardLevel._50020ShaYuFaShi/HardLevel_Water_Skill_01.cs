using System.Collections;
using TrueSync;

namespace AIScript.Monster._Water._HardLevel._50020ShaYuFaShi;

public class HardLevel_Water_Skill_01 : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1];

	private readonly string AreaName = "Area_50020ShaYuFaShi_HardLevel_Water_Skill01";

	private readonly string EffectName = "Effect_Wave";

	private TSVector2 SpawnPos;

	private long PlayEffectName;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true);
		BeginLookAt_NotWait(GetAttackTarget(), 1.2, 360);
		yield return WaitCustomEvent("Wave");
		SpawnPos = GetEntityPositionObsoleted(GetAttackTarget());
		PlayEffectName = PlayEffect(EffectName, 1f, 0.1, SpawnPos, 0);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == "Shoot")
		{
			PlayAreaEffect(AreaName, SpawnPos);
		}
	}
}
