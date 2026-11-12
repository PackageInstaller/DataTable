local TravelerDuelLevelGridCtrl = class("TravelerDuelLevelGridCtrl", BaseCtrl)
TravelerDuelLevelGridCtrl._mapNodeConfig = {
  imgLevelChar = {sComponentName = "Image"},
  imgMask = {sComponentName = "Image"},
  txtLock = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_Lock_Normal"
  },
  TMPRewardTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_LevelRewardTitle"
  },
  TMPTravelerLevelName = {sComponentName = "TMP_Text"},
  btnGrid = {sComponentName = "UIButton"},
  rewardItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 2
  }
}
TravelerDuelLevelGridCtrl._mapEventConfig = {}

function TravelerDuelLevelGridCtrl:Refresh(nBossId, nBossLevelId)
  local mapLevelCfgData = ConfigTable.GetData("TravelerDuelBoss", nBossId)
  if mapLevelCfgData == nil then
    printError("TravelerDuelBoss Data Missing:" .. nBossId)
    self.gameObject:SetActive(false)
    return
  end
  self:SetPngSprite(self._mapNode.imgLevelChar, mapLevelCfgData.Image)
  self:SetPngSprite(self._mapNode.imgMask, mapLevelCfgData.Image)
  local bUnlock = PlayerData.TravelerDuel:GetTravelerDuelLevelUnlock(nBossLevelId)
  self._mapNode.imgMask.gameObject:SetActive(not bUnlock)
  local totalRewardCount = ConfigTable.GetConfigValue("TravelerDuelWeeklyAwardLimit")
  NovaAPI.SetTMPText(self._mapNode.TMPTravelerLevelName, mapLevelCfgData.Name)
  local nRewardCount = PlayerData.TravelerDuel:GetTravelerDuelLevelRewardCount(nBossId)
  nRewardCount = -1 < nRewardCount and totalRewardCount - nRewardCount or totalRewardCount
  if nRewardCount < 0 then
    nRewardCount = 0
  end
  self._mapNode.btnGrid.interactable = true
  for i = 1, 2 do
    if mapLevelCfgData.ShowReward[i] ~= nil then
      self._mapNode.rewardItem[i].gameObject:SetActive(true)
      self._mapNode.rewardItem[i]:SetItem(mapLevelCfgData.ShowReward[i], nil, nil, nil, false, false, false, false, false)
    else
      self._mapNode.rewardItem[i].gameObject:SetActive(false)
    end
  end
end

return TravelerDuelLevelGridCtrl
