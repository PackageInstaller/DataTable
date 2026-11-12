local RogueBossSelectItemCtrl = class("RogueBossSelectItemCtrl", BaseCtrl)
RogueBossSelectItemCtrl._mapNodeConfig = {
  goUnlock = {},
  goUnOpen = {},
  goNone = {},
  goLock = {},
  imgLevel = {nCount = 2, sComponentName = "Image"},
  TMPBossName = {nCount = 2, sComponentName = "TMP_Text"},
  TMPOpenTime = {nCount = 2, sComponentName = "TMP_Text"},
  rtElements = {nCount = 2},
  imgElement1_ = {nCount = 2, sComponentName = "Image"},
  imgElement2_ = {nCount = 2, sComponentName = "Image"},
  imgElement3_ = {nCount = 2, sComponentName = "Image"},
  txtLock = {sComponentName = "TMP_Text"},
  btnGrid = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Grid"
  }
}
RogueBossSelectItemCtrl._mapEventConfig = {}

function RogueBossSelectItemCtrl:InitItem(mapBossData)
  self.mapBossData = mapBossData
  self._mapNode.goNone.gameObject:SetActive(false)
  self._mapNode.goUnlock.gameObject:SetActive(false)
  self._mapNode.goUnOpen.gameObject:SetActive(false)
  self._mapNode.goLock.gameObject:SetActive(false)
  if nil == mapBossData then
    self._mapNode.btnGrid.interactable = false
    self._mapNode.goNone.gameObject:SetActive(true)
  else
    self._mapNode.btnGrid.interactable = true
    local nLevelState, bUnlock = PlayerData.RogueBoss:GetLevelOpenState(mapBossData.Id)
    local bOpen = nLevelState == AllEnum.RogueBossLevelState.Open
    if not bUnlock then
      self._mapNode.goUnlock.gameObject:SetActive(true)
      self._mapNode.goLock.gameObject:SetActive(true)
    elseif not bOpen then
      self._mapNode.goUnOpen.gameObject:SetActive(true)
    else
      self._mapNode.goUnlock.gameObject:SetActive(true)
    end
    self._mapNode.btnGrid.bSkipBtnAnim = not bOpen
    for _, v in ipairs(self._mapNode.TMPBossName) do
      NovaAPI.SetTMPText(v, mapBossData.Name)
    end
    for _, v in ipairs(self._mapNode.TMPOpenTime) do
      NovaAPI.SetTMPText(v, mapBossData.OpenDayDesc)
    end
    for _, v in ipairs(self._mapNode.imgLevel) do
      self:SetPngSprite(v, mapBossData.Episode)
    end
    for i = 1, 3 do
      for _, v in ipairs(self._mapNode[string.format("imgElement%s_", i)]) do
        if mapBossData.EET == nil or mapBossData.EET[i] == nil then
          v.gameObject:SetActive(false)
        else
          v.gameObject:SetActive(true)
          self:SetAtlasSprite(v, "12_rare", AllEnum.ElementIconType.Icon .. mapBossData.EET[i])
        end
      end
    end
    local sUnlockTips = PlayerData.RogueBoss:GetUnOpenUITipText(nLevelState, mapBossData.Id)
    if nil ~= sUnlockTips and "" ~= sUnlockTips then
      NovaAPI.SetTMPText(self._mapNode.txtLock, sUnlockTips)
    end
  end
end

function RogueBossSelectItemCtrl:OnBtnClick_Grid()
  EventManager.Hit("SelectRogueBossItem", self.mapBossData)
end

return RogueBossSelectItemCtrl
