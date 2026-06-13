local YisongyingDormAction = BaseClass("YisongyingDormAction", require("DormAction.BaseDormAction"))
local M = YisongyingDormAction

function M:Init()
    self.OnRoleClickEventHandle = Bind(self, self.RoleClickEventHandle)
    self.OnDormClickFurnitureEventHandle = Bind(self, self.DormClickFurnitureEventHandle)
    self.DormClickFurnitureSlotEventHandle = Bind(self, self.DormClickFurnitureSlotEventHandle)
    IGameEventMgr:RegisterEventHandleByTypeName("DormRoleClickEvent", self.OnRoleClickEventHandle)
    IGameEventMgr:RegisterEventHandleByTypeName("DormClickFurnitureEvent", self.OnDormClickFurnitureEventHandle)
    IGameEventMgr:RegisterEventHandleByTypeName("DormClickFurnitureSlotEvent", self.DormClickFurnitureSlotEventHandle)
    self.commandAction = nil
end

--替换家具回调
function M:DressUpCallBack(type)
    if type == DormConst.FurnitureType.Console then
        local furnitureDatas = DormHelper.GetFurnitureDatasByAreaName("Console")
        self:ConsoleCallback(furnitureDatas)
    end

    if type == DormConst.FurnitureType.MainSofa then
        local furnitureDatas = DormHelper.GetFurnitureDatasByAreaName("Sofa")
        self:SofacommandCallback(furnitureDatas)
    end

    if type == DormConst.FurnitureType.Bed then
        local furnitureDatas = DormHelper.GetFurnitureDatasByAreaName("Bed")
        self:BedcommandCallback(furnitureDatas)
    end

    if type == DormConst.FurnitureType.DefaultStandPoint then
        local furnitureDatas = DormHelper.GetFurnitureDatasByAreaName("Main")
        self:MainCommandCallback(furnitureDatas)
    end
end

--回主机位指令回调
function M:MainCommandCallback(furnitureDatas)
    if self.commandAction then
        self.commandAction:Dispose()
        self.commandAction = nil
    end

    self.commandAction = require("DormAction.Yisongying.YisongyingMainAction").New(furnitureDatas)
end

--去床边指令回调
function M:BedcommandCallback(furnitureDatas)
    if self.commandAction then
        self.commandAction:Dispose()
        self.commandAction = nil
    end

    self.commandAction = require("DormAction.Yisongying.YisongyingBedAction").New(furnitureDatas)
end

--去沙发指令回调
function M:SofacommandCallback(furnitureDatas)
    if self.commandAction then
        self.commandAction:Dispose()
        self.commandAction = nil
    end

    self.commandAction = require("DormAction.Yisongying.YisongyingSofaAction").New(furnitureDatas)
end

--去操作台指令回调
function M:ConsoleCallback(furnitureDatas)
    if self.commandAction then
        self.commandAction:Dispose()
        self.commandAction = nil
    end

    self.commandAction = require("DormAction.Yisongying.YisongyingConsoleAction").New(furnitureDatas)
end

--邀请少女来回调
function M:CallGirlCallback(FurnitureName)
    self.isCalling = false
    EventMgr:Broadcast(UIMessageNames.DORM_CONCEAL_DORM, true)
    if self.commandAction then
        if self.commandAction.InviteGirlCallBack then
            self.commandAction:InviteGirlCallBack()
        end
    end
end

--宿舍角色点击事件回调
function M:RoleClickEventHandle(handler)
    --打招呼时禁止点击家具移动镜头
    if self.isCalling then
        return
    end 

    if self.state == DormConst.RoleState.Command then
        if  self.module.specialEventId and self.module.specialEventcfg.triggerType == DormConst.SpecialEventTriggerType.Click then
            self.module:ClickPlaySpecialEvent()
        else
            if DormHelper.CheckIsMoving() then
                local targetFurnitureName = DormHelper.GetTargetFurnitureName()
                local WatchPointFurnitureName = DormHelper.GetCurrentWatchPointFurnitureName()
                if targetFurnitureName ~= WatchPointFurnitureName then
                    self:CommanderMoveToFurniture(targetFurnitureName)
                end
            else
                if DormHelper.CheckCommanderAndRole() == false then
                    local roleFurnitureName = DormHelper.GetCurrentFurnitureName()
                    self:CommanderMoveToFurniture(roleFurnitureName)
                end
            end
        end
    end
end

