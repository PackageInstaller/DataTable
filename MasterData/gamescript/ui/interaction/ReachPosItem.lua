local ReachPosItem, Super = System.NewComponent("ReachPosItem")

function ReachPosItem:ctor(res, keyId, uiPath, tipId)
  Super.ctor(self)
  self.ui = Item_MainScene_TransmitResource(res)
  self.keyId = Vue.ref(keyId)
  self.uiPath = Vue.ref(uiPath)
  self.tipId = Vue.ref(tipId)
end

function ReachPosItem:OnBind(binder)
  binder:BindToText(self.ui.Text_Name, function()
    return DT.TipConfig[self.tipId.value].Text
  end)
  binder:BindToImage(self.ui.Image_Icon, function()
    return self.uiPath.value
  end)
  binder:BindButtonClick(self.ui.uiNode, function()
    Logger.Debug("Reach keyId == %s", self.keyId.value)
    EventMgr.Instance.ReachPos:Dispatch(self.keyId.value)
  end)
end

return ReachPosItem
