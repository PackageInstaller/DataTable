using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Activity.Duona;

public class Skill_Check_Red_Envelope : SkillSimpleBase
{
	private readonly string fx_idle = "Actor/Monster/30801XinXiang_Red/FX/fx_drop_mail_red_idle";

	private readonly string fx_get = "Actor/Monster/30801XinXiang_Red/FX/fx_drop_mail_red_get";

	private readonly string fx_warn = "FX/Warning/fx_warning_circular_2";

	private FP intervaltime = 0.03f;

	private int checkid = 308030101;

	private int activeid = 308030111;

	private int checkbossid = 308030001;

	private int dropitemid = 127;

	private long fx_1;

	private long fx_warning;

	private LogicEntity boss;

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	private PlayFX _playFx;

	protected override void OnSkillEnable()
	{
		SetBattleOutEnable(autoDisableWhenSkillDisable: false);
		SetLogicTagToggleValue(_actor, "isEnvelope", value: true);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopEffect(fx_1);
		StopEffect(fx_warning);
	}

	protected override IEnumerator DoMainLogic()
	{
		fx_1 = PlayEffect(fx_idle, 1f, 1.25f, GetPosition());
		StartCor(checkplayer());
		StartCor(checkboss());
		StartCor(timekill());
		yield return WaitTime(999);
	}

	private IEnumerator checkplayer()
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		FP fP = Distance(GetPosition(), GetEntityPosition(currentPlayer));
		while (fP > 1.5f)
		{
			yield return WaitTime(intervaltime);
			currentPlayer = GetCurrentPlayer();
			fP = Distance(GetPosition(), GetEntityPosition(currentPlayer));
		}
		StopEffect(fx_1);
		PlayEffect(fx_get, 1f, 1.25f, GetPosition());
		AddBuffToTarget(GetCurrentPlayer(), checkid);
		yield return WaitTime(0.3f);
		_actor.DestroySelf();
		yield return WaitTime(1);
	}

	private IEnumerator checkboss()
	{
		if (GetTargetByBuffID(checkbossid).Count == 0)
		{
			yield break;
		}
		yield return WaitTime(1);
		List<LogicEntity> targetByBuffID = GetTargetByBuffID(checkbossid);
		if (targetByBuffID.Count != 0)
		{
			boss = targetByBuffID.get_Item(0);
			TSVector2 entityPosition = GetEntityPosition(boss);
			FP fP = Distance(GetPosition(), entityPosition);
			while (fP > 1.5f)
			{
				yield return WaitTime(intervaltime);
				boss = GetTargetByBuffID(checkbossid).get_Item(0);
				entityPosition = GetEntityPosition(boss);
				fP = Distance(GetPosition(), entityPosition);
			}
			StopEffect(fx_1);
			PlayEffect(fx_get, 1f, 1.25f, GetPosition());
			AddBuffToTarget(boss, activeid);
			yield return WaitTime(0.3f);
			_actor.DestroySelf();
		}
	}

	private IEnumerator timekill()
	{
		yield return WaitTime(999);
		PlayEffect(fx_get, 1f, 1.25f, GetPosition());
		yield return WaitTime(0.3f);
		_actor.DestroySelf();
	}
}
