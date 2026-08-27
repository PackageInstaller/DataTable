local BattleDungeonAutoCtrl = class("BattleDungeonAutoCtrl")
local cs_MessageCommon = CS.MessageCommon

function BattleDungeonAutoCtrl:ctor(dungeonCtrl)
  self.dungeonCtrl = dungeonCtrl
  self.__OnEnterBattleDeploy = BindCallback(self, self.OnEnterBattleDeploy)
  self.__BreakAuto = BindCallback(self, self.BreakAuto)
  self:__Reset()
end

function BattleDungeonAutoCtrl:DungeonAutoReset()
  self:__Reset()
  TimerManager:StopTimer(self.__autoWaitTimerId)
  MsgCenter:RemoveListener(eMsgEventId.OnBattleReady, self.__OnEnterBattleDeploy)
end

function BattleDungeonAutoCtrl:__Reset()
  self._enableDungeonAuto = false
  self._totalCount = 0
  self._remainCount = 0
  self._startCount = 0
  self._curBreakOpeation = nil
  self._isNextLevelMode = false
  self._autoSelectSuitDic = nil
end

function BattleDungeonAutoCtrl:IsEnbaleDungeonAutoMode()
  return self._enableDungeonAuto
end

function BattleDungeonAutoCtrl:GetRemainDungeonAutoCount()
  if self._enableDungeonAuto then
    return self._remainCount
  end
  return 0
end

function BattleDungeonAutoCtrl:SetStartDungeonAutoCount(count)
  if not self._enableDungeonAuto then
    return
  end
  self._remainCount = count
  self._startCount = count
end

function BattleDungeonAutoCtrl:GetTotalDungeonAutoCount()
  if self._enableDungeonAuto then
    return self._totalCount
  end
  return 0
end

function BattleDungeonAutoCtrl:EnterDungeonAutoModel(count, isNextLevelMode)
  if count <= 0 then
    return
  end
  self._enableDungeonAuto = true
  self._totalCount = count
  self._startCount = count
  self._remainCount = count
  self._isBreaking = false
  self._curBreakOpeation = nil
  self._isNextLevelMode = isNextLevelMode or false
  self._autoSelectSuitDic = nil
  MsgCenter:AddListener(eMsgEventId.OnBattleReady, self.__OnEnterBattleDeploy)
end

function BattleDungeonAutoCtrl:SetAutoSelectSuitDic(autoSelectSuitDic)
  self._autoSelectSuitDic = autoSelectSuitDic
end

function BattleDungeonAutoCtrl:RecordAndCheckAutoState()
  if not self._enableDungeonAuto or self._remainCount <= 0 then
    return false, false
  end
  self._remainCount = self._remainCount - 1
  return true, self._remainCount <= 0
end

function BattleDungeonAutoCtrl:ExitDungeonAutoModel()
  if not self._enableDungeonAuto then
    return
  end
  self._enableDungeonAuto = false
  UIManager:DeleteWindow(UIWindowTypeID.EpAutoMode)
  TimerManager:StopTimer(self.__autoWaitTimerId)
  self.__autoWaitTimerId = nil
  self._isBreaking = false
  self._curBreakOpeation = nil
  MsgCenter:RemoveListener(eMsgEventId.OnBattleReady, self.__OnEnterBattleDeploy)
end

function BattleDungeonAutoCtrl:BreakAuto()
  self:AutoBreak(true)
  cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(8102), function()
    self:ExitDungeonAutoModel()
    BattleDungeonManager.dungeonCtrl.battleCtrl:ExitBattleDungeon()
  end, function()
    self:AutoBreak(false)
  end)
end

function BattleDungeonAutoCtrl:AutoBreak(flag)
  if not self._enableDungeonAuto then
    return
  end
  self._isBreaking = flag
  if not flag and self._curBreakOpeation ~= nil then
    self._curBreakOpeation()
    self._curBreakOpeation = nil
  end
end

function BattleDungeonAutoCtrl:OnEnterBattleResult(againAction, finishAction, checkAction, nextLevelAction)
  if not self._enableDungeonAuto then
    return
  end
  local autoTime = ConfigData.game_config.dungeonAutoWaitingTime
  local epAutoWindow = UIManager:ShowWindow(UIWindowTypeID.EpAutoMode)
  epAutoWindow:SetAutoMaskClickFunc(self.__BreakAuto)
  epAutoWindow:SetAutoTitleActive(true)
  epAutoWindow:SetAutoOperatorActive(false)
  epAutoWindow:SetAutoTitleState(0)
  epAutoWindow:SetAutoMaskActive(true)
  self.__autoWaitTimerId = TimerManager:StartTimer(1, function()
    autoTime = autoTime - 1
    if 0 < autoTime then
      local resultUI = UIManager:ShowWindow(UIWindowTypeID.DungeonResult)
      if resultUI ~= nil then
        resultUI:RefreshAutoCutdown(autoTime)
      end
      return
    end
    if self._isBreaking then
      return
    end
    TimerManager:StopTimer(self.__autoWaitTimerId)
    self.__autoWaitTimerId = nil
    epAutoWindow:SetAutoTitleState(0)
    epAutoWindow:SetAutoMaskActive(false)
    local resultExtraUI = UIManager:GetWindow(UIWindowTypeID.BattleResultExtra)
    if resultExtraUI ~= nil then
      resultExtraUI:Delete()
    end
    if 0 < self._remainCount then
      local isCanContinue, tip, reallyCannot = checkAction()
      if isCanContinue then
        if self._isNextLevelMode then
          nextLevelAction(BattleDungeonManager.dunInterfaceData)
        else
          againAction(BattleDungeonManager.dunInterfaceData)
        end
      elseif reallyCannot then
        cs_MessageCommon.ShowMessageBoxConfirm(ConfigData:GetTipContent(TipContent.Ath_MaxCount), function()
          finishAction()
        end)
      else
        cs_MessageCommon.ShowMessageBox(tip, function()
          if self._isNextLevelMode then
            nextLevelAction(BattleDungeonManager.dunInterfaceData)
          else
            againAction(BattleDungeonManager.dunInterfaceData)
          end
        end, function()
          finishAction()
        end)
      end
    else
      finishAction()
    end
  end)
end

function BattleDungeonAutoCtrl:OnEnterBattleDeploy()
  if not self._enableDungeonAuto then
    return
  end
  
  local function realStart()
    local battleWindow = UIManager:GetWindow(UIWindowTypeID.Battle)
    if battleWindow ~= nil then
      battleWindow:RealStartBattle()
    end
  end
  
  local function startFunc()
    if self._autoSelectSuitDic ~= nil then
      NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon):CS_BATTLE_SelectChipGroup(self._autoSelectSuitDic, function()
        MsgCenter:Broadcast(eMsgEventId.OnEpChipSuitUpdate)
        realStart()
      end)
    else
      realStart()
    end
  end
  
  if not self._isBreaking then
    startFunc()
  else
    self._curBreakOpeation = startFunc
  end
end

function BattleDungeonAutoCtrl:GetBattleCount()
  if self._enableDungeonAuto then
    return self._totalCount - self._remainCount
  end
  return 0
end

function BattleDungeonAutoCtrl:GetRealBattleCount()
  if self._enableDungeonAuto then
    return self._startCount - self._remainCount
  end
  return 0
end

return BattleDungeonAutoCtrl
