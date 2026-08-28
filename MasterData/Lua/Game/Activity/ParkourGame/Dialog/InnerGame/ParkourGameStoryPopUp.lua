---@type ${ModuleName}Mgr
local Mgr = import("${LuaDir}.${ModuleName}Mgr"):GetInstance()

--- lua:
local CoWait = CS.Engine.Lib.CoWait
local util = require 'XLua.util'
local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程


---@class ParkourGameStoryPopUp
---@field Env                            ParkourGameStoryPopUp
---@field controller                        Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
local ParkourGameStoryPopUp = Class("ParkourGameStoryPopUp")

---@class ParkourGameStoryPopUp.InputData

function ParkourGameStoryPopUp:__init()
    self.controller = nil
end

function ParkourGameStoryPopUp:__delete()
    self.controller = nil
end

function ParkourGameStoryPopUp:Awake()
end

function ParkourGameStoryPopUp:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        ---@type ParkourGameStoryPopUp.InputData
        self.inData = self.controller.Argument.parameters or {}
        self:RefreshUI()
    end))
    return coWait
end

---@param inData ParkourGameStoryPopUp.InputData
function ParkourGameStoryPopUp:RefreshData(inData)
    self.inData = inData
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function ParkourGameStoryPopUp:RefreshUI()

end

return ParkourGameStoryPopUp