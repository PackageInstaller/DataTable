local base = UIBaseNode
local UINSteGtRepeatItem = class("UINSteGtRepeatItem", base)

function UINSteGtRepeatItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self._OnClickDunItem)
end

function UINSteGtRepeatItem:InitSteGtRepeatItem(dungeonlLevel, index, callback)
  self._dungeonlLevel = dungeonlLevel
  self._callback = callback
  self.ui.tex_Num:SetIndex(0, string.format("%2d", index))
  self.ui.tex_QuestName.text = self._dungeonlLevel:GetDungeonLevelName()
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(self._dungeonlLevel:GetSpecialUnlockInfo())
  local unlock = self._dungeonlLevel:GetIsLevelUnlock()
  self.ui.img_Bottom:SetIndex(unlock and 0 or 1)
  self.ui.obj_Lock:SetActive(not unlock)
  self.ui.img_QuestNameBg.gameObject:SetActive(unlock)
  self.ui.tex_Num.text.color = self.ui.color_num[unlock and 1 or 2]
end

function UINSteGtRepeatItem:_OnClickDunItem()
  if self._callback ~= nil then
    self._callback(self._dungeonlLevel, self)
  end
end

function UINSteGtRepeatItem:PlaySteGtRepeatItemAnim()
  if IsNull(self.ui.canvasGroup) then
    return
  end
  self:__StopAnim()
  self.ui.canvasGroup:DOFade(0, 0.4):From():SetDelay(0.15):SetLink(self.gameObject)
  self.transform:DOLocalMoveX(25, 0.4):From():SetDelay(0.15):SetLink(self.gameObject)
end

function UINSteGtRepeatItem:__StopAnim()
  if IsNull(self.ui.canvasGroup) then
    return
  end
  self.ui.canvasGroup:DOComplete()
  self.transform:DOComplete()
end

function UINSteGtRepeatItem:OnDelete()
  self:__StopAnim()
  base.OnDelete(self)
end

return UINSteGtRepeatItem
