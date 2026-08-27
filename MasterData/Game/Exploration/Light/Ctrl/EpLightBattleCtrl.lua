local ExplorationBattleCtrl = require("Game.Exploration.Ctrl.ExplorationBattleCtrl")
local EpLightBattleCtrl = class("EpLightBattleCtrl", ExplorationBattleCtrl)
local util = require("XLua.Common.xlua_util")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function EpLightBattleCtrl:VictoryBattleEndCoroutine(battleEndState)
  local battleController = battleEndState.battleController
  local CS_CameraController_Ins = CS.CameraController.Instance
  self.__waitSelectChip = true
  self.__settleTimelinePause = false
  self.__startSelectChip = false
  self.__showResultUI = false
  local curRoomData = ExplorationManager.epCtrl:GetCurrentRoomData()
  if curRoomData ~= nil then
    local roomMonsterCfg = ConfigData.exploration_room_monster[curRoomData.battleId]
    if roomMonsterCfg ~= nil then
      self.__isHideVictoryEffect = roomMonsterCfg.isHideVictoryEffect == 1
    end
  end
  local playerRoleList = battleController.PlayerTeamController.battleOriginRoleList
  local enemyRoleList = battleController.EnemyTeamController.battleOriginRoleList
  local mvpGrade = BattleUtil.GenMvp(playerRoleList)
  local battleEndCoroutine
  if self.__isHideVictoryEffect == true then
    function battleEndCoroutine()
      self.epCtrl.autoCtrl:OnAutoStageOver()
      
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.7))
      battleEndState:EndBattleAndClear()
      MsgCenter:Broadcast(eMsgEventId.OnExitBattle)
      self.epCtrl:StartCompleteExploration()
    end
  else
    function battleEndCoroutine()
      CS_CameraController_Ins:PlaySettlementCut(battleController, mvpGrade.role, self:GetRoleMvpCameraOffset(mvpGrade.role))
      
      while self.__waitSettleResult do
        coroutine.yield()
      end
      UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.clear, false)
      if self.__settleTimelinePause then
        CS_CameraController_Ins:PauseSettlementCut(false)
      end
      while not self.__showResultUI do
        coroutine.yield()
      end
      ExplorationManager:PlayMVPVoice(mvpGrade.role.roleDataId)
      local dungeonRoleList = battleController.PlayerTeamController.battleRoleList
      self:PlayRoleWinActionAndEffect(dungeonRoleList, mvpGrade.role)
      UIManager:ShowWindowAsync(UIWindowTypeID.BattleResult, function(window)
        if window == nil then
          return
        end
        window:InitBattleResultData(playerRoleList, enemyRoleList, mvpGrade)
        window:SetContinueCallback(function()
          self.__startSelectChip = true
        end)
      end)
      while not CS_CameraController_Ins.settleTimlinePlayEnd or UIManager:GetWindow(UIWindowTypeID.BattleResult) == nil do
        coroutine.yield()
      end
      UIManager:HideWindow(UIWindowTypeID.ClickContinue)
      self.epCtrl.autoCtrl:OnEpBattleResultShow()
      while not self.__startSelectChip do
        coroutine.yield()
      end
      self.epCtrl.autoCtrl:OnAutoStageOver()
      local win = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
      if win ~= nil then
        win:Show()
      end
      
      local function waitAvtiveDropFunc()
        self.__waitActiveChip = false
      end
      
      self.__waitActiveChip = true
      if not self.epCtrl:CheckActiveChipDrop(waitAvtiveDropFunc) then
        self.__waitActiveChip = false
      end
      while self.__waitActiveChip do
        coroutine.yield()
      end
      local haveChipSelect = self.epCtrl:CheckChipSelect(function()
        self.__waitSelectChip = false
      end, false)
      local dungeonStateInfo = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
      if dungeonStateInfo ~= nil then
        dungeonStateInfo:Show()
        dungeonStateInfo:SetMoneyActive(true)
      end
      while self.__waitSelectChip do
        coroutine.yield()
      end
      self.__waitBuffDrop = self.epCtrl:CheckBuffDrop(function()
        self.__waitBuffDrop = false
      end)
      while self.__waitBuffDrop do
        coroutine.yield()
      end
      local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
      avgPlayCtrl:TryPlayTaskAvg(1, function()
        battleEndState:EndBattleAndClear(false)
        MsgCenter:Broadcast(eMsgEventId.OnExitBattle)
        MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, ExplorationEnum.eExitRoomCompleteType.BattleToEp)
        ExplorationManager.epCtrl:ContinueExploration()
      end)
    end
  end
  return util.cs_generator(battleEndCoroutine)
end

return EpLightBattleCtrl
