using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Fundamental;
using Sirenix.Serialization;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class ItemTreasureCenterView : BaseUIView<ItemTreasureCenterViewInputController>
{
	[SerializeField]
	private TextMeshProUGUI collectionCountText;

	public RectTransform TreasurePanel;

	public ActToggleGroup toggleGroup;

	public List<GameObject> toggles;

	[OdinSerialize]
	private Dictionary<int, List<RedDotItem>> _toggleRedDotItems;

	public GameObject GamepadTipsRoot;

	public ViewControlRoot ViewControlRoot;

	public GameObject PromptLB;

	public GameObject PromptRB;

	public GameObject PromptScroll;

	private Dictionary<int, GameObject> _treasureGameObject;

	private int _currentTreasureTypeID = 1;

	private int _lastSelectTreasureTypeID = -1;

	private int _jumpTargetTreasureId = -1;

	private bool _shouldJumpToSpecificTreasure;

	private int _defaultTypeID = 1;

	protected override void AddEventListener()
	{
		base.AddEventListener();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.TreasureJumpToSpecific, OnTreasureJumpToSpecific);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TreasureJumpToSpecific, OnTreasureJumpToSpecific);
	}

	protected override void Init()
	{
		base.Init();
		_treasureGameObject = new Dictionary<int, GameObject>();
		ItemTreasureCenterViewData itemTreasureCenterViewData = uiViewData as ItemTreasureCenterViewData;
		_currentTreasureTypeID = itemTreasureCenterViewData?.OpenType ?? _defaultTypeID;
		if (itemTreasureCenterViewData != null)
		{
			_shouldJumpToSpecificTreasure = itemTreasureCenterViewData.ShouldJumpToSpecificTreasure;
			_jumpTargetTreasureId = itemTreasureCenterViewData.JumpTargetTreasureId;
		}
		RefreshUI();
		InitToggleGroupRedDot();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show")?.Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		CleanCurSelectTabRedDot();
		if (toggleGroup != null)
		{
			toggleGroup.SetAllToggleOff();
		}
		if (toggles != null)
		{
			for (int i = 0; i < toggles.Count; i++)
			{
				if (toggles[i] != null)
				{
					toggles[i].SetActive(value: true);
				}
			}
		}
		for (int num = TreasurePanel.childCount - 1; num >= 0; num--)
		{
			Object.DestroyImmediate(TreasurePanel.GetChild(num).gameObject);
		}
		_treasureGameObject.Clear();
		_currentTreasureTypeID = 1;
		_lastSelectTreasureTypeID = -1;
		_jumpTargetTreasureId = -1;
		_shouldJumpToSpecificTreasure = false;
	}

	private void CleanCurSelectTabRedDot()
	{
		int currentTreasureTypeID = _currentTreasureTypeID;
		string treasureTabRedDotPath = GetTreasureTabRedDotPath(currentTreasureTypeID);
		if (string.IsNullOrEmpty(treasureTabRedDotPath))
		{
			return;
		}
		RedDotTrieNode node = Singleton<RedDotManager>.instance.GetNode(treasureTabRedDotPath);
		if (node == null || node.ActiveChildCount <= 0)
		{
			return;
		}
		Dictionary<string, RedDotTrieNode> childNodeDic = node.childNodeDic;
		if (childNodeDic == null)
		{
			return;
		}
		foreach (KeyValuePair<string, RedDotTrieNode> item in childNodeDic)
		{
			if (item.Value.isLeaf)
			{
				Singleton<RedDotManager>.instance.SetLeafNodeActive(item.Value.CompletePath, active: false);
			}
		}
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide")?.Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	private void RefreshUI()
	{
		foreach (int treasureTypeId in Model<TreasureModel>.Interface.GetTreasureTypeIds())
		{
			if (!_treasureGameObject.ContainsKey(treasureTypeId))
			{
				_treasureGameObject.Add(treasureTypeId, CreateTreasurePanel(treasureTypeId));
			}
		}
		RefreshTab();
	}

	private void RefreshCollectionCount(int treasureTypeId)
	{
		if (!(collectionCountText == null))
		{
			bool flag = treasureTypeId == 2;
			int num = (flag ? Model<TreasureModel>.Interface.GetMyDiskCounts() : Model<TreasureModel>.Interface.GetMyTreasureCounts());
			int localizeId = (flag ? 2886 : 2070);
			collectionCountText.SetText(LocalizationUtility.GetLocalizeString("Common", localizeId, new List<object> { num }));
		}
	}

	private void RefreshTab()
	{
		List<int> treasureTypeIds = Model<TreasureModel>.Interface.GetTreasureTypeIds();
		if (toggleGroup == null || toggles == null || toggles.Count == 0)
		{
			return;
		}
		int num = Mathf.Min(treasureTypeIds.Count, toggles.Count);
		for (int i = 0; i < toggles.Count; i++)
		{
			GameObject gameObject = toggles[i];
			if (gameObject == null)
			{
				continue;
			}
			bool flag = i < num;
			gameObject.SetActive(flag);
			if (!flag)
			{
				continue;
			}
			ActToggle component = gameObject.GetComponent<ActToggle>();
			if (component != null)
			{
				int typeId = treasureTypeIds[i];
				component.onToggleOn.RemoveAllListeners();
				component.onToggleOn.AddListener(() =>
				{
					OnClickTabButtonHandle(typeId);
				});
			}
		}
		UpdateToggleRedDotDisplay(treasureTypeIds);
		SetStartPage(treasureTypeIds);
	}

	private void InitToggleGroupRedDot()
	{
		UpdateToggleRedDotDisplay(Model<TreasureModel>.Interface.GetTreasureTypeIds());
	}

	private void UpdateToggleRedDotDisplay(IList<int> treasureTypeIds)
	{
		if (_toggleRedDotItems == null || _toggleRedDotItems.Count == 0 || toggles == null)
		{
			return;
		}
		for (int i = 0; i < toggles.Count; i++)
		{
			if (i >= treasureTypeIds.Count)
			{
				continue;
			}
			int typeId = treasureTypeIds[i];
			string treasureTabRedDotPath = GetTreasureTabRedDotPath(typeId);
			if (string.IsNullOrEmpty(treasureTabRedDotPath) || !_toggleRedDotItems.TryGetValue(i, out var value) || value == null)
			{
				continue;
			}
			foreach (RedDotItem item in value)
			{
				if (!(item == null))
				{
					if (item.displayAction == null)
					{
						item.displayAction = new SelfNodeActive();
					}
					item.redDotType = RedDotType.Dot;
					item.fullPath = treasureTabRedDotPath.Split("|").ToList();
					item.BindTrieNode();
					item.UpdateDisplay();
				}
			}
		}
	}

	private string GetTreasureTabRedDotPath(int typeId)
	{
		return (TreasureType)typeId switch
		{
			TreasureType.Precious => RedDotPathDefine.Treasure_Precious, 
			TreasureType.Fragmented => RedDotPathDefine.Treasure_Fragmented, 
			TreasureType.WaterfallSeal => RedDotPathDefine.Treasure_WaterfallSeal, 
			TreasureType.Relic => RedDotPathDefine.Treasure_Relic, 
			TreasureType.BygoneOldObject => RedDotPathDefine.Treasure_BygoneOldObject, 
			TreasureType.LeftOver => RedDotPathDefine.Treasure_LeftOver, 
			TreasureType.EnergyControl => RedDotPathDefine.Treasure_EnergyControl, 
			_ => string.Empty, 
		};
	}

	private void SetStartPage()
	{
		SetStartPage(Model<TreasureModel>.Interface.GetTreasureTypeIds());
	}

	private void SetStartPage(IList<int> treasureTypeIds)
	{
		if (treasureTypeIds == null || treasureTypeIds.Count == 0)
		{
			return;
		}
		if (!treasureTypeIds.Contains(_currentTreasureTypeID))
		{
			_currentTreasureTypeID = treasureTypeIds[0];
		}
		if (toggleGroup != null)
		{
			toggleGroup.SetAllToggleOff();
			int num = treasureTypeIds.IndexOf(_currentTreasureTypeID);
			if (num >= 0 && num < toggleGroup.ToggleCount && toggles != null && num < toggles.Count)
			{
				toggleGroup.Init(num);
			}
		}
		OpenTreasurePanel(_currentTreasureTypeID);
	}

	private void OnClickTabButtonHandle(int typeId)
	{
		if (_currentTreasureTypeID != typeId)
		{
			_lastSelectTreasureTypeID = _currentTreasureTypeID;
			_currentTreasureTypeID = typeId;
			RefreshCollectionCount(_currentTreasureTypeID);
			CleanAllRedDot();
			OpenTreasurePanel(_currentTreasureTypeID);
		}
	}

	private void OpenTreasurePanel(int treasureType)
	{
		RefreshCollectionCount(treasureType);
		if (_treasureGameObject.TryGetValue(_lastSelectTreasureTypeID, out var value))
		{
			value?.SetActive(value: false);
		}
		if (_treasureGameObject.TryGetValue(treasureType, out var value2))
		{
			if (value2 != null && !value2.activeSelf)
			{
				value2.SetActive(value: true);
				value2.GetComponent<TreasureTypePrefabBase>()?.PlayAnimation("Show");
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Collection/Animation");
			}
			value2?.SetActive(value: true);
			TreasureTypePrefabBase treasureTypePrefabBase = value2?.GetComponent<TreasureTypePrefabBase>();
			ApplyPendingTreasureJump(treasureType, treasureTypePrefabBase);
			treasureTypePrefabBase?.RefreshPanel();
		}
		else
		{
			GameObject gameObject = CreateTreasurePanel(treasureType);
			ApplyPendingTreasureJump(treasureType, gameObject?.GetComponent<TreasureTypePrefabBase>());
			gameObject?.SetActive(value: true);
			gameObject?.GetComponent<TreasureTypePrefabBase>()?.PlayAnimation("Show");
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Collection/Animation");
			_treasureGameObject.Add(treasureType, gameObject);
		}
		if (_treasureGameObject.TryGetValue(treasureType, out var value3))
		{
			TreasureFragment treasureFragment = value3?.GetComponent<TreasureFragment>();
			if (treasureFragment != null)
			{
				treasureFragment.ViewControlLayer.ReFocus();
			}
		}
	}

	private void ApplyPendingTreasureJump(int treasureType, TreasureTypePrefabBase treasureTypePrefab)
	{
		if (_shouldJumpToSpecificTreasure && treasureType == _currentTreasureTypeID)
		{
			if (treasureTypePrefab is TreasureFragment treasureFragment)
			{
				treasureFragment.SetInitialSelection(_jumpTargetTreasureId);
			}
			_shouldJumpToSpecificTreasure = false;
			_jumpTargetTreasureId = -1;
		}
	}

	private void OnTreasureJumpToSpecific(BaseEventContent evt)
	{
		if (evt is TreasureJumpToSpecificEvt treasureJumpToSpecificEvt)
		{
			_lastSelectTreasureTypeID = _currentTreasureTypeID;
			_currentTreasureTypeID = treasureJumpToSpecificEvt.OpenType;
			_jumpTargetTreasureId = treasureJumpToSpecificEvt.JumpTargetTreasureId;
			_shouldJumpToSpecificTreasure = true;
			SetStartPage();
		}
	}

	private GameObject CreateTreasurePanel(int treasureType)
	{
		if (treasureType == 0)
		{
			return null;
		}
		string prefabNameByTreasureType = Model<TreasureModel>.Interface.GetPrefabNameByTreasureType(treasureType);
		if (string.IsNullOrEmpty(prefabNameByTreasureType))
		{
			return null;
		}
		GameObject gameObject = Object.Instantiate(Station.Load<GameObject>(prefabNameByTreasureType).AsGameObject(), TreasurePanel);
		TreasureFragment component = gameObject.GetComponent<TreasureFragment>();
		if (component != null)
		{
			component.SetTypeId(treasureType);
		}
		gameObject.SetActive(value: false);
		return gameObject;
	}

	public void CleanAllRedDot()
	{
		int typeId = ((_lastSelectTreasureTypeID == -1) ? _currentTreasureTypeID : _lastSelectTreasureTypeID);
		string treasureTabRedDotPath = GetTreasureTabRedDotPath(typeId);
		if (string.IsNullOrEmpty(treasureTabRedDotPath))
		{
			return;
		}
		RedDotTrieNode node = Singleton<RedDotManager>.instance.GetNode(treasureTabRedDotPath);
		if (node == null || node.ActiveChildCount <= 0)
		{
			return;
		}
		Dictionary<string, RedDotTrieNode> childNodeDic = node.childNodeDic;
		if (childNodeDic == null)
		{
			return;
		}
		foreach (KeyValuePair<string, RedDotTrieNode> item in childNodeDic)
		{
			if (item.Value.isLeaf)
			{
				Singleton<RedDotManager>.instance.SetLeafNodeActive(item.Value.CompletePath, active: false);
			}
		}
	}

	public void OnControllerActivate()
	{
		OnInputDeviceChange(MonoECS.instance.InputMode);
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		GamepadTipsRoot.SetActive(type == DeviceInputMode.Gamepad);
		PromptLB.SetActive(type == DeviceInputMode.Gamepad);
		PromptRB.SetActive(type == DeviceInputMode.Gamepad);
		if (_treasureGameObject.TryGetValue(_currentTreasureTypeID, out var value))
		{
			TreasureFragment component = value.GetComponent<TreasureFragment>();
			if (component != null)
			{
				RefreshPrompScroll(component.GetGamepadIsScroll());
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
		if (EventSystemHelper.CurrentSelected != null)
		{
			EventSystemHelper.CurrentSelected.GetComponent<ItemUIComponentBase>()?.OnSubmit(null);
		}
	}

	public void SwitchPageUp()
	{
		if (toggles == null)
		{
			return;
		}
		List<int> treasureTypeIds = Model<TreasureModel>.Interface.GetTreasureTypeIds();
		int num = treasureTypeIds.IndexOf(_currentTreasureTypeID);
		int num2 = Mathf.Min(treasureTypeIds.Count, toggles.Count);
		if (num > 0 && num < num2)
		{
			ActToggle component = toggles[num - 1].GetComponent<ActToggle>();
			if ((bool)component)
			{
				component.OnSubmit(null);
			}
		}
	}

	public void SwitchPageDown()
	{
		if (toggles == null)
		{
			return;
		}
		List<int> treasureTypeIds = Model<TreasureModel>.Interface.GetTreasureTypeIds();
		int num = treasureTypeIds.IndexOf(_currentTreasureTypeID);
		int num2 = Mathf.Min(treasureTypeIds.Count, toggles.Count);
		if (num >= 0 && num < num2 - 1)
		{
			ActToggle component = toggles[num + 1].GetComponent<ActToggle>();
			if ((bool)component)
			{
				component.OnSubmit(null);
			}
		}
	}

	public void OnLookTutorial()
	{
		if (_treasureGameObject.TryGetValue(_currentTreasureTypeID, out var value))
		{
			TreasureFragment component = value.GetComponent<TreasureFragment>();
			if (!(component == null) && component._btnTutorial.gameObject.activeSelf && component._btnTutorial.IsInteractable())
			{
				component._btnTutorial.OnSubmit(null);
			}
		}
	}

	public bool TrySubmitDiskDetail()
	{
		if (!_treasureGameObject.TryGetValue(_currentTreasureTypeID, out var value) || value == null || !value.activeInHierarchy)
		{
			return false;
		}
		TreasureFragment component = value.GetComponent<TreasureFragment>();
		if (component != null)
		{
			return component.TrySubmitDiskDetail();
		}
		return false;
	}

	public void RefreshPrompScroll(bool isScroll)
	{
		PromptScroll.SetActive((MonoECS.instance.InputMode == DeviceInputMode.Gamepad) & isScroll);
	}
}
