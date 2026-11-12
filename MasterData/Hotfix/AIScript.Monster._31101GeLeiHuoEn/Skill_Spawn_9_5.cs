using System.Collections;
using TrueSync;

namespace AIScript.Monster._31101GeLeiHuoEn;

public class Skill_Spawn_9_5 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Born = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	private readonly string fx_Alias = "fx_common_base_monster_in";

	private readonly string fx_Alias1 = "fx_common_base_monster_in_ground";

	protected TSVector2 TargetPosition;

	private readonly string combo_key1 = "DogHunting";

	private readonly string combo_key2 = "Maline_9_5";

	private CoroutineNode _normalCor;

	private bool _finalStarted;

	private int _deathCount;

	protected override void OnSkillEnable()
	{
		SetUnparalleledEnable();
		InitListenEvent(MonsterEventType.MonsterDie, true, InterruptStrong, 1800627574, 2087480425, 1818848083, 1766612844, 1769236583, 1749247854, 1601071457, 1950445135);
	}

	private void InterruptStrong(IEvent evt)
	{
		_deathCount++;
		if (_finalStarted)
		{
			return;
		}
		switch (_deathCount)
		{
		case 25:
		case 46:
		case 67:
		case 71:
			_normalCor = StartCor(DoSomething());
			break;
		case 89:
			_finalStarted = true;
			if (_normalCor != null)
			{
				StopCor(_normalCor);
			}
			StartCor(DoSomethingFinal());
			break;
		}
	}

	private IEnumerator DoSomething()
	{
		yield return WaitTime(2.5);
		BeginAttack(3, combo_key1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1);
		CancelAttack();
	}

	private IEnumerator DoSomethingFinal()
	{
		yield return WaitTime(1);
		BeginAttack(4, combo_key2, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(999);
		CancelAttack();
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		PlayEffect(fx_Alias, 1f, default, GetPosition(), GetEntityAngle(_actor));
		PlayEffect(fx_Alias1, 1f, default, GetPosition(), GetEntityAngle(_actor));
		yield return WaitTime(0.65);
		BeginAttack(1, Born, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(3.2);
		AddBuffToTarget(_actor, 311010020);
		yield return WaitTime(1);
		BeginAttack(2, combo_key1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1);
		CancelAttack();
		yield return WaitTime(999999999);
	}
}
