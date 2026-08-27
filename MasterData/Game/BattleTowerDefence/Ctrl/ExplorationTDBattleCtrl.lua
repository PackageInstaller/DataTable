local base = require("Game.Exploration.Ctrl.ExplorationBattleCtrl")
local ExplorationTDBattleCtrl = class("ExplorationTDBattleCtrl", base)
local util = require("XLua.Common.xlua_util")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function ExplorationTDBattleCtrl:ReqBattleSettle(battleEndState, requestData)
  base.ReqBattleSettle(self, battleEndState, requestData)
  local tdWindow = UIManager:GetWindow(UIWindowTypeID.TDBattle)
  if tdWindow ~= nil then
    tdWindow:OnBattleEnd()
  end
end

function ExplorationTDBattleCtrl:VictoryBattleEndCoroutine(battleEndState, resultData)
  local battleController = battleEndState.battleController
  local CS_CameraController_Ins = CS.CameraController.Instance
  local playerRoleList = battleController.PlayerTeamController.battleOriginRoleList
  local enemyRoleList = battleController.EnemyTeamController.battleOriginRoleList
  local mvpGrade = BattleUtil.GenMvp(playerRoleList)
  if mvpGrade == nil then
    mvpGrade = {}
    mvpGrade.role = battleController.PlayerTeamController.dungeonRoleList[0]
    mvpGrade.MVPNum = 1
    mvpGrade.MvpType = BattleUtil.mvpType.default
  end
  
  local function battleEndCoroutine()
    while self.__waitSettleResult do
      coroutine.yield()
    end
    GR.MsgBroadcast(eCsMsgEventType.CallClearBattleEffect)
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    avgPlayCtrl:TryPlayTaskAvg(1, function()
      battleEndState:EndBattleAndClear()
      local dungeonStateInfo = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
      if dungeonStateInfo ~= nil then
        dungeonStateInfo:Show()
        dungeonStateInfo:SetMoneyActive(true)
      end
      MsgCenter:Broadcast(eMsgEventId.OnExitBattle)
      MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, ExplorationEnum.eExitRoomCompleteType.BattleToEp)
      ExplorationManager.epCtrl:ContinueExploration()
    end)
  end
  
  return util.cs_generator(battleEndCoroutine)
end

return ExplorationTDBattleCtrl
