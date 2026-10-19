using System;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using Runtime.WaitSort;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class HandBookTab : BaseTabToggle
{
	[Header("正常态")]
	[SerializeField]
	private GameObject _normalState;

	[SerializeField]
	public BImage normalIcon;

	[SerializeField]
	public LocalizeStringEvent normalText;

	[Header("选中态")]
	[SerializeField]
	private GameObject _selectedState;

	[SerializeField]
	public BImage selectedIcon;

	[SerializeField]
	public LocalizeStringEvent selectedText;

	[SerializeField]
	public RedDotItem redDotItem;

	private HandBookMain _handBookData;

	public override int TabIdentify
	{
		get
		{
			return _handBookData?.id ?? 0;
		}
		set
		{
			if (value != TabIdentify)
			{
				_handBookData = CoreUtils.GetData(value, RuntimeConfigs.data.handBookMains);
			}
		}
	}

	public override int SortOrder => _handBookData.tabOrder;

	public HandBookMain HandBookData => _handBookData;

	public override Func<bool> CanActive => () => _handBookData != null && !Singleton<SystemBlockManager>.instance.IsBlocked(SystemType.HandBook, _handBookData.id) && Model<HandBookModel>.Interface.IsFirstTabUnlock(_handBookData.id);

	public object Context { get; set; }

	protected override void OnTabActive()
	{
		base.OnTabActive();
		_normalState.SetActive(value: false);
		_selectedState.SetActive(value: true);
		GuideConsts.GuideType handBookFirstTabGuideType = GuideConsts.GetHandBookFirstTabGuideType(TabIdentify);
		if (handBookFirstTabGuideType != GuideConsts.GuideType.None)
		{
			GameUtility.SendFinshStepGuideEvent(handBookFirstTabGuideType);
		}
	}

	protected override void OnTabDeActive()
	{
		base.OnTabDeActive();
		_normalState.SetActive(value: true);
		_selectedState.SetActive(value: false);
	}
}
