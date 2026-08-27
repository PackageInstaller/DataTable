local UINActSum22DunRepeatItem = class("UINActSum22DunRepeatItem", UIBaseNode)
local base = UINActSum22DunRepeatItem

function UINActSum22DunRepeatItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.item, self, self.OnClickChallenge)
end

function UINActSum22DunRepeatItem:InitSum22ChallengeItem(dungeonLevelData, callback)
  self._dungeonLevelData = dungeonLevelData
  self._callback = callback
  self.ui.tex_Stage:SetIndex(0, tostring(dungeonLevelData:GetDungeonIndex()))
  self.ui.tex_Name.text = dungeonLevelData:GetDungeonLevelName()
  self:__Refresh()
end

function UINActSum22DunRepeatItem:__Refresh()
  local isLock = not self._dungeonLevelData:GetIsLevelUnlock()
  self.ui.obj_image:SetActive(not isLock)
  self.ui.lock:SetActive(isLock)
  if isLock then
    self.ui.img_Title.color = self.ui.color_title_nor
    self.ui.img_Clear:SetActive(false)
    local color = self.ui.img_Bottom.color
    color.a = 0.1
    self.ui.img_Bottom.color = color
    self.ui.tex_Stage.text.color = self.ui.color_title_nor
    self.ui.img_Dot.color = self.ui.color_title_nor
    return
  end
  local isComplect = PlayerDataCenter:GetTotalBattleTimes(self._dungeonLevelData:GetDungeonLevelStageId()) > 0
  self.ui.img_Clear:SetActive(isComplect)
  self.ui.img_Title.color = self.ui.color_title_cpl
end

function UINActSum22DunRepeatItem:OnClickChallenge()
  if self._callback ~= nil then
    self._callback(self._dungeonLevelData)
  end
end

function UINActSum22DunRepeatItem:OnClickSelectDungeon()
  if self._callback ~= nil then
    self._callback(self._dungeonLevelData)
  end
end

function UINActSum22DunRepeatItem:GetSum22ChallengeItemCanvasGroup()
  return self.ui.cvsGrp
end

return UINActSum22DunRepeatItem
