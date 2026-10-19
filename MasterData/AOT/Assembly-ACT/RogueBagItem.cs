using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Define;
using ACT.UI;
using ACT.UI.InputController;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

public class RogueBagItem : MonoBehaviour, ISubmitHandler, IEventSystemHandler, IPointerClickHandler
{
	public GameObject GoItem;

	public BImage ImageQua;

	public BImage ImageItemIcon;

	public ActButton BtnClick;

	public GameObject GoSelect;

	public TextMeshProUGUI CharacterLevel;

	public int Itemid;

	public GameObject UnActive;

	public List<Sprite> Qualitys = new List<Sprite>();

	private ACT.ViewControl.SelectableEx _selectableEx;

	private bool _isSelected;

	private bool _isFocusSelected;

	private void Awake()
	{
		_selectableEx = GetComponent<ACT.ViewControl.SelectableEx>();
		if (_selectableEx != null)
		{
			_selectableEx.OnSelectChanged.AddListener(OnSelectChanged);
		}
	}

	private void OnDestroy()
	{
		if (_selectableEx != null)
		{
			_selectableEx.OnSelectChanged.RemoveListener(OnSelectChanged);
		}
		if ((bool)MonoECS.instance)
		{
			MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		}
	}

	private void Start()
	{
		if ((bool)MonoECS.instance)
		{
			MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
		}
	}

	private void Update()
	{
	}

	public void Init(int id, RogueItemType type, ImageAssetStation station = null)
	{
		Itemid = id;
		UnActive.SetActive(id == 0);
		GoItem.SetActive(id != 0);
		if (id == 0)
		{
			SetSelected(isSelected: false);
			return;
		}
		RogueElement data = CoreUtils.GetData(id, RuntimeConfigs.data.rogueElements);
		switch (type)
		{
		case RogueItemType.Prop:
		{
			RogueItem data4 = CoreUtils.GetData(id, RuntimeConfigs.data.rogueItems);
			ImageQua.icon.sprite = Qualitys[data4.rarity - 1];
			break;
		}
		case RogueItemType.Bloodbottle:
		{
			RogueHealthPotion data3 = CoreUtils.GetData(id, RuntimeConfigs.data.rogueHealthPotions);
			ImageQua.icon.sprite = Qualitys[data3.rarity - 1];
			break;
		}
		case RogueItemType.AssistCharacter:
		{
			RogueAssistCharacter data2 = CoreUtils.GetData(id, RuntimeConfigs.data.rogueAssistCharacters);
			CharacterLevel.SetText("等阶{0:0}", data2.tier);
			break;
		}
		}
		station.LoadImage(188, data.iconAddress, ImageItemIcon);
		ImageQua.icon.gameObject.SetActive(type == RogueItemType.Prop || type == RogueItemType.Bloodbottle);
	}

	public void SetSelected(bool isSelected)
	{
		_isSelected = isSelected;
		RefreshSelectState();
	}

	public void OnSubmit(BaseEventData eventData)
	{
		BtnClick.OnClick?.Invoke();
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		EventSystemHelper.SetSelectedGameObject(gameObject);
	}

	private void OnSelectChanged(bool isSelected)
	{
		_isFocusSelected = isSelected;
		RefreshSelectState();
	}

	private void OnInputModeChanged(DeviceInputMode inputMode)
	{
		if (_isSelected)
		{
			RefreshSelectState();
		}
	}

	private void RefreshSelectState()
	{
		if (!(GoSelect == null))
		{
			bool flag = _isSelected || _isFocusSelected;
			if (flag && _isSelected)
			{
				GoSelect.transform.localScale = Vector3.one;
			}
			if (GoSelect.activeSelf != flag)
			{
				GoSelect.SetActive(flag);
			}
		}
	}
}
