using System;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_124 : SoldierPartnerBase
{
	private enum Weather
	{
		ShunFeng,
		QingKong,
		ZhangChao,
		HaiWu,
		BaoYu,
		Count
	}

	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.HangHaiJia;

	private static readonly TSVector2 fxPosition = new TSVector2(0, 0);

	private static readonly FP fxPositionY = 0;

	private static readonly FP fxAngle = 180;

	private const float fxScale = 1f;

	private static readonly string[] weatherFx = new string[5] { "FX/Soldier/fx_soldier_base_navigator_smooth", "FX/ScreenEffect/fx_screen_soldier_navigator_clearsky", "FX/ScreenEffect/fx_screen_soldier_navigator_tide", "FX/ScreenEffect/fx_screen_soldier_navigator_seafog", "FX/ScreenEffect/fx_screen_soldier_navigator_rainstorm" };

	private static readonly int[] weatherWeight = new int[5] { 1818848083, 1800633452, 1600941161, 1751607628, 1735289204 };

	private const int buff_ShunFeng = 260112411;

	private const int buff_ShunFeng_Member = 260112412;

	private readonly FP energy_ShunFeng = 0.3;

	private const int buff_QingKong = 260112421;

	private const int buff_QingKong_Member = 260112422;

	private const int buff_ZhangChao = 260112431;

	private const int buff_ZhangChao_Member = 260112432;

	private const int buff_HaiWu = 260112441;

	private const int buff_HaiWu_Member = 260112442;

	private const int buff_BaoYu = 260112451;

	private static readonly FP energyRateDown_BaoYu = 0.3;

	private SoldierLevelController _levelCtrl;

	private readonly List<SoldierActor> _allyBuffer = new List<SoldierActor>();

	private readonly List<SoldierActor> _enemyBuffer = new List<SoldierActor>();

	private readonly List<(SoldierActor actor, FP delta)> _ratePatched = new List<(SoldierActor, FP)>();

	private AdventureFXPlayer _weatherFx;

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
	}

	protected override void OnPartnerDisable()
	{
		base.OnPartnerDisable();
		for (int i = 0; i < _ratePatched.Count; i++)
		{
			var (soldierActor, fP) = _ratePatched.get_Item(i);
			if (soldierActor != null)
			{
				soldierActor.ModifyEnergyRecoverRatePercent(-fP);
			}
		}
		_ratePatched.Clear();
		StopWeatherFx();
		_allyBuffer.Clear();
		_enemyBuffer.Clear();
		_levelCtrl = null;
	}

	protected override void OnPartnerBattleStart()
	{
		base.OnPartnerBattleStart();
		if (!(_levelCtrl == null) && RollWeather(out var weather))
		{
			PlayWeatherFx(weather);
			ApplyWeather(weather);
		}
	}

	private bool RollWeather(out Weather weather)
	{
		weather = Weather.ShunFeng;
		int num = 5;
		if (weatherWeight.Length < num)
		{
			Debug.LogError($"SoldierPartner_124 weatherWeight 长度 {weatherWeight.Length} 少于天气种类 {num}");
			return false;
		}
		int num2 = 0;
		for (int i = 0; i < num; i++)
		{
			if (weatherWeight[i] > 0)
			{
				num2 += weatherWeight[i];
			}
		}
		if (num2 <= 0)
		{
			Debug.LogError("SoldierPartner_124 天气权重全为 0，本局不出天气");
			return false;
		}
		int num3 = TSRandom.Range(0, num2);
		for (int j = 0; j < num; j++)
		{
			if (weatherWeight[j] > 0)
			{
				num3 -= weatherWeight[j];
				if (num3 < 0)
				{
					weather = (Weather)j;
					return true;
				}
			}
		}
		return false;
	}

	private void ApplyWeather(Weather weather)
	{
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return;
		}
		if (weather == Weather.BaoYu)
		{
			ApplyBaoYu(_levelCtrl.GetAllActors(mainControlActor, _allyBuffer));
			SoldierActor enemyMainControlActor = _levelCtrl.enemyMainControlActor;
			if (enemyMainControlActor != null)
			{
				ApplyBaoYu(_levelCtrl.GetAllActors(enemyMainControlActor, _enemyBuffer));
			}
			return;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _allyBuffer);
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!IsAffected(soldierActor))
			{
				continue;
			}
			bool flag = IsMember(soldierActor);
			switch (weather)
			{
			case Weather.ShunFeng:
				AddBuff(soldierActor, 260112411);
				if (flag)
				{
					AddBuff(soldierActor, 260112412);
					int val = soldierActor.energy + (int)(long)(soldierActor.maxEnergy * energy_ShunFeng);
					soldierActor.SetEnergy(Math.Min(soldierActor.maxEnergy, val));
				}
				break;
			case Weather.QingKong:
				AddBuff(soldierActor, 260112421);
				if (flag)
				{
					AddBuff(soldierActor, 260112422);
				}
				break;
			case Weather.ZhangChao:
				AddBuff(soldierActor, 260112431);
				if (flag)
				{
					AddBuff(soldierActor, 260112432);
				}
				break;
			case Weather.HaiWu:
				AddBuff(soldierActor, 260112441);
				if (flag)
				{
					AddBuff(soldierActor, 260112442);
				}
				break;
			}
		}
	}

	private void ApplyBaoYu(List<SoldierActor> actors)
	{
		for (int i = 0; i < actors.Count; i++)
		{
			SoldierActor actor = actors.get_Item(i);
			if (IsAffected(actor) && !IsMember(actor))
			{
				AddBuff(actor, 260112451);
				AddEnergyRate(actor, -energyRateDown_BaoYu);
			}
		}
	}

	private bool IsMember(SoldierActor actor)
	{
		if (actor != null && !actor.isEnemyCamp)
		{
			return actor.HasPartnerType(partnerTypes);
		}
		return false;
	}

	private bool IsAffected(SoldierActor actor)
	{
		if (actor == null || actor.isDead || actor.buffComponent == null)
		{
			return false;
		}
		SoldierActor summoner;
		return !IsSummoned(actor, out summoner);
	}

	private void AddBuff(SoldierActor actor, int buffId)
	{
		if (buffId != 0)
		{
			actor.buffComponent.AddBuff(buffId, actor);
		}
	}

	private void AddEnergyRate(SoldierActor actor, FP delta)
	{
		if (!(delta == FP.Zero))
		{
			actor.ModifyEnergyRecoverRatePercent(delta);
			_ratePatched.Add((actor, delta));
		}
	}

	private void PlayWeatherFx(Weather weather)
	{
		if (weather >= Weather.ShunFeng && (int)weather < weatherFx.Length)
		{
			string text = weatherFx[(int)weather];
			if (!string.IsNullOrEmpty(text))
			{
				StopWeatherFx();
				Vector3 spawnPosition = new Vector3((float)fxPosition.x, (float)fxPositionY, (float)fxPosition.y);
				Quaternion spawnRotation = Quaternion.Euler(0f, 0f - (float)fxAngle, 0f);
				_weatherFx = AdventureFXManager.PlayFX(text, 1f, spawnPosition, spawnRotation);
			}
		}
	}

	private void StopWeatherFx()
	{
		_weatherFx?.Stop();
		_weatherFx = null;
	}
}
