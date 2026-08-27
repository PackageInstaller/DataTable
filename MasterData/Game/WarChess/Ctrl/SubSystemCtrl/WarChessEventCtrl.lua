local base = require("Game.WarChess.Ctrl.SubSystemCtrl.Base.WarChessSubSystemCtrlBase")
local WarChessEventCtrl = class("WarChessEventCtrl", base)
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local WarChessHelper = require("Game.WarChess.WarChessHelper")
local WarchessEventUtil = require("Game.WarChess.WarchessEventUtil")
local cs_MessageCommon = CS.MessageCommon

function WarChessEventCtrl:ctor(wcCtrl)
  self.__eventSystemData = nil
  self.__identify = nil
  self.__eventCfg = nil
  self.__choiceDatas = nil
end

function WarChessEventCtrl:__GetWCSubSystemCat()
  local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
  return eWarChessEnum.eSystemCat.event
end

function WarChessEventCtrl:OpenWCSubSystem(systemState, identify)
  if systemState == nil or systemState.eventSystemData == nil then
    error("not have data")
    return
  end
  self.__eventSystemData = systemState.eventSystemData
  self.__identify = identify
  self.__systemPos = systemState.pos
  self:__DealEventData()
  UIManager:ShowWindowAsync(UIWindowTypeID.WarChessEvent, function(win)
    if win == nil then
      return
    end
    win:InitWCEvent(self)
    WarChessManager:QuickExeWCGuideActions(eWarChessEnum.wcGuideMomentType.WCEventEnter, self.__systemPos)
  end)
end

function WarChessEventCtrl:EnterNextWCEvent(eventSystemData)
  self.__eventSystemData = eventSystemData
  self:__DealEventData()
  UIManager:ShowWindowAsync(UIWindowTypeID.WarChessEvent, function(win)
    if win == nil then
      return
    end
    win:InitWCEvent(self)
  end)
end

function WarChessEventCtrl:__DealEventData()
  self.__eventCfg, self.__choiceDatas = WarchessEventUtil:DealEventDataByMsg(self.__eventSystemData)
end

function WarChessEventCtrl:GetWCEventConfig()
  return self.__eventCfg
end

function WarChessEventCtrl:GetWCEventChoices()
  return self.__choiceDatas
end

function WarChessEventCtrl:WCEventSelect(choiceData)
  local index = choiceData.index
  self._lastEventCfg = self.__eventCfg
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_EventSystem_Select(self.__identify, index, function()
    WarChessHelper.AcquireOutSideBoxReward(choiceData.choiceCfg.triggerActions, self.wcCtrl.wcGlobalData)
    self:_OnEventSelectEnd(choiceData)
  end)
end

local eventEndFuncDic = {
  [eWarChessEnum.eWcEventId.EatPumpkin] = function(choiceData)
    local costItemNum
    for i, trigger in ipairs(choiceData.choiceCfg.triggerActions) do
      if trigger.cat == eWarChessEnum.eTriggerType.ItemChange then
        local isReduce = trigger.pms[1] == 1
        if isReduce then
          local itemId = trigger.pms[2]
          if itemId == eWarChessEnum.eItemId.Pumpkin then
            costItemNum = trigger.pms[3]
          end
        end
      end
    end
    if costItemNum == nil then
      return
    end
    cs_MessageCommon.ShowMessageTips(string.format(ConfigData:GetTipContent(8530), costItemNum))
  end
}

function WarChessEventCtrl:_OnEventSelectEnd(choiceData)
  if self.__eventCfg and eventEndFuncDic[self.__eventCfg.id] then
    eventEndFuncDic[self.__eventCfg.id](choiceData)
  end
end

function WarChessEventCtrl:CloseWCSubSystem(isSwitchClose)
  base.CloseWCSubSystem()
  local logicPos = self.__systemPos
  self:Exit()
  WarChessManager:QuickExeWCGuideActions(eWarChessEnum.wcGuideMomentType.WCEventExit, logicPos)
end

function WarChessEventCtrl:Exit()
  UIManager:DeleteWindow(UIWindowTypeID.WarChessEvent)
  self.__eventSystemData = nil
  self.__identify = nil
  self.__eventCfg = nil
  self.__choiceDatas = nil
  self.__systemPos = nil
end

function WarChessEventCtrl:Delete()
end

return WarChessEventCtrl
