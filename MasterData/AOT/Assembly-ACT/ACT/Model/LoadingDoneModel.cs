using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.UI;
using ACT.Utility;
using Fundamental;

namespace ACT.Model;

public class LoadingDoneModel : Model<LoadingDoneModel>
{
	protected override void Init()
	{
	}

	protected override void UnInit()
	{
	}

	public void OnLoadingDone()
	{
		switch (MonoECS.instance.sceneStatus)
		{
		case SceneStatus.Raid:
			OnRiadLoadingDone();
			break;
		case SceneStatus.Temple:
			OnTempleLoadingDone();
			break;
		case SceneStatus.Abyss:
			OnAbyssLoadingDone();
			break;
		default:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BATTLEMAIN);
			break;
		case SceneStatus.Lounge:
			break;
		}
	}

	private async void OnRiadLoadingDone()
	{
		int currentRaidId = Model<RaidModel>.Interface.CurrentRaidId;
		switch (Model<RaidModel>.Interface.GetRaidType(currentRaidId))
		{
		case 6:
		{
			ACT.Config.Raid data = CoreUtils.GetData(currentRaidId, RuntimeConfigs.data.raids);
			if (data == null || data.tryRole == null || data.tryRole.Length == 0)
			{
				break;
			}
			EntityCharacterProbation data2 = CoreUtils.GetData(data.tryRole[0], RuntimeConfigs.data.entityCharacterProbations);
			if (data2.isShow != 0)
			{
				if (data2.skinId > 0)
				{
					Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BATTLEMAIN);
					break;
				}
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTERTRIALTIPS, new CharacterTrialTipsViewData
				{
					characterId = data2.id
				});
			}
			else
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BATTLEMAIN);
			}
			break;
		}
		case 7:
			_ = CoreUtils.GetData(currentRaidId, RuntimeConfigs.data.raids).belongEntranceData;
			_ = 201;
			OpenPerformanceUI();
			break;
		default:
			await GameUtility.PlayOpeningPreformance();
			OpenPerformanceUI();
			break;
		}
	}

	private async void OpenPerformanceUI()
	{
		if (Singleton<NewUIManager>.instance.GetTopActivePanel() == null)
		{
			await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_BATTLEMAIN);
		}
		Singleton<InteractiveDialogueManager>.instance.DispatchTriggerInteractiveDialogue(1003);
		OnHudCpEnqueue evt = Singleton<EventManager>.instance.GetEvt<OnHudCpEnqueue>();
		evt.position = UIPosition.UpperMiddle;
		evt.type = HudComponentType.RaidOpeningPerformance;
		evt.uiData = null;
		evt.timeOutDuration = 15f;
		evt.priorityInQueue = 4;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_HudUIEnqueue, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private async void OnTempleLoadingDone()
	{
		await GameUtility.PlayOpeningPreformance();
		OpenPerformanceUI();
	}

	private async void OnAbyssLoadingDone()
	{
		await GameUtility.PlayOpeningPreformance();
		OpenPerformanceUI();
	}
}
