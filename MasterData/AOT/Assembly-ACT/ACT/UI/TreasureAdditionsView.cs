using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class TreasureAdditionsView : BaseUIView<TreasureAdditionsViewInputController>
{
	private TreasureAdditionsViewData m_data;

	[SerializeField]
	private LoopVerticalScrollRect _specialTreasureList;

	[SerializeField]
	public ActToggleGroup toggleGroup;

	[SerializeField]
	private RectTransform _specialTreasureListRoot;

	[SerializeField]
	private RectTransform _propertyAddRoot;

	[SerializeField]
	private PublicToggleGroup _propertyAddToggleGroup;

	public PublicToggle globalTab;

	public PublicToggle characterTab;

	private BetterAnimation globalTabAnimation;

	private BetterAnimation characterTabAnimation;

	[SerializeField]
	private RectTransform _globalAddRoot;

	[SerializeField]
	private GameObject prefab;

	[SerializeField]
	private Transform BaseRoot;

	[SerializeField]
	private Transform AdvanceRoot;

	[SerializeField]
	private Transform ElementRoot;

	[SerializeField]
	private GameObject _content;

	[SerializeField]
	private GameObject _noneRoot1;

	[SerializeField]
	private RectTransform _characterAddRoot;

	[SerializeField]
	private LoopVerticalScrollRect _characterList;

	[SerializeField]
	private RectTransform _contentRT;

	[SerializeField]
	private GameObject _ViewPortContent;

	[SerializeField]
	private GameObject _noneRoot2;

	[SerializeField]
	private Transform baseRootGO;

	[SerializeField]
	private Transform advanceRootGO;

	[SerializeField]
	private Transform elementRootGO;

	public GameObject GamepadTipsRoot;

	public Dictionary<TreasureAdditionsViewControlType, List<GameObject>> ControlDownPromts;

	public Dictionary<TreasureAdditionsViewControlType, List<GameObject>> ControlPromts;

	public Dictionary<TreasureAdditionsViewControlType, ViewControlLayer> ControlLayerDic;

	public ViewControlRoot ViewControlRoot;

	public TextMeshProUGUI ConfirmLabel;

	public GameObject PromptLB;

	public GameObject PromptRB;

	private int _defaultSelectIndex;

	private int m_curPageIndex = -1;

	private List<Toggle> toggleCacheList = new List<Toggle>();

	private List<GameObject> m_ObjList = new List<GameObject>();

	private TreasureAdditionsViewControlType ControlType
	{
		get
		{
			return GetController().ControlType;
		}
		set
		{
			GetController().ControlType = value;
		}
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.TreasureCharacterPropertyRefresh, RefreshTreasureCharacterProperty);
		globalTab.onValueChanged.AddListener(OnClickGlobalTabTabHandle);
		characterTab.onValueChanged.AddListener(OnClickCharacterTabHandle);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TreasureCharacterPropertyRefresh, RefreshTreasureCharacterProperty);
		globalTab.onValueChanged.RemoveListener(OnClickGlobalTabTabHandle);
		characterTab.onValueChanged.RemoveListener(OnClickCharacterTabHandle);
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		toggleGroup.Init(_defaultSelectIndex);
		toggleGroup.SetToggleOn(0);
		globalTabAnimation = globalTab.gameObject.GetComponent<BetterAnimation>();
		characterTabAnimation = characterTab.gameObject.GetComponent<BetterAnimation>();
	}

	public void SelectToggle(int index)
	{
		_specialTreasureListRoot.gameObject.SetActive(value: false);
		_propertyAddRoot.gameObject.SetActive(value: false);
		switch (index)
		{
		case 0:
			betterAnimation.GetSequence("Change01")?.OnComplete(async (AnimationBuilder _) =>
			{
			}).Play();
			_specialTreasureListRoot.gameObject.SetActive(value: true);
			RefreshSpecialTreasureList();
			break;
		case 1:
			betterAnimation.GetSequence("Change02")?.OnComplete(async (AnimationBuilder _) =>
			{
			}).Play();
			_propertyAddRoot.gameObject.SetActive(value: true);
			RefreshPropertyAddPart();
			break;
		}
		_defaultSelectIndex = index;
	}

	private void RefreshSpecialTreasureList()
	{
		_specialTreasureList.ClearCells();
		_specialTreasureList.totalCount = Model<TreasureModel>.Interface.GetAllSpecialTreasures().Count;
		_specialTreasureList.RefillCells();
		ChangeControlType(TreasureAdditionsViewControlType.SpecialTreasure);
	}

	private void RefreshPropertyAddPart()
	{
		InitToggleGroup();
	}

	private void InitToggleGroup()
	{
		_propertyAddToggleGroup.toggles[0].isOn = true;
		RefreshGlobalProperty();
	}

	private void OnClickGlobalTabTabHandle(bool value)
	{
		if (value)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Collection/Buff/Top_Click");
			globalTabAnimation.GetSequence("Hightlight")?.OnComplete(async (AnimationBuilder _) =>
			{
			}).Play();
			betterAnimation.GetSequence("ButtonChange01")?.OnComplete(async (AnimationBuilder _) =>
			{
			}).Play();
			_characterAddRoot.gameObject.SetActive(value: false);
			_globalAddRoot.gameObject.SetActive(value: true);
			RefreshGlobalProperty();
		}
	}

	private void RefreshGlobalProperty()
	{
		Dictionary<int, Dictionary<int, float>> mergeTreasuresAttrBonus = Model<TreasureModel>.Interface.GetMergeTreasuresAttrBonus();
		SetAttribute(mergeTreasuresAttrBonus, Station);
		ChangeControlType(TreasureAdditionsViewControlType.GlobalProperty);
	}

	private void SetAttribute(Dictionary<int, Dictionary<int, float>> treasuresAttrBonus, ImageAssetStation imageAssetStation)
	{
		_content.gameObject.SetActive(treasuresAttrBonus.Count > 0);
		_noneRoot1.SetActive(treasuresAttrBonus.Count == 0);
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		int num4 = 0;
		foreach (KeyValuePair<int, Dictionary<int, float>> treasuresAttrBonu in treasuresAttrBonus)
		{
			foreach (KeyValuePair<int, float> item in treasuresAttrBonu.Value)
			{
				int key = treasuresAttrBonu.Key;
				float value = item.Value;
				PropertyData data = CoreUtils.GetData(key, RuntimeConfigs.data.propertyDatas);
				if (data == null)
				{
					continue;
				}
				PropertyTypeData data2 = CoreUtils.GetData(data.propertyId, RuntimeConfigs.data.propertyTypeDatas);
				if (data2 != null)
				{
					num++;
					GameObject gameObject = null;
					Transform parent = null;
					switch (data2.type)
					{
					case 1:
						parent = BaseRoot;
						num2++;
						break;
					case 2:
						parent = AdvanceRoot;
						num3++;
						break;
					case 3:
						parent = ElementRoot;
						num4++;
						break;
					}
					if (m_ObjList.Count < num)
					{
						gameObject = UnityEngine.Object.Instantiate(prefab, parent);
						gameObject.SetActive(value: true);
						m_ObjList.Add(gameObject);
					}
					else
					{
						gameObject = m_ObjList[num - 1];
						gameObject.transform.parent = parent;
						gameObject.SetActive(value: true);
					}
					PropertyCell component = gameObject.GetComponent<PropertyCell>();
					bool flag = value == 0f;
					string arg = (data.judge ? GameUtility.Topercentage((float)(Math.Ceiling(value * 10000f) / 10000.0), 1) : Math.Ceiling(value).ToString());
					component.InitInNumNeedIcon(data, data.descLocal, imageAssetStation, flag ? $"<color=#FFFFFF>+{arg}</color>" : $"+{arg}");
				}
			}
		}
		for (int i = num; i < m_ObjList.Count; i++)
		{
			if (m_ObjList[i] != null)
			{
				m_ObjList[i].SetActive(value: false);
			}
		}
		baseRootGO.gameObject.SetActive(num2 > 0);
		advanceRootGO.gameObject.SetActive(num3 > 0);
		elementRootGO.gameObject.SetActive(num4 > 0);
	}

	private void OnClickCharacterTabHandle(bool value)
	{
		if (value)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Collection/Buff/Top_Click");
			characterTabAnimation.GetSequence("Hightlight")?.OnComplete(async (AnimationBuilder _) =>
			{
			}).Play();
			betterAnimation.GetSequence("ButtonChange02")?.OnComplete(async (AnimationBuilder _) =>
			{
			}).Play();
			_globalAddRoot.gameObject.SetActive(value: false);
			_characterAddRoot.gameObject.SetActive(value: true);
			RefreshCharacterProperty();
		}
	}

	private void RefreshCharacterProperty()
	{
		int count = Model<TreasureModel>.Interface._treasureCharacterList.Count;
		_contentRT.gameObject.SetActive(count > 0);
		_noneRoot2.SetActive(count == 0);
		_characterList.ClearCells();
		_characterList.totalCount = count;
		_characterList.RefillCells();
		ChangeControlType(TreasureAdditionsViewControlType.CharacterProperty);
	}

	private void RefreshTreasureCharacterProperty(BaseEventContent obj)
	{
		LayoutRebuilder.ForceRebuildLayoutImmediate(_contentRT);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show")?.OnComplete(async (AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		toggleGroup.SetAllToggleOff();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide")?.OnComplete(async (AnimationBuilder _) =>
		{
			CloseEffectCallback();
		}).Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (GamepadTipsRoot != null)
		{
			GamepadTipsRoot.SetActive(type == DeviceInputMode.Gamepad);
		}
		if (PromptLB != null)
		{
			PromptLB.SetActive(type == DeviceInputMode.Gamepad);
		}
		if (PromptRB != null)
		{
			PromptRB.SetActive(type == DeviceInputMode.Gamepad);
		}
		if (type == DeviceInputMode.Gamepad)
		{
			ChangeControlType(ControlType);
		}
	}

	public void ChangeControlType(TreasureAdditionsViewControlType controlType)
	{
		TreasureAdditionsViewControlType controlType2 = ControlType;
		ControlType = controlType;
		if (ControlLayerDic != null && ControlLayerDic.TryGetValue(controlType, out var value) && value != null)
		{
			value.ReFocus();
		}
		if (GamepadTipsRoot != null && GamepadTipsRoot.transform.childCount > 0)
		{
			Transform child = GamepadTipsRoot.transform.GetChild(0);
			for (int i = 0; i < child.childCount; i++)
			{
				child.GetChild(i).gameObject.SetActive(value: false);
			}
			if (ControlDownPromts != null && ControlDownPromts.TryGetValue(controlType, out var value2) && value2 != null)
			{
				foreach (GameObject item in value2)
				{
					if (!(item == null))
					{
						item.SetActive(value: true);
						RectTransform component = item.GetComponent<RectTransform>();
						if (component != null)
						{
							LayoutRebuilder.ForceRebuildLayoutImmediate(component);
						}
					}
				}
			}
			RectTransform component2 = child.GetComponent<RectTransform>();
			if (component2 != null)
			{
				LayoutRebuilder.ForceRebuildLayoutImmediate(component2);
			}
		}
		SetControlPromptsActive(controlType2, active: false);
		SetControlPromptsActive(controlType, active: true);
		if (controlType == TreasureAdditionsViewControlType.SpecialTreasure && ConfirmLabel != null)
		{
			ConfirmLabel.SetText(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 774));
		}
		HandleCharacterPropertyTips();
	}

	private void SetControlPromptsActive(TreasureAdditionsViewControlType controlType, bool active)
	{
		if (ControlPromts == null || !ControlPromts.TryGetValue(controlType, out var value) || value == null)
		{
			return;
		}
		foreach (GameObject item in value)
		{
			if (item != null)
			{
				item.SetActive(active);
			}
		}
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Left:
			ViewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			ViewControlRoot.SelectRight();
			break;
		case MoveDirection.Up:
			ViewControlRoot.SelectUp();
			break;
		case MoveDirection.Down:
			ViewControlRoot.SelectDown();
			break;
		}
		HandleCharacterPropertyTips();
	}

	public void SwitchPageUp()
	{
		int firstActiveToggleIndex = toggleGroup.GetFirstActiveToggleIndex();
		if (firstActiveToggleIndex > 0)
		{
			toggleGroup.GetToggleByIndex(firstActiveToggleIndex - 1).OnSubmit(null);
		}
	}

	public void SwitchPageDown()
	{
		int firstActiveToggleIndex = toggleGroup.GetFirstActiveToggleIndex();
		if (firstActiveToggleIndex < toggleGroup.ToggleCount - 1)
		{
			toggleGroup.GetToggleByIndex(firstActiveToggleIndex + 1).OnSubmit(null);
		}
	}

	public void OnGlobalPropertyHandle()
	{
		globalTab.OnSubmit(null);
	}

	public void OnCharacterPropertyHandle()
	{
		characterTab.OnSubmit(null);
	}

	public void HandleConfirm()
	{
		if (!(EventSystemHelper.CurrentSelected == null))
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
			HandleCharacterPropertyTips();
		}
	}

	private void HandleCharacterPropertyTips()
	{
		if (ControlType != TreasureAdditionsViewControlType.CharacterProperty || ConfirmLabel == null)
		{
			return;
		}
		TreasureCharacterPropertyCell treasureCharacterPropertyCell = null;
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected != null)
		{
			treasureCharacterPropertyCell = currentSelected.GetComponent<TreasureCharacterPropertyCell>() ?? currentSelected.GetComponentInParent<TreasureCharacterPropertyCell>();
		}
		if (treasureCharacterPropertyCell == null && _characterList != null && _characterList.totalCount > 0)
		{
			treasureCharacterPropertyCell = _characterList.GetItem(0) as TreasureCharacterPropertyCell;
			if (treasureCharacterPropertyCell != null && EventSystemHelper.Available)
			{
				EventSystemHelper.SetSelectedGameObject(treasureCharacterPropertyCell.gameObject);
			}
		}
		ConfirmLabel.SetText(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, (treasureCharacterPropertyCell != null && treasureCharacterPropertyCell.IsExpand) ? 115 : 2595));
	}
}
