---
--- 烹饪玩法，暂停界面
--- Author: dawanfan
--- Date: 2024-3-14 20:12:22
---

local util = require 'XLua.util'
local UIModule = CS.Engine.UI.UIModule
local Yielders = CS.Engine.Lib.Yielders
local CoWait = CS.Engine.Lib.CoWait
local cs_coroutine = require('XLua.cs_coroutine')

---@type ActivityCookingGame
local ActivityCookingGame = import("Game.UI.ActivityCooking.ActivityCookingGame"):GetInstance()
---@type ActivityCookingComponent
local ActivityCookingComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityCookingComponent)
local ActivityCookingConstants = import("Game.UI.ActivityCooking.ActivityCookingConstants")

--- from: Assets/BundleResources/Prefabs/ActivityCakeShop/ActivityOperateSuspendDialog.prefab > name: ActivityOperateSuspendDialog
---@class ActivityCookingSuspendDialog
---@field Env                           	ActivityCookingSuspendDialog            
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnContinue                   	UnityEngine.RectTransform               	@ 0    
---@field BtnExit                       	UnityEngine.UI.Button                   	@ 1    
---@field BtnInstruction                	UnityEngine.RectTransform               	@ 2    
local ActivityCookingSuspendDialog = Class("ActivityCookingSuspendDialog")

function ActivityCookingSuspendDialog:__init()
    
end

function ActivityCookingSuspendDialog:__delete()
    
end

function ActivityCookingSuspendDialog:Awake()
    SetButtonAction(self.BtnContinue, Bind(self, self.OnBtnContinueClick))
    SetButtonAction(self.BtnExit, Bind(self, self.OnBtnExitClick))
    SetButtonAction(self.BtnInstruction, Bind(self, self.OnBtnInstructionClick))
end

function ActivityCookingSuspendDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        
    end))
    return coWait
end

function ActivityCookingSuspendDialog:OnFocus()
    
end

function ActivityCookingSuspendDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(
        util.cs_generator(
            function ()

            end
        )
    )

    return coWait
end

function ActivityCookingSuspendDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        self.controller = nil
        self:Delete()
        self = nil
    end))
    return coWait
end

function ActivityCookingSuspendDialog:OnBtnContinueClick()
    UIModule.CloseDialog(self.controller, true)
    ActivityCookingGame:GameStop(false)
end

function ActivityCookingSuspendDialog:OnBtnExitClick()
    UIModule.CloseDialog(self.controller, true)
    ActivityCookingGame:ExitGame()
end

function ActivityCookingSuspendDialog:OnBtnInstructionClick()
    local dialog = ActivityCookingConstants.CookingUIConfigs[ActivityCookingComponent.dojo.config.id].InstructionDialog
    UIModule.OpenDialog({id=dialog})
end

return ActivityCookingSuspendDialog