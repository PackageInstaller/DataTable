using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.BrickBreaker._14501;

public class Skill : SkillSimpleBase
{
	private readonly string combo_key = "Ultra_1_TimelineOn";

	private readonly string eventBoom = "Fire";

	private readonly string areaFx = "AreaEffect_145_BreakOut";

	private const int BulletNum = 6;

	private readonly string bullet_kw = "Bullet_145_Ultra_BreakOut";

	private readonly FP pauseTime = 0.3;

	private readonly FP waitShoot = 0.1;

	private readonly string ballfx = "fx_14501_bullet_Ball_trail_breakout";

	private FP ballFx_duration = 0.45;

	private readonly List<Brick_Ball> _ballFxKeys = new List<Brick_Ball>();

	private readonly List<AdventureFXPlayer> _ballFxPlayers = new List<AdventureFXPlayer>();

	private FP _ballFxTimer;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopAllBallFx();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, combo_key, flushInputedKeys: true, forceInterruptAttack: true);
		List<Brick_Ball> allBalls = Singleton<BrickBreakerManager>.Instance.GetEnergyBalls();
		if (allBalls != null)
		{
			for (int i = 0; i < allBalls.Count; i++)
			{
				Brick_Ball brick_Ball = allBalls.get_Item(i);
				if (brick_Ball == null)
				{
					continue;
				}
				TSVector2 position = brick_Ball.tsTransform.Position;
				Vector3 pos = new Vector3((float)position.x, 1f, (float)position.y);
				if (!string.IsNullOrEmpty(ballfx))
				{
					AdventureFXPlayer adventureFXPlayer = Singleton<BrickBreakerManager>.Instance.PlayBrickFx(ballfx, pos, brick_Ball.transform, _actor);
					if (adventureFXPlayer != null)
					{
						_ballFxKeys.Add(brick_Ball);
						_ballFxPlayers.Add(adventureFXPlayer);
					}
				}
			}
			if (_ballFxPlayers.Count > 0)
			{
				_ballFxTimer = ballFx_duration;
			}
		}
		yield return WaitCustomEvent(eventBoom);
		yield return WaitTime(waitShoot);
		if (allBalls != null)
		{
			for (int j = 0; j < allBalls.Count; j++)
			{
				Brick_Ball brick_Ball2 = allBalls.get_Item(j);
				if (!(brick_Ball2 == null))
				{
					TSVector2 position2 = brick_Ball2.tsTransform.Position;
					for (int k = 0; k < 6; k++)
					{
						FP degrees = (FP)360 / (FP)6 * k;
						TSVector2 shootDir = TSVector2.Rotate(TSVector2.up, degrees);
						ILRuntimeAPI.ShootByDirection(bullet_kw, _actor, 0, shootDir, position2, 1.6f);
					}
				}
			}
		}
		yield return WaitTime(0.1);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	public void OnUpdate()
	{
		if (_ballFxPlayers.Count == 0)
		{
			return;
		}
		_ballFxTimer -= _actor.LogicDeltaTime;
		if (_ballFxTimer <= 0)
		{
			StopAllBallFx();
			return;
		}
		List<Brick_Ball> energyBalls = Singleton<BrickBreakerManager>.Instance.GetEnergyBalls();
		for (int num = _ballFxKeys.Count - 1; num >= 0; num--)
		{
			if (_ballFxKeys.get_Item(num) == null || energyBalls == null || !energyBalls.Contains(_ballFxKeys.get_Item(num)))
			{
				StopBallFx(_ballFxPlayers.get_Item(num));
				_ballFxKeys.RemoveAt(num);
				_ballFxPlayers.RemoveAt(num);
			}
		}
	}

	private void StopBallFx(AdventureFXPlayer fx)
	{
		if (!(fx == null))
		{
			fx.syncNode = null;
			fx.Stop();
		}
	}

	private void StopAllBallFx()
	{
		for (int i = 0; i < _ballFxPlayers.Count; i++)
		{
			StopBallFx(_ballFxPlayers.get_Item(i));
		}
		_ballFxKeys.Clear();
		_ballFxPlayers.Clear();
		_ballFxTimer = 0;
	}

	protected override void OnCustomEvent(int comboIndex, string evt)
	{
		if (!evt.Equals(eventBoom))
		{
			return;
		}
		List<Brick_Ball> energyBalls = Singleton<BrickBreakerManager>.Instance.GetEnergyBalls();
		if (energyBalls == null)
		{
			return;
		}
		Singleton<BrickBreakerManager>.Instance.ballPauseTime = pauseTime;
		for (int i = 0; i < energyBalls.Count; i++)
		{
			Brick_Ball brick_Ball = energyBalls.get_Item(i);
			if (!(brick_Ball == null))
			{
				TSVector2 position = brick_Ball.tsTransform.Position;
				new Vector3((float)position.x, 1f, (float)position.y);
				if (!string.IsNullOrEmpty(areaFx))
				{
					ILRuntimeAPI.PlayAreaEffect(_actor, areaFx, position);
				}
			}
		}
	}
}
