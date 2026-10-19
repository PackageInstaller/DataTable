using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class LeaveSubWorldBtnComponent : MonoBehaviour, IBattleMainComponent
{
	private Button btn;

	public void Initialize(MonoBattleMainBaseView view)
	{
		btn = gameObject.GetComponent<Button>();
		btn.SetBtnClick(LeaveSubWorld);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.InSubWorldClickEscBtn, OnLeaveSubWorld);
	}

	public void UnInitialize()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.InSubWorldClickEscBtn, OnLeaveSubWorld);
	}

	public void OpenComponent()
	{
	}

	public void CloseComponent()
	{
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}

	private void OnLeaveSubWorld(BaseEventContent obj)
	{
		LeaveSubWorld();
	}

	public void LeaveSubWorld()
	{
		if (MonoECS.instance.mainEntity.GetCompMotion().curMotionState == MotionState.Die)
		{
			return;
		}
		switch (MonoECS.instance.sceneStatus)
		{
		case SceneStatus.Raid:
		{
			bool flag = (Model<TeamTeachingModel>.HasInstance() && Model<TeamTeachingModel>.Interface.IsTeamTeachingRaid()) || Model<RaidModel>.Interface.GetRaidType(Model<RaidModel>.Interface.CurrentRaidId) == 9;
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ABYSSEXIT, new AbyssExitViewData
			{
				IsTeamTeaching = flag,
				IsRaid = !flag
			});
			break;
		}
		case SceneStatus.Abyss:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ABYSSEXIT);
			break;
		case SceneStatus.Temple:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ABYSSEXIT, new AbyssExitViewData
			{
				IsTemple = true
			});
			break;
		case SceneStatus.Rogue:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ROGUEEXIT);
			break;
		case SceneStatus.Trainingground:
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
			{
				onlyClickOnce = true,
				needPause = true,
				OnConfirm = () =>
				{
					G.service.LeaveTrainingGround(async (bool r) =>
					{
						if (r)
						{
							Singleton<GameState>.instance.SetWorldLoadState(WorldLoadState.GiveUp);
							await Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main);
							Singleton<GameState>.instance.RemoveWorldLoadState(WorldLoadState.GiveUp);
						}
					});
				},
				commonId = 1139
			});
			break;
		}
	}
}
