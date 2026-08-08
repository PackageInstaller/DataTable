using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TowerPTUI : MonoBehaviour
{
	public Text m_titleTxt;

	public Text ptText;

	public Text m_hpTxt;

	public Text m_waveTxt;

	public Button skipButton;

	public Text m_timeTxt;

	public CanvasGroup m_selectPanel;

	public CanvasGroup m_recyclePanel;

	public Button m_recycleBtn;

	public Text m_recycleTxt;

	public TowerPTUISelectItem m_selectA;

	public TowerPTUISelectItem m_selectB;

	public Dictionary<int, TowerData> m_towerDataDict = new Dictionary<int, TowerData>(new IntComparer());

	public List<int> m_unlockTowerList = new List<int>();

	private int currentPT;

	private bool _showed;

	public void SetPT(int value)
	{
		if (!(ptText == null))
		{
			currentPT = value;
			if (value >= CommonString.Numbers.Length || value < 0)
			{
				ptText.text = value.ToString();
			}
			else
			{
				ptText.text = CommonString.Numbers[value];
			}
		}
	}

	public int GetPT()
	{
		return currentPT;
	}

	public TowerData GetTowerData(int pTriggerID)
	{
		if (!m_towerDataDict.TryGetValue(pTriggerID, out var value))
		{
			value = FrameObjectPool<TowerData>.Claim();
			m_towerDataDict[pTriggerID] = value;
			value.m_weaponArr = new int[2];
			value.m_weaponUpgradeArr = new int[2];
		}
		return value;
	}

	public int RecycleTower(int pTriggerID)
	{
		TowerData towerData = GetTowerData(pTriggerID);
		int recycle = towerData.m_recycle;
		m_towerDataDict.Remove(pTriggerID);
		FrameObjectPool<TowerData>.Release(towerData);
		return recycle;
	}

	public void SetHP(int hp)
	{
		if (!(m_hpTxt == null))
		{
			m_hpTxt.text = WorldStateManager.GetNumberString(hp);
		}
	}

	public void SetWave(int current, int total)
	{
		if (!(m_waveTxt == null))
		{
			m_waveTxt.text = $"{WorldStateManager.GetNumberString(current)}/{WorldStateManager.GetNumberString(total)}";
		}
	}

	public void SetTime(int millisecond, bool onlySecond)
	{
		if (m_timeTxt != null)
		{
			if (onlySecond)
			{
				m_timeTxt.text = CommonString.GetNumbers(millisecond);
			}
			else
			{
				m_timeTxt.text = CommonString.GetTimestamp(millisecond);
			}
		}
	}

	public void SetTitle(string pContent)
	{
		if (m_titleTxt != null)
		{
			m_titleTxt.text = pContent;
		}
	}

	public bool IsLock(int index)
	{
		return !m_unlockTowerList.Contains(index);
	}

	public void ShowSelectPanel()
	{
		m_selectPanel.alpha = 1f;
		m_selectPanel.blocksRaycasts = true;
		_showed = true;
	}

	public void HideSelectPanel()
	{
		_showed = false;
		m_selectPanel.alpha = 0f;
		m_selectPanel.blocksRaycasts = false;
		HideRecyclePanel();
		m_selectA.Hide();
		m_selectB.Hide();
	}

	public bool IsShowed()
	{
		return _showed;
	}

	public void ShowRecyclePanel()
	{
		m_recyclePanel.alpha = 1f;
		m_recyclePanel.blocksRaycasts = true;
	}

	public void HideRecyclePanel()
	{
		m_recyclePanel.alpha = 0f;
		m_recyclePanel.blocksRaycasts = false;
	}
}
