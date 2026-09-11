using System.Collections.Generic;
using Config;
using NetProcol;
using UnityEngine;
using UnityEngine.UI;

public class PlayerInfoUI : MonoBehaviour
{
	public Text HpValueText;

	public Text MaxHpValueText;

	public Slider HpBar;

	public HPSlowSliderEffect HpSlowBar;

	public GameObject AffixTip;

	public Text AffixTipText;

	public EnergyController Energy;

	public BeanController Bean;

	public EnergyController Anger;

	public EnergyController Special;

	public EnergyController Tune;

	public GameObject TuneSubstrate;

	public GameObject PowerText;

	public List<int> ShowBuffID = new List<int>();

	public int ShowBuffLeftTime = 1000;

	private HashSet<int> _showBuffID = new HashSet<int>();

	private List<BuffState> _showBuff = new List<BuffState>();

	private List<BuffItemUI> _buffs = new List<BuffItemUI>();

	private List<AffixItemUI> _affixs = new List<AffixItemUI>();

	private List<string> buffIconTempList = new List<string>();

	private BBHumanoid _blackboard;

	private ComponentHealth _componentHealth;

	private IPowerController _powerController;

	private long _lastShield = -1L;

	private long _lastHealth = -1L;

	private long _lastMaxHealth = -1L;

	private int _lastPower = -1;

	private int _lastMaxPower = -1;

	private int _lastSlowPower = -1;

	public const int SHIELD_BUFF_CLASS_ID = 102;

	public const int SHIELD_MAX_HP_BUFF_CLASS_ID = 108;

	private void Awake()
	{
		_showBuffID.Clear();
		for (int i = 0; i < ShowBuffID.Count; i++)
		{
			_showBuffID.Add(ShowBuffID[i]);
		}
		for (int j = 0; j < 4; j++)
		{
			Transform transform = base.transform.Find("Buff_Debuff/Buff/Item" + j);
			if (null != transform)
			{
				BuffItemUI buffItemUI = transform.gameObject.AddComponent<BuffItemUI>();
				buffItemUI._playEffectTime = ShowBuffLeftTime;
				_buffs.Add(buffItemUI);
				transform.gameObject.SetActive(value: false);
			}
		}
		for (int k = 0; k < 3; k++)
		{
			Transform transform2 = base.transform.Find("SelfAffix/Item" + k);
			if (null != transform2)
			{
				AffixItemUI item = transform2.gameObject.AddComponent<AffixItemUI>();
				int index = k;
				transform2.transform.Find("clickArea").GetComponent<Button>().onClick.AddListener(delegate
				{
					OnAffixClick(index);
				});
				_affixs.Add(item);
			}
		}
	}

	private void OnAffixClick(int index)
	{
		if (AffixTip.transform.parent != _affixs[index].transform)
		{
			AffixTip.transform.SetParent(_affixs[index].transform);
			AffixTip.transform.localPosition = new Vector3(0f, 33f, 0f);
			AffixTip.gameObject.SetActive(value: true);
		}
		else
		{
			AffixTip.gameObject.SetActive(!AffixTip.activeSelf);
		}
		if (AffixTip.activeSelf)
		{
			string desc = _affixs[index].GetDesc();
			if (!string.IsNullOrEmpty(desc))
			{
				AffixTipText.text = desc;
				LayoutRebuilder.ForceRebuildLayoutImmediate(AffixTipText.transform as RectTransform);
				LayoutRebuilder.ForceRebuildLayoutImmediate(AffixTip.transform as RectTransform);
			}
		}
	}

	private void OnEnable()
	{
		UpdateUI();
	}

	public void OnMainPlayerUpdate(NAgent agent)
	{
		_blackboard = agent.Blackboard as BBHumanoid;
		_componentHealth = agent.GetComponent<ComponentHealth>();
		charactor_param config = ConfigHelper.GetInstance().GetConfig<charactor_param>(agent.AgentConfigID);
		Anger.SetActive(active: false);
		Energy.SetActive(active: false);
		Bean.SetActive(active: false);
		Special.SetActive(active: false);
		if (Tune != null)
		{
			Tune.SetActive(active: false);
		}
		if (TuneSubstrate != null)
		{
			TuneSubstrate.SetActive(value: false);
		}
		EnergyType energyType = (EnergyType)config.EnergyType;
		if (EnergyType.Rage == energyType)
		{
			_powerController = Anger;
		}
		else if (EnergyType.Power == energyType)
		{
			_powerController = Energy;
		}
		else if (EnergyType.Mark == energyType)
		{
			_powerController = Bean;
		}
		else if (EnergyType.Unique == energyType)
		{
			_powerController = Special;
		}
		else if (EnergyType.Tune == energyType)
		{
			_powerController = Tune;
		}
		else
		{
			_powerController = null;
		}
		Debug.Log("energyType " + energyType);
		if (_powerController != null)
		{
			if (null != PowerText)
			{
				PowerText.SetActive(_powerController is EnergyController);
			}
			_powerController.SetActive(active: true);
			_powerController.SetPower(_lastPower, _lastMaxPower);
			if (energyType != EnergyType.Tune)
			{
				return;
			}
			RoleDataForExchangeInfo roleDataForExchangeInfo = (NScene.GetCurrentScene() as BattleScene).ready.SceneDataForExcehange.RoleDataInLua.get_Item(0);
			if (roleDataForExchangeInfo == null || roleDataForExchangeInfo.AIChip == null || roleDataForExchangeInfo.AIChip.Count <= 0)
			{
				return;
			}
			for (int i = 0; i < roleDataForExchangeInfo.AIChip.Count; i++)
			{
				int num = roleDataForExchangeInfo.AIChip.get_Item(i);
				if (num != 0)
				{
					if (!ConfigHelper.GetInstance().TryGetConfig<ai_chip>(num, out var config2))
					{
						Debug.LogError($"芯片ID {num} 在ai_chip表里查询不到");
					}
					else if (config2.TypeId == 4)
					{
						TuneSubstrate.SetActive(value: true);
						break;
					}
					continue;
				}
				break;
			}
		}
		else if (null != PowerText)
		{
			PowerText.SetActive(value: false);
		}
	}

