using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_Summon_Ultra_Phase_1 : SkillSimpleBase
{
	private string key_Base = "Book_Ultra";

	private string FxLink = "fx_m70001_loop_skill13_self_ball_link";

	private string FxOut = "fx_m70001_base_skill13_self_ball_out";

	private long EffectName1;

	private long EffectName2;

	private Dictionary<string, string> FxDissolveList = new Dictionary<string, string>
	{
		["Normal"] = "fx_m70001_base_skill13_book_02_dissolve",
		["Golden"] = "fx_m70001_base_skill13_book_02_dissolve",
		["Blue"] = "fx_m70001_base_skill13_book_03_dissolve",
		["Red"] = "fx_m70001_base_skill13_book_04_dissolve"
	};

	private List<FP> MoveTime = new List<FP> { 3, 3.5, 3.5, 4 };

	protected override void OnInterrupt(int comboIndex)
	{
		StopEffect(EffectName1);
		StopEffect(EffectName2);
	}

	protected override IEnumerator DoMainLogic()
	{
		AdventureActor Boss = (_actor as MonsterAdventureActor).monsterSummonInfo.SummonActor;
		TSVector2 BossPos = TransLocalPosToWorldPos(GetEntityPosition(Boss), GetEntityForward(Boss), new TSVector2(0, 4.5));
		TSVector2 FxPos = TransLocalPosToWorldPos(GetEntityPosition(Boss), GetEntityForward(Boss), new TSVector2(-0.2, 4.5));
		Skill_Summon_Ultra_Phase_1 skill_Summon_Ultra_Phase_ = this;
		string fxLink = FxLink;
		TSVector2 targetPosition = BossPos;
		FP targetPositionY = 4.5;
		long LinkName = skill_Summon_Ultra_Phase_.PlayLinkEffect(fxLink, useCustomSource: false, null, default, default, null, targetPosition, targetPositionY);
		FP fP = Distance(GetPosition(), GetEntityPosition(Boss));
		FP fP2 = MoveTime.get_Item(TSRandom.Range(0, MoveTime.Count));
		_actor.actorInfo.runSpeed = fP / fP2;
		_actor.RefreshMoveSpeed();
		yield return WaitTime(5);
		MoveToPosition(BossPos, 2);
		yield return WaitMoveStatus();
		EffectName1 = PlayEffect(FxOut, 1f, 4.5, FxPos, 0, 1.5f);
		EffectName2 = PlayEffect(FxDissolveList.get_Item(GetMonsterTagValue(_actor, 1)), 1f, 0, GetPosition(), GetEntityAngle(_actor));
		StopEffect(LinkName);
		AddBuffToTarget(Boss, 700010015);
		SetUnparalleledEnable();
		SetHideModelEnable();
		yield return WaitTime(1);
		StopEffect(EffectName1);
		StopEffect(EffectName2);
		_actor.ClearSelf();
	}
}
