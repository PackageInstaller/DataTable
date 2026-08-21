using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class OnlineTowerPTUI : MonoBehaviour
{
	public Text m_titleText;

	public Text m_ptText;

	public Text m_waveText;

	public Text m_timeText;

	public GameObject m_timeTextGo;

	public GameObject m_skipGo;

	public Slider m_currentWavePercent;

	public Slider[] m_currentTowerHP;

	public CanvasGroup m_selectPanle;

	public OnlineTowerPTUISelectItem[] m_selects;

	public List<int>[] gachaPool;

	public Dictionary<int, OnlineTowerData> m_onlineTowerDataDic = new Dictionary<int, OnlineTowerData>();

	private int currentPT;

	private bool m_showd;

	private bool m_timeRunning;

	private float m_time;

	private int m_timeTipID;

	private string m_timeString;

	private bool m_onlySecond;

	private float secondCount;

	public void SetPT(int val)
	{
		if (!(m_ptText == null))
		{
			currentPT = val;
			m_ptText.text = WorldStateManager.GetNumberString(val);
		}
	}

	public int GetPT()
	{
		return currentPT;
	}

	public OnlineTowerData GetOnlineTowerData(int pTriggerID)
	{
		if (!m_onlineTowerDataDic.TryGetValue(pTriggerID, out var value))
		{
			value = FrameObjectPool<OnlineTowerData>.Claim();
			m_onlineTowerDataDic[pTriggerID] = value;
			value.OnResetData();
		}
		return value;
	}

	public void SetWave(int current, int total)
	{
		if (!(m_waveText == null))
		{
			m_waveText.text = $"{WorldStateManager.GetNumberString(current)}/{WorldStateManager.GetNumberString(total)}";
		}
	}

	public void SetTimeString(int tipID)
	{
		m_timeString = WorldStateManager.GetTipsContent(tipID);
		SetTimeText((int)(m_time * 1000f), m_onlySecond);
	}

	public void ResetTimeString()
	{
		m_timeString = WorldStateManager.GetTipsContent(m_timeTipID);
		SetTimeText((int)(m_time * 1000f), m_onlySecond);
	}

	public void SetTime(float time, int battleTip, bool useSecond, bool useSkip)
	{
		m_time = time;
		m_timeRunning = true;
		m_timeTextGo?.SetActive(value: true);
		m_skipGo?.SetActive(useSkip);
		m_timeTipID = battleTip;
		m_timeString = WorldStateManager.GetTipsContent(battleTip);
		m_onlySecond = useSecond;
		secondCount = 0f;
	}

	private void SetTimeText(int millisecond, bool onlySecond)
	{
		if (!(m_timeText == null))
		{
			if (onlySecond)
			{
				m_timeText.text = string.Format(m_timeString, CommonString.GetNumbers(millisecond / 1000));
			}
			else
			{
				m_timeText.text = string.Format(m_timeString, CommonString.GetTimestamp(millisecond));
			}
		}
	}

	public void SetWavePercent(float value)
	{
		if (m_currentWavePercent != null)
		{
			m_currentWavePercent.value = value;
		}
	}

	public void SetTowerHP(float value, int index)
	{
		if (index < m_currentTowerHP.Length && m_currentTowerHP[index] != null)
		{
			m_currentTowerHP[index].value = value;
		}
	}

	public void ShowSelectPanel()
	{
		m_selectPanle.alpha = 1f;
		m_selectPanle.blocksRaycasts = true;
		m_showd = true;
	}

	public void HideSelectPanel()
	{
		m_selectPanle.alpha = 0f;
		m_selectPanle.blocksRaycasts = false;
		m_showd = false;
		for (int i = 0; i < m_selects.Length; i++)
		{
			m_selects[i].Hide();
		}
	}

	public bool IsShow()
	{
		return m_showd;
	}

	private void Update()
	{
		if (m_timeRunning)
		{
			m_time -= Time.deltaTime;
			secondCount -= Time.deltaTime;
			if (m_time <= 0f)
			{
				m_time = 0f;
				m_timeRunning = false;
				m_timeTextGo?.SetActive(value: false);
				m_skipGo?.SetActive(value: false);
			}
			if (secondCount <= 0f)
			{
				SetTimeText((int)(m_time * 1000f), m_onlySecond);
				secondCount = 1f;
			}
		}
	}
}
