_class("UISeasonBuildPlanS3", UICustomWidget)
UISeasonBuildPlanS3 = UISeasonBuildPlanS3

function UISeasonBuildPlanS3:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonBuildPlanS3:InitWidget()
  self.planContent = self:GetUIComponent("UISelectObjectPath", "planContent")
  self._planScroll = self:GetUIComponent("ScrollRect", "planScroll")
end

function UISeasonBuildPlanS3:InitWithRewardClickCb(cb)
  self.rewardClickCb = cb
end

function UISeasonBuildPlanS3:SetData(context)
  self._context = context
  local curLevel = self._context:GetCurLevel()
  local maxLevel = self._context:GetMaxLevel()
  local levelCfgs = self._context:GetLevelCfgs()
  local len = maxLevel - 1
  if not self.planItemsWidget then
    self.planItemsWidget = self.planContent:SpawnObjects("UISeasonBuildPlanItemS3", len)
  end
  local index = 1
  if curLevel < maxLevel then
    for i = curLevel, maxLevel - 1 do
      local subWidget = self.planItemsWidget[index]
      index = index + 1
      self:_RefreshItem(subWidget, levelCfgs[i], false)
      subWidget:SetVisible(false)
    end
  end
  if 1 < curLevel then
    for i = 1, curLevel - 1 do
      local subWidget = self.planItemsWidget[index]
      index = index + 1
      self:_RefreshItem(subWidget, levelCfgs[i], true)
      subWidget:SetVisible(false)
    end
  end
  self._planScroll.verticalNormalizedPosition = 1
  self:Lock("UISeasonBuildPlanS3_switch")
  self:StartTask(function(TT)
    for i, v in ipairs(self.planItemsWidget) do
      v:PlayEnterAni()
      if i < 5 then
        YIELD(TT, 50)
      end
    end
    self:UnLock("UISeasonBuildPlanS3_switch")
  end)
end

function UISeasonBuildPlanS3:_RefreshItem(planWidget, cfg, finish)
  planWidget:SetData(cfg, finish, self.rewardClickCb)
end
