local AwakerAttrTip, Super = System.NewClass("AwakerAttrTip", UIBasePanel)
AwakerAttrTip.uiResCls = Awaker_Common_Attr_TipResource

function AwakerAttrTip:ctor(attrId)
  Super.ctor(self)
  self.attrId = attrId
end

function AwakerAttrTip:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.mask, System.fn(self, self.OnBtnClose))
  if self.attrId then
    local tbl = DT.ActorAttrType[self.attrId]
    self:SetName(tbl.Text)
    self:SetDesc(tbl.AttributeDesc)
  end
end

function AwakerAttrTip:OnBtnClose()
  self:Close()
end

function AwakerAttrTip:SetName(name)
  self.binder:SetText(self.ui.Text_Attr_Tips_Name, name)
end

function AwakerAttrTip:SetDesc(desc)
  self.binder:SetText(self.ui.Text_Attr_Tips_Desc, desc)
end

function AwakerAttrTip:ResetPosition(worldPos)
  local trans = self.ui.Node:GetComponent(typeof(CS.UnityEngine.RectTransform))
  local pos = CS.Framework.UIUtilTool.ConvertUIWorldPosToLocalPos(worldPos, trans.parent, UIRootMgr.GetUICamera())
  trans.anchoredPosition = pos
end

return AwakerAttrTip
