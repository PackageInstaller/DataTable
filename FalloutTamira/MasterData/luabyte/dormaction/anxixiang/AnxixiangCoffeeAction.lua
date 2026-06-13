local AnxixiangCoffeeAction = BaseClass("AnxixiangCoffeeAction")
local M = AnxixiangCoffeeAction

function M:__init(furnitureId, parentAction)
    self.furnitureId = furnitureId
    self.parentAction = parentAction
    self.OnClickEventHandle = Bind(self, self.OnClickFurnitureEventHandle)
    IGameEventMgr:RegisterEventHandleByTypeName("DormClickFurnitureSlotEvent", self.OnClickEventHandle)
end

function M:OnClickFurnitureEventHandle(handler)
    --布置家具时忽略点击
    if self.parentAction.dormAction.state == DormConst.RoleState.DressUp then
        return 
    end
    
    if handler.slotAssetData and handler.slotAssetData.Id == self.furnitureId then
        if not self.parentAction:CheckRoleIn() then
            self:OnClickAction()
            return 
        end
        
        local actioncfg = DormHelper.GetAction(self.parentAction.dormAction.heroId, DormConst.ActionType.SofaCoffeeAction, DormConst.FurnitureType.MainSofa, 215003)
        
        if actioncfg then
            self.curFuritureData = DormHelper.GetCurrentFurnitureData()
            
            if not IsNull(self.curFuritureData) then
                DormHelper.PlayAction(self.curFuritureData, actioncfg.name)
            end
        end
    end
end

function M:OnClickAction()
    local furniture = self.parentAction:GetFurniture(self.furnitureId)
    
    if furniture then
        furniture:PlayClickAnimation()
    end
end

function M:Dispose()
    IGameEventMgr:UnRegisterEventHandleByTypeName("DormClickFurnitureSlotEvent", self.OnClickEventHandle)
end


return AnxixiangCoffeeAction
