local UILogicPreviewNodeBase = class("UILogicPreviewNodeBase", UIBaseNode)
local base = UIBaseNode
local UINLogicPreviewAttrItemBase = require("Game.CommonUI.LogicPreviewNode.UINLogicPreviewAttrItemBase")
local UINLogicPreviewRowBase = require("Game.CommonUI.LogicPreviewNode.UINLogicPreviewRowBase")

function UILogicPreviewNodeBase:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Bg, self, self._OnClickClose)
end

function UILogicPreviewNodeBase:InitWithClass(headAttrClass, rowItemClass)
  headAttrClass = headAttrClass or UINLogicPreviewAttrItemBase
  rowItemClass = rowItemClass or UINLogicPreviewRowBase
  if self.ui.tex_HeadAttri ~= nil then
    self.ui.tex_HeadAttri:SetActive(false)
  end
  if self.ui.tex_HeadAttri ~= nil then
    self.headAttrPool = UIItemPool.New(headAttrClass, self.ui.tex_HeadAttri)
  end
  self.ui.rowItem:SetActive(false)
  self.rowItemPool = UIItemPool.New(rowItemClass, self.ui.rowItem)
end

function UILogicPreviewNodeBase:_Close()
  self:Hide()
end

function UILogicPreviewNodeBase:_OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UILogicPreviewNodeBase:OnShow()
  base.OnShow(self)
  AudioManager:PlayAudioById(1067)
end

function UILogicPreviewNodeBase:OnHide()
  AudioManager:PlayAudioById(1068)
  base.OnHide(self)
end

function UILogicPreviewNodeBase:OnDelete()
  if self.headAttrPool ~= nil then
    self.headAttrPool:DeleteAll()
  end
  self.rowItemPool:DeleteAll()
  base.OnDelete(self)
end

return UILogicPreviewNodeBase
