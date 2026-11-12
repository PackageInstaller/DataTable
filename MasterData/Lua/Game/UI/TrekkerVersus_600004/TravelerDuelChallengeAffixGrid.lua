local TravelerDuelChallengeAffixGrid = class("TravelerDuelChallengeAffixGrid", BaseCtrl)
TravelerDuelChallengeAffixGrid._mapNodeConfig = {
  imgSelect = {},
  imgGroupMask = {sComponentName = "Image"},
  imgLock = {},
  imgHardMask = {},
  TMPLockCond = {sComponentName = "TMP_Text"},
  imgAffixIcon = {sComponentName = "Image"},
  TMPHard = {sComponentName = "TMP_Text"},
  TMPHardMask = {sComponentName = "TMP_Text"},
  imgLine = {},
  btnGrid = {sComponentName = "UIButton"}
}
TravelerDuelChallengeAffixGrid._mapEventConfig = {}

function TravelerDuelChallengeAffixGrid:Refresh(nAffixId, bSelect, bGroupMask, bLine, mapActData)
  self.nAffixId = nAffixId
  if nAffixId == 0 then
    self._mapNode.btnGrid.gameObject:SetActive(false)
    return
  else
    self._mapNode.btnGrid.gameObject:SetActive(true)
  end
  local bUnlock, nType, nCond = mapActData:GetTravelerDuelAffixUnlock(nAffixId)
  self.bUnlock = bUnlock
  self.nType = nType
  self.nCond = nCond
  local mapAffixCfgData = ConfigTable.GetData("TravelerDuelChallengeAffix", nAffixId)
  self._mapNode.imgLine:SetActive(bLine)
  self:SetPngSprite(self._mapNode.imgAffixIcon, mapAffixCfgData.Icon)
  self:SetPngSprite(self._mapNode.imgGroupMask, mapAffixCfgData.Icon)
  NovaAPI.SetTMPText(self._mapNode.TMPHard, mapAffixCfgData.Difficulty)
  NovaAPI.SetTMPText(self._mapNode.TMPHardMask, mapAffixCfgData.Difficulty)
  self._mapNode.imgSelect:SetActive(bSelect)
  self._mapNode.imgGroupMask.gameObject:SetActive(bGroupMask or not bUnlock)
  self._mapNode.imgHardMask:SetActive(bGroupMask or not bUnlock)
  self._mapNode.TMPHardMask.gameObject:SetActive(bGroupMask or not bUnlock)
  self._mapNode.imgLock:SetActive(not bUnlock)
  if not bUnlock then
    NovaAPI.SetTMPText(self._mapNode.TMPLockCond, orderedFormat(ConfigTable.GetUIText("TD_AffixCond" .. nType), nCond))
  end
end

function TravelerDuelChallengeAffixGrid:SetSelect(bSelect)
  self._mapNode.imgSelect:SetActive(bSelect)
end

function TravelerDuelChallengeAffixGrid:GetAffixId()
  return self.nAffixId
end

function TravelerDuelChallengeAffixGrid:SetGroupMask(bGroupSelect)
  self._mapNode.imgGroupMask.gameObject:SetActive(bGroupSelect or not self.bUnlock)
  self._mapNode.imgHardMask:SetActive(bGroupSelect or not self.bUnlock)
  self._mapNode.TMPHardMask.gameObject:SetActive(bGroupSelect or not self.bUnlock)
end

return TravelerDuelChallengeAffixGrid
