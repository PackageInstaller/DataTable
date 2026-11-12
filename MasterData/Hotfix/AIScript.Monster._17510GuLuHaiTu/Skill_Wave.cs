#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._17510GuLuHaiTu;

public class Skill_Wave : SkillSimpleBase
{
	private int waveIndex;

	private string waveKey = "Wave";

	private string effect_fish = "fx_m17510_base_Skill03_fire";

	private List<TSVector2> spwanPOS = new List<TSVector2>
	{
		new TSVector2(-10, 0),
		new TSVector2(-5, 6),
		new TSVector2(5, 2),
		new TSVector2(10, 7)
	};

	private List<long> fxID = new List<long>();

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("咕噜海兔.潮汐.开始");
	}

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("咕噜海兔.潮汐.结束");
		StopAllEffect();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(waveIndex, waveKey, flushInputedKeys: true, forceInterruptAttack: true);
		for (int i = 0; i < spwanPOS.Count; i++)
		{
			TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), spwanPOS.get_Item(i));
			fxID.Add(PlayEffect(effect_fish, 0.5f, default, position));
			yield return WaitTime(GetRandomValue(0, 0.3));
		}
		yield return WaitTime(0.3);
		StopAllEffect();
		DispatchCustomEvent("HorizontalWave");
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void StopAllEffect()
	{
		for (int i = 0; i < fxID.Count; i++)
		{
			StopEffect(fxID.get_Item(i));
		}
		fxID.Clear();
	}
}
