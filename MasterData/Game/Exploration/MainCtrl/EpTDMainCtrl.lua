local base = require("Game.Exploration.MainCtrl.EpMainCtrlBase")
local EpTDMainCtrl = class("EpTDMainCtrl", base)
local ExplorationTDBattleCtrl = require("Game.BattleTowerDefence.Ctrl.ExplorationTDBattleCtrl")
local ExplorationTDPlayerCtrl = require("Game.BattleTowerDefence.Ctrl.ExplorationTDPlayerCtrl")
local ExplorationTDSceneCtrl = require("Game.Exploration.TowerDefense.Ctrl.ExplorationTDSceneCtrl")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local cs_MessageCommon = CS.MessageCommon

function EpTDMainCtrl:ctor()
end

function EpTDMainCtrl:InitEpMainSubCtrls()
  base.InitEpMainSubCtrls(self)
  self.battleCtrl = ExplorationTDBattleCtrl.New(self)
  self.playerCtrl = ExplorationTDPlayerCtrl.New(self)
  self.sceneCtrl = ExplorationTDSceneCtrl.New(self)
end

function EpTDMainCtrl:__OnEnterEpSceneComplete()
  if not self.__isFirstEnter then
    base.__TryShowOperationBeforeEpSceneComplete(self)
    return
  end
  if BattleUtil.IsSpecialTDMode() then
    base.__TryShowOperationBeforeEpSceneComplete(self)
    return
  end
  self:__ShowTDProcessView(true, function()
    base.__TryShowOperationBeforeEpSceneComplete(self)
  end)
end

function EpTDMainCtrl:__EnterBattleScene(roomData, isReconnect)
  base.__EnterBattleScene(self, roomData, isReconnect)
  self.sceneCtrl:SetTDInBattleScene(true)
  local csbattleCtrl = self.battleCtrl:StartNewEpBattle(roomData, self.dynPlayer)
  csbattleCtrl:StartEnterDeployState()
  self.__isStartInTheFloor = nil
end

function EpTDMainCtrl:OnStartTimelineComplete()
  self.__isStartInTheFloor = true
  base.OnStartTimelineComplete(self)
end

function EpTDMainCtrl:OutsideTheRoom()
  if not base.OutsideTheRoom(self) and self.__isStartInTheFloor then
    self:ApplyAutoSelectRoom()
  end
end

function EpTDMainCtrl:__OperationProcess()
  base.__OperationProcess(self)
  self.__isStartInTheFloor = nil
end

function EpTDMainCtrl:CheckAfterOutSide()
  base.CheckAfterOutSide(self)
  self:ApplyAutoSelectRoom()
end

function EpTDMainCtrl:ContinueExploration(isRevive)
  self.sceneCtrl:SetTDInBattleScene(false)
  base.ContinueExploration(self, isRevive)
end

function EpTDMainCtrl:TryEnterNextTDRoom()
  local curRoomData = self:GetCurrentRoomData()
  
  local function enterNextFunc()
    local nextRoomList = curRoomData:GetNextRoom()
    local nextRoomData = nextRoomList[1]
    self.playerCtrl:Move(nextRoomData)
  end
  
  if curRoomData:IsEndColRoom() then
    self:StartCompleteExploration()
  elseif curRoomData:IsRealBossRoom() then
    if self.mapData:HasWeeklyChallengeBigBossRoom() then
      local bossMonsterName = "?"
      local bigBossRoomData = curRoomData:GetNextRoom()[1]
      if bigBossRoomData ~= nil and bigBossRoomData.mode == 5 then
        for _, dynMonster in pairs(bigBossRoomData.monsterList) do
          if dynMonster:GetBossBloodNum() > 0 then
            bossMonsterName = dynMonster:GetName()
            break
          end
        end
      end
      cs_MessageCommon.ShowMessageBoxConfirm(string.format(ConfigData:GetTipContent(905), bossMonsterName), enterNextFunc)
    elseif self.mapData:HasOverBossRoom() then
      local stageId = ExplorationManager:GetSectorStageCfg().id
      local curFloor = ExplorationManager:GetCurLevelIndex() + 1
      ControllerManager:GetController(ControllerTypeId.AvgPlay, true):TryPlayAvg(eAvgTriggerType.MainAvgEp, stageId, curFloor, 3, function()
        UIManager:ShowWindowAsync(UIWindowTypeID.MessageBox, function(win)
          if win == nil then
            return
          end
          win:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(255), function()
            AudioManager:PlayAudioById(1125)
            enterNextFunc()
          end, function()
            AudioManager:PlayAudioById(1125)
            self:StartCompleteExploration()
          end)
        end)
      end)
    else
      self:StartCompleteExploration()
    end
  else
    enterNextFunc()
  end
end

function EpTDMainCtrl:ApplyAutoSelectRoom()
  self._outsideTheRoomFunc = self._outsideTheRoomFunc or function()
    self:TryEnterNextTDRoom()
  end
  local opDetail = self.dynPlayer:GetOperatorDetail()
  local opState = opDetail.state
  if opState ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
    return
  end
  local curRoomData = self:GetCurrentRoomData()
  if self:IsFirstEnterNewFloor() or curRoomData:IsEndColRoom() or self.__isFirstEnter or self.__isReconnect then
    self._outsideTheRoomFunc()
    return
  end
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  if BattleUtil.IsSpecialTDMode() then
    self._outsideTheRoomFunc()
  else
    self.timerId = TimerManager:StartTimer(0.5, function()
      self.timerId = nil
      self:__ShowTDProcessView(false, function()
        if not self.residentStoreCtrl:CheckEpResidentStore(self._outsideTheRoomFunc) then
          self._outsideTheRoomFunc()
        end
      end)
    end, self, true)
  end
end

function EpTDMainCtrl:__ShowTDProcessView(isFirst, continueFunc)
  UIManager:ShowWindowAsync(UIWindowTypeID.TDProcessView, function(window)
    if window == nil then
      if continueFunc ~= nil then
        continueFunc()
      end
      return
    end
    local opDetail = self.dynPlayer:GetOperatorDetail()
    local x, y = ExplorationManager.Coordination2Pos(opDetail.curPostion)
    window:RefreshTDProcessView(self.mapData, x + 1, x, function()
      if continueFunc ~= nil then
        continueFunc()
      end
    end)
    window:RefreshCC(isFirst)
  end)
end

function EpTDMainCtrl:IsEpAutoSelectRoom()
  return true
end

function EpTDMainCtrl:OnDelete()
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  base.OnDelete(self)
end

return EpTDMainCtrl
