using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70022HuaYuan;

public class Skill_Illusion_BFan : SkillSimpleBase
{
	private static readonly string FlashFx = "fx_70022_base_Kagebunsin_Flash";

	private static TSVector2 TargetPOS;

	private static List<TSVector2> SummonPOS = new List<TSVector2>
	{
		new TSVector2(0, 10),
		new TSVector2(10, 0),
		new TSVector2(0, -10),
		new TSVector2(-10, 0)
	};

	private static readonly TSVector2 ZeroPOS = new TSVector2(0, 0);

	private static bool MoveSwitch = false;

	private static bool AttackTag = false;

	private static int Dnumb = 7;

	private static LogicEntity Target;

	private static TSVector2 SelfPOS;

	private static FP DIST;

	private static bool StateSwitch;

	private static FP CheckINTR = 0.2;

	private static CoroutineNode Check;

	private static FP HideDuration = 20;

	private static int NinjutsuIndex = 0;

	private static string NinjutsuKey = "Ninjutsu_G";

	private static List<LogicEntity> ClearActor = new List<LogicEntity>();

	protected override void OnSkillEnable()
	{
		AttackHintHide();
		Dnumb = 7;
		MoveSwitch = false;
		AttackTag = false;
	}

	protected override void OnSkillDisable()
	{
		MoveSwitch = false;
		Dnumb = 7;
		AttackTag = false;
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return StartCor(MoveTo());
		Check = StartCor(CheckTarget());
		yield return StartCor(WaitTag());
		yield return WaitTime(5);
		CancelAttack();
		yield return StartCor(ClearSefe());
	}

	protected IEnumerator MoveTo()
	{
		for (int i = 0; i < 200; i++)
		{
			MoveSwitch = GetLogicTagToggleValue(_actor, "MoveSwitch");
			if (MoveSwitch)
			{
				PlayEffect(FlashFx, 1f, default, GetPosition(), default, 2.2f);
				yield return WaitTime(0.1);
				Dnumb = (int)(long)GetLogicTagFpValue(_actor, "Dnumb");
				switch (Dnumb)
				{
				case 0:
					TargetPOS = SummonPOS.get_Item(2);
					break;
				case 1:
					TargetPOS = SummonPOS.get_Item(3);
					break;
				case 2:
					TargetPOS = SummonPOS.get_Item(0);
					break;
				case 3:
					TargetPOS = SummonPOS.get_Item(1);
					break;
				}
				Teleport(TargetPOS);
				SetHideModelEnable();
				SetHideOutEnable();
				BeginLookAtByPos_NotWait(ZeroPOS, 0.3, 999);
				yield return WaitTime(2);
				break;
			}
			yield return WaitTime(0.1);
		}
	}

	protected IEnumerator CheckTarget()
	{
		BeginAttack(NinjutsuIndex, NinjutsuKey, flushInputedKeys: true, forceInterruptAttack: true);
		Target = GetCurrentPlayer();
		SelfPOS = GetPosition();
		StateSwitch = true;
		for (int i = 0; i < HideDuration / CheckINTR; i++)
		{
			TargetPOS = GetEntityPositionObsoleted(Target);
			DIST = Distance(SelfPOS, TargetPOS);
			if (DIST <= 3.5 && StateSwitch)
			{
				SetHideModelDisable();
				SetHideOutDisable();
				StateSwitch = false;
			}
			else if (DIST > 3.5 && !StateSwitch)
			{
				SetHideOutEnable();
				yield return WaitTime(0.3);
				SetHideModelEnable();
				StateSwitch = true;
			}
			yield return WaitTime(CheckINTR);
		}
	}

	protected IEnumerator WaitTag()
	{
		for (int i = 0; i < 200; i++)
		{
			AttackTag = GetLogicTagToggleValue(_actor, "Attack");
			if (AttackTag)
			{
				StopCor(Check);
				SetHideModelDisable();
				SetHideOutDisable();
				break;
			}
			yield return WaitTime(0.1);
		}
	}

	protected IEnumerator ClearSefe()
	{
		yield return WaitTime(0.5);
		PlayEffect(FlashFx, 1f, default, GetPosition(), default, 2.2f);
		ClearActor.Add(_actor);
		ClearActors(ClearActor);
	}
}
