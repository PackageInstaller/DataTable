using System;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("发送结束战斗给服务器", 0)]
[Category("Render/UI")]
[Description("调用Lua层发送TCP结束战斗事件")]
[ExposeAsDefinition]
public class SendBattleResult : CallableFunctionNode<bool, E_BattleResult, bool>
{
	private bool finished;

	private BattleResultForLua battleResult;

	public override void OnGraphStarted()
	{
	}

	public static StatisticsData CalcStatisticsData(int result)
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		WorldStateManager worldSatetManager = battleScene.GetWorldSatetManager();
		StatisticsData data = worldSatetManager.data;
		worldSatetManager.CalcCurrentHp();
		bool flag = result == 1;
		BattleResultForLua dataForLua = data.dataForLua;
		dataForLua.Result = flag;
		dataForLua.battleId = battleScene.ready.BattleID;
		dataForLua.loadMilliseconds = (int)(LoadingTime.GetInstance().finishedTime * 1000f - LoadingTime.GetInstance().startTime * 1000f);
		data.currentFrameNumber = worldSatetManager.currentFrameNumber;
		return data;
	}

	public override bool Invoke(E_BattleResult result, bool getReward)
	{
		if (finished)
		{
			return true;
		}
		Debug.Log("======send battle result========>>");
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		StatisticsData statisticsData = CalcStatisticsData((int)result);
		E_BattleResult e_BattleResult = result;
		Debug.Log(Time.time + " ====> " + battleScene.ready.BattleID + " UUID " + battleScene.ready.Uuid + " Result " + e_BattleResult.ToString() + " IP " + BattleScene.IP + " Port " + BattleScene.Port);
		ClientSimulator.Instance.SendBattleResult(battleScene.ready.BattleID, battleScene.ready.Uuid, e_BattleResult, statisticsData.ToBattleResultInfo(), null);
		LuaExchangeHelper.data = (NScene.GetCurrentScene() as BattleScene).GetWorldSatetManager().data;
		finished = true;
		TryShowLowFPSTips();
		return true;
	}

	private void TryShowLowFPSTips()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (!(battleScene != null))
		{
			return;
		}
		GameObject battlePanelGameObject = battleScene.battlePanelGameObject;
		if (!(battlePanelGameObject != null))
		{
			return;
		}
		BattleUI component = battlePanelGameObject.GetComponent<BattleUI>();
		if (component != null && component.fpsMonitor != null)
		{
			object[] array = LuaHelper.CallFunction("getCommonData", "userSetting", "battle_low_fps_tips");
			if (((array != null && array.Length != 0 && Math.Abs((double)array[0] - 1.0) < 0.001) || array == null) && component.fpsMonitor.need_show_tip)
			{
				LuaHelper.CallFunction("ShowTips", 60300);
			}
			component.DestoryHighFpsMonitor();
		}
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		base.parentNode.mSimContext.GetSimInterface().mGSRecvBattleResultFinishEvent = null;
		finished = false;
	}
}
