using System.Collections.ObjectModel;
using System.Linq;
using ACT.Model;
using ACT.UI;
using ACT.UI.Interface;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.Config.Action;

public class SetGuideDefaultSelectHandBookRaidFirstEntrance : GuideStepAction
{
	public override void Execute(GuideStepData data)
	{
		MonoHandbookView monoHandbookView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_HANDBOOK) as MonoHandbookView;
		if (!monoHandbookView)
		{
			Debug.LogWarning("SetGuideDefaultSelectHandBookRaidFirstEntrance Execute failed: UI_HANDBOOK view not found.");
			return;
		}
		if (!(monoHandbookView.ActiveTab?.Content is RaidTabView { tabParent: var tabParent } raidTabView))
		{
			Debug.LogWarning("SetGuideDefaultSelectHandBookRaidFirstEntrance Execute failed: active handbook tab is not raid.");
			return;
		}
		ObservableCollection<ITabItem> observableCollection = tabParent?.TabItems;
		if (observableCollection == null)
		{
			Debug.LogWarning("SetGuideDefaultSelectHandBookRaidFirstEntrance Execute failed: raid tab list is null.");
			return;
		}
		RaidSubTab raidSubTab = observableCollection.OfType<RaidSubTab>().FirstOrDefault((RaidSubTab tab) => tab.TabIdentify == 3 && (tab.CanActive?.Invoke() ?? true));
		if (!raidSubTab)
		{
			Debug.LogWarning("SetGuideDefaultSelectHandBookRaidFirstEntrance Execute failed: first raid sub tab is unavailable.");
			return;
		}
		raidTabView.tabParent.ActiveTab = raidSubTab;
		monoHandbookView.ChangeToGamePadInputState(HandBookSubController.raidContent, needReFocusLayer: true);
		if (!(raidSubTab.Content is BaseCultivateView baseCultivateView) || baseCultivateView.content == null)
		{
			Debug.LogWarning("SetGuideDefaultSelectHandBookRaidFirstEntrance Execute failed: first raid entrance list is empty.");
			return;
		}
		CultivateItem cultivateItem = baseCultivateView.content.GetComponentsInChildren<CultivateItem>(includeInactive: false).FirstOrDefault();
		if (!cultivateItem)
		{
			Debug.LogWarning("SetGuideDefaultSelectHandBookRaidFirstEntrance Execute failed: first raid entrance list is empty.");
			return;
		}
		GameObject gameObject = cultivateItem.gameObject;
		if (EventSystem.current != null)
		{
			EventSystem.current.SetSelectedGameObject(gameObject);
		}
		else
		{
			Debug.LogWarning("SetGuideDefaultSelectHandBookRaidFirstEntrance Execute failed: EventSystem.current is null.");
		}
	}
}
