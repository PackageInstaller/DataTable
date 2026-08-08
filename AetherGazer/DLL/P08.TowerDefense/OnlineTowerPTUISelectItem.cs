using System;
using Config;
using UnityEngine;
using UnityEngine.UI;

public class OnlineTowerPTUISelectItem : MonoBehaviour
{
	public OnlineTowerPTUI m_ptUI;

	public CanvasGroup m_canvasGroup;

	public LayoutElement m_layoutElement;

	public Text m_nameText;

	public Text m_costText;

	public Image m_iconImg;

	public Text m_descText;

	public bool m_activeGameObject;

	public Controller m_lockController;

	public Controller m_rareController;

	public Controller m_typeController;

	public Button m_unlockBtn;

	public Button m_upgradeBtn;

	public Button m_energyLessBtn;

	private int m_triggerID;

	private int m_index;

	private activity_online_tower m_OnlineTowerConfig;

	private Action<int, int, int, int> m_selectAction;

	private Action m_lockAction;

	private Action m_energyLessAction;

	private bool m_show;

	public void InitSelectItem(int TowerBuffID, int TriggerID, int index, Action<int, int, int, int> selectFunc)
	{
		m_upgradeBtn.onClick.RemoveAllListeners();
		m_triggerID = TriggerID;
		m_index = index;
		m_OnlineTowerConfig = ConfigHelper.GetInstance().GetConfig<activity_online_tower>(TowerBuffID);
		m_nameText.text = WorldStateManager.GetSystemTableI18N(m_OnlineTowerConfig.Name);
		m_costText.text = WorldStateManager.GetNumberString(m_OnlineTowerConfig.Cost);
		m_iconImg.sprite = AtlasManager.GetSpriteWithoutAtlas(m_OnlineTowerConfig.IconBattle);
		m_descText.text = m_OnlineTowerConfig.DescBattle;
		m_selectAction = selectFunc;
		m_unlockBtn.onClick.AddListener(OnClickLock);
		m_upgradeBtn.onClick.AddListener(OnClickSelect);
		m_energyLessBtn.onClick.AddListener(OnClickEnergyLess);
	}

	public void SetLockAction(Action action)
	{
		m_lockAction = action;
	}

	public void OnClickLock()
	{
		m_lockAction?.Invoke();
	}

	public void OnClickSelect()
	{
		if (m_ptUI.GetPT() >= m_OnlineTowerConfig.Cost)
		{
			m_ptUI.SetPT(m_ptUI.GetPT() - m_OnlineTowerConfig.Cost);
			m_ptUI.GetOnlineTowerData(m_triggerID).isSelect[m_index] = true;
			m_selectAction?.Invoke(m_OnlineTowerConfig.ID, m_OnlineTowerConfig.BuffConfigId, m_OnlineTowerConfig.Type, m_OnlineTowerConfig.AddType);
		}
	}

	public void SetEnergyLessAction(Action action)
	{
		m_energyLessAction = action;
	}

	public void OnClickEnergyLess()
	{
		m_energyLessAction?.Invoke();
	}

	public void UpdateItem()
	{
		if (!m_show)
		{
			return;
		}
		OnlineTowerData onlineTowerData = m_ptUI.GetOnlineTowerData(m_triggerID);
		if (m_rareController != null)
		{
			m_rareController.SetSelectedIndex(m_OnlineTowerConfig.Rare - 1);
		}
		if (m_typeController != null)
		{
			m_typeController.SetSelectedIndex(m_OnlineTowerConfig.Type);
		}
		if (onlineTowerData.isSelect[m_index])
		{
			if (m_lockController != null)
			{
				m_lockController.SetSelectedState("lock");
			}
			return;
		}
		bool flag = m_OnlineTowerConfig.Cost <= m_ptUI.GetPT();
		m_upgradeBtn.enabled = flag;
		if (!flag)
		{
			m_costText.color = Color.red;
			m_lockController.SetSelectedState("energy_less");
			return;
		}
		m_costText.color = Color.white;
		if (m_lockController != null)
		{
			m_lockController.SetSelectedState("unlock");
		}
	}

	public void Show()
	{
		m_show = true;
		m_layoutElement.ignoreLayout = false;
		m_canvasGroup.alpha = 1f;
		m_canvasGroup.blocksRaycasts = true;
		if (m_activeGameObject)
		{
			base.gameObject.SetActive(value: true);
		}
	}

	public void Hide()
	{
		m_show = false;
		m_canvasGroup.alpha = 0f;
		m_canvasGroup.blocksRaycasts = false;
		m_layoutElement.ignoreLayout = true;
		if (m_activeGameObject)
		{
			base.gameObject.SetActive(value: false);
		}
	}
}
