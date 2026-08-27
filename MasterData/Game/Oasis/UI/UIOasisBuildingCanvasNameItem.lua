local UIOasisBuildingCanvasNameItem = class("UIOasisBuildingCanvasNameItem", UIBaseNode)
local base = UIBaseNode
local cs_tweening = CS.DG.Tweening

function UIOasisBuildingCanvasNameItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIOasisBuildingCanvasNameItem:InitCanvasNameItem(id, UIbulidData, isTop)
  self.id = id
  self.ui.tex_Name.text = UIbulidData.name
  self.ui.tex_NameEditor.text = UIbulidData.name
  self:UpdateBuildingLevel(UIbulidData.level)
  self:ShowBuildName3dTop(isTop)
  self:BuildName3dCanLevelUp(UIbulidData.canLvUp)
end

function UIOasisBuildingCanvasNameItem:Split(flowRoot, bg1Root, bg2Root, arrowBgRoot, text1Root, text2Root)
  self.ui.bg.transform:SetParent(bg1Root)
  self.ui.canLevelUp.transform:SetParent(bg1Root)
  self.ui.bgEditor:SetParent(bg2Root)
  self.ui.arrowBg:SetParent(arrowBgRoot)
  self.ui.Flow:SetParent(flowRoot)
  self.ui.img_BLN.transform:SetParent(bg1Root)
  self.ui.tex_Name.transform:SetParent(text1Root)
  self.ui.tex_NameEditor.transform:SetParent(text1Root)
  self.ui.texLevelUp:SetParent(text1Root)
  self.ui.tex_Level.transform:SetParent(text2Root)
end

function UIOasisBuildingCanvasNameItem:ShowBuildName3dTop(isTop)
  self.isTop = isTop
  self.ui.bg.gameObject:SetActive(not isTop)
  self.ui.canLevelUp.gameObject:SetActive(not isTop)
  self.ui.tex_Name.gameObject:SetActive(not isTop)
  self.ui.texLevelUp.gameObject:SetActive(not isTop)
  self.ui.Flow.gameObject:SetActive(not isTop)
  self.ui.img_BLN.gameObject:SetActive(not isTop)
  self.ui.tex_Level.gameObject:SetActive(not isTop)
  self:__RefreshLvUpState()
  self.ui.bgEditor.gameObject:SetActive(isTop)
  self.ui.tex_NameEditor.gameObject:SetActive(isTop)
end

function UIOasisBuildingCanvasNameItem:BuildName3dCanLevelUp(canLvUp)
  self.canLvUp = canLvUp
  self:__RefreshLvUpState()
end

function UIOasisBuildingCanvasNameItem:__RefreshLvUpState()
  local show = self.canLvUp and not self.isTop and self.active
  self.ui.arrowBg.gameObject:SetActive(show)
  if show then
    if self._arrowTween == nil then
      self._arrowTween = self.ui.arrow:DOPunchPosition(Vector3.New(0, 6, 0), 1, 1):SetLoops(-1)
    end
    if self._blnTween == nil then
      self._blnTween = self.ui.img_BLN:DOFade(0, 1.5):SetLoops(-1, cs_tweening.LoopType.Yoyo)
    end
  else
    self:_ClearArrowTween()
    self:_ClearBLNTween()
  end
  self.ui.texLevelUp.gameObject:SetActive(show)
  self.ui.canLevelUp.gameObject:SetActive(show)
  self.ui.Flow.gameObject:SetActive(show)
  self.ui.img_BLN.gameObject:SetActive(show)
end

function UIOasisBuildingCanvasNameItem:_ClearArrowTween()
  if self._arrowTween ~= nil then
    self._arrowTween:Rewind()
    self._arrowTween:Kill()
    self._arrowTween = nil
  end
end

function UIOasisBuildingCanvasNameItem:_ClearBLNTween()
  if self._blnTween ~= nil then
    self._blnTween:Rewind()
    self._blnTween:Kill()
    self._blnTween = nil
  end
end

function UIOasisBuildingCanvasNameItem:UpdateNamePos(position)
  self.transform.position = position
end

function UIOasisBuildingCanvasNameItem:UpdateBuildingLevel(level)
  local isUnits = level <= 9
  local strLevel = tostring(level)
  if isUnits then
    strLevel = "0" .. strLevel
  end
  self.ui.tex_Level:SetIndex(0, strLevel)
end

function UIOasisBuildingCanvasNameItem:OnRecycle()
  self.id = nil
  self.transform.localScale = Vector3.zero
  self:_ClearArrowTween()
  self:_ClearBLNTween()
end

function UIOasisBuildingCanvasNameItem:OnShow()
  self:ShowBuildName3dTop(self.isTop)
end

function UIOasisBuildingCanvasNameItem:OnHide()
  self.ui.bg.gameObject:SetActive(false)
  self.ui.canLevelUp.gameObject:SetActive(false)
  self.ui.arrowBg.gameObject:SetActive(false)
  self.ui.tex_Name.gameObject:SetActive(false)
  self.ui.texLevelUp.gameObject:SetActive(false)
  self.ui.Flow.gameObject:SetActive(false)
  self.ui.img_BLN.gameObject:SetActive(false)
  self.ui.tex_Level.gameObject:SetActive(false)
  self.ui.bgEditor.gameObject:SetActive(false)
  self.ui.tex_NameEditor.gameObject:SetActive(false)
end

function UIOasisBuildingCanvasNameItem:OnDelete()
  self.ui.bg.transform:SetParent(self.ui.normal.transform)
  self.ui.arrowBg:SetParent(self.ui.normal.transform)
  self.ui.tex_Name.transform:SetParent(self.ui.normal.transform)
  self.ui.Flow:SetParent(self.ui.normal.transform)
  self.ui.img_BLN.transform:SetParent(self.ui.normal.transform)
  self.ui.tex_Level.transform:SetParent(self.ui.normal.transform)
  self.ui.texLevelUp:SetParent(self.ui.normal.transform)
  self.ui.bgEditor:SetParent(self.ui.editor.transform)
  self.ui.tex_NameEditor.transform:SetParent(self.ui.editor.transform)
  self:_ClearArrowTween()
  self:_ClearBLNTween()
  base.OnDelete(self)
end

return UIOasisBuildingCanvasNameItem
