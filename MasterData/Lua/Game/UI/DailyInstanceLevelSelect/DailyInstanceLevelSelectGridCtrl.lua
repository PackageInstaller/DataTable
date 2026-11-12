local DailyInstanceLevelSelectGridCtrl = class("DailyInstanceLevelSelectGridCtrl", BaseCtrl)
DailyInstanceLevelSelectGridCtrl._mapNodeConfig = {
  imgLevelImage = {sComponentName = "Image"},
  txtInstanceName = {sComponentName = "TMP_Text"},
  txtInstanceDesc = {sComponentName = "TMP_Text"},
  btnChosen = {
    sComponentName = "UIButton",
    callback = "OnBtn_ClickChosen"
  },
  imgCurChose = {sComponentName = "GameObject"},
  txtCurChose = {
    sComponentName = "TMP_Text",
    sLanguageId = "DailyInstance_Cur_Chose"
  },
  txtBtn = {
    sComponentName = "TMP_Text",
    sLanguageId = "DailyInstance_Reward_Select"
  }
}
DailyInstanceLevelSelectGridCtrl._mapEventConfig = {
  ChangeDailyInstanceRewardMode = "OnEvent_ChangeDailyInstanceRewardMode"
}

function DailyInstanceLevelSelectGridCtrl:Refresh(nId)
  local mapData = ConfigTable.GetData("DailyInstanceRewardGroup", nId)
  if mapData == nil then
    return
  end
  self:SetPngSprite(self._mapNode.imgLevelImage, mapData.RewardIcon)
  NovaAPI.SetTMPText(self._mapNode.txtInstanceName, mapData.RewardName)
  NovaAPI.SetTMPText(self._mapNode.txtInstanceDesc, mapData.RewardDes)
  self.dailyRewardType = mapData.DailyRewardType
  local curChoseType = PlayerData.DailyInstance:GetLastRewardType()
  self._mapNode.imgCurChose:SetActive(curChoseType == self.dailyRewardType)
  self._mapNode.txtCurChose.gameObject:SetActive(curChoseType == self.dailyRewardType)
  self._mapNode.btnChosen.gameObject:SetActive(curChoseType ~= self.dailyRewardType)
end

function DailyInstanceLevelSelectGridCtrl:OnEvent_ChangeDailyInstanceRewardMode()
  local curChoseType = PlayerData.DailyInstance:GetLastRewardType()
  self._mapNode.imgCurChose:SetActive(curChoseType == self.dailyRewardType)
  self._mapNode.txtCurChose.gameObject:SetActive(curChoseType == self.dailyRewardType)
  self._mapNode.btnChosen.gameObject:SetActive(curChoseType ~= self.dailyRewardType)
end

function DailyInstanceLevelSelectGridCtrl:OnBtn_ClickChosen()
  PlayerData.DailyInstance:SetRewardType(self.dailyRewardType)
  EventManager.Hit("ChangeDailyInstanceRewardMode")
end

function DailyInstanceLevelSelectGridCtrl:CheckMainlinePass(mapData)
  if mapData.MainLineId > 0 then
    local nStar = PlayerData.Mainline:GetMianlineLevelStar(mapData.MainLineId)
    return 0 < nStar
  else
    return true
  end
end

return DailyInstanceLevelSelectGridCtrl
