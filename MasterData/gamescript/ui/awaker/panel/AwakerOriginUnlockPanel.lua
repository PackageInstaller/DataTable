local AwakerOriginUnlockPanel, Super = System.NewClass("AwakerOriginUnlockPanel", UIBasePanel)
AwakerOriginUnlockPanel.uiResCls = UI_Awaker_Item_Origin_TipResource

function AwakerOriginUnlockPanel:ctor(awakerId)
  Super.ctor(self)
  self.awakerId = awakerId
end

function AwakerOriginUnlockPanel:OnBind(binder)
  self.binder = binder
  local list = {}
  local awakerCfg = DT.AwakerConfig[self.awakerId]
  local unlockItemList = awakerCfg.UnlockOriginalFormItem
  if unlockItemList then
    for i = 1, #unlockItemList, 2 do
      local itemId = unlockItemList[i]
      local costCnt = unlockItemList[i + 1]
      local itemData = {itemId = itemId, useCnt = costCnt}
      table.insert(list, itemData)
    end
  end
  local layout = self.ui.Content:GetComponent(typeof(CS.UnityEngine.UI.HorizontalLayoutGroup))
  self.binder:BindToCircularListView(self.ui.ScrollView, function()
    return list
  end, function(_, go, index)
    binder:BindComponent(AwakerOriginUnlockMaterialItem(go, list[index]))
    if #list == index then
      layout.enabled = true
    else
      layout.enabled = false
    end
  end)
  binder:BindZ1Button(self.ui.Btn_Cancel, function()
    self:Close()
  end, function()
    return CommonDefine.BtnType.High
  end)
  binder:BindZ1Button(self.ui.Btn_Confirm, function()
    self:OnUnlockOriginShape()
  end)
end

function AwakerOriginUnlockPanel:OnUnlockOriginShape()
  ProtoManager.Instance:ReqServer("GameRequest", "OnUnlockOriginShape", function()
    self:Close()
    EventMgr.Instance.UnlockAwakerOriginEvent:Dispatch()
  end, function(_, code)
  end, self.awakerId)
end

return AwakerOriginUnlockPanel
