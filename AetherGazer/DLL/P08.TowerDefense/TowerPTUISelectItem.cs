using System;
using Config;
using UnityEngine;
using UnityEngine.UI;

public class TowerPTUISelectItem : MonoBehaviour
{
	public TowerPTUI m_ptui;

	public CanvasGroup m_canvasGroup;

	public LayoutElement m_layoutElement;

	public Text m_nameTxt;

	public GameObject m_costGo;

	public Text m_costTxt;

	public Image m_iconImg;

	public Text m_levelTxt;

	public Text m_descTxt;

	public bool m_activeGameObject;

	public Controller m_lockController;

	public Button m_unlockBtn;

	public Button m_upgradeBtn;

	public Button m_energyLessBtn;

	public Button m_levelMaxBtn;

	private int _triggerID;

	private int _index;

	private activity_tower_defense_tower _towerConfig;

	private Action<int> _selectAction;

	private Action _lockAction;

	private Action _energyLessAction;

	private Action _levelMaxAction;

	private bool _show;

	public void InitSelectItem(int pTowerConfigID, int pTriggerID, int pIndex, Action<int> selectFunc)
	{
		m_upgradeBtn.onClick.RemoveAllListeners();
		_triggerID = pTriggerID;
		_index = pIndex;
		_towerConfig = ConfigHelper.GetInstance().GetConfig<activity_tower_defense_tower>(pTowerConfigID);
		m_nameTxt.text = WorldStateManager.GetSystemTableI18N(_towerConfig.Name);
		m_costTxt.text = WorldStateManager.GetNumberString(_towerConfig.UpgradeCost);
		m_iconImg.sprite = AtlasManager.GetSpriteWithoutAtlas(_towerConfig.IconBattle);
		int num = 1;
		TowerData towerData = m_ptui.GetTowerData(_triggerID);
		num = ((_towerConfig.SubType != 1) ? towerData.m_weaponUpgradeArr[_index] : towerData.m_bodyUpgrade);
		m_levelTxt.text = string.Format(_towerConfig.MiniTip, WorldStateManager.GetNumberString(num + 1));
		num = ((num < _towerConfig.DescBattle.Count) ? num : (_towerConfig.DescBattle.Count - 1));
		m_descTxt.text = _towerConfig.DescBattle.get_Item(num);
		_selectAction = selectFunc;
		m_unlockBtn.onClick.AddListener(OnClickLock);
		m_upgradeBtn.onClick.AddListener(OnClickUpgrade);
		m_energyLessBtn.onClick.AddListener(OnClickEnergyLess);
		m_levelMaxBtn.onClick.AddListener(OnClickLevelMax);
	}

	public void SetLockAction(Action pAction)
	{
		_lockAction = pAction;
	}

	public void OnClickLock()
	{
		_lockAction?.Invoke();
	}

	public void OnClickUpgrade()
	{
		if (m_ptui.GetPT() >= _towerConfig.UpgradeCost)
		{
			TowerData towerData = m_ptui.GetTowerData(_triggerID);
			if (_towerConfig.SubType == 1)
			{
				towerData.m_body = _towerConfig.ID;
				towerData.m_bodyUpgrade++;
			}
			else
			{
				towerData.m_weaponArr[_index] = _towerConfig.ID;
				towerData.m_weaponUpgradeArr[_index]++;
			}
			m_ptui.SetPT(m_ptui.GetPT() - _towerConfig.UpgradeCost);
			towerData.m_recycle += _towerConfig.DismantleReturn;
			_selectAction?.Invoke(_towerConfig.ID);
		}
	}

	public void SetEnergyLessAction(Action pAction)
	{
		_energyLessAction = pAction;
	}

	public void OnClickEnergyLess()
	{
		_energyLessAction?.Invoke();
	}

	public void SetLevelMaxAction(Action pAction)
	{
		_levelMaxAction = pAction;
	}

	public void OnClickLevelMax()
	{
		_levelMaxAction?.Invoke();
	}

	public void UpdateItem()
	{
		if (!_show)
		{
			return;
		}
		if (m_ptui.IsLock(_towerConfig.ID))
		{
			if (m_lockController != null)
			{
				m_lockController.SetSelectedState("lock");
			}
			return;
		}
		TowerData towerData = m_ptui.GetTowerData(_triggerID);
		bool flag = _towerConfig.SubType == 2 && towerData.m_weaponUpgradeArr[_index] >= _towerConfig.UpgradeCountLimit;
		bool flag2 = _towerConfig.UpgradeCost <= m_ptui.GetPT();
		m_upgradeBtn.enabled = flag2 && !flag;
		if (flag)
		{
			m_lockController.SetSelectedState("max");
			return;
		}
		if (!flag2)
		{
			m_costTxt.color = Color.red;
			m_lockController.SetSelectedState("energy_less");
			return;
		}
		m_costTxt.color = Color.white;
		if (m_lockController != null)
		{
			m_lockController.SetSelectedState("unlock");
		}
	}

	public void Show()
	{
		_show = true;
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
		_show = false;
		m_canvasGroup.alpha = 0f;
		m_canvasGroup.blocksRaycasts = false;
		m_layoutElement.ignoreLayout = true;
		if (m_activeGameObject)
		{
			base.gameObject.SetActive(value: false);
		}
	}
}
