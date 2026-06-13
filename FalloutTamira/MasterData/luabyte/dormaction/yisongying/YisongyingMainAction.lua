local YisongyingMainAction = BaseClass("YisongyingMainAction")
local M = YisongyingMainAction
local tInsert = table.insert

function M:__init(csfurnitureDatas)
    self:ConvertData(csfurnitureDatas)
    self.dormAction = DormActionMgr:GetInstance():GetCurrentDormAction()
    self.mainData = self:GetMainData()
    self.OnRoleClickEventHandle = Bind(self, self.RoleClickEventHandle)
    IGameEventMgr:RegisterEventHandleByTypeName("DormRoleClickEvent", self.OnRoleClickEventHandle)
    self.dormAction.state = DormConst.RoleState.Command
    self:RootFuriture()
end

function M:CheckRoleIn()
    if DormHelper.CheckIsMoving() then
        return false
    else
        self.curFuritureName = DormHelper.GetCurrentFurnitureName()
        return self.curFuritureName == "Main"
    end
end

function M:HeroId()
    return self.dormAction.module.heroId
end

function M:ConvertData(data)
    local len = data.Length
    self.furnitureDatas = {}
    
    for i = 0, len - 1 do
        local item = data[i]
        
        if item.FurnitureName then
            tInsert(self.furnitureDatas, item)
        end
    end
end

function M:GetMainData()
    return MapUtil.Find(self.furnitureDatas, function(v)
        local FurnitureName = v.FurnitureName
        return FurnitureName == "Home01_Furniture_Main"
    end)
end

function M:RootFuriture()
    if self.soltFurniture then
        for k, v in pairs(self.soltFurniture) do
            v:Dispose()
        end
    end
    
    self.soltFurniture = {}
    
    for k, v in pairs(self.furnitureDatas) do
        self:BranchFuriture(v.Id)
    end
end

function M:BranchFuriture(dormId)
    local parents = self.dormAction.module:GetSlotFurnituresById(dormId)
    
    for k, v in pairs(parents) do
        local config = MapUtil.Find(SlotFurnitureActionConfig, function(c)
            return c.templateId == v.TemplateId and (c.heroId == self.dormAction.heroId or c.heroId == 0)
        end)
        
        if config then
            tInsert(self.soltFurniture, require(config.dormaction).New(v.id, self))
        end
    end
end

function M:RoleClickEventHandle(handler)
    if  self.dormAction.module.specialEventId then
        return
    end

    if self.dormAction.isCalling then
        return
    end

    if self:CheckRoleIn() then
        if self.dormAction.state == DormConst.RoleState.Command then
            --进入交互状态
            self.dormAction:EnterInteract()
            local actionName = 'Common_Stand_Player1_Idle_Stay'
            self.curFuritureData = DormHelper.GetCurrentFurnitureData()
            DormHelper.PlayAction(self.curFuritureData, actionName)
            return
        end

        if self.dormAction.state == DormConst.RoleState.Interact then
            if handler.actionName == "Common_Stand_Player1_Idle_Stay" or handler.actionName == "" then
                DormHelper.SetRandomShow(false)
                self.curFuritureData = DormHelper.GetCurrentFurnitureData()
                self.dormAction:PlayRandomClick(DormConst.FurnitureType.DefaultStandPoint, 0, self.curFuritureData)
            end
        end
    end
end

function M:Dispose()
    if self.soltFurniture then
        for k, v in pairs(self.soltFurniture) do
            v:Dispose()
        end
        
        self.soltFurniture = nil
    end
    
    IGameEventMgr:UnRegisterEventHandleByTypeName("DormRoleClickEvent", self.OnRoleClickEventHandle)
end

return YisongyingMainAction
