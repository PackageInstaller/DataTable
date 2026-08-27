local UIActXMas22DunRepeatItem = class("UIActXMas22DunRepeatItem", UIBaseNode)
local base = UIActXMas22DunRepeatItem

function UIActXMas22DunRepeatItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.item, self, self.OnClickChallenge)
end

function UIActXMas22DunRepeatItem:InitXMas22ChallengeItem(dungeonLevelData, callback)
  self._dungeonLevelData = dungeonLevelData
  self._callback = callback
  self.ui.tex_Name.text = dungeonLevelData:GetDungeonLevelName()
  self.ui.tex_Num.text = dungeonLevelData:GetDungeonIndex()
  self:__Refresh()
end

function UIActXMas22DunRepeatItem:__Refresh()
  local idx = self._dungeonLevelData:GetDungeonIndex()
  if idx % 2 == 0 then
    self.ui.tex_kuang.transform:SetParent(self.ui.textPosUp.transform)
  else
    self.ui.tex_kuang.transform:SetParent(self.ui.textPosDown.transform)
  end
  self.ui.tex_kuang.transform.anchoredPosition = Vector2.zero
  local isLock = not self._dungeonLevelData:GetIsLevelUnlock()
  self.ui.obj_Lock:SetActive(isLock)
  self.ui.img_icon:SetActive(not isLock)
  if isLock then
    self.ui.tex_Num.color = self.ui.lockColor
    self.ui.tex_kuang.color = self.ui.lockColor
    self.ui.obj_Clear:SetActive(false)
    return
  else
    self.ui.tex_Num.color = self.ui.unlockColor
    self.ui.tex_kuang.color = self.ui.unlockColor
  end
  local isComplect = 0 < PlayerDataCenter:GetTotalBattleTimes(self._dungeonLevelData:GetDungeonLevelStageId())
  self.ui.obj_Clear:SetActive(isComplect)
end

function UIActXMas22DunRepeatItem:OnClickChallenge()
  if self._callback ~= nil then
    self._callback(self._dungeonLevelData)
  end
end

return UIActXMas22DunRepeatItem
