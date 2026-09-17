local this = class("moduleGameActivityDoubleReward", G_UIModuleBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()

function this.bind()
  return {
    txtRemainTime = "",
    txtDescription = "",
    bLockState = false,
    bUnlockState = false,
    bShowBtnReddot = false,
    moduleDoubleRewardTipItem = {
      moduleName = "pages/gameAct/doubleDrop/moduleDoubleRewardTipItem"
    },
    bgPos = C_Vector2(0, 0),
    listModuleLock = {
      moduleName = "pages/gameAct/cellLockCondition"
    }
  }
end

function this.methods()
  return {
    onBtnClick = function(self)
      self.bind.bShowBtnReddot = false
      L_ReddotManager:clearDailyNew(L_ReddotManager.DotDef.GameAct_EventsInCenter, self.actId)
      AzurWorld.RedDotMgr:MarkDirty(string.format(L_ReddotManager.DotDef.GameAct_Events, self.actId))
      local tpl = _GameEventTpl:getTplById(self.actId)
      local jumpTo = _GameEventTpl:getCommonJump(tpl)
      if jumpTo then
        L_JumpMgr:jumpTo(jumpTo)
      end
    end,
    onHelpClick = function(self)
      local tpl = _GameEventTpl:getTplById(self.actId)
      if tpl then
        L_UI:open("pageCommonIntroduction", {
          groupId = _GameEventTpl:getHelp(tpl)
        })
      end
    end
  }
end

function this:preOpen()
end

function this:open()
  if C_ResolutionUtility.CheckSuperWidthScreen() then
    self.bind.bgPos = C_Vector2(0, -225)
  end
  L_GameStore:listenCallFunc(L_GameStore.event.refreshDayChange, self.initPage, self)
end

function this:close()
  L_GameStore:unListenCallFunc(L_GameStore.event.refreshDayChange, self.initPage)
  self:disposeTimer()
end

function this:setActId(id)
  self.actId = id
  self:initPage()
end

function this:initPage()
  local gameEventData = L_GameEventStore:getGameEventData(self.actId)
  if not gameEventData then
    return
  end
  local tpl = _GameEventTpl:getTplById(self.actId)
  self.bind.txtDescription = L_Lang:get(_GameEventTpl:getDesc(tpl))
  local endTimeType = _GameEventTpl:getEndShowType(tpl)
  if endTimeType == L_Const.gameActEndType.permanent then
  elseif endTimeType == L_Const.gameActEndType.specifyTime then
    local showBegin, showEnd = C_CommonTimerMgr.GetStartTime(_GameEventTpl:getTimeLimit(tpl)), C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(tpl))
    local nowTime = L_TimeUtil.getServerTime()
    if not (showBegin < nowTime) or showEnd > nowTime then
    end
  end
  self.endTime = C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(tpl))
  self.bind.txtRemainTime = L_TimeUtil.getLeftTimeFormatString(self.endTime)
  self.timer = L_GameTimer.repeated(1, self.repeatShowTime, self)
  local lock = false
  local conditions = _GameEventTpl:getCondition(tpl)
  local lockArray = {}
  for i, con in pairs(conditions) do
    if not L_ConditionManager:singleIsComplete(con) then
      lock = true
      table.insert(lockArray, {
        lockParam = {
          _GameEventTpl:getLockJump(tpl)[i]
        },
        txt_lockDesc = L_Lang:get(_GameEventTpl:getLockText(tpl)[i])
      })
    end
  end
  self.bind.bLockState = lock
  self.bind.bUnlockState = not lock
  if lock then
    self.bind.listModuleLock:clear()
    self.bind.listModuleLock:insert_array(lockArray)
  else
    local ret = L_ReddotManager:haveDailyNew(L_ReddotManager.DotDef.GameAct_EventsInCenter, self.actId)
    self.bind.bShowBtnReddot = ret
  end
  self.modules.moduleDoubleRewardTipItem:refreshVisible()
end

function this:startDateTimer(endTime)
  self:disposeTimer()
  self.timer = Timer.repeated(1, function()
    local gapTime = endTime - L_TimeUtil:getServerTime()
    if gapTime <= 0 then
      self:disposeTimer()
    end
  end, self, self.gameObject)
end

function this:repeatShowTime()
  local isChange, str = L_TimeUtil.tryGetLeftTimeFormatString(self.endTime, 1)
  if isChange then
    self.bind.txtRemainTime = str
  end
end

function this:disposeTimer()
  if self.timer ~= nil then
    self.timer:stop()
    Timer.remove(self.timer)
    self.timer = nil
  end
end

function this:refreshDate(tpl)
  local startTime = L_TimeUtil.getDisplayTimeCustom(C_CommonTimerMgr.GetStartTime(_GameEventTpl:getTimeLimit(tpl)), "!%m.%d")
  local endTime = L_TimeUtil.getDisplayTimeCustom(C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(tpl)), "!%m.%d")
  local startMonth = startTime:sub(1, 2)
  local endMonth = endTime:sub(1, 2)
  local startDate = startTime:sub(4, 5)
  local endDate = endTime:sub(4, 5)
  self.bind.txtRemainTime = startMonth .. "/" .. startDate .. "-" .. endMonth .. "/" .. endDate
end

return this
