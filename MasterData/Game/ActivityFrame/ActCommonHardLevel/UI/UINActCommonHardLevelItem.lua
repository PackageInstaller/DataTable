local UINActCommonHardLevelItem = class("UINActCommonHardLevelItem", UIBaseNode)
local base = UINActCommonHardLevelItem

function UINActCommonHardLevelItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.item, self, self.OnClickChallenge)
end

function UINActCommonHardLevelItem:InitCommonChallengeItem(hardLevelPlayData, actHardLevelData, index, onSelectChallenge)
  self.actHardLevelData = actHardLevelData
  self.index = index
  self.onSelectChallenge = onSelectChallenge
  self.ui.tex_QuestName.text = self.actHardLevelData:GetDungeonLevelName()
  self.ui.tex_Num.text = tostring(index)
  self:__Refresh()
end

function UINActCommonHardLevelItem:__Refresh()
  local isUnlock = self.actHardLevelData:GetIsLevelUnlock()
  self.ui.obj_Lock:SetActive(not isUnlock)
  if not isUnlock then
    self.ui.tex_LockDes.text = self.actHardLevelData:GetIsUnlockDes()
    self.ui.text_Time:SetIndex(1)
    return
  end
  local isVerifying = self.actHardLevelData:ACHLD_GetIsVerifying()
  self.ui.obj_Check:SetActive(isVerifying)
  local score = self.actHardLevelData:ACHLD_GetHightScore()
  if score ~= nil and score ~= 0 then
    self.ui.text_Time:SetIndex(3, tostring(score))
  else
    self.ui.text_Time:SetIndex(1)
  end
  self.ui.BlueDot:SetActive(not self.actHardLevelData:ACHLD_GetIsSeen())
end

function UINActCommonHardLevelItem:OnClickChallenge()
  local isUnlock = self.actHardLevelData:GetIsLevelUnlock()
  if isUnlock and self.onSelectChallenge ~= nil then
    self.onSelectChallenge(self.actHardLevelData, self.index)
    self.ui.BlueDot:SetActive(false)
  end
end

return UINActCommonHardLevelItem
