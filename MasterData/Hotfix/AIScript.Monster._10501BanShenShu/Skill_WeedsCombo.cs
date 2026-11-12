#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._10501BanShenShu;

public class Skill_WeedsCombo : SkillSimpleBase
{
	private static readonly int ActionIndex = 0;

	private static readonly string AttackAction = "GeneralAttack";

	private static readonly int MonsterID = 1400607;

	private static readonly FP SpawnINTR = 0.25;

	private static readonly FP AttackINTR = 2.5;

	private readonly string warningFx_short = "fx_m10501_loop_Spikeweed_warning_01";

	private List<long> _warningFx = new List<long>();

	private CoroutineNode WarningFXCor;

	private static readonly TSVector2 OriginPOS = new TSVector2(0, 0);

	private static readonly List<TSVector2> SpawnPOS = new List<TSVector2>
	{
		new TSVector2(0, 8),
		new TSVector2(0, 4),
		new TSVector2(0, 0),
		new TSVector2(0, -4)
	};

	private List<TSVector2> WeedPOSTempTop = new List<TSVector2>();

	private List<TSVector2> WeedPOSTempBelow = new List<TSVector2>();

	private static readonly List<TSVector2> WeedPOS = new List<TSVector2>
	{
		new TSVector2(-12, 7.5),
		new TSVector2(-12, -1)
	};

	private CoroutineNode TimeLimit;

	private int AttackTimes;

	private List<TSVector2> SpawnPOSTemp = new List<TSVector2>();

	private long fx_L_Warning;

	private long fx_L_Ground;

	private long fx_R_Warning;

	private long fx_R_Ground;

	private TSVector2 SelfPOS;

	private TSVector2 LeftAttackPOS;

	private TSVector2 RightAttackPOS;

	private DeterministicShape Shape;

	private HitFeatureData HitData;

	private FP Width = 18;

	private FP Length = 30;

	private FP Rotation = 0;

	private List<long> FxList = new List<long>();

	private TSVector2 LeftHitPOS = new TSVector2(10, 6.25);

	private TSVector2 RightHitPOS = new TSVector2(-10, 6.25);

	private static readonly string Fx_L_Warning = "fx_m10501_loop_Skill8_warning_l";

	private static readonly string Fx_L_Ground = "fx_m10501_loop_Skill8_ground_l";

	private static readonly string Fx_R_Warning = "fx_m10501_loop_Skill8_warning_r";

	private static readonly string Fx_R_Ground = "fx_m10501_loop_Skill8_ground_r";

	protected override void OnSkillEnable()
	{
		AttackTimes = 0;
		for (int i = 0; i < SpawnPOS.Count; i++)
		{
			SpawnPOSTemp.Add(SpawnPOS.get_Item(i));
		}
	}

