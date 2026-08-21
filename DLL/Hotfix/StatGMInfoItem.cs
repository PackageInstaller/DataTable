using System;
using Ase;
using DG.Tweening;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class StatGMInfoItem : UIBehaviour
{
	[SerializeField]
	private CanvasGroup cg_content;

	[SerializeField]
	private Button btn_refreshCD;

	[SerializeField]
	private Image img_trgger_refreshCD;

	[SerializeField]
	private Button btn_energy;

	[SerializeField]
	private GameObject go_energy_open;

	[SerializeField]
	private Button btn_sp;

	[SerializeField]
	private GameObject go_sp_open;

	[SerializeField]
	private Button btn_reset;

	[SerializeField]
	private Image img_trigger_reset;

	[SerializeField]
	private Button btn_autoWeakness;

	[SerializeField]
	private GameObject go_autoWeakness_open;

	[SerializeField]
	private Button btn_ai;

	[SerializeField]
	private GameObject go_ai_open;

	[SerializeField]
	private Button btn_clearData;

	[SerializeField]
	private Image img_trigger_clearData;

	[SerializeField]
	private Button btn_autoClear;

	[SerializeField]
	private GameObject go_autoClear_open;

	[SerializeField]
	private Button btn_team_ai;

	[SerializeField]
	private GameObject go_teamAI_open;

	[SerializeField]
	private GameObject go_teamAI_noInter;

	[SerializeField]
	private Button btn_tenacity_level;

	[SerializeField]
	private Image img_trigger_tenacityLevel;

	[SerializeField]
	private Button btn_down;

	[SerializeField]
	private GameObject go_down_open;

	private Action<BattleGMEnum> callback;

	[SerializeField]
	private Color triggerColor = new Color(0.75686276f, 31f / 51f, 0.38039216f, 20f / 51f);

	public void OnInit(Action<BattleGMEnum> callback)
	{
		this.callback = callback;
		InitComponent();
	}

	private void InitComponent()
	{
		btn_refreshCD.onClick.AddListener(OnBtn_RefreshCD);
		btn_energy.onClick.AddListener(OnBtn_Energy);
		btn_sp.onClick.AddListener(OnBtn_Sp);
		btn_reset.onClick.AddListener(OnBtn_Reset);
		btn_autoWeakness.onClick.AddListener(OnBtn_AutoWeakness);
		btn_ai.onClick.AddListener(OnBtn_Ai);
		btn_clearData.onClick.AddListener(OnBtn_ClearData);
		btn_autoClear.onClick.AddListener(OnBtn_AutoClear);
		btn_team_ai.onClick.AddListener(OnBtn_TeamAI);
		btn_tenacity_level.onClick.AddListener(OnBtn_Tenacity_Level);
		btn_down.onClick.AddListener(OnBtn_BossDown);
	}

	public void OnShowGMItem(bool isShow)
	{
		CanvasGroup obj = cg_content;
		if (obj != null)
		{
			DOTweenModuleUI.DOFade(obj, (float)(isShow ? 1 : 0), 0.1f);
		}
		cg_content.interactable = isShow;
	}

	public void OnUpdateGMState(BattleGMEnum gmEnum, bool isOpen)
	{
		switch (gmEnum)
		{
		case BattleGMEnum.RefreshCD:
			DOTweenModuleUI.DOColor(img_trgger_refreshCD, triggerColor, 0.1f).OnComplete(delegate
			{
				DOTweenModuleUI.DOColor(img_trgger_refreshCD, Color.clear, 0.1f);
			});
			break;
		case BattleGMEnum.InfiniteEnergy:
			go_energy_open?.SetActive(isOpen);
			break;
		case BattleGMEnum.InfiniteSp:
			go_sp_open?.SetActive(isOpen);
			break;
		case BattleGMEnum.ResetState:
			DOTweenModuleUI.DOColor(img_trigger_reset, triggerColor, 0.1f).OnComplete(delegate
			{
				DOTweenModuleUI.DOColor(img_trigger_reset, Color.clear, 0.1f);
			});
			break;
		case BattleGMEnum.AutoWeakness:
			go_autoWeakness_open?.SetActive(isOpen);
			break;
		case BattleGMEnum.AI:
			go_ai_open?.SetActive(isOpen);
			break;
		case BattleGMEnum.ClearData:
			DOTweenModuleUI.DOColor(img_trigger_clearData, triggerColor, 0.1f).OnComplete(delegate
			{
				DOTweenModuleUI.DOColor(img_trigger_clearData, Color.clear, 0.1f);
			});
			break;
		case BattleGMEnum.AutoClear:
			go_autoClear_open?.SetActive(isOpen);
			break;
		case BattleGMEnum.TeamAI:
			go_teamAI_open?.SetActive(isOpen);
			break;
		case BattleGMEnum.TenacityLevel:
			DOTweenModuleUI.DOColor(img_trigger_tenacityLevel, triggerColor, 0.1f).OnComplete(delegate
			{
				DOTweenModuleUI.DOColor(img_trigger_clearData, Color.clear, 0.1f);
			});
			break;
		case BattleGMEnum.BossDown:
			go_down_open?.SetActive(isOpen);
			break;
		}
	}

	public void SetGMInteractable(BattleGMEnum gmEnum, bool isInter)
	{
		if (gmEnum == BattleGMEnum.TeamAI)
		{
			go_teamAI_noInter?.SetActive(!isInter);
			btn_team_ai.interactable = isInter;
		}
	}

	private void OnBtn_RefreshCD()
	{
		callback?.Invoke(BattleGMEnum.RefreshCD);
	}

	private void OnBtn_Energy()
	{
		callback?.Invoke(BattleGMEnum.InfiniteEnergy);
	}

	private void OnBtn_Sp()
	{
		callback?.Invoke(BattleGMEnum.InfiniteSp);
	}

	private void OnBtn_Reset()
	{
		callback?.Invoke(BattleGMEnum.ResetState);
	}

	private void OnBtn_AutoWeakness()
	{
		callback?.Invoke(BattleGMEnum.AutoWeakness);
	}

	private void OnBtn_Ai()
	{
		callback?.Invoke(BattleGMEnum.AI);
	}

	private void OnBtn_ClearData()
	{
		callback?.Invoke(BattleGMEnum.ClearData);
	}

	private void OnBtn_AutoClear()
	{
		callback?.Invoke(BattleGMEnum.AutoClear);
	}

	private void OnBtn_TeamAI()
	{
		callback?.Invoke(BattleGMEnum.TeamAI);
	}

	private void OnBtn_Tenacity_Level()
	{
		callback?.Invoke(BattleGMEnum.TenacityLevel);
	}

	private void OnBtn_BossDown()
	{
		callback?.Invoke(BattleGMEnum.BossDown);
	}
}
