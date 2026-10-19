using System;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.UI.Interface;
using ACT.ViewControl;
using UnityEngine;

namespace ACT.UI;

public class TrainingTabView : BaseTabContent
{
	public CharacterSingleTutorialView characterSingleTutorialView;

	public CharacterTeamTutorialView characterTeamTutorialView;

	[SerializeField]
	public CommonTabListComponent tabParent;

	public TrainingSubTab tabTemplate;

	private MonoHandbookView _view;

	public TrainingSubTab ActiveTab => tabParent.ActiveTab as TrainingSubTab;

	private void Awake()
	{
		GenerateTabs();
	}

	public override void OnPopStack()
	{
		base.OnPopStack();
		_view.ChangeToGamePadInputState(_view.GetCurSubControllerType(), needReFocusLayer: true);
	}

	public void SetView(MonoHandbookView view)
	{
		_view = view;
		RegisterGamePadLayers();
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
				TrainingSubTab trainingSubTab = UnityEngine.Object.Instantiate(tabTemplate, tabParent.transform);
				trainingSubTab.TabIdentify = tabIdentify;
				trainingSubTab.gameObject.SetActive(value: true);
				trainingSubTab.OnTabSelected = (Action<int>)Delegate.Combine(trainingSubTab.OnTabSelected, new Action<int>(OnTabSelected));
				tabParent.TabItems.Add(trainingSubTab);
				trainingSubTab.RefreshLockMask();
			}
		}
	}

	public void OnTabSelected(int tabIndex)
	{
		if (!(_view == null) && _view.ViewControlLayers.TryGetValue(HandBookSubController.characterTeamTutorialContent, out var value) && !(value == null))
		{
			switch (tabIndex)
			{
			case 8:
				value.SetTargetTransform(characterSingleTutorialView.content);
				break;
			case 9:
				value.SetTargetTransform(characterTeamTutorialView.content);
				break;
			}
		}
	}

	public void SetParentRewardContent(ViewControlLayer layer)
	{
	}

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		foreach (ITabItem tabItem3 in tabParent.TabItems)
		{
			switch (tabItem3.TabIdentify)
			{
			case 8:
				tabItem3.Content = characterSingleTutorialView;
				characterSingleTutorialView.SetParentView(this);
				break;
			case 9:
				tabItem3.Content = characterTeamTutorialView;
				characterTeamTutorialView.SetParentView(this);
				break;
			}
			if (tabItem3 is TrainingSubTab trainingSubTab)
			{
				trainingSubTab.RefreshLockMask();
				trainingSubTab.gameObject.SetActive(value: true);
			}
		}
		if (!(Tab is HandBookTab { Context: var context }))
		{
			return;
		}
		HandBookViewParam viewParam = context as HandBookViewParam;
		if (viewParam != null)
		{
			ITabItem tabItem2 = tabParent.TabItems.FirstOrDefault((ITabItem x) => x.TabIdentify == viewParam.H2TabIndex && (x.CanActive?.Invoke() ?? true));
			if (tabItem2 != null)
			{
				tabParent.ActiveTab = tabItem2;
				goto IL_013c;
			}
		}
		tabParent.ActiveTab = tabParent.TabItems.FirstOrDefault((ITabItem x) => x.CanActive?.Invoke() ?? true);
		goto IL_013c;
		IL_013c:
		_view.ChangeToGamePadInputState(HandBookSubController.characterTutorialMain);
		PlayShowAnimation();
	}

	protected override void OnTabDeActive(ITabItem tabItem)
	{
		base.OnTabDeActive(tabItem);
		SetContentVisible(visible: false);
		tabParent.Group.SetAllToggleOff();
		foreach (ITabItem tabItem2 in tabParent.TabItems)
		{
			if (tabItem2 is TrainingSubTab trainingSubTab)
			{
				trainingSubTab.gameObject.SetActive(value: false);
			}
		}
	}

	private void PlayShowAnimation()
	{
		for (int i = 0; i < tabParent.TabItems.Count; i++)
		{
			if (tabParent.TabItems[i] is TrainingSubTab { animation: { } animation } trainingSubTab)
			{
				animation.GetSequence(trainingSubTab.IsOn ? "SelectedShow" : "NormalShow")?.Goto(0f).SetDelay((float)i * 0.05f).Play();
			}
		}
	}

	private void RegisterGamePadLayers()
	{
		if (!(_view == null) && _view.ViewControlLayers != null)
		{
			ViewControlLayer viewControlLayer = ((tabParent != null) ? tabParent.GetComponent<ViewControlLayer>() : null);
			if (viewControlLayer != null)
			{
				_view.ViewControlLayers[HandBookSubController.characterTutorialMain] = viewControlLayer;
			}
			ViewControlLayer viewControlLayer2 = ((characterSingleTutorialView != null && characterSingleTutorialView.content != null) ? characterSingleTutorialView.content.GetComponentInParent<ViewControlLayer>(includeInactive: true) : null);
			if (viewControlLayer2 != null)
			{
				_view.ViewControlLayers[HandBookSubController.characterTeamTutorialContent] = viewControlLayer2;
			}
		}
	}
}
