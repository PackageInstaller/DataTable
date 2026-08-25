local WorldStageMimiMap, Super = System.NewComponent("WorldStageMimiMap")

function WorldStageMimiMap:ctor(res, stageGroupId)
  self.ui = UI_Dbgcopy_Item_Mini_MapResource(res)
  self.stageGroupId = stageGroupId
  self.stageData = WorldStageManager.Instance:GetStageData(stageGroupId)
end

function WorldStageMimiMap:OnBind(binder)
  local nodeList = self.stageData.nodeList
  local nodeIndex = self.stageData.nodeIndex
  binder:BindCenterListView(self.ui.ScrollView_Event_Node, function()
    return nodeList
  end, function()
    return "UI_Dbgcopy_Item_Event_Node"
  end, function(itemBinder, item, index)
    local itemData = {}
    itemData.eventData = nodeList[index]
    itemData.isFinish = index < nodeIndex
    itemData.isDoing = index == nodeIndex
    itemBinder:BindComponent(WorldStageMiniMapItem(item, itemData))
  end)
  Logger.Info("center index ==> ", nodeIndex)
  binder:CenterListScrollTo(self.ui.ScrollView_Event_Node, 0 == nodeIndex and 1 or nodeIndex)
end

function WorldStageMimiMap:OnUnbind()
end

return WorldStageMimiMap
