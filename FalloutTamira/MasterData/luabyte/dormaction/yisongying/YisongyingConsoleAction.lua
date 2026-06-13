local YisongyingConsoleAction = BaseClass("YisongyingConsoleAction")
local M = YisongyingConsoleAction
local tInsert = table.insert

function M:__init(csfurnitureDatas)
    self:ConvertData(csfurnitureDatas)
    self.dormAction = DormActionMgr:GetInstance():GetCurrentDormAction()
    self.consoleData = self:GetConsoleData()
    self.bookCaseData = self:GetBookCaseData()
    self.OnRoleClickEventHandle = Bind(self, self.RoleClickEventHandle)
    IGameEventMgr:RegisterEventHandleByTypeName("DormRoleClickEvent", self.OnRoleClickEventHandle)
    self.dormAction.state = DormConst.RoleState.Command
    self:RootFuriture()
end

--判断角色是否在与当前家具交互
function M:CheckConsoleRoleIn()
    if DormHelper.CheckIsMoving() then
        return false
    else
        if self.consoleData then
            self.curFurnitureId = DormHelper.GetCurrentFurnitureId()
            return self.curFurnitureId == self.consoleData.Id
        else
            return false
        end
    end
end

function M:CheckBookCaseRoleIn()
    if DormHelper.CheckIsMoving() then
        return false
    else
        if self.bookCaseData then
            self.curFurnitureId = DormHelper.GetCurrentFurnitureId()
            return self.curFurnitureId == self.bookCaseData.Id
        else
            return false
        end
    end
end

function M:HeroId()
    return self.dormAction.module.heroId
end

function M:GetFurniture(id)
    return self.dormAction.module:GetFurniture(id)
end

--转换家具数据
function M:ConvertData(data)
    local len = data.Length
    self.furnitureDatas = {}
    
    for i = 0, len - 1 do
        local item = data[i]
        
        if item.FurnitureName then
            local assetData = DormHelper.GetFurnitureAssetDataByName(item.FurnitureName)
            tInsert(self.furnitureDatas, assetData)
        end
    end
end

function M:GetConsoleData()
    return MapUtil.Find(self.furnitureDatas, function(v)
        local cfg = ConfigHelper.GetCfgByLua("houseFurniture", v.TemplateId)
        return cfg.type == DormConst.FurnitureType.Console
    end)
end

function M:GetBookCaseData()
    return MapUtil.Find(self.furnitureDatas, function(v)
        local cfg = ConfigHelper.GetCfgByLua("houseFurniture", v.TemplateId)
        return cfg.type == DormConst.FurnitureType.BookCase
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

--邀请少女来控制台回调
function M:InviteGirlCallBack()
    if self:CheckBookCaseRoleIn() then
        self.curFuritureData = DormHelper.GetCurrentFurnitureData()
        DormHelper.PlayAction(self.curFuritureData, "Common_Sit_Player1_TurnLeftToPlayer2_Show")
    end
end

--角色点击事件
function M:RoleClickEventHandle(handler)
    if  self.dormAction.module.specialEventId then
        return
    end

    if self.dormAction.isCalling then
        return
    end

    --操作台点击角色
    if self:CheckConsoleRoleIn() then
        if self.dormAction.state == DormConst.RoleState.Command then
            if handler.rolePointType == DormConst.RolePointType.Player1 and handler.actionType == DormConst.RoleActionType.Enter then
                return
            end
            --进入交互状态
            self.dormAction:EnterInteract()
            local actionName = 'Common_Sit_Player2_TurnLeftToPlayer1_Show'
            if handler.rolePointType == DormConst.RolePointType.Player2 or
                handler.rolePointType == DormConst.RolePointType.NavMesh1 then
                self.curFuritureData = DormHelper.GetCurrentFurnitureData()
                DormHelper.PlayAction(self.curFuritureData, actionName)
            end
            return
        end

        if self.dormAction.state == DormConst.RoleState.Interact then
            if handler.actionName == "Common_Sit_Player1_Idle_Stay" or handler.actionName == "" or handler.actionName == "Common_Move_Player1_Idle_Stay" 
                or handler.actionName == "Common_Move_Player1_Sit_Stay" then
                DormHelper.SetRandomShow(false)
                self.curFuritureData = DormHelper.GetCurrentFurnitureData()
                self.dormAction:PlayRandomClick(DormConst.FurnitureType.Console, 0, self.curFuritureData)
            end
        end
    end

    --书柜点击角色
    if self:CheckBookCaseRoleIn() then
        if self.dormAction.state == DormConst.RoleState.Command then
            if handler.rolePointType == DormConst.RolePointType.Player1 and handler.actionType == DormConst.RoleActionType.Enter then
                return
            end
            --进入交互状态
            self.dormAction:EnterInteract()
            if handler.rolePointType == DormConst.RolePointType.Player1 or
                handler.rolePointType == DormConst.RolePointType.NavMesh1 then
                self.curFuritureData = DormHelper.GetCurrentFurnitureData()
                local actionName = 'Common_Stand_Player1_TurnRightToPlayer2_Show'
                DormHelper.PlayAction(self.curFuritureData, actionName)
            end

            if handler.rolePointType == DormConst.RolePointType.Player2 then
            self.curFuritureData = DormHelper.GetCurrentFurnitureData()
            local actionName = 'Common_Stand_Player2_Idle_Stay'
            DormHelper.PlayAction(self.curFuritureData, actionName)
            end
            return
        end

        if self.dormAction.state == DormConst.RoleState.Interact then
            if handler.actionName == "Common_Stand_Player2_Idle_Stay" or handler.actionName == "" then
                DormHelper.SetRandomShow(false)
                self.curFuritureData = DormHelper.GetCurrentFurnitureData()
                self.dormAction:PlayRandomClick(DormConst.FurnitureType.BookCase, 0, self.curFuritureData)
            end
        end
    end
end

function M:ExitInteract()
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

return YisongyingConsoleAction
