local UICompPvpHistoryLevelItem, Super = NewViewComponent("UICompPvpHistoryLevelItem")

function UICompPvpHistoryLevelItem:ctor(uiNode, view, careerLevelCfg)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Other_Item_AwardResource(uiNode)
  self.careerLevelCfg = careerLevelCfg
end

function UICompPvpHistoryLevelItem:RegisterNotifications()
end

function UICompPvpHistoryLevelItem:RegisterEvents()
end

function UICompPvpHistoryLevelItem:OnEnterComponent()
  self:_RefreshView()
end

function UICompPvpHistoryLevelItem:_GetRewardInfos()
  local cfgLevelReward = self.careerLevelCfg.LevelRewardV2 or {}
  local rewardInfos = {}
  for i = 1, #cfgLevelReward, 2 do
    local tid = cfgLevelReward[i]
    local num = cfgLevelReward[i + 1]
    table.insert(rewardInfos, {tid = tid, num = num})
  end
  return rewardInfos
end

function UICompPvpHistoryLevelItem:_RefreshView()
  self:SetActive(self.ui.Image_Finish, true)
  self:SetActive(self.ui.Image_Finish_Next, false)
  self:SetText(self.ui.Text_Victory, LT.Textf("Team_AwakerLevel", self.careerLevelCfg.Level))
  local careerLevelMO = CareerLevelModel.Instance:GetCareerLevelMO(self.careerLevelCfg.Type)
  local curLevel = careerLevelMO:GetLevel()
  local targetPercent = 0
  if curLevel == self.careerLevelCfg.Level then
    targetPercent = 0.5
  elseif curLevel > self.careerLevelCfg.Level then
    targetPercent = 1
  end
  self:SetImageFillAmount(self.ui.Image_Finish, targetPercent)
  self:_RefreshReward()
end

function UICompPvpHistoryLevelItem:_RefreshReward()
  local haveHighQualityReward = false
  local isGot = CareerLevelModel.Instance:IsCareerLevelGoted(self.careerLevelCfg.Type, self.careerLevelCfg.Level)
  local canReceived = CareerLevelModel.Instance:IsCareerLevelCanReceive(self.careerLevelCfg.Type, self.careerLevelCfg.Level)
  local rewardInfos = self:_GetRewardInfos()
  local parentTs = self.ui.Group_Rewards.transform
  self:ReserveChildren(parentTs, #rewardInfos)
  print("revv rew", table.tostring(rewardInfos))
  for i = 1, #rewardInfos do
    local rewardInfo = rewardInfos[i]
    local rewardQuality = ItemCfgUtils.GetCfgField("Quality", rewardInfo.tid)
    if rewardQuality ~= CommonDefine.CommonQuality.Blue then
      haveHighQualityReward = true
    end
    local go = parentTs:GetChild(i - 1).gameObject
    go:SetActive(true)
    local viewData = {
      itemTid = rewardInfo.tid,
      itemCount = rewardInfo.num,
      isShowRing = canReceived,
      isGot = isGot,
      clickFunc = function()
        if not isGot and canReceived then
          PvpController.Instance:ReqOnGainAllLevelReward(self.careerLevelCfg.Type)
        else
          ItemDataUtils.ShowItemDetailTips(self.binder, go, nil, rewardInfo.tid)
        end
      end
    }
    self:AddViewComponentOnce(go, CompPublicIconItemType2, viewData)
  end
  for i = #rewardInfos + 1, parentTs.childCount do
    local targetGo = parentTs:GetChild(i - 1)
    if targetGo and targetGo.gameObject then
      targetGo.gameObject:SetActive(false)
    end
  end
  local careerLevelMO = CareerLevelModel.Instance:GetCareerLevelMO(self.careerLevelCfg.Type)
  local curLevel = careerLevelMO:GetLevel()
  self:SetActive(self.ui.Dark_Open, curLevel >= self.careerLevelCfg.Level and not haveHighQualityReward)
  self:SetActive(self.ui.Bright_Open, curLevel >= self.careerLevelCfg.Level and haveHighQualityReward)
  self:SetActive(self.ui.Image_Bright, haveHighQualityReward)
end

return UICompPvpHistoryLevelItem
