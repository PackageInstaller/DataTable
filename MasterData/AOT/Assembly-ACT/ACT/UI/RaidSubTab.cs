using System;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class RaidSubTab : BaseTabToggle
{
	[Serializable]
	public struct Style
	{
		public GameObject root;

		public LocalizeStringEvent mainTitle;

		public LocalizeStringEvent subTitle;
	}

	public Style normalPart;

	public Style selectPart;

	public GameObject lockMask;

	public ActButton lockBtn;

	public BetterAnimation animation;

	private int _hbContentID;

	private HbContent _hbContentData;

	public Action<int> OnTabSelected { get; set; }

	public override Func<bool> CanActive => IsUnlocked;

	public override int TabIdentify
	{
		get
		{
			return _hbContentID;
		}
		set
		{
			_hbContentID = value;
			_hbContentData = CoreUtils.GetData(value, RuntimeConfigs.data.hbContents);
			SetStyle(normalPart);
			SetStyle(selectPart);
			RefreshLockMask();
		}
	}

	public HbContent HbContent => _hbContentData;

	protected override void Awake()
	{
		base.Awake();
		onToggleOn.AddListener(OnSelected);
		onValueChanged.AddListener(PlaySelectAnimation);
		lockBtn.SetBtnClick(OnLockClick);
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		RefreshLockMask();
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		onToggleOn.RemoveListener(OnSelected);
	}

	private void OnSelected()
	{
		OnTabSelected?.Invoke(TabIdentify);
	}

	private void PlaySelectAnimation(bool isOn)
	{
		animation?.GetSequence(isOn ? "Selected" : "Normal")?.Play();
	}

	public void RefreshLockMask()
	{
		bool flag = IsUnlocked();
		lockMask?.SetActive(!flag);
		isLock = !flag;
		Interactable(flag);
	}

	private bool IsUnlocked()
	{
		if (_hbContentID != 0)
		{
			return Model<HandBookModel>.Interface.IsSecondTabUnlock(_hbContentID);
		}
		return true;
	}

	private void SetStyle(Style targetStyle)
	{
		targetStyle.mainTitle.SetTable("shortcommon");
		targetStyle.mainTitle.StringReference.TableEntryReference = _hbContentData.contentName;
		targetStyle.subTitle.SetTable("shortcommon");
		targetStyle.subTitle.StringReference.TableEntryReference = _hbContentData.tabName;
	}

	private void OnLockClick()
	{
		MissionGroup data = CoreUtils.GetData(_hbContentData.openRequire, RuntimeConfigs.data.missionGroups);
		if (data != null)
		{
			GameUtility.OpenToolTip(data.groupDes, "shortcommon");
		}
	}
}
