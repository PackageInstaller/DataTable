local PublicKeyWordTipItem, Super = System.NewComponent("PublicKeyWordTipItem")

function PublicKeyWordTipItem:ctor(uiNode, maskNode, desc)
  Super.ctor(self)
  self.ui = Func_Public_Keyword_TipResource(uiNode)
  self.maskNode = maskNode
  self.desc = desc
end

function PublicKeyWordTipItem:OnBind(binder)
  self.binder = binder
  self.model = binder:createModel(PublicKeyWordTipItemModel, self.desc)
  binder:BindToText(self.ui.Text_Public_Keyword_Desc, function()
    return self.model.desc
  end)
end

function PublicKeyWordTipItem:SetItemPos2(pos)
  local sizeDelta = self.ui.uiNode.transform.sizeDelta
  local halfWidth, halfHeight = sizeDelta.x * 0.5, sizeDelta.y * 0.5
  local uiTransform = self.ui.uiNode.transform.parent
  local uiPos = uiTransform:InverseTransformPoint(pos)
  local tipsX = uiPos.x + halfWidth - 105
  local tipsY = uiPos.y - halfHeight - 70
  local itemPos = CS.UnityEngine.Vector3(tipsX, tipsY, pos.z)
  self.ui.uiNode.transform.localPosition = itemPos
end

function PublicKeyWordTipItem:OnMaskClicked()
  self.binder:teardown()
end

return PublicKeyWordTipItem