	private void Update()
	{
		UpdateUI();
	}

	public void UpdateUI()
	{
		if (_powerController != null && _blackboard != null && _blackboard.m_NextSimFrameData != null)
		{
			if (_lastMaxPower != _blackboard.m_NextSimFrameData.mMaxPowerValue)
			{
				_powerController.UpdatePowerMax(_blackboard.m_NextSimFrameData.mMaxPowerValue);
				_lastMaxPower = _blackboard.m_NextSimFrameData.mMaxPowerValue;
			}
			if (_lastPower != _blackboard.m_NextSimFrameData.mPowerValue)
			{
				_powerController.SetPower(_blackboard.m_NextSimFrameData.mPowerValue, _blackboard.m_NextSimFrameData.mMaxPowerValue);
				_lastPower = _blackboard.m_NextSimFrameData.mPowerValue;
			}
		}
		if (null != _componentHealth && _blackboard != null && _blackboard.m_NextSimFrameData != null)
		{
			int num = 0;
			if (_blackboard.m_NextSimFrameData.BuffStateArray != null)
			{
				for (int i = 0; i < _blackboard.m_NextSimFrameData.BuffStateArray.Count; i++)
				{
					BuffState buffState = _blackboard.m_NextSimFrameData.BuffStateArray[i];
					if (buffState.mBuffClassID == 102 || buffState.mBuffClassID == 108)
					{
						num = buffState.mBuffParams.v2;
						break;
					}
				}
			}
			if (_lastHealth != _blackboard.m_NextSimFrameData.HP || _lastShield != num)
			{
				if (num == 0)
				{
					HpValueText.text = _blackboard.m_NextSimFrameData.HP.ToString();
				}
				else
				{
					HpValueText.text = $"{_blackboard.m_NextSimFrameData.HP.ToString()}({num})";
				}
				_lastHealth = _blackboard.m_NextSimFrameData.HP;
				_lastShield = num;
			}
			if (_lastMaxHealth != _blackboard.m_NextSimFrameData.MaxHP)
			{
				MaxHpValueText.text = _blackboard.m_NextSimFrameData.MaxHP.ToString();
				_lastMaxHealth = _blackboard.m_NextSimFrameData.MaxHP;
			}
			if (_blackboard.m_NextSimFrameData.MaxHP == 0L)
			{
				HpBar.value = 0f;
			}
			else
			{
				HpBar.value = (float)_blackboard.m_NextSimFrameData.HP * 1f / (float)_blackboard.m_NextSimFrameData.MaxHP;
			}
			HpSlowBar.SetDuration(HpBar.value, (float)_componentHealth.HealthChangeSlowly * 1f / (float)_blackboard.m_NextSimFrameData.MaxHP);
		}
		if (ShowBuffID.Count <= 0 || !(null != _blackboard) || _blackboard.m_NextSimFrameData == null || _blackboard.m_NextSimFrameData.BuffStateArray == null)
		{
			return;
		}
		buffIconTempList.Clear();
		_showBuff.Clear();
		for (int j = 0; j < _blackboard.m_NextSimFrameData.BuffStateArray.Count; j++)
		{
			if (_showBuffID.Contains(_blackboard.m_NextSimFrameData.BuffStateArray[j].mBuffConfigID))
			{
				_showBuff.Add(_blackboard.m_NextSimFrameData.BuffStateArray[j]);
			}
		}
		BuffItemUI.UpdateBuffList(_showBuff, _buffs, "BUFF", buffIconTempList);
		BuffItemUI.UpdateBuffCD(_showBuff, _buffs);
	}

	private void OnDestroy()
	{
		for (int i = 0; i < _affixs.Count; i++)
		{
			_affixs[i].transform.Find("clickArea").GetComponent<Button>().onClick.RemoveAllListeners();
		}
	}
}
