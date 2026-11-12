using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31701MoFaZhen;

public class Sigil_Activity : SkillSimpleBase
{
	private readonly string combo_key1 = "Start";

	private const int BUFF_ID = 317010040;

	private const int BUFF_ID_BASE = 317010010;

	private const int MAX_BUFF_NUM = 20;

	private const float CHECK_RANGE = 3.5f;

	private const double TICK_INTERVAL = 0.4;

	private const double ADD_BUFF_INTERVAL = 0.4;

	private const double DEATH_DELAY = 0.3;

	private const double DECAY_GRACE_TIME = 2.0;

	private long _fxCircle1 = -1L;

	private long _fxCircle2 = -1L;

	private long _fxLink = -1L;

	private bool _condMet;

	private bool _ended;

	private double _buffTimer;

	private double _decayGraceTimer;

	protected override void OnSkillEnable()
	{
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetSearchedImmunityEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		_ended = false;
		_condMet = false;
	}

	protected override void OnSkillDisable()
	{
		StopAllFx();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, combo_key1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.43);
		AddBuffToTarget(_actor, 317010010);
		_fxCircle1 = PlayEffect("fx_StoryActivity_17_loop_MagicCircle_1", 1f, 0, GetPosition(), 0, 0.7f);
		yield return WaitTime(0.1);
		while (!_ended)
		{
			if (GetBuffNum(_actor, 317010040) >= 20)
			{
				_ended = true;
				break;
			}
			CheckBuffState();
			yield return WaitTime(0.4);
		}
		StopAllFx();
		PlayEffect("fx_StoryActivity_17_base_MagicCircle_2_end_2", 1f, 0, GetPosition(), 0, 0.7f);
		PlayEffect("fx_StoryActivity_17_base_core_ready", 1f, 0, GetPosition(), 0, 0.7f);
		SetHideModelEnable();
		yield return WaitTime(0.3);
		KillActors(new List<LogicEntity> { _actor });
	}

	private void CheckBuffState()
	{
		TSVector2 position = GetPosition();
		TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
		bool flag = Distance(position, entityPosition) <= 3.5f;
		if (flag && !_condMet)
		{
			EnterCondMet();
			_buffTimer = 0.0;
		}
		else if (!flag && _condMet)
		{
			ExitCondMet();
		}
		_condMet = flag;
		if (flag)
		{
			_decayGraceTimer = 0.0;
			_buffTimer += 0.4;
			if (_buffTimer >= 0.4)
			{
				_buffTimer -= 0.4;
				if (GetBuffNum(_actor, 317010040) == 0)
				{
					RemoveBuffFromTarget(_actor, 317010010);
				}
				AddBuffToTarget(_actor, 317010040);
			}
			return;
		}
		_decayGraceTimer += 0.4;
		if (_decayGraceTimer >= 2.0 && GetBuffNum(_actor, 317010040) > 0)
		{
			RemoveBuffByNumFromTarget(_actor, 317010040, 1);
			if (GetBuffNum(_actor, 317010040) == 0)
			{
				AddBuffToTarget(_actor, 317010010);
			}
		}
		_buffTimer = 0.0;
	}

	private void EnterCondMet()
	{
		StopFx(ref _fxCircle1);
		_fxCircle2 = PlayEffect("fx_StoryActivity_17_loop_MagicCircle_2", 1f, 0, GetPosition(), 0, 0.7f);
		LogicEntity currentPlayer = GetCurrentPlayer();
		_fxLink = PlayLinkEffect("fx_StoryActivity_17_loop_link", useCustomSource: false, null, default, default, currentPlayer);
	}

	private void ExitCondMet()
	{
		StopFx(ref _fxCircle2);
		StopFx(ref _fxLink);
		PlayEffect("fx_StoryActivity_17_base_MagicCircle_2_end_1", 1f, 0, GetPosition(), 0, 0.7f);
		_fxCircle1 = PlayEffect("fx_StoryActivity_17_loop_MagicCircle_1", 1f, 0, GetPosition(), 0, 0.7f);
	}

	private void StopFx(ref long fxHandle, bool stopSubFx = false)
	{
		if (fxHandle > 0)
		{
			StopEffect(fxHandle, stopSubFx);
			fxHandle = -1L;
		}
	}

	private void StopAllFx()
	{
		StopFx(ref _fxCircle1);
		StopFx(ref _fxCircle2);
		StopFx(ref _fxLink);
	}
}
