local this = class("cellLimitedTimeActivity", G_UIModuleBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    actType = 0,
    lock = false,
    inOpenTime = true
  }
end

function this.bind()
  return {txt_activityName = ""}
end

function this.methods()
  return {
    onClick_goPlay = function(self)
      self:onClickGoPlay()
    end
  }
end

function this:setActType(actType)
  self.data.actType = actType
  self:initCell()
end

function this:initCell()
  if not self.data.actType or self.data.actType == 0 then
    return
  end
  self.data.tpl = _GameEventTpl:getTplById(self.data.actType)
  self.bind.txt_activityName = L_Lang:get(_GameEventTpl:getName(self.data.tpl))
  self:checkLockState()
end

function this:checkLockState()
  self.data.lock = false
  local showBegin, showEnd = C_CommonTimerMgr:GetStartTime(_GameEventTpl:getTimeLimit(self.data.tpl)), C_CommonTimerMgr:GetEndTime(_GameEventTpl:getTimeLimit(self.data.tpl))
  local currTime = L_TimeUtil.getServerTime()
  self.data.inOpenTime = showBegin <= currTime and showEnd >= currTime
  if self.data.inOpenTime then
    local preConditions = _GameEventTpl:getCondition(self.data.tpl)
    for i, condition in ipairs(preConditions or {}) do
      if not L_ConditionManager:singleIsComplete(condition) then
        self.data.lock = true
        self.lockConditionIndex = i
        break
      end
    end
  else
    self.data.lock = true
  end
end

function this:onClickGoPlay()
  if not self.data.actType or self.data.actType == 0 then
    return
  end
  if self.data.lock then
    if self.data.inOpenTime then
      local conditions = _GameEventTpl:getCondition(self.data.tpl)
      if self.lockConditionIndex and conditions[self.lockConditionIndex] then
        local condition = conditions[self.lockConditionIndex]
        local desc = L_ConditionManager:getSingleDesc(condition)
        L_FlyMsgManager:showNormalMsg(desc)
      end
    else
      local currTime = L_TimeUtil.getServerTime()
      local showBegin, showEnd = C_CommonTimerMgr.GetStartTime(_GameEventTpl:getTimeLimit(self.data.tpl)), C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(self.data.tpl))
      if currTime > showEnd then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_activity_time_end"))
      elseif currTime < showBegin then
        local deltaTime = showBegin - currTime
        local showMsg = L_WordsTpl:getValue("ui_time_to_start_activity", {
          [0] = L_TimeUtil.secondToLangString(deltaTime)
        })
        L_FlyMsgManager:showNormalMsg(showMsg)
      end
    end
    return
  end
  if self.data.actType == L_LimitedTimeActivityStore.LimitedActivityType.Xiaoyu then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("residual_code_celllimitedtimeactivity_01"))
  elseif self.data.actType == L_LimitedTimeActivityStore.LimitedActivityType.XiaoyuAvatarBattle then
    L_UI:open("pageAvatarBattleActivityMain", {
      activityId = L_LimitedTimeActivityStore.LimitedActivityType.XiaoyuAvatarBattle
    })
  elseif self.data.actType == L_LimitedTimeActivityStore.LimitedActivityType.Qiandai then
    L_UI:open("pageQiandaiActivityMain")
  elseif self.data.actType == L_LimitedTimeActivityStore.LimitedActivityType.QiandaiAvatarBattle then
    L_UI:open("pageAvatarBattleActivityMain", {
      activityId = L_LimitedTimeActivityStore.LimitedActivityType.QiandaiAvatarBattle
    })
  end
end

return this
