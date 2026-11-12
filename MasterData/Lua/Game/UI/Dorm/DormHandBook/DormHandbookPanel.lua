local DormHandbookPanel = class("DormHandbookPanel", BasePanel)
DormHandbookPanel._bIsMainPanel = false
DormHandbookPanel._tbDefine = {
  {
    sPrefabPath = "Dorm/DormHandBookPanel.prefab",
    sCtrlName = "Game.UI.Dorm.DormHandBook.DormHandbookCtrl"
  }
}

function DormHandbookPanel:Awake()
  self.mapDormSuitData = {}
  
  local function forEachLayoutFurniture(mapData)
    if self.mapDormSuitData[mapData.RoomLayoutId] == nil then
      self.mapDormSuitData[mapData.RoomLayoutId] = {}
    end
    table.insert(self.mapDormSuitData[mapData.RoomLayoutId], {
      FurnitureId = mapData.FurnitureId,
      X = mapData.Pos[1],
      Y = mapData.Pos[2],
      Z = mapData.Pos[3],
      Rotation = mapData.Rot
    })
  end
  
  ForEachTableLine(DataTable.DormRoomLayout, forEachLayoutFurniture)
end

function DormHandbookPanel:OnEnable()
end

function DormHandbookPanel:OnAfterEnter()
end

function DormHandbookPanel:OnDisable()
end

function DormHandbookPanel:OnDestroy()
end

function DormHandbookPanel:OnRelease()
end

return DormHandbookPanel
