using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.Sound;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Sirenix.Utilities;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.UI.EquipSort;

public class EquipSortPanel : SubUIView<EquipSortPanelSubInputController>
{
	public ActButton settingButton;

	public EquipSortCell recommendSettingOption;

	public LocalizeStringEvent recommendDesc;

	public EquipSortCell sortTemplate;

	public Transform propertyParent;

	[Header("辅助排序规则")]
	public EquipSortCell levelSortOption;

	public EquipSortCell qualitySortOption;

	[Header("排序方式")]
	public EquipSortCell ascSortOption;

	public EquipSortCell descSortOption;

	[Header("按钮")]
	public ActButton confirmButton;

	public ActButton resetButton;

	[SerializeField]
	private ViewControlLayer m_EquipSortPanelLayer;

	[SerializeField]
	private ViewControlRoot m_EquipSortPanelRoot;

	[Header("打开音效")]
	public AudioEventReference openSound;

	private ContinuousNavigateData m_NavigateData;

	private List<EquipSortCell> _propertyCells;

	private List<EquipSortCell> _selectedOptions = new List<EquipSortCell>(3);

	private const int MaxPropertySortOptionCount = 3;

	private Character _character;

	private EntityCharacterData _entityCharacterData;

	private int _equipSlotIndex;

	private EquipSlotInfo _equipSlotInfo;

	private bool _isInited;

	private List<int> _propertySortOrder;

	public Action OnClose { get; set; }

	private void Awake()
	{
		InitPanel();
		confirmButton.SetBtnClick(Confirm);
		resetButton.SetBtnClick(ResetOptions);
		m_EquipSortPanelLayer.Focus();
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		Singleton<GameManager>.instance.audioManager.PlaySound(openSound);
	}

	private void InitPanel()
	{
		if (!_isInited)
		{
			_propertyCells = ListPool<EquipSortCell>.Get();
			_propertySortOrder = ListPool<int>.Get();
			recommendSettingOption.onValueChanged.AddListener(OnRecommendOptionChanged);
			settingButton.SetBtnClick(OpenSortSetting);
			GenerateSortOptions();
			ResetOptions();
			_isInited = true;
		}
	}

	private void OnDestroy()
	{
		ListPool<EquipSortCell>.Release(_propertyCells);
		_propertyCells = null;
		ListPool<int>.Release(_propertySortOrder);
		_propertySortOrder = null;
		_isInited = false;
	}

	protected override void OnFocusOut()
	{
		base.OnFocusOut();
		m_NavigateData?.Reset();
	}

