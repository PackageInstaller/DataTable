local AnxixiangSofaAction = BaseClass("AnxixiangSofaAction")
local M = AnxixiangSofaAction

function M:__init(furnitureId, parentAction)
    self.furnitureId = furnitureId
    self.curFurnitureId = DormHelper.GetCurrentFurnitureId()
    self.curFuritureData = DormHelper.GetCurrentFurnitureData()
    self.parentAction = parentAction
    self.OnClickEventHandle = Bind(self, self.ClickCallBack)
    IGameEventMgr:RegisterEventHandleByTypeName("DormClickFurnitureSlotEvent", self.OnClickEventHandle)
end

function M:ClickCallBack(handler)
    --布置家具时忽略点击
    -- if self.parentAction.dormAction.state == DormConst.RoleState.Command then
    --     if handler.slotAssetData and handler.slotAssetData.Id == self.furnitureId then
    --         UIContextMgr:GetInstance():Show("GamesLoginUI")
    --     end
    -- end
end

function M:Dispose()
    IGameEventMgr:UnRegisterEventHandleByTypeName("DormClickFurnitureSlotEvent", self.OnClickEventHandle)
end


return AnxixiangSofaAction
