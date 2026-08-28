---
--- 烹饪玩法入口界面，星级奖励节点
--- Author: dawanfan
--- Date: 2024-3-18 10:43:31
---


local util = require 'XLua.util'
local UIModule = CS.Engine.UI.UIModule
local Yielders = CS.Engine.Lib.Yielders
local CoWait = CS.Engine.Lib.CoWait
local cs_coroutine = require('XLua.cs_coroutine')

       
--- from: Assets/BundleResources/Prefabs/ActivityCakeShop/ActivityCakeShopFightDescNode.prefab > name: ActivityCakeShopFightDescNode3
---@class ActivityCookingEntryLevelTargetDetail
---@field Env                           	ActivityCookingEntryLevelTargetDetail   
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgStar                       	UnityEngine.RectTransform               	@ 0    
---@field CommonGoodsListLight          	UnityEngine.RectTransform               	@ 1    
---@field TextDesc                      	UnityEngine.RectTransform               	@ 2    
local ActivityCookingEntryLevelTargetDetail = Class("ActivityCookingEntryLevelTargetDetail")

function ActivityCookingEntryLevelTargetDetail:__init()
    
end

function ActivityCookingEntryLevelTargetDetail:__delete()
    
end

function ActivityCookingEntryLevelTargetDetail:Awake()

end

function ActivityCookingEntryLevelTargetDetail:OnDestroy()
    self.controller = nil
    self:Delete()
    self = nil
end

function ActivityCookingEntryLevelTargetDetail:Refresh(finish, desc, rewards)
    if finish then
        CfUtils.SetUISwitchImage(self.ImgStar, 2)
        CfUtils.SetUISwitchText(self.TextDesc, 2)
    else
        CfUtils.SetUISwitchImage(self.ImgStar, 1)
        CfUtils.SetUISwitchText(self.TextDesc, 1)
    end

    CfUtils.FillText(self.TextDesc, desc)

    local scr = CfUtils.GetLuaScr(self.CommonGoodsListLight,  "Game.Behaviours.CommonGoodsListLight")
    scr:FreshBaseUI(rewards, false, finish)
end

return ActivityCookingEntryLevelTargetDetail
