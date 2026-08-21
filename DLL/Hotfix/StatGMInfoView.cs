#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Ase;
using Ase.ECS;
using GameFramework;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class StatGMInfoView : StatInfoViewBase
{
	[SerializeField]
	private Toggle tg_player;

	[SerializeField]
	private Toggle tg_ai;

	[SerializeField]
	private GameObject go_player_sel;

	[SerializeField]
	private GameObject go_ai_sel;

	[SerializeField]
	private TextMeshProUGUI tmp_player;

	[SerializeField]
	private TextMeshProUGUI tmp_ai;

	[SerializeField]
	private TextMeshProUGUI tmp_time;

	[SerializeField]
	private StatSubInfoItem item_damage;

	[SerializeField]
	private StatSubInfoItem item_damage_sec;

	[SerializeField]
	private StatSubInfoItem item_damage_last;

	[SerializeField]
	private StatSubInfoItem item_tenacity;

	[SerializeField]
	private StatSubInfoItem item_tenacity_sec;

	[SerializeField]
	private StatSubInfoItem item_tenacity_last;

	[SerializeField]
	private StatSubInfoView[] ai_subViews;

	[SerializeField]
	private StatSubInfoView team_subView;

	[SerializeField]
	private Button btn_gm;

	[SerializeField]
	private Button btn_unfold;

	[SerializeField]
	private Image img_gm_arrow;

	[SerializeField]
	private StatGMInfoItem gmInfoItem;

	private Dictionary<int, StatSubInfoView> ai_subViewDic;

	private int aiCount;

	private int mainPlayerId;

	private BaseEntity _actorEntity;

	private bool isOpenGm;

	[Space]
	[SerializeField]
	private Color imgShowColor = new Color(0f, 0f, 0f, 20f / 51f);

	[SerializeField]
	private Color tmpPlayerColor = new Color(1f / 51f, 0.654902f, 0.88235295f, 1f);

	[SerializeField]
	private Color tmpAIColor = new Color(84f / 85f, 38f / 51f, 0.003921569f);

	[SerializeField]
	private Color imgHideColor = new Color(0.5f, 0.5f, 0.5f);

	[SerializeField]
	private Color tmpHideColor = new Color(0.2f, 0.2f, 0.2f);

	private float _lastTimer = -1f;

	public override void OnInit()
	{
		base.OnInit();
		ai_subViewDic = new Dictionary<int, StatSubInfoView>();
		TextMeshProUGUI obj = tmp_time;
		if (obj != null)
		{
			((TMP_Text)obj).SetText("0", true);
		}
		item_damage.OnReset();
		item_damage_sec.OnReset();
		item_damage_last.OnReset();
		item_damage.SetName("总伤害");
		item_damage_sec.SetName("每秒伤害");
		item_damage_last.SetName("最后一击伤害");
		item_tenacity.OnReset();
		item_tenacity_sec.OnReset();
		item_tenacity_last.OnReset();
		item_tenacity.SetName("总削韧");
		item_tenacity_sec.SetName("每秒削韧");
		item_tenacity_last.SetName("最后一击削韧");
		if (ai_subViews == null)
		{
			Log.Error("BattleStatView 预设组件丢失");
			return;
		}
		for (int i = 0; i < ai_subViews.Length; i++)
		{
			ai_subViews[i].OnReset();
			ai_subViews[i].SetVisibility(visibility: false);
		}
		team_subView.OnReset();
		tg_player.onValueChanged.AddListener(OnToggle_Player);
		tg_ai.onValueChanged.AddListener(OnToggle_AI);
		btn_gm.onClick.AddListener(OnBtn_GM);
		btn_unfold.onClick.AddListener(OnBtn_Unfold);
		isOpenGm = true;
		UpdateGmItem();
	}

	public void InitGMAction(Action<BattleGMEnum> callback)
	{
		gmInfoItem.OnInit(callback);
	}

	public override void OnInitInfo(List<HeroEntity> heros)
	{
		base.OnInitInfo(heros);
		aiCount = heros.Count - 1;
		if (aiCount > ai_subViews.Length)
		{
			Log.Error("AI 数量超出统计面板最大AI数量");
			return;
		}
		int num = 0;
		for (int i = 0; i < heros.Count; i++)
		{
			if (!heros[i].IsActorEntity)
			{
				OnInitAI(num, heros[i]);
				num++;
			}
			else
			{
				mainPlayerId = heros[i].Id;
				_actorEntity = heros[i];
			}
		}
		team_subView.SetVisibility(aiCount > 0);
		tg_player.isOn = true;
		if (aiCount > 0)
		{
			tg_ai.isOn = true;
			team_subView.SetShowName("小队");
			team_subView.SetVisibility(visibility: true);
		}
		else
		{
			tg_ai.isOn = false;
			tg_ai.interactable = false;
		}
	}

	private void OnInitAI(int index, HeroEntity ai)
	{
		StatSubInfoView statSubInfoView = ai_subViews[index];
		statSubInfoView.SetShowName(ai.BattleHeroData.Name);
		statSubInfoView.SetVisibility(visibility: true);
		ai_subViewDic.Add(ai.Id, statSubInfoView);
	}

	private void OnToggle_Player(bool isOn)
	{
		item_damage.SetVisibility(isOn, 0.1f);
		item_damage_sec.SetVisibility(isOn, 0.1f);
		item_damage_last.SetVisibility(isOn, 0.1f);
		item_tenacity.SetVisibility(isOn, 0.1f);
		item_tenacity_sec.SetVisibility(isOn, 0.1f);
		item_tenacity_last.SetVisibility(isOn, 0.1f);
		tg_player.image.color = (isOn ? imgShowColor : imgHideColor);
		((Graphic)(object)tmp_player).color = (isOn ? tmpPlayerColor : tmpHideColor);
		go_player_sel?.SetActive(isOn);
	}

	private void OnToggle_AI(bool isOn)
	{
		for (int i = 0; i < aiCount; i++)
		{
			ai_subViews[i].SetVisibility(isOn, 0.1f);
		}
		team_subView.SetVisibility(isOn, 0.1f);
		tg_ai.image.color = (isOn ? imgShowColor : imgHideColor);
		((Graphic)(object)tmp_ai).color = (isOn ? tmpAIColor : tmpHideColor);
		go_ai_sel?.SetActive(isOn);
	}

	private void OnBtn_GM()
	{
		isOpenGm = true;
		UpdateGmItem();
	}

	private void OnBtn_Unfold()
	{
		isOpenGm = false;
		UpdateGmItem();
	}

	private void UpdateGmItem()
	{
		btn_gm.gameObject.SetActive(!isOpenGm);
		btn_unfold.gameObject.SetActive(isOpenGm);
		gmInfoItem.OnShowGMItem(isOpenGm);
	}

	public void UpdateGMSatte(BattleGMEnum gmEnum, bool isOpen)
	{
		gmInfoItem.OnUpdateGMState(gmEnum, isOpen);
	}

	public void SetGMInteractable(BattleGMEnum gmEnum, bool isInter)
	{
		gmInfoItem?.SetGMInteractable(gmEnum, isInter);
	}

	public override void OnRefreshStat(int battleTime, int entityId, EntityStatInfo info, List<EntityStatInfo> infoList)
	{
		base.OnRefreshStat(battleTime, entityId, info, infoList);
		StatSubInfoView value;
		if (entityId == mainPlayerId)
		{
			OnRefreshMainPlayerStat(battleTime, info);
		}
		else if (ai_subViewDic.TryGetValue(entityId, out value))
		{
			value.UpdateStatInfo(info);
		}
		if (aiCount > 0)
		{
			team_subView?.UpdateStatInfo(infoList);
		}
	}

	private void OnRefreshMainPlayerStat(int battleTime, EntityStatInfo info)
	{
		item_damage.SetValue(info.Damage);
		item_damage_sec.SetValue(Mathf.Ceil(info.Damage / (float)battleTime));
		item_tenacity.SetValue(info.Tenacity);
		item_tenacity_sec.SetValue(Mathf.Ceil(info.Tenacity / (float)battleTime));
		item_damage_last.SetValue(info.EntityGlobalStatDataInfo.lastHitDamage);
		item_tenacity_last.SetValue(info.EntityGlobalStatDataInfo.lastHitTenacity);
	}

	public override void ResetStatInfo()
	{
		item_damage.SetValue(0f);
		item_damage_sec.SetValue(0f);
		item_tenacity.SetValue(0f);
		item_tenacity_sec.SetValue(0f);
		item_damage_last.SetValue(0f);
		item_tenacity_last.SetValue(0f);
		StatSubInfoView[] array = ai_subViews;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].OnResetValue();
		}
		team_subView.OnResetValue();
	}

	public override void UpdateTimer(float timer)
	{
		if (_lastTimer != timer)
		{
			_lastTimer = timer;
			TimeSpan timeSpan = TimeSpan.FromSeconds(timer);
			TextMeshProUGUI obj = tmp_time;
			if (obj != null)
			{
				((TMP_Text)obj).SetText(timeSpan.ToString("mm\\:ss\\:ff"), true);
			}
		}
	}
}
