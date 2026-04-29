_class("UIN17DailyPlanTabHomeListItem", UICustomWidget)
UIN17DailyPlanTabHomeListItem = UIN17DailyPlanTabHomeListItem

function UIN17DailyPlanTabHomeListItem:OnShow(uiParams)
end

function UIN17DailyPlanTabHomeListItem:OnHide()
end

function UIN17DailyPlanTabHomeListItem:SetData(index, desc, count, icon)
  self._index = index
  self:_SetTitle(desc)
  self:_SetRewardIcon(icon)
  self:_SetRewardIconCount(count)
  self:_SetAnimation((index - 1) * 50)
end

function UIN17DailyPlanTabHomeListItem:_SetTitle(desc)
  local text = StringTable.Get(desc)
  UIWidgetHelper.SetLocalizationText(self, "_txtTitle", text)
end

function UIN17DailyPlanTabHomeListItem:_SetRewardIcon(url)
  UIWidgetHelper.SetRawImage(self, "_rewardIcon", url)
end

function UIN17DailyPlanTabHomeListItem:_SetRewardIconCount(reward)
  local text = StringTable.Get("str_n17_daily_plan_home_desc_count", reward)
  UIWidgetHelper.SetLocalizationText(self, "_rewardCount", text)
end

function UIN17DailyPlanTabHomeListItem:_SetAnimation(delay)
  UIWidgetHelper.PlayAnimationInSequence(self, "_anim", "_anim", "UIN17DailyPlan_TabHome_ListItem_anim", delay, 500, nil)
end
