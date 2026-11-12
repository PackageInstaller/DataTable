#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._10501BanShenShu;

public class Skill_Spikeweed : SkillSimpleBase
{
	private static readonly int ActionIndex = 0;

	private static readonly string AttackAction = "GeneralAttack";

	private static readonly List<TSVector2> WeedPOS = new List<TSVector2>
	{
		new TSVector2(-12, 7.5),
		new TSVector2(-12, -1)
	};

	private List<TSVector2> WeedPOSTemp = new List<TSVector2>();

	private readonly string warningFx = "fx_m10501_loop_SpikeWeed_warning";

	private readonly string warningFx_long = "fx_m10501_loop_Spikeweed_warning_02";

	private readonly string warningFx_short = "fx_m10501_loop_Spikeweed_warning_01";

	private List<long> _warningFx = new List<long>();

	private static CoroutineNode TimeLimit;

	private static int AttackTimes;

	protected override void OnSkillEnable()
	{
		AttackTimes = 0;
		NovaLogger.Debug("半身树.进入地刺");
	}

	protected override void OnSkillDisable()
	{
		AttackTimes = 0;
		StopCor(TimeLimit);
		WeedPOSTemp.Clear();
		if (_warningFx.Count > 0)
		{
			for (int i = 0; i < _warningFx.Count; i++)
			{
				StopEffect(_warningFx.get_Item(i));
			}
		}
		_warningFx.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		TimeLimit = StartCor(SkillDuration());
		BeginAttack(ActionIndex, AttackAction, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return StartCor(SpikeweedAttack());
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		StopCor(TimeLimit);
	}

	protected override void OnComboLoop(int comboIndex)
	{
		if (comboIndex == 0)
		{
			AttackTimes++;
			if (AttackTimes == 1)
			{
				CancelAttack();
			}
		}
	}

	protected IEnumerator SkillDuration()
	{
		yield return WaitTime(10);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		InterruptSkill();
	}

	protected IEnumerator SpikeweedAttack()
	{
		if ((int)(long)GetRandomValue(0, 1.5, isInt: true) == 0)
		{
			NovaLogger.Debug("半身树.地刺随机上");
			for (int i = 0; i < 7; i++)
			{
				WeedPOSTemp.Add(new TSVector2(WeedPOS.get_Item(0).x + 4 * i, WeedPOS.get_Item(0).y));
				WeedPOSTemp.Add(new TSVector2(WeedPOS.get_Item(0).x + 4 * i, WeedPOS.get_Item(1).y));
			}
			NovaLogger.Debug("半身树.地刺取点结束");
		}
		else
		{
			NovaLogger.Debug("半身树.地刺随机下");
			for (int j = 0; j < 7; j++)
			{
				WeedPOSTemp.Add(new TSVector2(WeedPOS.get_Item(0).x + 4 * j, WeedPOS.get_Item(0).y - 4.25));
				WeedPOSTemp.Add(new TSVector2(WeedPOS.get_Item(0).x + 4 * j, WeedPOS.get_Item(1).y - 4.25));
			}
			NovaLogger.Debug("半身树.地刺取点结束");
		}
		NovaLogger.Debug("半身树.生成预警");
		_warningFx.Add(PlayEffect(warningFx_long, 0.5f, default, new TSVector2(0, WeedPOSTemp.get_Item(0).y)));
		_warningFx.Add(PlayEffect(warningFx_short, 0.5f, default, new TSVector2(0, WeedPOSTemp.get_Item(1).y)));
		yield return WaitTime(1.3);
		for (int k = 0; k < WeedPOSTemp.Count; k++)
		{
			PlayAreaEffect("FSpikeweed_Normal", WeedPOSTemp.get_Item(k));
		}
		yield return WaitTime(0.6);
		for (int l = 0; l < _warningFx.Count; l++)
		{
			StopEffect(_warningFx.get_Item(l));
		}
		yield return WaitTime(0.1);
	}
}
