local AnxixiangDiaryAction = BaseClass("AnxixiangDiaryAction")
local M = AnxixiangDiaryAction

function M:__init(furnitureId, parentAction)
    self.furnitureId = furnitureId
    self.parentAction = parentAction
    self.heroId = self.parentAction:HeroId()
    self.OnClickEventHandle = Bind(self, self.DormClickFurnitureSlotEventHandle)
    self.furniture = self.parentAction.dormAction.module:GetFurniture(self.furnitureId)
    IGameEventMgr:RegisterEventHandleByTypeName("DormClickFurnitureSlotEvent", self.OnClickEventHandle)
    self.actioning = false
end

function M:DormClickFurnitureSlotEventHandle(handler)
    --布置家具时忽略点击
    if self.parentAction.dormAction.state == DormConst.RoleState.Command or self.parentAction.dormAction.state == DormConst.RoleState.Interact then
        if handler.slotAssetData and handler.slotAssetData.Id == self.furnitureId then
            self:OnClickAction()
        end
    end
end

function M:OnClickAction()
    if self.furniture then
        if  self.actioning == false then
            self.actioning = true
            self.furniture:PlayClickAnimation(function ()
                self.actioning = false
                self:OpenBenzoinBook()
            end)
        end
    end
end

function M:OpenBenzoinBook()
    local studioData = IRoleStudioHeroDataMgr:GetRoleStudioDataById(self.heroId)
    local level = studioData:GetFavorLevel()
    UIContextMgr:GetInstance():Show("BenzoinBook", self.heroId, level)
end

function M:Dispose()
    self.actioning = false
    IGameEventMgr:UnRegisterEventHandleByTypeName("DormClickFurnitureSlotEvent", self.OnClickEventHandle)
end

return AnxixiangDiaryAction