	protected override void OnSkillDisable()
	{
		StopCor(WarningFXCor);
		AttackTimes = 0;
		StopCor(TimeLimit);
		SpawnPOSTemp.Clear();
		WeedPOSTempTop.Clear();
		WeedPOSTempBelow.Clear();
		for (int i = 0; i < FxList.Count; i++)
		{
			StopEffect(FxList.get_Item(i));
		}
		if (_warningFx.Count > 0)
		{
			for (int j = 0; j < _warningFx.Count; j++)
			{
				StopEffect(_warningFx.get_Item(j));
			}
		}
		_warningFx.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		TimeLimit = StartCor(SkillDuration());
		BeginAttack(ActionIndex, AttackAction, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		HitData = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, 2);
		SelfPOS = GetPosition();
		if ((int)(long)GetRandomValue(0, 1.5, isInt: true) == 0)
		{
			StartCor(WeedsAttackL());
			yield return WaitTime(AttackINTR);
			if ((int)(long)GetRandomValue(0, 1.5, isInt: true) == 0)
			{
				yield return StartCor(SpikeweedAttackRF());
			}
			else
			{
				yield return StartCor(SpikeweedAttackRB());
			}
		}
		else
		{
			StartCor(WeedsAttackR());
			yield return WaitTime(AttackINTR);
			if ((int)(long)GetRandomValue(0, 1.5, isInt: true) == 0)
			{
				yield return StartCor(SpikeweedAttackLF());
			}
			else
			{
				yield return StartCor(SpikeweedAttackLB());
			}
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
		StopCor(TimeLimit);
	}

	protected override void OnComboLoop(int comboIndex)
	{
		if (comboIndex == 0)
		{
			AttackTimes++;
			if (AttackTimes == 3)
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

	protected IEnumerator WeedsAttackL()
	{
		LeftAttackPOS = TransLocalPosToWorldPos(SelfPOS, GetForward(), LeftHitPOS);
		Shape = GetShapeData(DeterministicShape.ShapeType.Rectangle, LeftAttackPOS, Width, Length, default, default, default, Rotation);
		fx_L_Warning = PlayEffect(Fx_L_Warning, 1f, default, SelfPOS, 90);
		FxList.Add(fx_L_Warning);
		yield return WaitTime(0.2);
		PlayWwiseSound("mon_10010_general_attack_start");
		yield return WaitTime(0.8);
		fx_L_Ground = PlayEffect(Fx_L_Ground, 1f, default, SelfPOS, 90);
		FxList.Add(fx_L_Ground);
		yield return WaitTime(0.2);
		PlayWwiseSound("mon_10010_general_attack_end");
		yield return WaitTime(0.8);
		for (int i = 0; i < 5; i++)
		{
			AreaHit_Simple(_actor, Shape, HitData, 1050130, 1, HitBox.HurtAnimType.Small);
			yield return WaitTime(1.1);
		}
		yield return WaitTime(0.2);
		StopEffect(FxList.get_Item(0));
		yield return WaitTime(0.3);
		StopEffect(FxList.get_Item(1));
		PlayWwiseSound("mon_10010_general_attack_diappear ");
		yield return WaitTime(0.1);
	}

	protected IEnumerator WeedsAttackR()
	{
		NovaLogger.Debug("随机右刀");
		RightAttackPOS = TransLocalPosToWorldPos(SelfPOS, GetForward(), RightHitPOS);
		Shape = GetShapeData(DeterministicShape.ShapeType.Rectangle, RightAttackPOS, Width, Length, default, default, default, Rotation);
		fx_R_Warning = PlayEffect(Fx_R_Warning, 1f, default, SelfPOS, -90);
		FxList.Add(fx_R_Warning);
		yield return WaitTime(0.2);
		PlayWwiseSound("mon_10010_general_attack_start");
		yield return WaitTime(0.8);
		fx_R_Ground = PlayEffect(Fx_R_Ground, 1f, default, SelfPOS, -90);
		FxList.Add(fx_R_Ground);
		yield return WaitTime(0.2);
		PlayWwiseSound("mon_10010_general_attack_end");
		yield return WaitTime(0.8);
		for (int i = 0; i < 5; i++)
		{
			AreaHit_Simple(_actor, Shape, HitData, 1050130, 1, HitBox.HurtAnimType.Small);
			yield return WaitTime(1.1);
		}
		yield return WaitTime(0.2);
		StopEffect(FxList.get_Item(0));
		yield return WaitTime(0.3);
		StopEffect(FxList.get_Item(1));
		PlayWwiseSound("mon_10010_general_attack_diappear ");
		yield return WaitTime(0.1);
	}

	protected IEnumerator SpikeweedAttackLF()
	{
		for (int i = 0; i < 4; i++)
		{
			WeedPOSTempTop.Add(new TSVector2(-14 + 4 * i, WeedPOS.get_Item(0).y));
			WeedPOSTempBelow.Add(new TSVector2(-14 + 4 * i, WeedPOS.get_Item(1).y));
		}
		WarningFXCor = StartCor(WarningFx(new TSVector2(-10, WeedPOSTempTop.get_Item(0).y), new TSVector2(-10, WeedPOSTempBelow.get_Item(0).y)));
		yield return WaitTime(1.3);
		for (int j = 0; j < 4; j++)
		{
			PlayAreaEffect("FSpikeweed_Normal", WeedPOSTempTop.get_Item(j));
			PlayAreaEffect("FSpikeweed_Normal", WeedPOSTempBelow.get_Item(j));
		}
		CancelAttack();
		yield return null;
	}

	protected IEnumerator SpikeweedAttackLB()
	{
		for (int i = 0; i < 4; i++)
		{
			WeedPOSTempTop.Add(new TSVector2(-14 + 4 * i, WeedPOS.get_Item(0).y - 4.25));
			WeedPOSTempBelow.Add(new TSVector2(-14 + 4 * i, WeedPOS.get_Item(1).y - 4.25));
		}
		WarningFXCor = StartCor(WarningFx(new TSVector2(-10, WeedPOSTempTop.get_Item(0).y), new TSVector2(-10, WeedPOSTempBelow.get_Item(0).y)));
		yield return WaitTime(1.3);
		for (int j = 0; j < 4; j++)
		{
			PlayAreaEffect("FSpikeweed_Normal", WeedPOSTempTop.get_Item(j));
			PlayAreaEffect("FSpikeweed_Normal", WeedPOSTempBelow.get_Item(j));
		}
		CancelAttack();
		yield return null;
	}

	protected IEnumerator SpikeweedAttackRF()
	{
		for (int i = 0; i < 4; i++)
		{
			WeedPOSTempTop.Add(new TSVector2(2 + 4 * i, WeedPOS.get_Item(0).y));
			WeedPOSTempBelow.Add(new TSVector2(2 + 4 * i, WeedPOS.get_Item(1).y));
		}
		WarningFXCor = StartCor(WarningFx(new TSVector2(10, WeedPOSTempTop.get_Item(0).y), new TSVector2(10, WeedPOSTempBelow.get_Item(0).y)));
		yield return WaitTime(1.3);
		for (int j = 0; j < 4; j++)
		{
			PlayAreaEffect("FSpikeweed_Normal", WeedPOSTempTop.get_Item(j));
			PlayAreaEffect("FSpikeweed_Normal", WeedPOSTempBelow.get_Item(j));
		}
		CancelAttack();
		yield return null;
	}

	protected IEnumerator SpikeweedAttackRB()
	{
		for (int i = 0; i < 4; i++)
		{
			WeedPOSTempTop.Add(new TSVector2(2 + 4 * i, WeedPOS.get_Item(0).y - 4.25));
			WeedPOSTempBelow.Add(new TSVector2(2 + 4 * i, WeedPOS.get_Item(1).y - 4.25));
		}
		WarningFXCor = StartCor(WarningFx(new TSVector2(10, WeedPOSTempTop.get_Item(0).y), new TSVector2(10, WeedPOSTempBelow.get_Item(0).y)));
		yield return WaitTime(1.3);
		for (int j = 0; j < 4; j++)
		{
			PlayAreaEffect("FSpikeweed_Normal", WeedPOSTempTop.get_Item(j));
			PlayAreaEffect("FSpikeweed_Normal", WeedPOSTempBelow.get_Item(j));
		}
		CancelAttack();
		yield return null;
	}

	protected IEnumerator WarningFx(TSVector2 positionTop, TSVector2 positionBelow)
	{
		_warningFx.Add(PlayEffect(warningFx_short, 0.5f, default, new TSVector2(positionTop.x, positionTop.y)));
		_warningFx.Add(PlayEffect(warningFx_short, 0.5f, default, new TSVector2(positionBelow.x, positionBelow.y)));
		yield return WaitTime(2);
		for (int i = 0; i < _warningFx.Count; i++)
		{
			StopEffect(_warningFx.get_Item(i));
		}
		yield return null;
	}
}
