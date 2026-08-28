---
--- 烹饪玩法，结算界面
--- Author: dawanfan
--- Date: 2024-3-15 15:52:50
---

local util = require 'XLua.util'
local UIModule = CS.Engine.UI.UIModule
local Yielders = CS.Engine.Lib.Yielders
local CoWait = CS.Engine.Lib.CoWait
local cs_coroutine = require('XLua.cs_coroutine')

---@type ActivityCookingGame
local ActivityCookingGame = import("Game.UI.ActivityCooking.ActivityCookingGame"):GetInstance()
local ActivityCookingUtils = import("Game.UI.ActivityCooking.ActivityCookingUtils")
local ActivityCookingConstants = import("Game.UI.ActivityCooking.ActivityCookingConstants")


--- from: Assets/BundleResources/Prefabs/ActivityCakeShop/ActivityOperatePopup.prefab > name: ActivityOperatePopup
---@class ActivityCookingPopupDialog
---@field Env                           	ActivityCookingPopupDialog              
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnExit                       	UnityEngine.RectTransform               	@ 0    
---@field BtnReChallenge                	UnityEngine.RectTransform               	@ 1    
---@field TxtTotalSell                  	UnityEngine.RectTransform               	@ 2    
---@field RewardList                    	UnityEngine.RectTransform               	@ 3    
---@field StarNode                      	UnityEngine.RectTransform               	@ 4    
---@field TurnoverNode                  	UnityEngine.RectTransform               	@ 5    
---@field ImgStar1                      	UnityEngine.RectTransform               	@ 6    
---@field ImgStar2                      	UnityEngine.RectTransform               	@ 7    
---@field ImgStar3                      	UnityEngine.RectTransform               	@ 8    
---@field Root                          	UnityEngine.RectTransform               	@ 9    
local ActivityCookingPopupDialog = Class("ActivityCookingPopupDialog")

function ActivityCookingPopupDialog:__init()
    
end

function ActivityCookingPopupDialog:__delete()
    
end

function ActivityCookingPopupDialog:Awake()
    SetButtonAction(self.BtnExit, Bind(self, self.OnBtnExitClick))
    SetButtonAction(self.BtnReChallenge, Bind(self, self.OnBtnReChallengeClick))
end

function ActivityCookingPopupDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:FillSelf()
        CfUtils.WaitPlayAnimationTo(self.Root, "UI_CommonDialogShow02", function ()
            
        end)
    end))
    return coWait
end

function ActivityCookingPopupDialog:OnFocus()
    
end

function ActivityCookingPopupDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(
        util.cs_generator(
            function ()

            end
        )
    )

    return coWait
end

function ActivityCookingPopupDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        self.controller = nil
        self:Delete()
        self = nil
    end))
    return coWait
end

function ActivityCookingPopupDialog:FillSelf()
    local initParams = self.controller.Argument.parameters or {}
    local levelId = initParams.levelId
    local rewards = initParams.rewards
    local starNum = initParams.starNum
    local selledPrice = initParams.selledPrice

    local levelVo = ActivityCookingUtils.GetCookingLevelVo(levelId)

    local isNormalLevel = levelVo.type == ActivityCookingConstants.GameMode.Normal
    CfUtils.SetActive(self.TurnoverNode, not isNormalLevel)
    CfUtils.SetActive(self.StarNode, isNormalLevel)

    if isNormalLevel then
        for i = 1, 3 do
            CfUtils.SetActive(self["ImgStar"..tostring(i)], i <= starNum)
        end
    else
        CfUtils.FillText(self.TxtTotalSell, selledPrice)
    end

    CfUtils.RefreshCommonGoodsListLight(self.RewardList, rewards)
end

function ActivityCookingPopupDialog:OnBtnExitClick()
    UIModule.CloseDialog(self.controller)
    ActivityCookingGame:ExitGame()
end

function ActivityCookingPopupDialog:OnBtnReChallengeClick()
    
    local initParams = self.controller.Argument.parameters or {}
    local levelId = initParams.levelId

    ---@type ActivityCookingComponent
    local ActivityCookingComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityCookingComponent)
    ActivityCookingComponent:RestartGame(function ()
        UIModule.CloseDialog(self.controller)
    end)
end


return ActivityCookingPopupDialog