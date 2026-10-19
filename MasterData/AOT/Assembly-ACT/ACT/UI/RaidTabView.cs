using System;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.UI.Interface;
using ACT.UI.WildBossBattle;
using ACT.ViewControl;
using UnityEngine;

namespace ACT.UI;

public class RaidTabView : BaseTabContent
{
	public BaseCultivateView baseCultivateView;

	public SkillCultivateView skillCultivateView;

	public DataCalibrationView dataCalibrationView;

	public BossBattleTabView bossBattleTabView;

	public WildBossBattleTabView wildBossTabView;

	[SerializeField]
	public CommonTabListComponent tabParent;

	public RaidSubTab tabTemplate;

	private MonoHandbookView _view;

	public RaidSubTab ActiveTab => tabParent.ActiveTab as RaidSubTab;

	private void Awake()
	{
		GenerateTabs();
	}

	public override void OnPopStack()
	{
		base.OnPopStack();
		if (ActiveTab?.Content is BossBattleTabView bossBattleTabView)
		{
			bossBattleTabView.RefreshEntranceLevels();
		}
		_view.ChangeToGamePadInputState(_view.GetCurSubControllerType(), needReFocusLayer: true);
	}

	public void SetView(MonoHandbookView view)
	{
		_view = view;
	}

	public void SetLayerStatus(HandBookSubController controller, bool refocus = false)
	{
		_view.ChangeToGamePadInputState(controller, refocus);
	}

	public void ResetLayerDefault(HandBookSubController controller)
	{
		_view.ViewControlLayers[controller].SetDefaultSelect(null);
	}

	private void GenerateTabs()
	{
		HandBookMain data = CoreUtils.GetData(Tab.TabIdentify, RuntimeConfigs.data.handBookMains);
		if (data != null)
		{
			tabParent.HideInactiveTabOnAdd = false;
			int[] contentLv2ID = data.contentLv2ID;
			foreach (int tabIdentify in contentLv2ID)
			{
				RaidSubTab raidSubTab = UnityEngine.Object.Instantiate(tabTemplate, tabParent.transform);
				raidSubTab.TabIdentify = tabIdentify;
				raidSubTab.gameObject.SetActive(value: true);
				raidSubTab.OnTabSelected = (Action<int>)Delegate.Combine(raidSubTab.OnTabSelected, new Action<int>(OnTabSelected));
				tabParent.TabItems.Add(raidSubTab);
				raidSubTab.RefreshLockMask();
			}
		}
	}

	public void OnTabSelected(int tabIndex)
	{
		_view.ViewControlLayers[HandBookSubController.raidSelectItem] = null;
		switch (tabIndex)
		{
		case 3:
			_view.ViewControlLayers[HandBookSubController.raidContent].SetTargetTransform(baseCultivateView.content);
			break;
		case 4:
			_view.ViewControlLayers[HandBookSubController.raidContent].SetTargetTransform(skillCultivateView.content);
			break;
		case 5:
			_view.ViewControlLayers[HandBookSubController.raidContent].SetTargetTransform(bossBattleTabView.content);
			break;
		case 6:
		{
			RaidSubTab raidSubTab = tabParent.TabItems.FirstOrDefault((ITabItem x) => x.TabIdentify == tabIndex) as RaidSubTab;
			_view.ViewControlLayers[HandBookSubController.raidNoFocusContent].SetDefaultSelect(raidSubTab.transform.GetComponent<ACT.ViewControl.SelectableEx>());
			_view.ViewControlLayers[HandBookSubController.raidNoFocusContent].SetTargetTransform(tabParent.transform);
			_view.ViewControlLayers[HandBookSubController.raidSelectItem] = dataCalibrationView.GetComponent<ViewControlLayer>();
			_view.ViewControlLayers[HandBookSubController.raidSelectItem].SetTargetTransform(dataCalibrationView.content);
			SetLayerStatus(HandBookSubController.raidNoFocusContent);
			break;
		}
		case 7:
			_view.ViewControlLayers[HandBookSubController.raidContent].SetTargetTransform(wildBossTabView.content);
			break;
		}
	}

	public void SetParentRewardContent(ViewControlLayer layer)
	{
		_view.ViewControlLayers[HandBookSubController.raidSelectItem] = layer;
	}

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		foreach (ITabItem tabItem3 in tabParent.TabItems)
		{
			switch (tabItem3.TabIdentify)
			{
			case 3:
				tabItem3.Content = baseCultivateView;
				baseCultivateView.SetParentView(this);
				break;
			case 4:
				tabItem3.Content = skillCultivateView;
				skillCultivateView.SetParentView(this);
				break;
			case 5:
				tabItem3.Content = bossBattleTabView;
				bossBattleTabView.SetParentView(this);
				break;
			case 6:
				tabItem3.Content = dataCalibrationView;
				dataCalibrationView.SetParentView(this);
				break;
			case 7:
				tabItem3.Content = wildBossTabView;
				wildBossTabView.SetParentView(this);
				break;
			}
			if (tabItem3 is RaidSubTab raidSubTab)
			{
				raidSubTab.RefreshLockMask();
				raidSubTab.gameObject.SetActive(value: true);
			}
		}
		if (!(Tab is HandBookTab handBookTab))
		{
			return;
		}
		if (handBookTab.Context is HandBookViewParam { H2TabIndex: 7 } handBookViewParam)
		{
			wildBossTabView.DefaultSelectedAreaID = handBookViewParam.WildBossUseId;
		}
		object context = handBookTab.Context;
		HandBookViewParam viewParam = context as HandBookViewParam;
		if (viewParam != null)
		{
			ITabItem tabItem2 = tabParent.TabItems.FirstOrDefault((ITabItem x) => x.TabIdentify == viewParam.H2TabIndex && (x.CanActive?.Invoke() ?? true));
			if (tabItem2 != null)
			{
				tabParent.ActiveTab = tabItem2;
				goto IL_01e3;
			}
		}
		tabParent.ActiveTab = tabParent.TabItems.FirstOrDefault((ITabItem x) => x.CanActive?.Invoke() ?? true);
		_view.ChangeToGamePadInputState(HandBookSubController.raidMain);
		goto IL_01e3;
		IL_01e3:
		handBookTab.Context = null;
		PlayShowAnimation();
	}

	protected override void OnTabDeActive(ITabItem tabItem)
	{
		base.OnTabDeActive(tabItem);
		tabParent.ActiveTab = null;
		try
		{
			_view.ViewControlLayers[HandBookSubController.raidContent]?.UnFocus();
			_view.ViewControlLayers[HandBookSubController.raidMain]?.UnFocus();
			_view.ViewControlLayers[HandBookSubController.raidNoFocusContent]?.UnFocus();
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
	}

	private void PlayShowAnimation()
	{
		for (int i = 0; i < tabParent.TabItems.Count; i++)
		{
			if (tabParent.TabItems[i] is RaidSubTab { animation: { } animation } raidSubTab)
			{
				animation.GetSequence(raidSubTab.IsOn ? "SelectedShow" : "NormalShow")?.Goto(0f).SetDelay((float)i * 0.05f).Play();
			}
		}
	}
}