	private void OpenSortSetting()
	{
		UIOpenResult openUIResult = Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_SORTSETTING);
		Singleton<NewUIManager>.instance.WaitUICloseAsync(openUIResult).ContinueWith((Action)UpdateSortDescription).Forget();
	}

	public void OnConfirm()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected != null)
		{
			ExecuteEvents.Execute(currentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler?.OnSubmit(data);
			});
		}
	}

	public void OpenSortSettingPanel()
	{
		OpenSortSetting();
	}

	public bool IsPanelOpen()
	{
		return gameObject.activeInHierarchy;
	}

	public void OnNavigate(Vector2 value)
	{
		if (IsPanelOpen() && !(m_EquipSortPanelRoot == null))
		{
			if (EventSystemHelper.CurrentSelected != null)
			{
				ContinuousNavigateUtility.StartContinuousNavigate(value, ref m_NavigateData, OnNavigateSelect);
			}
			else if (!m_EquipSortPanelRoot.ReFocus())
			{
				m_EquipSortPanelLayer?.Focus();
			}
		}
	}

	private void OnNavigateSelect(MoveDirection moveDirection)
	{
		if (!(m_EquipSortPanelRoot == null))
		{
			switch (moveDirection)
			{
			case MoveDirection.Down:
				m_EquipSortPanelRoot.SelectDown();
				break;
			case MoveDirection.Left:
				m_EquipSortPanelRoot.SelectLeft();
				break;
			case MoveDirection.Up:
				m_EquipSortPanelRoot.SelectUp();
				break;
			case MoveDirection.Right:
				m_EquipSortPanelRoot.SelectRight();
				break;
			}
		}
	}

	private void GenerateSortOptions()
	{
		foreach (KeyValuePair<int, PropertyData> propertyData in RuntimeConfigs.data.propertyDatas)
		{
			if (propertyData.Value.sort == 0)
			{
				continue;
			}
			EquipSortCell go = UnityEngine.Object.Instantiate(sortTemplate, propertyParent);
			_propertySortOrder.Add(propertyData.Key);
			if (!go)
			{
				break;
			}
			go.gameObject.SetActive(value: true);
			go.optionType = EquipSortOptionType.Property;
			go.PropertyID = propertyData.Key;
			go.Sort = propertyData.Value.sort;
			go.optionName.SetTable("shortcommon");
			go.optionName.StringReference.TableEntryReference = propertyData.Value.descLocal;
			go.onValueChanged.AddListener((bool v) =>
			{
				if (v)
				{
					if (_selectedOptions.Count >= 3)
					{
						GameUtility.OpenToolTip(LocalizationCommonData.CommonString.PropertyMaxCount);
						go.SetIsOn(val: false);
					}
					else
					{
						_selectedOptions.Add(go);
						int i;
						for (i = 1; i <= 3; i++)
						{
							if (!_selectedOptions.Exists((EquipSortCell x) => x.Priority == i))
							{
								go.Priority = i;
								break;
							}
						}
					}
				}
				else
				{
					go.Priority = 0;
					_selectedOptions.Remove(go);
				}
			});
			if (_propertyCells.Count == 0)
			{
				_propertyCells.Add(go);
				continue;
			}
			for (int num = 0; num < _propertyCells.Count; num++)
			{
				if (propertyData.Value.sort < _propertyCells[num].Sort)
				{
					_propertyCells.Insert(num, go);
					break;
				}
				if (num == _propertyCells.Count - 1)
				{
					_propertyCells.Add(go);
					break;
				}
			}
		}
	}

	private void SortPropertyOptions()
	{
		_propertyCells.Sort((EquipSortCell x, EquipSortCell y) =>
		{
			if (x.likeIcon.activeSelf && !y.likeIcon.activeSelf)
			{
				return -1;
			}
			return (!x.likeIcon.activeSelf && y.likeIcon.activeSelf) ? 1 : (x.Sort - y.Sort);
		});
		for (int num = 0; num < _propertyCells.Count; num++)
		{
			_propertyCells[num].transform.SetSiblingIndex(num);
		}
	}

	private void OnRecommendOptionChanged(bool isOn)
	{
		if (isOn)
		{
			qualitySortOption.SetIsOn(val: false);
			levelSortOption.SetIsOn(val: false);
			ascSortOption.SetIsOn(val: false);
			descSortOption.SetIsOn(val: false);
			qualitySortOption.Interactable(active: false);
			levelSortOption.Interactable(active: false);
			ascSortOption.Interactable(active: false);
			descSortOption.Interactable(active: false);
		}
		else
		{
			qualitySortOption.Interactable(active: true);
			levelSortOption.Interactable(active: true);
			ascSortOption.Interactable(active: true);
			descSortOption.Interactable(active: true);
			foreach (EquipSortCell propertyCell in _propertyCells)
			{
				propertyCell.SetIsOn(_selectedOptions.Contains(propertyCell));
			}
		}
		foreach (EquipSortCell propertyCell2 in _propertyCells)
		{
			propertyCell2.Interactable(!isOn);
		}
	}

	public void Init(Character character, int equipSlotIndex, bool dontResetTempOptions = false)
	{
		if (!_isInited)
		{
			InitPanel();
		}
		_character = character;
		_equipSlotIndex = equipSlotIndex;
		if (Model<EquipModel>.Interface.SlotInfos.TryGetValue(_character.Id, out var value) && value != null && _equipSlotIndex >= 0 && _equipSlotIndex < value.Length)
		{
			_equipSlotInfo = value[_equipSlotIndex]?.Clone() as EquipSlotInfo;
		}
		if (_equipSlotInfo == null)
		{
			_equipSlotInfo = new EquipSlotInfo();
		}
		_entityCharacterData = CoreUtils.GetData(_character.Id, RuntimeConfigs.data.entityCharacterDatas);
		if (_entityCharacterData == null)
		{
			return;
		}
		ResetPropertyOptions();
		if (!dontResetTempOptions)
		{
			levelSortOption.SetIsOn(val: true);
			qualitySortOption.SetIsOn(val: false);
			descSortOption.SetIsOn(val: true);
			ascSortOption.SetIsOn(val: false);
		}
		recommendSettingOption.SetIsOn(val: false);
		recommendSettingOption.SetIsOn(_equipSlotInfo.SortIDs.Contains(0));
		foreach (EquipSortCell propertyCell in _propertyCells)
		{
			if (_equipSlotInfo.SortIDs.Contains(propertyCell.PropertyID))
			{
				propertyCell.SetIsOn(val: true);
				propertyCell.Priority = _equipSlotInfo.SortIDs.IndexOf(propertyCell.PropertyID) + 1;
			}
			else
			{
				propertyCell.SetIsOn(val: false);
			}
			propertyCell.likeIcon.SetActive(_entityCharacterData.comProperty.Contains(propertyCell.PropertyID));
		}
		SortPropertyOptions();
		UpdateSortDescription();
	}

	public void SortEquips(IList<ItemUnifierProxy> equips)
	{
		if (recommendSettingOption.IsOn)
		{
			RecommendSort(equips);
		}
		else
		{
			CustomSort(equips);
		}
	}

	private void RecommendSort(IList<ItemUnifierProxy> equips)
	{
		bool isDes = descSortOption.IsOn;
		equips.Sort((ItemUnifierProxy xProxy, ItemUnifierProxy yProxy) =>
		{
			int num = 0;
			Equip equip = xProxy.As<Equip>();
			Equip equip2 = yProxy.As<Equip>();
			int[] comProperty = _entityCharacterData.comProperty;
			foreach (int propertyID in comProperty)
			{
				float propertyValue = equip.GetPropertyValue(propertyID);
				float propertyValue2 = equip2.GetPropertyValue(propertyID);
				num = propertyValue.CompareTo(propertyValue2);
				if (num != 0)
				{
					break;
				}
			}
			int quality = equip.Quality;
			int quality2 = equip2.Quality;
			if (quality != quality2)
			{
				num = quality.CompareTo(quality2);
			}
			if (num == 0)
			{
				int level = equip.Level;
				int level2 = equip2.Level;
				if (level != level2)
				{
					num = level.CompareTo(level2);
				}
			}
			if (num == 0)
			{
				num = SortUtility.SortEquip(equip, equip2);
			}
			return (!isDes) ? num : (-num);
		});
	}

	private void CustomSort(IList<ItemUnifierProxy> equips)
	{
		bool isDes = descSortOption.IsOn;
		_selectedOptions.Sort((EquipSortCell a, EquipSortCell b) => a.Priority - b.Priority);
		equips.Sort((ItemUnifierProxy xProxy, ItemUnifierProxy yProxy) =>
		{
			int num = 0;
			Equip equip = xProxy.As<Equip>();
			Equip equip2 = yProxy.As<Equip>();
			foreach (EquipSortCell selectedOption in _selectedOptions)
			{
				if (selectedOption.IsOn)
				{
					int propertyID = selectedOption.PropertyID;
					float propertyValue = equip.GetPropertyValue(propertyID);
					float propertyValue2 = equip2.GetPropertyValue(propertyID);
					num = propertyValue.CompareTo(propertyValue2);
					if (num != 0)
					{
						break;
					}
				}
			}
			if (num == 0 && levelSortOption.IsOn)
			{
				int level = equip.Level;
				int level2 = equip2.Level;
				if (level != level2)
				{
					num = level.CompareTo(level2);
				}
			}
			if (num == 0 && qualitySortOption.IsOn)
			{
				int quality = xProxy.Quality;
				int quality2 = yProxy.Quality;
				if (quality != quality2)
				{
					num = quality.CompareTo(quality2);
				}
			}
			if (num == 0)
			{
				num = SortUtility.SortEquip(equip, equip2);
			}
			return (!isDes) ? num : (-num);
		});
	}

	public void Open()
	{
		gameObject.SetActive(value: true);
		FocusIn();
		if (EventSystemHelper.Available && settingButton != null)
		{
			EventSystemHelper.SetSelectedGameObject(settingButton.gameObject);
		}
	}

	public void Confirm()
	{
		_equipSlotInfo.SortIDs.Clear();
		_selectedOptions.Sort((EquipSortCell a, EquipSortCell b) => a.Priority - b.Priority);
		foreach (EquipSortCell selectedOption in _selectedOptions)
		{
			_equipSlotInfo.SortIDs.Add(selectedOption.PropertyID);
		}
		if (recommendSettingOption.IsOn)
		{
			_equipSlotInfo.SortIDs.Add(0);
		}
		else
		{
			_equipSlotInfo.SortIDs.Remove(0);
		}
		if (!Model<EquipModel>.Interface.SlotInfos.TryGetValue(_character.Id, out var value) || value == null)
		{
			value = new EquipSlotInfo[4];
			Model<EquipModel>.Interface.SlotInfos[_character.Id] = value;
		}
		if (_equipSlotIndex >= 0 && _equipSlotIndex < value.Length)
		{
			value[_equipSlotIndex] = _equipSlotInfo;
		}
		if (ServerPlayerPrefs.GetInt("Equip_SortSetting") == 0 && Model<EquipModel>.Interface.SlotInfos.TryGetValue(_character.Id, out var value2) && value2 != null)
		{
			for (int num = 0; num < value2.Length; num++)
			{
				EquipSlotInfo equipSlotInfo = value2[num] ?? new EquipSlotInfo();
				if (recommendSettingOption.IsOn)
				{
					equipSlotInfo.SortIDs.Add(0);
				}
				else
				{
					equipSlotInfo.SortIDs.Remove(0);
				}
				value2[num] = equipSlotInfo;
			}
		}
		Model<EquipModel>.Interface.SerializeSlots();
		Close();
	}

	public void Close()
	{
		if (gameObject.activeInHierarchy)
		{
			Init(_character, _equipSlotIndex, dontResetTempOptions: true);
			gameObject.SetActive(value: false);
			OnClose?.Invoke();
			m_EquipSortPanelLayer.UnFocus();
		}
	}

	public void ResetOptions()
	{
		ResetPropertyOptions();
		levelSortOption.SetIsOn(val: true);
		descSortOption.SetIsOn(val: true);
	}

	private void ResetPropertyOptions()
	{
		foreach (EquipSortCell propertyCell in _propertyCells)
		{
			propertyCell.SetIsOn(val: false);
		}
	}

	private void UpdateSortDescription()
	{
		recommendDesc.SetTable(LocalizeTable.Common);
		int num = ServerPlayerPrefs.GetInt("Equip_SortSetting");
		recommendDesc.StringReference.TableEntryReference = ((num == 0) ? LocalizationCommonData.CommonString.EquipSortAll : LocalizationCommonData.CommonString.EquipSortPart);
	}
}
