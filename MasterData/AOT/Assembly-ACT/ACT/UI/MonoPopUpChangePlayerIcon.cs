using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using Unity.Profiling;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoPopUpChangePlayerIcon : BaseUIView<PopUpChangePlayerIconInputController>
{
	[SerializeField]
	private BImage previewAvatar;

	[SerializeField]
	private BImage previewAvatarFrame;

	[SerializeField]
	private BImage previewUpperAvatarFrame;

	[SerializeField]
	private BImage previewTitle;

	[SerializeField]
	private LocalizeStringEvent previewTitleName;

	[SerializeField]
	private LocalizeStringEvent avatarName;

	[SerializeField]
	private LoopScrollRect iconList;

	[SerializeField]
	private LoopScrollRect titleList;

	[SerializeField]
	private AccountDecorationTab tab;

	[SerializeField]
	private TextMeshProUGUI descriptionText;

	[SerializeField]
	private ActButton confirmBtn;

	[SerializeField]
	private LocalizeStringEvent confirmBtnLocalize;

	[SerializeField]
	private GameObject iconListRoot;

	[SerializeField]
	private GameObject titleListRoot;

	[SerializeField]
	private GameObject confirmGamePadPrompt;

	[SerializeField]
	private int confirmButtonTextId;

	[SerializeField]
	private int usingButtonTextId;

	[SerializeField]
	private int lockedButtonTextId;

	public ViewControlRoot ViewControlRoot;

	public ViewControlLayer ViewControlLayer;

	public GameObject ScrollPrompt;

	private List<AccountDecorationItemData> _currentItems;

	private int _selectedIndex = -1;

	private AccountDecorationType _currentTabType;

	private int _selectedAvatarId;

	private int _selectedAvatarFrameId;

	private int _selectedTitleId;

	private bool _canConfirmCurrentSelection;

	private bool _isSubmitting;

	private readonly Dictionary<AccountDecorationType, HashSet<int>> _pendingViewedRedDotIds = new Dictionary<AccountDecorationType, HashSet<int>>();

	private static readonly ProfilerMarker RefreshVisibleStatesMarker = new ProfilerMarker("AccountDecoration.RefreshVisibleStates");

	private static readonly ProfilerMarker OnScrollMarker = new ProfilerMarker("AccountDecoration.OnScroll");

	private static readonly ProfilerMarker LoadIconMarker = new ProfilerMarker("AccountDecoration.LoadIcon");

	protected override void Init()
	{
		base.Init();
		BindComponentsIfNeeded();
		ConfigureAvatarNameText();
		BindTabEvents();
		BindButtonEvents();
		_currentItems = ListPool<AccountDecorationItemData>.Get();
		_selectedAvatarId = G.localPlayer.Profile.EscInfo.CurAvatarId;
		_selectedAvatarFrameId = G.localPlayer.Profile.EscInfo.CurAvatarFrameId;
		_selectedTitleId = G.localPlayer.Profile.EscInfo.CurTitleId;
		tab?.SwitchToImmediately(0);
		SwitchToTab(AccountDecorationType.Avatar, force: true);
	}

	protected override void UnInit()
	{
		FlushAllPendingViewedRedDots();
		UnbindTabEvents();
		UnbindButtonEvents();
		if (_currentItems != null)
		{
			_currentItems.Clear();
			ListPool<AccountDecorationItemData>.Release(_currentItems);
			_currentItems = null;
		}
		base.UnInit();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		AnimationBuilder animationBuilder = betterAnimation?.GetSequence("Show");
		if (animationBuilder == null)
		{
			OpenEffectFinishNew();
			return;
		}
		animationBuilder.OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		AnimationBuilder animationBuilder = betterAnimation?.GetSequence("Hide");
		if (animationBuilder == null)
		{
			CloseEffectFinishNew();
			return;
		}
		animationBuilder.OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	private void PlaySwitchAnimation()
	{
		betterAnimation?.GetSequence("Switch")?.Play();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/ProfileDecoration/IconBanner");
	}

	public override void Close()
	{
		if (!_isSubmitting)
		{
			FlushAllPendingViewedRedDots();
			base.Close();
		}
	}

	public void OnScroll(PlayerIconComponent item)
	{
		if (_currentItems == null || item.index < 0 || item.index >= _currentItems.Count)
		{
			return;
		}
		using (OnScrollMarker.Auto())
		{
			AccountDecorationItemData accountDecorationItemData = _currentItems[item.index];
			item.Init();
			item.toggle.onSelected.RemoveListener(() =>
			{
				SetPreview(item);
			});
			item.toggle.onSelected.AddListener(() =>
			{
				SetPreview(item);
			});
			item.toggle.onSelected.RemoveListener(OnPlayerIconSelected);
			item.toggle.onSelected.AddListener(OnPlayerIconSelected);
			LoadDecorationIcon(accountDecorationItemData.Type, accountDecorationItemData.IconId, item.icon);
			if (accountDecorationItemData.Type == AccountDecorationType.AvatarFrame && item.upperIcon != null)
			{
				item.SetUpperIconVisible(visible: true);
				Station.LoadImage(243, accountDecorationItemData.IconId, item.upperIcon);
			}
			item.SetLocked(!accountDecorationItemData.IsUnlocked);
			item.InitRedDot(accountDecorationItemData.RedDotPath);
			MarkVisibleRedDotViewed(accountDecorationItemData);
			if (item.index == _selectedIndex)
			{
				item.toggle.SetIsOnWithoutNotifyAndRefreshVisual(value: true);
			}
			if (accountDecorationItemData.IsUsing)
			{
				item.SetUsing();
			}
		}
	}

	public void OnPlayerIconSelected()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Item_Click");
	}

	public void OnTitleScroll(TitleIconComponent item)
	{
		if (_currentItems != null && item.index >= 0 && item.index < _currentItems.Count)
		{
			AccountDecorationItemData accountDecorationItemData = _currentItems[item.index];
			item.Init();
			item.toggle.onSelected.RemoveListener(() =>
			{
				SetTitlePreview(item);
			});
			item.toggle.onSelected.AddListener(() =>
			{
				SetTitlePreview(item);
			});
			item.toggle.onSelected.RemoveListener(OnPlayerIconSelected);
			item.toggle.onSelected.AddListener(OnPlayerIconSelected);
			LoadDecorationIcon(accountDecorationItemData.Type, accountDecorationItemData.IconId, item.icon);
			item.SetLocked(!accountDecorationItemData.IsUnlocked);
			item.InitRedDot(accountDecorationItemData.RedDotPath);
			MarkVisibleRedDotViewed(accountDecorationItemData);
			if (item.titleText != null)
			{
				item.titleText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, accountDecorationItemData.Name);
			}
			if (item.index == _selectedIndex)
			{
				item.toggle.SetIsOnWithoutNotifyAndRefreshVisual(value: true);
			}
			if (accountDecorationItemData.IsUsing)
			{
				item.SetUsing();
			}
		}
	}

	public void SetPreview(PlayerIconComponent item)
	{
		if (_currentItems != null && item.index >= 0 && item.index < _currentItems.Count)
		{
			_selectedIndex = item.index;
			AccountDecorationItemData accountDecorationItemData = _currentItems[item.index];
			SetSelectedId(_currentTabType, accountDecorationItemData.Id);
			RefreshPreview(accountDecorationItemData);
		}
	}

	public void SetTitlePreview(TitleIconComponent item)
	{
		if (_currentItems != null && item.index >= 0 && item.index < _currentItems.Count)
		{
			_selectedIndex = item.index;
			AccountDecorationItemData accountDecorationItemData = _currentItems[item.index];
			SetSelectedId(_currentTabType, accountDecorationItemData.Id);
			RefreshPreview(accountDecorationItemData);
		}
	}

	public void OnSubmit()
	{
		SubmitCurrentSelection();
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Up:
			ViewControlRoot?.SelectUp();
			break;
		case MoveDirection.Down:
			ViewControlRoot?.SelectDown();
			break;
		case MoveDirection.Left:
			ViewControlRoot?.SelectLeft();
			break;
		case MoveDirection.Right:
			ViewControlRoot?.SelectRight();
			break;
		}
		RefreshPreviewByCurrentSelectedGameObject();
		RefreshScrollPrompt();
	}

	public void SwitchTabByGamepad(int direction)
	{
		if (!(tab == null))
		{
			int num = ((tab.CurrentIndex >= 0) ? tab.CurrentIndex : ((int)_currentTabType));
			int num2 = Mathf.Clamp(num + direction, 0, 2);
			if (num2 != num)
			{
				SwitchToTab((AccountDecorationType)num2);
				RefreshGamepadFocus();
			}
		}
	}

	public void SwitchToTab(AccountDecorationType type)
	{
		SwitchToTab(type, force: false);
	}

	public void RefreshCurrentTab()
	{
		if (_currentItems != null)
		{
			BuildCurrentItemData();
			RefreshListVisible();
			_selectedIndex = FindSelectedIndex();
			RefreshScrollView();
			if (_selectedIndex >= 0 && _selectedIndex < _currentItems.Count)
			{
				RefreshPreview(_currentItems[_selectedIndex]);
			}
			else
			{
				RefreshPreview(null);
			}
			RefreshRedDot();
			RefreshGamePadHints();
			RefreshGamepadFocus();
		}
	}

	public void RefreshRedDot()
	{
		tab?.RefreshRedDot();
	}

	public void RefreshGamePadHints()
	{
		RefreshScrollPrompt();
		RefreshConfirmGamePadHint();
	}

	public void RefreshGamepadFocus()
	{
		if (!(MonoECS.instance == null) && MonoECS.instance.InputMode == DeviceInputMode.Gamepad && !(ViewControlLayer == null))
		{
			Component currentScrollItem = GetCurrentScrollItem(_selectedIndex);
			ACT.ViewControl.SelectableEx selectableEx = ((currentScrollItem != null) ? currentScrollItem.GetComponentInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true) : null);
			if (selectableEx != null)
			{
				ViewControlLayer.SetDefaultSelect(selectableEx);
			}
			ViewControlLayer.ReFocus();
			RefreshPreviewByCurrentSelectedGameObject();
		}
	}

	private void RefreshPreviewByCurrentSelectedGameObject()
	{
		GameObject gameObject = (EventSystemHelper.Available ? EventSystemHelper.CurrentSelected : null);
		if (gameObject == null)
		{
			return;
		}
		PlayerIconComponent componentInParent = gameObject.GetComponentInParent<PlayerIconComponent>();
		if (componentInParent != null && _currentTabType != AccountDecorationType.Title)
		{
			if (componentInParent.toggle != null && !componentInParent.toggle.isOn)
			{
				componentInParent.toggle.isOn = true;
			}
			SetPreview(componentInParent);
			return;
		}
		TitleIconComponent componentInParent2 = gameObject.GetComponentInParent<TitleIconComponent>();
		if (componentInParent2 != null && _currentTabType == AccountDecorationType.Title)
		{
			if (componentInParent2.toggle != null && !componentInParent2.toggle.isOn)
			{
				componentInParent2.toggle.isOn = true;
			}
			SetTitlePreview(componentInParent2);
		}
	}

	private void RefreshScrollPrompt()
	{
		if (ScrollPrompt == null)
		{
			return;
		}
		if (MonoECS.instance == null || MonoECS.instance.InputMode != DeviceInputMode.Gamepad)
		{
			ScrollPrompt.SetActive(value: false);
			return;
		}
		LoopScrollRect currentScrollRect = GetCurrentScrollRect();
		RectTransform rectTransform = ((currentScrollRect != null) ? currentScrollRect.content : null);
		RectTransform rectTransform2 = ((currentScrollRect != null) ? currentScrollRect.viewport : null);
		if (currentScrollRect == null || rectTransform == null || rectTransform2 == null || !currentScrollRect.gameObject.activeInHierarchy)
		{
			ScrollPrompt.SetActive(value: false);
			return;
		}
		bool active = (currentScrollRect.vertical ? (rectTransform.rect.height > rectTransform2.rect.height) : (currentScrollRect.horizontal && rectTransform.rect.width > rectTransform2.rect.width));
		ScrollPrompt.SetActive(active);
	}

	private LoopScrollRect GetCurrentScrollRect()
	{
		if (_currentTabType != AccountDecorationType.Title)
		{
			return iconList;
		}
		return titleList;
	}

	private Component GetCurrentScrollItem(int index)
	{
		LoopScrollRect currentScrollRect = GetCurrentScrollRect();
		if (currentScrollRect == null || index < 0)
		{
			return null;
		}
		return currentScrollRect.GetItem(index) as Component;
	}

	private void SwitchToTab(AccountDecorationType type, bool force)
	{
		if (_isSubmitting || (!force && _currentTabType == type))
		{
			return;
		}
		if (!force)
		{
			FlushPendingViewedRedDots(_currentTabType);
		}
		if (!force && tab != null)
		{
			if (!tab.TrySwitchTo((int)type))
			{
				return;
			}
		}
		_currentTabType = type;
		ResetSelectedIdByCurrentTab();
		RefreshCurrentTab();
		if (!force)
		{
			PlaySwitchAnimation();
		}
	}

	private void BuildCurrentItemData()
	{
		_currentItems.Clear();
		int nowTimestampSecond = TimeManager.ServerTime.NowTimestampSecond;
		switch (_currentTabType)
		{
		case AccountDecorationType.Avatar:
		{
			int currentGenderProtagonistAvatarId = GetCurrentGenderProtagonistAvatarId();
			bool flag3 = false;
			foreach (MtyAvatar value4 in RuntimeConfigs.data.MtyAvatars.Values)
			{
				if (!IsInDuration(value4.duration, nowTimestampSecond))
				{
					continue;
				}
				if (IsProtagonistAvatar(value4.id))
				{
					if ((value4.id != currentGenderProtagonistAvatarId) | flag3)
					{
						continue;
					}
					flag3 = true;
				}
				bool flag4 = G.localPlayer.Profile.EscInfo.AvatarIds.TryGetValue(value4.id, out var value3) & value3;
				string redDotPath3 = GetRedDotPath(AccountDecorationType.Avatar, value4.id);
				_currentItems.Add(new AccountDecorationItemData
				{
					Id = value4.id,
					Sort = value4.sort,
					Type = AccountDecorationType.Avatar,
					IsUnlocked = flag4,
					IsUsing = (value4.id == G.localPlayer.Profile.EscInfo.CurAvatarId),
					IsNew = (flag4 && IsRedDotActive(redDotPath3)),
					Name = value4.name,
					IconId = value4.iconID,
					GetWay = value4.getWay,
					RedDotPath = redDotPath3
				});
			}
			break;
		}
		case AccountDecorationType.AvatarFrame:
			foreach (Frame value5 in RuntimeConfigs.data.Frames.Values)
			{
				if (IsInDuration(value5.duration, nowTimestampSecond))
				{
					bool flag2 = G.localPlayer.Profile.EscInfo.AvatarFrameIds.TryGetValue(value5.id, out var value2) & value2;
					if (value5.channelType != 1 || flag2)
					{
						string redDotPath2 = GetRedDotPath(AccountDecorationType.AvatarFrame, value5.id);
						_currentItems.Add(new AccountDecorationItemData
						{
							Id = value5.id,
							Sort = value5.sort,
							Type = AccountDecorationType.AvatarFrame,
							IsUnlocked = flag2,
							IsUsing = (value5.id == G.localPlayer.Profile.EscInfo.CurAvatarFrameId),
							IsNew = (flag2 && IsRedDotActive(redDotPath2)),
							Name = value5.name,
							IconId = value5.iconID,
							GetWay = value5.getWay,
							RedDotPath = redDotPath2
						});
					}
				}
			}
			break;
		case AccountDecorationType.Title:
			foreach (Title value6 in RuntimeConfigs.data.Titles.Values)
			{
				if (IsInDuration(value6.duration, nowTimestampSecond))
				{
					bool flag = G.localPlayer.Profile.EscInfo.TitleIds.TryGetValue(value6.id, out var value) & value;
					if (value6.channelType != 1 || flag)
					{
						string redDotPath = GetRedDotPath(AccountDecorationType.Title, value6.id);
						_currentItems.Add(new AccountDecorationItemData
						{
							Id = value6.id,
							Sort = value6.sort,
							Type = AccountDecorationType.Title,
							IsUnlocked = flag,
							IsUsing = (value6.id == G.localPlayer.Profile.EscInfo.CurTitleId),
							IsNew = (flag && IsRedDotActive(redDotPath)),
							Name = value6.name,
							IconId = value6.iconID,
							GetWay = value6.getWay,
							RedDotPath = redDotPath
						});
					}
				}
			}
			break;
		default:
			throw new ArgumentOutOfRangeException();
		}
		_currentItems.Sort((AccountDecorationItemData left, AccountDecorationItemData right) =>
		{
			if (left.IsUnlocked != right.IsUnlocked)
			{
				if (!left.IsUnlocked)
				{
					return 1;
				}
				return -1;
			}
			bool flag5 = left.Sort > 0;
			bool flag6 = right.Sort > 0;
			if (flag5 & flag6)
			{
				int num = right.Sort.CompareTo(left.Sort);
				if (num == 0)
				{
					return left.Id.CompareTo(right.Id);
				}
				return num;
			}
			return (flag5 != flag6) ? ((!flag5) ? 1 : (-1)) : left.Id.CompareTo(right.Id);
		});
	}

	private static bool IsProtagonistAvatar(int avatarId)
	{
		if (avatarId != RuntimeConfigs.data.game.FemaleDefaultAvatarId)
		{
			return avatarId == RuntimeConfigs.data.game.MaleDefaultAvatarId;
		}
		return true;
	}

	private static int GetCurrentGenderProtagonistAvatarId()
	{
		if (G.detailUserInfo.Brief.Gender != 1)
		{
			return RuntimeConfigs.data.game.FemaleDefaultAvatarId;
		}
		return RuntimeConfigs.data.game.MaleDefaultAvatarId;
	}

	private static bool IsInDuration(int[] duration, long nowTimestamp)
	{
		if (duration == null || duration.Length == 0)
		{
			return true;
		}
		if (duration.Length < 2)
		{
			return true;
		}
		if (nowTimestamp >= duration[0])
		{
			return nowTimestamp <= duration[1];
		}
		return false;
	}

	private int FindSelectedIndex()
	{
		if (_currentItems.Count == 0)
		{
			return -1;
		}
		int selectedId = GetSelectedId(_currentTabType);
		for (int i = 0; i < _currentItems.Count; i++)
		{
			if (_currentItems[i].Id == selectedId)
			{
				return i;
			}
		}
		if (_currentTabType == AccountDecorationType.Title && GetCurrentUsingId() == 0)
		{
			SetSelectedId(AccountDecorationType.Title, _currentItems[0].Id);
		}
		return 0;
	}

	private void RefreshScrollView()
	{
		if (_currentTabType == AccountDecorationType.Title)
		{
			RefreshTitleScrollView();
		}
		else
		{
			RefreshIconScrollView();
		}
	}

	private void RefreshIconScrollView()
	{
		if (!(iconList == null))
		{
			iconList.ClearCellsPool();
			iconList.totalCount = _currentItems.Count;
			iconList.RefillCells();
		}
	}

	private void RefreshTitleScrollView()
	{
		if (!(titleList == null))
		{
			titleList.ClearCellsPool();
			titleList.totalCount = _currentItems.Count;
			titleList.RefillCells();
		}
	}

	private void RefreshPreview(AccountDecorationItemData data)
	{
		if (data == null)
		{
			if (descriptionText != null)
			{
				descriptionText.text = string.Empty;
			}
			ClearCurrentPreview();
			RefreshConfirmButton(null);
			return;
		}
		if (avatarName != null)
		{
			avatarName.SetTable("shortcommon");
			avatarName.SetEntry(data.Name);
		}
		if (descriptionText != null)
		{
			descriptionText.text = GetDescriptionText(data);
		}
		switch (data.Type)
		{
		case AccountDecorationType.Avatar:
			RefreshAvatarPreview(_selectedAvatarId, G.localPlayer.Profile.EscInfo.CurAvatarFrameId);
			break;
		case AccountDecorationType.AvatarFrame:
			RefreshAvatarPreview(G.localPlayer.Profile.EscInfo.CurAvatarId, _selectedAvatarFrameId);
			break;
		case AccountDecorationType.Title:
			RefreshTitlePreview(data);
			break;
		default:
			throw new ArgumentOutOfRangeException();
		}
		RefreshConfirmButton(data);
	}

	private void ConfigureAvatarNameText()
	{
		if (!(avatarName == null))
		{
			TMP_Text tMP_Text = avatarName.GetComponent<TMP_Text>() ?? avatarName.GetComponentInChildren<TMP_Text>(includeInactive: true);
			if (!(tMP_Text == null))
			{
				tMP_Text.richText = true;
				tMP_Text.overrideColorTags = true;
				tMP_Text.color = Color.white;
			}
		}
	}

	private void RefreshAvatarPreview(int avatarId, int avatarFrameId)
	{
		iconListRoot.SetActive(value: true);
		if (previewAvatar != null && RuntimeConfigs.data.MtyAvatars.TryGetValue(avatarId, out var value))
		{
			LoadDecorationIcon(AccountDecorationType.Avatar, value.iconID, previewAvatar);
		}
		if (avatarFrameId > 0 && RuntimeConfigs.data.Frames.TryGetValue(avatarFrameId, out var value2))
		{
			SetPreviewAvatarFrameVisible(previewAvatarFrame, visible: true);
			SetPreviewAvatarFrameVisible(previewUpperAvatarFrame, visible: true);
			if (previewAvatarFrame != null)
			{
				Station.LoadImage(144, value2.iconID, previewAvatarFrame);
			}
			if (previewUpperAvatarFrame != null)
			{
				Station.LoadImage(243, value2.iconID, previewUpperAvatarFrame);
			}
		}
		else
		{
			previewAvatarFrame?.UnLoad();
			previewUpperAvatarFrame?.UnLoad();
			SetPreviewAvatarFrameVisible(previewAvatarFrame, visible: false);
			SetPreviewAvatarFrameVisible(previewUpperAvatarFrame, visible: false);
		}
	}

	private static void SetPreviewAvatarFrameVisible(BImage image, bool visible)
	{
		if (image == null)
		{
			return;
		}
		if (image.isRawImage)
		{
			if (image.rawIcon != null)
			{
				image.rawIcon.gameObject.SetActive(visible);
			}
		}
		else if (image.icon != null)
		{
			image.icon.gameObject.SetActive(visible);
		}
	}

	private void RefreshTitlePreview(AccountDecorationItemData data)
	{
		titleListRoot.SetActive(value: true);
		SetPreviewTitleName(data);
		if (previewTitle != null)
		{
			LoadDecorationIcon(AccountDecorationType.Title, data.IconId, previewTitle);
		}
	}

	private void ClearCurrentPreview()
	{
		switch (_currentTabType)
		{
		case AccountDecorationType.Avatar:
		case AccountDecorationType.AvatarFrame:
			iconListRoot.SetActive(value: false);
			break;
		case AccountDecorationType.Title:
			titleListRoot.SetActive(value: false);
			ClearPreviewTitleName();
			break;
		default:
			throw new ArgumentOutOfRangeException();
		}
	}

	private void SetPreviewTitleName(AccountDecorationItemData data)
	{
		if (!(previewTitleName == null))
		{
			previewTitleName.gameObject.SetActive(value: true);
			previewTitleName.SetTable("shortcommon");
			previewTitleName.SetEntry(data.Name);
		}
	}

	private void ClearPreviewTitleName()
	{
		if (!(previewTitleName == null))
		{
			previewTitleName.gameObject.SetActive(value: false);
		}
	}

	private int GetCurrentUsingId()
	{
		return _currentTabType switch
		{
			AccountDecorationType.Avatar => G.localPlayer.Profile.EscInfo.CurAvatarId, 
			AccountDecorationType.AvatarFrame => G.localPlayer.Profile.EscInfo.CurAvatarFrameId, 
			AccountDecorationType.Title => G.localPlayer.Profile.EscInfo.CurTitleId, 
			_ => throw new ArgumentOutOfRangeException(), 
		};
	}

	private int GetSelectedId(AccountDecorationType type)
	{
		return type switch
		{
			AccountDecorationType.Avatar => _selectedAvatarId, 
			AccountDecorationType.AvatarFrame => _selectedAvatarFrameId, 
			AccountDecorationType.Title => _selectedTitleId, 
			_ => throw new ArgumentOutOfRangeException("type", type, null), 
		};
	}

	private void SetSelectedId(AccountDecorationType type, int id)
	{
		switch (type)
		{
		case AccountDecorationType.Avatar:
			_selectedAvatarId = id;
			break;
		case AccountDecorationType.AvatarFrame:
			_selectedAvatarFrameId = id;
			break;
		case AccountDecorationType.Title:
			_selectedTitleId = id;
			break;
		default:
			throw new ArgumentOutOfRangeException("type", type, null);
		}
	}

	private void ResetSelectedIdByCurrentTab()
	{
		switch (_currentTabType)
		{
		case AccountDecorationType.Avatar:
			_selectedAvatarId = G.localPlayer.Profile.EscInfo.CurAvatarId;
			break;
		case AccountDecorationType.AvatarFrame:
			_selectedAvatarFrameId = G.localPlayer.Profile.EscInfo.CurAvatarFrameId;
			break;
		case AccountDecorationType.Title:
			_selectedTitleId = G.localPlayer.Profile.EscInfo.CurTitleId;
			break;
		default:
			throw new ArgumentOutOfRangeException();
		}
	}

	private void SubmitCurrentSelection()
	{
		if (_isSubmitting)
		{
			return;
		}
		FlushPendingViewedRedDots(_currentTabType);
		if (_selectedIndex < 0 || _selectedIndex >= _currentItems.Count)
		{
			return;
		}
		if (!_currentItems[_selectedIndex].IsUnlocked)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("当前账号装饰未解锁，无法使用");
			}
			return;
		}
		int pendingId = GetSelectedId(_currentTabType);
		if (pendingId == GetCurrentUsingId())
		{
			if (_currentTabType != AccountDecorationType.Title)
			{
				return;
			}
			pendingId = 0;
		}
		PlaySwitchAnimation();
		SetSubmitting(submitting: true);
		switch (_currentTabType)
		{
		case AccountDecorationType.Avatar:
			G.service.ChangeAvatar(pendingId, (bool changed) =>
			{
				SetSubmitting(submitting: false);
				if (changed)
				{
					G.localPlayer.Profile.EscInfo.CurAvatarId = pendingId;
					DispatchAccountDecorationChanged(AccountDecorationChangeType.Avatar);
					RefreshAfterWearStateChanged();
				}
				else if (LuminApplication.LogEnabled)
				{
					Debug.LogWarning("更换头像失败");
				}
			});
			break;
		case AccountDecorationType.AvatarFrame:
			G.service.ChangeAvatarFrame(pendingId, (bool changed) =>
			{
				SetSubmitting(submitting: false);
				if (changed)
				{
					G.localPlayer.Profile.EscInfo.CurAvatarFrameId = pendingId;
					DispatchAccountDecorationChanged(AccountDecorationChangeType.AvatarFrame);
					RefreshAfterWearStateChanged();
				}
				else if (LuminApplication.LogEnabled)
				{
					Debug.LogWarning("更换头像框失败");
				}
			});
			break;
		case AccountDecorationType.Title:
			G.service.ChangeTitle(pendingId, (bool changed) =>
			{
				SetSubmitting(submitting: false);
				if (changed)
				{
					G.localPlayer.Profile.EscInfo.CurTitleId = pendingId;
					DispatchAccountDecorationChanged(AccountDecorationChangeType.Title);
					RefreshAfterWearStateChanged();
				}
				else if (LuminApplication.LogEnabled)
				{
					Debug.LogWarning("更换称号失败");
				}
			});
			break;
		default:
			throw new ArgumentOutOfRangeException();
		}
	}

	private void RefreshVisibleCells()
	{
		using (RefreshVisibleStatesMarker.Auto())
		{
			LoopScrollRect currentScrollRect = GetCurrentScrollRect();
			if (currentScrollRect == null || currentScrollRect.content == null || _currentItems == null)
			{
				return;
			}
			for (int i = 0; i < currentScrollRect.content.childCount; i++)
			{
				LoopScrollBaseItem component = currentScrollRect.content.GetChild(i).GetComponent<LoopScrollBaseItem>();
				if (!(component == null) && component.index >= 0 && component.index < _currentItems.Count)
				{
					AccountDecorationItemData data = _currentItems[component.index];
					if (component is PlayerIconComponent item)
					{
						RefreshPlayerIconState(item, data, component.index == _selectedIndex);
					}
					else if (component is TitleIconComponent item2)
					{
						RefreshTitleIconState(item2, data, component.index == _selectedIndex);
					}
				}
			}
		}
	}

	private static void RefreshPlayerIconState(PlayerIconComponent item, AccountDecorationItemData data, bool selected)
	{
		if (!(item == null) && data != null)
		{
			item.SetLocked(!data.IsUnlocked);
			item.InitRedDot(data.RedDotPath);
			item.usingImage?.SetActive(data.IsUsing);
			item.toggle?.SetIsOnWithoutNotifyAndRefreshVisual(selected);
		}
	}

	private static void RefreshTitleIconState(TitleIconComponent item, AccountDecorationItemData data, bool selected)
	{
		if (!(item == null) && data != null)
		{
			item.SetLocked(!data.IsUnlocked);
			item.InitRedDot(data.RedDotPath);
			item.usingImage?.SetActive(data.IsUsing);
			item.toggle?.SetIsOnWithoutNotifyAndRefreshVisual(selected);
		}
	}

	private void SetSubmitting(bool submitting)
	{
		_isSubmitting = submitting;
		if (submitting)
		{
			SetConfirmButtonInteractable(interactable: false);
		}
		else if (_currentItems != null && _selectedIndex >= 0 && _selectedIndex < _currentItems.Count)
		{
			RefreshConfirmButton(_currentItems[_selectedIndex]);
		}
	}

	private void RefreshAfterWearStateChanged()
	{
		if (_currentItems != null)
		{
			int currentUsingId = GetCurrentUsingId();
			for (int i = 0; i < _currentItems.Count; i++)
			{
				_currentItems[i].IsUsing = _currentItems[i].Id == currentUsingId;
			}
			if (_selectedIndex >= 0 && _selectedIndex < _currentItems.Count)
			{
				RefreshPreview(_currentItems[_selectedIndex]);
			}
			RefreshVisibleCells();
		}
	}

	private static void DispatchAccountDecorationChanged(AccountDecorationChangeType changeType)
	{
		AccountDecorationChangedEvt evt = Singleton<EventManager>.instance.GetEvt<AccountDecorationChangedEvt>();
		evt.ChangeType = changeType;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_ChangeAvatar, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void BindTabEvents()
	{
		if (!(tab == null) && tab.tabItems != null && tab.tabItems.Count >= 3)
		{
			tab.tabItems[0].onClick.RemoveListener(OnAvatarTabClick);
			tab.tabItems[1].onClick.RemoveListener(OnAvatarFrameTabClick);
			tab.tabItems[2].onClick.RemoveListener(OnTitleTabClick);
			tab.tabItems[0].onClick.AddListener(OnAvatarTabClick);
			tab.tabItems[1].onClick.AddListener(OnAvatarFrameTabClick);
			tab.tabItems[2].onClick.AddListener(OnTitleTabClick);
		}
	}

	private void BindButtonEvents()
	{
		if (!(confirmBtn == null))
		{
			confirmBtn.OnClick.RemoveListener(OnSubmit);
			confirmBtn.SetBtnClick(OnSubmit);
		}
	}

	private void UnbindTabEvents()
	{
		if (!(tab == null) && tab.tabItems != null && tab.tabItems.Count >= 3)
		{
			tab.tabItems[0].onClick.RemoveListener(OnAvatarTabClick);
			tab.tabItems[1].onClick.RemoveListener(OnAvatarFrameTabClick);
			tab.tabItems[2].onClick.RemoveListener(OnTitleTabClick);
		}
	}

	private void UnbindButtonEvents()
	{
		if (!(confirmBtn == null))
		{
			confirmBtn.OnClick.RemoveListener(OnSubmit);
		}
	}

	private void OnAvatarTabClick()
	{
		SwitchToTab(AccountDecorationType.Avatar);
	}

	private void OnAvatarFrameTabClick()
	{
		SwitchToTab(AccountDecorationType.AvatarFrame);
	}

	private void OnTitleTabClick()
	{
		SwitchToTab(AccountDecorationType.Title);
	}

	private void BindComponentsIfNeeded()
	{
		if ((object)tab == null)
		{
			tab = FindInChildren<AccountDecorationTab>("TabView");
		}
		if ((object)iconList == null)
		{
			iconList = FindInChildren<LoopScrollRect>("Scroll View");
		}
		if ((object)titleList == null)
		{
			titleList = FindInChildren<LoopScrollRect>("TitleScrollView");
		}
		if ((object)previewTitleName == null)
		{
			previewTitleName = FindInChildren<LocalizeStringEvent>("preview_title_name");
		}
		if ((object)descriptionText == null)
		{
			descriptionText = FindInChildren<TextMeshProUGUI>("description");
		}
		if ((object)confirmBtn == null)
		{
			confirmBtn = FindInChildren<ActButton>("common_btn_levelup_confirm");
		}
		if (confirmBtn != null && (object)confirmBtnLocalize == null)
		{
			confirmBtnLocalize = confirmBtn.GetComponentInChildren<LocalizeStringEvent>(includeInactive: true);
		}
	}

	private void MarkVisibleRedDotViewed(AccountDecorationItemData data)
	{
		if (data != null && data.IsUnlocked && data.IsNew)
		{
			if (!_pendingViewedRedDotIds.TryGetValue(data.Type, out var value))
			{
				value = new HashSet<int>();
				_pendingViewedRedDotIds[data.Type] = value;
			}
			value.Add(data.Id);
		}
	}

	private void FlushAllPendingViewedRedDots()
	{
		foreach (AccountDecorationType value in Enum.GetValues(typeof(AccountDecorationType)))
		{
			FlushPendingViewedRedDots(value);
		}
	}

	private void FlushPendingViewedRedDots(AccountDecorationType type)
	{
		if (!_pendingViewedRedDotIds.TryGetValue(type, out var value) || value.Count == 0)
		{
			return;
		}
		List<int> clearIds = new List<int>(value);
		value.Clear();
		RedPoints redPoints = new RedPoints();
		FillRedPoints(type, redPoints, clearIds, active: false);
		G.service.RefreshRedDot(redPoints, (bool success) =>
		{
			if (!success)
			{
				if (_currentItems != null)
				{
					if (!_pendingViewedRedDotIds.TryGetValue(type, out var value2))
					{
						value2 = new HashSet<int>();
						_pendingViewedRedDotIds[type] = value2;
					}
					foreach (int item in clearIds)
					{
						value2.Add(item);
					}
				}
			}
			else
			{
				ClearRedPointsLocal(type, clearIds);
				if (_currentItems != null)
				{
					RefreshRedDot();
					if (_currentTabType == type)
					{
						RefreshCurrentItemNewState();
						RefreshVisibleCells();
					}
				}
			}
		});
	}

	private void RefreshCurrentItemNewState()
	{
		if (_currentItems != null)
		{
			for (int i = 0; i < _currentItems.Count; i++)
			{
				AccountDecorationItemData accountDecorationItemData = _currentItems[i];
				accountDecorationItemData.IsNew = accountDecorationItemData.IsUnlocked && IsRedDotActive(accountDecorationItemData.RedDotPath);
			}
		}
	}

	private static bool IsRedDotActive(string path)
	{
		if (!string.IsNullOrEmpty(path))
		{
			return Singleton<RedDotManager>.instance.IsNodeActive(path);
		}
		return false;
	}

	private static string GetRedDotPath(AccountDecorationType type, int id)
	{
		return type switch
		{
			AccountDecorationType.Avatar => string.Format(RedDotPathDefine.AccountDecorationAvatarNew, id), 
			AccountDecorationType.AvatarFrame => string.Format(RedDotPathDefine.AccountDecorationAvatarFrameNew, id), 
			AccountDecorationType.Title => string.Format(RedDotPathDefine.AccountDecorationTitleNew, id), 
			_ => string.Empty, 
		};
	}

	private static void FillRedPoints(AccountDecorationType type, RedPoints redPoints, IReadOnlyCollection<int> ids, bool active)
	{
		foreach (int id in ids)
		{
			switch (type)
			{
			case AccountDecorationType.Avatar:
				redPoints.Avatars.Add(id, active);
				break;
			case AccountDecorationType.AvatarFrame:
				redPoints.AvatarFrames.Add(id, active);
				break;
			case AccountDecorationType.Title:
				redPoints.Titles.Add(id, active);
				break;
			default:
				throw new ArgumentOutOfRangeException("type", type, null);
			}
		}
	}

	private static void ClearRedPointsLocal(AccountDecorationType type, IReadOnlyCollection<int> ids)
	{
		foreach (int id in ids)
		{
			switch (type)
			{
			case AccountDecorationType.Avatar:
				G.localPlayer.redPoints.Avatars.Remove(id);
				break;
			case AccountDecorationType.AvatarFrame:
				G.localPlayer.redPoints.AvatarFrames.Remove(id);
				break;
			case AccountDecorationType.Title:
				G.localPlayer.redPoints.Titles.Remove(id);
				break;
			default:
				throw new ArgumentOutOfRangeException("type", type, null);
			}
			Singleton<RedDotManager>.instance.SetLeafNodeActive(GetRedDotPath(type, id), active: false);
		}
	}

	private void RefreshListVisible()
	{
		bool flag = _currentTabType == AccountDecorationType.Title;
		iconListRoot.SetActive(!flag);
		iconList.gameObject.SetActive(!flag);
		titleListRoot.SetActive(flag);
		titleList.gameObject.SetActive(flag);
	}

	private void RefreshConfirmButton(AccountDecorationItemData data)
	{
		if (confirmBtn == null)
		{
			return;
		}
		if (data == null)
		{
			SetConfirmButtonInteractable(interactable: false);
			SetConfirmButtonText(confirmButtonTextId, LocalizeTable.Common);
		}
		else if (!data.IsUnlocked)
		{
			SetConfirmButtonInteractable(interactable: false);
			SetConfirmButtonText(lockedButtonTextId, LocalizeTable.Common);
		}
		else if (data.Id == GetCurrentUsingId())
		{
			if (data.Type != AccountDecorationType.Title)
			{
				SetConfirmButtonInteractable(interactable: false);
				SetConfirmButtonText(usingButtonTextId, LocalizeTable.Common);
			}
			else
			{
				SetConfirmButtonInteractable(interactable: true);
				SetConfirmButtonText(143, LocalizeTable.Common);
			}
		}
		else
		{
			SetConfirmButtonInteractable(interactable: true);
			SetConfirmButtonText(confirmButtonTextId, LocalizeTable.ShortCommon);
		}
	}

	private void SetConfirmButtonInteractable(bool interactable)
	{
		_canConfirmCurrentSelection = interactable;
		confirmBtn.Interactable(interactable);
		RefreshConfirmGamePadHint();
	}

	private void RefreshConfirmGamePadHint()
	{
		if (!(confirmGamePadPrompt == null))
		{
			bool flag = MonoECS.instance != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
			confirmGamePadPrompt.SetActive(flag && _canConfirmCurrentSelection);
		}
	}

	private void SetConfirmButtonText(int localizeId, LocalizeTable table)
	{
		if (!(confirmBtnLocalize == null) && localizeId > 0)
		{
			confirmBtnLocalize.enabled = true;
			confirmBtnLocalize.SetReference(table, localizeId);
		}
	}

	private void LoadDecorationIcon(AccountDecorationType type, int iconId, BImage image)
	{
		using (LoadIconMarker.Auto())
		{
			if (image != null)
			{
				switch (type)
				{
				case AccountDecorationType.Avatar:
					Station.LoadImage(241, iconId, image);
					break;
				case AccountDecorationType.AvatarFrame:
					Station.LoadImage(144, iconId, image);
					break;
				case AccountDecorationType.Title:
					Station.LoadImage(242, iconId, image);
					break;
				default:
					throw new ArgumentOutOfRangeException("type", type, null);
				}
			}
		}
	}

	private static string GetDescriptionText(AccountDecorationItemData data)
	{
		if (data == null)
		{
			return string.Empty;
		}
		if (data.GetWay > 0)
		{
			return LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, data.GetWay);
		}
		return string.Empty;
	}

	private T FindInChildren<T>(string objectName) where T : Component
	{
		Transform[] componentsInChildren = GetComponentsInChildren<Transform>(includeInactive: true);
		foreach (Transform transform in componentsInChildren)
		{
			if (!(transform.name != objectName))
			{
				T component = transform.GetComponent<T>();
				if (component != null)
				{
					return component;
				}
			}
		}
		return null;
	}
}
