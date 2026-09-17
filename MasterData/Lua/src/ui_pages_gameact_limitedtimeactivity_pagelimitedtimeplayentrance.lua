local this = class("pageLimitedTimePlayEntrance", G_UIPageBase)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {actId = 0}
end

function this.bind()
  return {
    txt_activityName = "",
    txt_remainTime = "",
    moduleCommonTop = {
      moduleName = "modulePages/moduleCommonTop"
    },
    limitedTimeActivity = {
      moduleName = "pages/gameAct/limitedTimeActivity/cellLimitedTimeActivity"
    },
    avatarBattleActivity = {
      moduleName = "pages/gameAct/limitedTimeActivity/cellLimitedTimeActivity"
    },
    go_allRewardsGet = false
  }
end

function this.methods()
  return {
    onClick_help = function(self)
      local activityIds = L_GameActivityManager:GetSubActivitiesByMainActivityId(self.data.actId)
      L_GameActivityManager:OpenGameActivityHelpPage(activityIds)
    end,
    onClick_rewardPreview = function(self)
      L_UI:open("pageGamePlayActivityReward", {
        mainGameplayActivityId = self.data.actId
      })
    end
  }
end

function this:preOpen(options)
  self.options = options
  self.data.actId = self.options.actId
  self:setCommonTopInfo()
  self:setInfo()
end

function this:setInfo()
  self.data.tpl = _GameEventTpl:getTplById(self.data.actId)
  if not self.data.tpl then
    return
  end
  self.bind.txt_activityName = L_Lang:get(_GameEventTpl:getName(self.data.tpl))
  local showBegin, showEnd = C_CommonTimerMgr.GetStartTime(_GameEventTpl:getTimeLimit(self.data.tpl)), C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(self.data.tpl))
  local nowTime = L_TimeUtil.getServerTime()
  if showBegin < nowTime and showEnd > nowTime then
    self.bind.txt_remainTime = L_TimeUtil.secondToLangString(showEnd - nowTime)
  end
  self.bind.go_allRewardsGet = L_GameActivityManager:IsAllActivitiesRewardGet(self.data.actId)
  if self.data.actId == L_LimitedTimeActivityStore.MainGameplayActivity.Xiaoyu then
    self.modules.limitedTimeActivity:setActType(L_LimitedTimeActivityStore.LimitedActivityType.Xiaoyu)
    self.modules.avatarBattleActivity:setActType(L_LimitedTimeActivityStore.LimitedActivityType.XiaoyuAvatarBattle)
  elseif self.data.actId == L_LimitedTimeActivityStore.MainGameplayActivity.Qiandai then
    self.modules.limitedTimeActivity:setActType(L_LimitedTimeActivityStore.LimitedActivityType.Qiandai)
    self.modules.avatarBattleActivity:setActType(L_LimitedTimeActivityStore.LimitedActivityType.QiandaiAvatarBattle)
  end
end

function this:setCommonTopInfo()
  local data = {
    name = L_WordsTpl:getValue("ui_hintActivity_01"),
    helpBtnBool = false,
    mainBtnBool = true,
    closeCurPage = function()
      L_UI:close(self.pageName)
    end,
    helpBtn = function()
    end,
    mainBtn = function()
      L_UI:backToRoot()
    end
  }
  self.modules.moduleCommonTop:initModule(data)
end

return this
