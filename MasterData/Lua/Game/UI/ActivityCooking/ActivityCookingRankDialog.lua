---
--- 烹饪玩法排行榜界面
--- Author: dawanfan
--- Date: 2024-3-18 11:11:19
---


local util = require 'XLua.util'
local UIModule = CS.Engine.UI.UIModule
local Yielders = CS.Engine.Lib.Yielders
local CoWait = CS.Engine.Lib.CoWait
local cs_coroutine = require('XLua.cs_coroutine')

---@type ActivityCookingComponent
local ActivityCookingComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityCookingComponent)
local ActivityCookingConstants = import("Game.UI.ActivityCooking.ActivityCookingConstants")


--- from: Assets/BundleResources/Prefabs/ActivityCakeShop/ActivityCakeShopFightRankingsDialog.prefab > name: ActivityCakeShopFightRankingsDialog
---@class ActivityCookingRankDialog
---@field Env                           	ActivityCookingRankDialog               
---@field controller                    	Engine.UI.UILuaDialog                   
---@field LoopView                      	SuperScrollView.LoopListView2           	@ 0    
---@field EmptyNode                     	UnityEngine.RectTransform               	@ 1    
---@field LayoutListAndMyselef          	UnityEngine.RectTransform               	@ 2    
---@field MyRanking                     	UnityEngine.RectTransform               	@ 3    
---@field RewardPreviewButton           	UnityEngine.RectTransform               	@ 4    
local ActivityCookingRankDialog = Class("ActivityCookingRankDialog")

function ActivityCookingRankDialog:__init()
    
end

function ActivityCookingRankDialog:__delete()
    
end

function ActivityCookingRankDialog:Awake()
    SetButtonAction(self.RewardPreviewButton, Bind(self, self.ShowRewardPreviewWindow))
end

function ActivityCookingRankDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        if next(ActivityCookingComponent.dojo.rank) == nil then
            CfUtils.SetActive(self.LayoutListAndMyselef, false)
            CfUtils.SetActive(self.EmptyNode, true)
        else
            CfUtils.SetActive(self.LayoutListAndMyselef, true)
            CfUtils.SetActive(self.EmptyNode, false)

            self:RefreshLoopList()
            self:FillPlayerInfo()
        end
    end))
    return coWait
end

function ActivityCookingRankDialog:OnFocus()
    
end

function ActivityCookingRankDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(
        util.cs_generator(
            function ()

            end
        )
    )

    return coWait
end

function ActivityCookingRankDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        self.controller = nil
        self:Delete()
        self = nil
    end))
    return coWait
end

function ActivityCookingRankDialog:RefreshLoopList()
    if not self.LoopView.IsListViewInit then
        self.LoopView:InitListView(#ActivityCookingComponent.dojo.rank, Bind(self, self.OnRefreshListIndex))
    else
        GameUtils.ReloadData(self.LoopView, #ActivityCookingComponent.dojo.rank)
    end
end

function ActivityCookingRankDialog:OnRefreshListIndex(listView, index)
    if index < 0 then
        return nil
    end

    local cell = listView:NewListViewItem("Cell")
    local data = {
        index = index, 
        input = ActivityCookingComponent.dojo.rank[index + 1]
    }

    local scr = CfUtils.GetLuaScr(cell, "Game.UI.ActivityCooking.ActivityCookingRankNode")
    if scr then
        scr:Refresh(data)
    else
        printError("[UI][ActivityCookingRankDialog][OnRefreshListIndex] lua script Game.UI.ActivityCooking.ActivityCookingRankNode not found")
    end

    return cell
end

function ActivityCookingRankDialog:FillPlayerInfo()
    local scr = CfUtils.GetLuaScr(self.MyRanking, "Game.UI.ActivityCooking.ActivityCookingRankNode")

    local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
    ---@type PlayerDojo
    local playerDojo = playerComponent:GetPlayerDojo()

    local data = {}
    data["input"] = {
        playerId=playerDojo.playerId,
        score=checkInt(ActivityCookingComponent.dojo.playerRank.score),
        name=playerDojo.playerName,
        avatar=playerDojo.playerAvatar,
        avatarFrame=playerDojo.playerAvatarFrame,
        level=checkInt(playerDojo.level),
        ranking=checkInt(ActivityCookingComponent.dojo.playerRank.ranking),
    }

    if scr then
        scr:Refresh(data)
    end
end

function ActivityCookingRankDialog:ShowRewardPreviewWindow()
    local dialog = ActivityCookingConstants.CookingUIConfigs[ActivityCookingComponent.dojo.config.id].RankDialog
    UIModule.OpenDialog({id= dialog})
end

return ActivityCookingRankDialog
