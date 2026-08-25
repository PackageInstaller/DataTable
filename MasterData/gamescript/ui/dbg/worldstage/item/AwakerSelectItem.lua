local AwakerSelectItem, Super = System.NewComponent("AwakerSelectItem")

function AwakerSelectItem:ctor(uiNode, awakerData, index, callFunc)
  Super.ctor(self)
  self.ui = UI_Dbgcopy_Item_Select_WakeResource(uiNode)
  self.userData = awakerData
  self.callback = callFunc
  self.index = index
end

function AwakerSelectItem:OnBind(binder)
  self.binder = binder
  local awaker = self.userData
  local curSkin = awaker.curSkin
  local paintingPath = DT.AwakerConfig[awaker.tid].AwakeList
  local skinResNum = AwakerSkinUtils.GetSkinResNum(curSkin)
  binder:SetImage(self.ui.Image_Awaker, AwakerDataUtils.ReplaceSkinRes(paintingPath, awaker.tid, skinResNum))
  binder:BindButtonClick(self.ui.Btn_Click, function()
    if self.callback then
      self.callback(awaker.uid, self.index)
    end
  end)
end

function AwakerSelectItem:SetSelectedCancelable(cancelable)
  if self.ui.Btn_Selected then
    local compImage = self.ui.Btn_Selected:GetComponent(typeof(CS.UnityEngine.UI.Image))
    if compImage then
      compImage.raycastTarget = not cancelable
    end
  end
end

function AwakerSelectItem:SetSelected(state)
  self.isSelect = state
  self.binder:SetActive(self.ui.Btn_Selected, state)
end

return AwakerSelectItem
