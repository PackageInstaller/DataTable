local this = class("moduleActivityBondsMission", G_UIModuleBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {}
end

function this.bind()
  return {
    textDate = "",
    textDesc = "",
    showView = true,
    showComplete = false,
    showLock = false,
    moduleLockCondition = {
      moduleName = "pages/gameAct/cellLockCondition"
    },
    listReward = {
      moduleName = "modulePages/cellIconBag"
    }
  }
end

function this.methods()
  return {
    OnClick_Go = function(self)
      if not self.isUnlock or self.commonJump == nil then
        return
      end
      L_JumpMgr:jumpTo(self.commonJump)
    end,
    onClick_help = function(self)
      if math.isEmpty(self.helpGroupId) then
        return
      end
      L_UI:open("pageCommonIntroduction", {
        groupId = self.helpGroupId
      })
    end
  }
end

function this:setActId(id)
  self.actId = id
  self:init()
end

function this:closeFx()
end

function this:init()
  self.tpl = _GameEventTpl:getTplById(self.actId)
  self.bind.textDesc = _GameEventTpl:getDesc(self.tpl)
  local rewards = _GameEventTpl:getRewardShow(self.tpl)
  self.helpGroupId = _GameEventTpl:getHelp(self.tpl)
  self.commonJump = _GameEventTpl:getCommonJump(self.tpl)
  local rewards = _GameEventTpl:getRewardShow(self.tpl)
  local rewardsData = L_DataUtil.parseRewardConfig(rewards)
  self.bind.listReward:clear()
  self.bind.listReward:insert_array(rewardsData)
  local conditions = _GameEventTpl:getCondition(self.tpl)
  self.isUnlock = L_ConditionManager:singleIsComplete(conditions[1])
  self.bind.showLock = not self.isUnlock
  if not self.isUnlock then
    self.modules.moduleLockCondition:updateView({
      _GameEventTpl:getLockJump(self.tpl)[1]
    }, L_Lang:get(_GameEventTpl:getLockText(self.tpl)[1]))
  end
  local taskId = _GameEventTpl:getEndTaskId(self.tpl)
  local isFinish = AzurWorld.TaskMgr:IsFinishTask(taskId)
  self.bind.showView = self.isUnlock and not isFinish
  self.bind.showComplete = isFinish
  self.endTime = C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(self.tpl))
  self.bind.textDate = L_TimeUtil.getLeftTimeFormatString(self.endTime)
  local EndTime = self.endTime - L_TimeUtil.getServerTime()
  if EndTime <= 0 then
    self.timer = L_GameTimer.repeated(1, self.repeatShowTime, self)
  else
    self:disposeTimer()
  end
end

function this:repeatShowTime()
  local isChange, str = L_TimeUtil.tryGetLeftTimeFormatString(self.endTime, 1)
  if isChange then
    self.bind.textDate = str
  end
end

function this:initRedPoint()
end

function this:preOpen(options)
  self.timer = nil
  self.helpGroupId = 1
  self.isUnlock = false
end

function this:open()
end

function this:show()
  if self.actId ~= nil then
    self.bindComponents.rewardList.horizontalNormalizedPosition = 0
  end
end

function this:close()
  self:disposeTimer()
end

function this:disposeTimer()
  if self.timer ~= nil then
    self.timer:stop()
    Timer.remove(self.timer)
    self.timer = nil
  end
end

return this
