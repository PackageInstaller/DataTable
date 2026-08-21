_class("UISeasonBuildProgramStep3S3", UICustomWidget)
UISeasonBuildProgramStep3S3 = UISeasonBuildProgramStep3S3

function UISeasonBuildProgramStep3S3:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonBuildProgramStep3S3:InitWidget()
  self.txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self.txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self.rewardsPool = self:GetUIComponent("UISelectObjectPath", "rewardsPool")
  self.unFinishGo = self:GetGameObject("unFinish")
  self.finishGo = self:GetGameObject("btnBuild")
  self.canBuildGo = self:GetGameObject("canBuildGo")
end

function UISeasonBuildProgramStep3S3:SetData(context, buildClickCb, rewardClickCb)
  self._context = context
  self._buildClickCb = buildClickCb
  self._rewardClickCb = rewardClickCb
  local level = self._context:GetCurLevel()
  local cfg = self._context:GetBuildCfgByLevel(level)
  local showCfg = Cfg.cfg_season_castle_show[cfg.ID]
  if showCfg then
    self.txtDesc:SetText(StringTable.Get(showCfg.PlanTitle))
  end
  self.txtTitle:SetText(StringTable.Get("str_season_s3_castle_build_title"))
  local quest = self._context:GetQuestByBuildLevel(level)
  local finish = quest.Finish
  self.unFinishGo:SetActive(not finish)
  self.finishGo:SetActive(finish)
  self.canBuildGo:SetActive(finish)
  local rewardList = cfg.Reward
  local len = #rewardList
  self.rewardWigets = self.rewardsPool:SpawnObjects("UISeasonBuildRewardItemS3", len)
  for i = 1, len do
    local subWidget = self.rewardWigets[i]
    local subRewardData = rewardList[i]
    subWidget:SetData(subRewardData[1], subRewardData[2], self._rewardClickCb)
  end
end

function UISeasonBuildProgramStep3S3:BtnBuildOnClick(go)
  if self._buildClickCb then
    self._buildClickCb()
  end
end
