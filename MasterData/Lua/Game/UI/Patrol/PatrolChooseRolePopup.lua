---
--- Created by Eric.
--- DateTime: 2021/11/3 10:11
---

------------ import ------------
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule

------------ import ------------

------------ define ------------

------------ define ------------


---@class PatrolChooseRolePopup
---@field heroView                      	UnityEngine.RectTransform
local PatrolChooseRolePopup = Class("PatrolChooseRolePopup")
function PatrolChooseRolePopup:__init()
    self.teamPanelEnv = nil

end

function PatrolChooseRolePopup:__delete()
    self.teamPanelEnv = nil

    self.controller = nil
end

function PatrolChooseRolePopup:Awake()
    if isNull(self.teamPanelEnv) then
        self.teamPanelEnv = CfUtils.GetLuaScr(self.heroView, "Game.UI.Patrol.PatrolTeamPanel")
    end
end

function PatrolChooseRolePopup:OnFocus(focus)
end

function PatrolChooseRolePopup:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end

function PatrolChooseRolePopup:OnShow()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local argument = self.controller.Argument
        self.teamPanelEnv:FreshBaseUI({
            useItemId = argument.parameters.id,
            usedCB = function()
                UIModule.BackDialog()
            end
        })
    end))
    return coWait
end

function PatrolChooseRolePopup:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

return PatrolChooseRolePopup