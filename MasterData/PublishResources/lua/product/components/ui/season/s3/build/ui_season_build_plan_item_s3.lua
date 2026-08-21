_class("UISeasonBuildPlanItemS3", UICustomWidget)
UISeasonBuildPlanItemS3 = UISeasonBuildPlanItemS3

function UISeasonBuildPlanItemS3:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonBuildPlanItemS3:InitWidget()
  self.txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self.txtTitle2 = self:GetUIComponent("UILocalizationText", "txtTitle2")
  self.finishGo = self:GetGameObject("finish")
  self.unFinishGo = self:GetGameObject("unFinish")
  self.rewardsPool = self:GetUIComponent("UISelectObjectPath", "rewardsPool")
  self.animation = self:GetUIComponent("Animation", "animation")
end

function UISeasonBuildPlanItemS3:SetData(levelCfg, finish, rewardClickCb)
  self._levelCfg = levelCfg
  self.finishGo:SetActive(finish)
  self.unFinishGo:SetActive(not finish)
  local showCfg = Cfg.cfg_season_castle_show[levelCfg.ID]
  if showCfg then
    local str = StringTable.Get(showCfg.PlanTitle)
    self.txtTitle:SetText(str)
    self.txtTitle2:SetText(str)
  end
  local rewardList = levelCfg.Reward
  local len = #rewardList
  self.rewardWigets = self.rewardsPool:SpawnObjects("UISeasonBuildRewardItemS3", len)
  for i = 1, len do
    local subWidget = self.rewardWigets[i]
    local subRewardData = rewardList[i]
    subWidget:SetData(subRewardData[1], subRewardData[2], rewardClickCb)
    if finish then
      subWidget:ShowMask(true)
    end
  end
end

function UISeasonBuildPlanItemS3:PlayEnterAni()
  self:SetVisible(true)
  self.animation:Play()
end

function UISeasonBuildPlanItemS3:SetVisible(bVisible)
  if not self._gameObject then
    self._gameObject = self:GetGameObject()
  end
  self._gameObject:SetActive(bVisible)
end
