
--- lua:
local CoWait = CS.Engine.Lib.CoWait
local util = require 'XLua.util'
local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程
local UIModule = CS.Engine.UI.UIModule

local GameUtils = import('Game.Utils.GameUtils')
local Object = CS.UnityEngine.Object
local GameObject = CS.UnityEngine.GameObject
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local Mathf = CS.UnityEngine.Mathf
local Random = CS.UnityEngine.Random
local Canvas = CS.UnityEngine.Canvas
local Physics = CS.UnityEngine.Physics
local KTool = CS.Engine.Lib.KTool
local KCookie = CS.Engine.Lib.KCookie
local BehaviourAction = CS.Engine.Lib.BehaviourAction

---@type TimeLimitedMgr
local Mgr = import("Game.Activity.TimeLimitedRecruit.TimeLimitedMgr"):GetInstance()


--[[
        再来一次 弹窗页面
]]


--- from: Assets/BundleResources/Prefabs/ActivityDK12003501/ActivityDKobtainedFreeDialog.prefab > name: ActivityDKobtainedFreeDialog
---@class UIActivityTimeLimitedObtainedFreePanel
---@field Env                           	UIActivityTimeLimitedObtainedFreePanel  
---@field controller                    	Engine.UI.UILuaDialog                   
---@field FontStyleButton               	UnityEngine.RectTransform               	@ 0    
---@field ImgRole                       	UnityEngine.RectTransform               	@ 1    
---@field TxtName                       	UnityEngine.RectTransform               	@ 2    
local UIActivityTimeLimitedObtainedFreePanel = Class("UIActivityTimeLimitedObtainedFreePanel")
---------------------------------------------


---------------------------------------------
function UIActivityTimeLimitedObtainedFreePanel:__init()
end


function UIActivityTimeLimitedObtainedFreePanel:__delete()
end


function UIActivityTimeLimitedObtainedFreePanel:Awake()

    SetButtonAction(self.FontStyleButton, Bind(self,self._OnClickBtn))
end


function UIActivityTimeLimitedObtainedFreePanel:OnFocus(focus)
end


function UIActivityTimeLimitedObtainedFreePanel:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        -- local parameters = checkTable(self.controller.Argument.parameters)
    end))
    return coWait
end


function UIActivityTimeLimitedObtainedFreePanel:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end


function UIActivityTimeLimitedObtainedFreePanel:OnShow()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

    end))
    return coWait
end



function UIActivityTimeLimitedObtainedFreePanel:_OnClickBtn()
    Mgr:ToNextRound()
    CfUtils.DialogBack()
end



return UIActivityTimeLimitedObtainedFreePanel