--点击家具回调
function M:DormClickFurnitureEventHandle(handler)
    --宿舍心流体验禁止点击家具移动镜头
    if self.module.isGuide then
        return
    end
    --打招呼时禁止点击家具移动镜头
    if self.isCalling then
        return
    end 
    --交互模式下不允许点击家具移动镜头
    if self.state == DormConst.RoleState.Command then
        if handler.homeFurnitureData and handler.assetData then
            self:CheckFurnitureArea(handler.homeFurnitureData.Area)
        end
    end

end

-- 点击附属家具回调
function M:DormClickFurnitureSlotEventHandle(handler)
    --宿舍心流体验禁止点击家具移动镜头
    if self.module.isGuide then
        return
    end
    --打招呼时禁止点击家具移动镜头
    if self.isCalling then
        return
    end
    --交互模式下不允许点击家具移动镜头
    if self.state == DormConst.RoleState.Command then
        if handler.parentFurnitureData then
            self:CheckFurnitureArea(handler.parentFurnitureData.Area)
        end
    end
end

--判断家具所在区域
function M:CheckFurnitureArea(Area)
    --判断点击家具
    if Area.SimpleAreaName == DormConst.DormArea.SofaArea.areaName and
        DormHelper.GetCurrentWatchPointFurnitureName() ~= DormConst.FurnitureName.Sofa then
        self:CommanderMoveToFurniture(DormConst.FurnitureName.Sofa)
        return
    end

    if Area.SimpleAreaName == DormConst.DormArea.ConsoleArea.areaName and
        DormHelper.GetCurrentWatchPointFurnitureName() ~= DormConst.FurnitureName.Console then
        self:CommanderMoveToFurniture(DormConst.FurnitureName.Console)
        return
    end

    if Area.SimpleAreaName == DormConst.DormArea.BedArea.areaName and
        DormHelper.GetCurrentWatchPointFurnitureName() ~= DormConst.FurnitureName.Bed then
        self:CommanderMoveToFurniture(DormConst.FurnitureName.Bed)
        return
    end
end

function M:CommanderMoveToFurniture(FurnitureName)
    if FurnitureName == DormConst.FurnitureName.Sofa then
        DormHelper.CommanderMoveToFurniture(FurnitureName, Bind(self, self.SofacommandCallback))
        return
    end

    if FurnitureName == DormConst.FurnitureName.Console then
        DormHelper.CommanderMoveToFurniture(FurnitureName, Bind(self, self.ConsoleCallback))
        return
    end

    if FurnitureName == DormConst.FurnitureName.Bed then
        DormHelper.CommanderMoveToFurniture(FurnitureName, Bind(self, self.BedcommandCallback))
        return
    end

    if FurnitureName == DormConst.FurnitureName.Bookcase then
        DormHelper.CommanderMoveToFurniture(DormConst.FurnitureName.Console, Bind(self, self.ConsoleCallback))
        return
    end

    if FurnitureName == DormConst.FurnitureName.Main then
        DormHelper.CommanderMoveToFurniture(FurnitureName, Bind(self, self.MainCommandCallback))
        return
    end

    if FurnitureName == DormConst.FurnitureName.Photowall3 then
        DormHelper.CommanderMoveToFurniture(FurnitureName, Bind(self, self.GroupPhotoWallCallBack))
        return
    end
end

function M:SwitchFurnitureAction(FurnitureName, data)
    if FurnitureName == DormConst.FurnitureName.Sofa then
        self:SofacommandCallback(data)
        return
    end

    if FurnitureName == DormConst.FurnitureName.Console then
        self:ConsoleCallback(data)
        return
    end

    if FurnitureName == DormConst.FurnitureName.Bed then
        self:BedcommandCallback(data)
        return
    end

    if FurnitureName == DormConst.FurnitureName.Main then
        self:MainCommandCallback(data)
        return
    end
end

function M:OnExitCommonder()
    DormHelper.RoleAfk(true)

    if self.commandAction then
        self.commandAction:Dispose()
    end

    self.commandAction = nil
end

function M:Dispose()
    if self.commandAction then
        self.commandAction:Dispose()
    end

    self.commandAction = nil
    self._doomDressupBack = nil
    IGameEventMgr:UnRegisterEventHandleByTypeName("DormRoleClickEvent", self.OnRoleClickEventHandle)
    IGameEventMgr:UnRegisterEventHandleByTypeName("DormClickFurnitureEvent", self.OnDormClickFurnitureEventHandle)
    IGameEventMgr:UnRegisterEventHandleByTypeName("DormClickFurnitureSlotEvent", self.DormClickFurnitureSlotEventHandle)
    M.super.Dispose(self)
end

return YisongyingDormAction
