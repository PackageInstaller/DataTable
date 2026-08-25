local WorldStageMimiMapItem, Super = System.NewComponent("WorldStageMimiMapItem")

function WorldStageMimiMapItem:ctor(res, itemData)
  self.ui = UI_Dbgcopy_Item_Event_NodeResource(res)
  self.itemData = itemData
end

function WorldStageMimiMapItem:OnBind(binder)
  self.binder = binder
  self.ui.Group_Arrow:SetActive(self.itemData.isDoing)
  self.ui.Group_Done:SetActive(self.itemData.isFinish)
  local nodeType = self.itemData.eventData[1]
  local nodeId = self.itemData.eventData[2]
end

function WorldStageMimiMapItem:OnUnbind()
end

return WorldStageMimiMapItem
