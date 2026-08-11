#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Ase;
using Ase.ECS;
using Cysharp.Text;
using GameFramework;
using TMPro;
using UnityEngine;

public class StatTimerInfoView : StatInfoViewBase
{
	[SerializeField]
	private TextMeshProUGUI tmp_timer;

	[SerializeField]
	private StatSubInfoView[] hero_subViews;

	[SerializeField]
	private StatSubInfoView team_subView;

	[SerializeField]
	private GameObject go_timer;

	private bool isCountDown;

	private float timer;

	private bool isMultiPlayer;

	private Dictionary<int, StatSubInfoView> statSubViewDic = new Dictionary<int, StatSubInfoView>();

	private float _lastTimer = -1f;

	public override void OnInit()
	{
		base.OnInit();
		((Component)(object)tmp_timer).gameObject.SetActive(value: true);
		for (int i = 0; i < hero_subViews.Length; i++)
		{
			hero_subViews[i].OnReset();
			hero_subViews[i].SetVisibility(visibility: false);
		}
		team_subView.OnReset();
		_lastTimer = -1f;
	}

	public override void OnInitInfo(List<HeroEntity> heros)
	{
		base.OnInitInfo(heros);
		if (heros.Count > hero_subViews.Length)
		{
			Log.Error("Hero 数量超出统计面板最大Hero数量");
			return;
		}
		isMultiPlayer = heros.Count > 1;
		team_subView.SetVisibility(isMultiPlayer);
		int num = 1;
		for (int i = 0; i < heros.Count; i++)
		{
			if (heros[i].IsActorEntity)
			{
				OnInitHero(0, heros[i]);
				continue;
			}
			OnInitHero(num, heros[i]);
			num++;
		}
		if (isMultiPlayer)
		{
			team_subView.SetShowName("小队");
			team_subView.SetVisibility(visibility: true);
		}
	}

	private void OnInitHero(int index, HeroEntity hero)
	{
		string text = ((index == 0) ? "8cb1da" : "ffd8ab");
		StatSubInfoView statSubInfoView = hero_subViews[index];
		statSubInfoView.SetShowName("<color=#" + text + ">" + hero.BattleHeroData.Name + "</color>");
		statSubInfoView.SetVisibility(visibility: true);
		statSubViewDic.Add(hero.Id, statSubInfoView);
	}

	public void OnStartReadyTimer(bool isStart)
	{
		go_timer?.SetActive(isStart);
	}

	public override void UpdateTimer(float timer)
	{
		if (_lastTimer != timer)
		{
			_lastTimer = timer;
			if ((UnityEngine.Object)(object)tmp_timer != null)
			{
				TimeSpan timeSpan = TimeSpan.FromSeconds(Mathf.Max(0, 60 - (int)timer));
				((TMP_Text)tmp_timer).SetText(ZString.Format("{0:00}:{1:00}", timeSpan.Minutes, timeSpan.Seconds), true);
			}
		}
	}

	public override void OnRefreshStat(int battleTime, int entityId, EntityStatInfo info, List<EntityStatInfo> infoList)
	{
		base.OnRefreshStat(battleTime, entityId, info, infoList);
		if (statSubViewDic.TryGetValue(entityId, out var value))
		{
			value.UpdateStatInfo(info);
		}
		if (isMultiPlayer)
		{
			team_subView?.UpdateStatInfo(infoList);
		}
	}
}
