local base = UIBaseNode
local UINCardSetRewindItem = class("UINCardSetRewindItem", base)

function UINCardSetRewindItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
end

function UINCardSetRewindItem:SetCardSetRewindItemSprite(scoreSprite)
  self.ui.img_ExIcon.sprite = scoreSprite
  self.ui.img_BaseIcon.sprite = scoreSprite
end

function UINCardSetRewindItem:SetCardSetRewindItemFunc(clickFunc)
  self._clickFunc = clickFunc
end

function UINCardSetRewindItem:InitCardSetRewindItem(rewindData, inProgress, selected)
  self._rewindData = rewindData
  self.ui.tex_Round.text = tostring(rewindData.roundId)
  self.ui.tex_ExPoint.text = tostring(rewindData.score)
  self.ui.tex_BasePoint.text = tostring(rewindData.baseScore)
  self.ui.obj_NowTag:SetActive(inProgress)
  self:SetCardSetRewindItemSelected(selected)
end

function UINCardSetRewindItem:SetCardSetRewindItemSelected(selected)
  self.ui.cg.alpha = selected and 1 or 0.7
  self.ui.root.localScale = selected and Vector3.one or Vector3.Temp(0.88, 0.88, 0.88)
end

function UINCardSetRewindItem:_OnClickRoot()
  if self._clickFunc ~= nil then
    self._clickFunc(self, self._rewindData)
  end
end

function UINCardSetRewindItem:OnDelete()
  base.OnDelete(self)
end

return UINCardSetRewindItem
