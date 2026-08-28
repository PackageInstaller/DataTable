---
--- 烹饪玩法，排行榜奖励预览界面
--- Author: dawanfan
--- Date: 2024-5-16 14:24:50
---

local util = require 'XLua.util'

local UIModule = CS.Engine.UI.UIModule
local CoWait = CS.Engine.Lib.CoWait

--- from: Assets/BundleResources/Prefabs/ActivityCakeShop/ActivityCakeShopBossRankRewardDialog.prefab > name: ActivityCakeShopFightRankingsRewardDialog
---@class ActivityCookingRankRewardPreviewDialog
---@field Env                           	ActivityCookingRankRewardPreviewDialog  
---@field controller                    	Engine.UI.UILuaDialog                   
---@field Fuzzy                         	UnityEngine.RectTransform               	@ 0    
---@field BtnClose                      	UnityEngine.RectTransform               	@ 1    
---@field RankingLoopView               	SuperScrollView.LoopListView2           	@ 2    
---@field CommonPopupBoardDialog        	UnityEngine.RectTransform               	@ 3    
---@field Root                          	UnityEngine.RectTransform               	@ 4    
local ActivityCookingRankRewardPreviewDialog = Class("ActivityCookingRankRewardPreviewDialog")


function ActivityCookingRankRewardPreviewDialog:__init()

end

function ActivityCookingRankRewardPreviewDialog:__delete()

    self.controller = nil
end

function ActivityCookingRankRewardPreviewDialog:Awake()

end

function ActivityCookingRankRewardPreviewDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:InitHandler()
        self:InitData()
    end))
    return coWait
end

function ActivityCookingRankRewardPreviewDialog:OnFocus(focus)

end

function ActivityCookingRankRewardPreviewDialog:OnShow()
end

function ActivityCookingRankRewardPreviewDialog:OnHide()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        CfUtils.ResetNavigatorCustomBackAction()
    end))
    return coWait
end

function ActivityCookingRankRewardPreviewDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引⽤到的c#对象否则不会产⽣c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end


function ActivityCookingRankRewardPreviewDialog:InitHandler()
    SetButtonAction(self.BtnClose, Bind(self, self.OnCloseHandler))
    SetButtonAction(self.Fuzzy, Bind(self, self.OnCloseHandler))
end

function ActivityCookingRankRewardPreviewDialog:InitData()
    local autoId = self:GetAutoId()
    self._rewardsList = self:GetRewardVos(autoId)
    self:RefreshUI()
end

function ActivityCookingRankRewardPreviewDialog:GetRewardVos(autoId)
    if self.controller.Argument.parameters and self.controller.Argument.parameters.rewardVos then
        return self.controller.Argument.parameters.rewardVos
    end
    return CfUtils.GetCf(autoId, "ActivityCookingRankVo", true)
end

function ActivityCookingRankRewardPreviewDialog:GetAutoId()
    if self.controller.Argument.parameters and self.controller.Argument.parameters.autoId then
        return self.controller.Argument.parameters.autoId
    end
    return AutoIds.IdSetting6252
end

function ActivityCookingRankRewardPreviewDialog:OnCloseHandler()
    UIModule.CloseDialog(self.controller)
end

function ActivityCookingRankRewardPreviewDialog:FillItemByIndex(loopView, index)
    local luaIndex = index + 1
    local cellData = self._rewardsList[luaIndex]
    local cell = loopView:NewListViewItem("Cell")
    ---@type UIActivityMidFestivalBossRankRewardCell
    local scr = CfUtils.GetLuaScr(cell, "Game.UI.ActivityCakeShopDialog.Cell.UIActivityCakeShopBossRankRewardCell")
    scr:Refresh(cellData)
    return cell
end

function ActivityCookingRankRewardPreviewDialog:RefreshUI()
    if not self.RankingLoopView.IsListViewInit then
        self.RankingLoopView:InitListView(#self._rewardsList, Bind(self, self.FillItemByIndex))
    else
        GameUtils.ReloadData(self.RankingLoopView, #self._rewardsList)
    end
end


return ActivityCookingRankRewardPreviewDialog
