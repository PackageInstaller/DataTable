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


--- from: Assets/BundleResources/Prefabs/Common/CommonActivityShopFightRankingsDialog.prefab > name: CommonActivityShopFightRankingsDialog
---@class CommonRankingsDialog
---@field Env                           	CommonRankingsDialog                    
---@field controller                    	Engine.UI.UILuaDialog                   
---@field LoopView                      	SuperScrollView.LoopListView2           	@ 0    
---@field EmptyNode                     	UnityEngine.RectTransform               	@ 1    
---@field LayoutListAndMyselef          	UnityEngine.RectTransform               	@ 2    
---@field MyRanking                     	UnityEngine.RectTransform               	@ 3    
---@field RewardPreviewButton           	UnityEngine.RectTransform               	@ 4    
---@field Text1                         	UnityEngine.RectTransform               	@ 5    
---@field Text2                         	UnityEngine.RectTransform               	@ 6    
---@field Text3                         	UnityEngine.RectTransform               	@ 7    
---@field Text4                         	UnityEngine.RectTransform               	@ 8    
---@field ImgBg                         	UnityEngine.RectTransform               	@ 9    
local CommonRankingsDialog = Class("CommonRankingsDialog")

function CommonRankingsDialog:__init()
    
end

function CommonRankingsDialog:__delete()
    
end

function CommonRankingsDialog:Awake()
    SetButtonAction(self.RewardPreviewButton, Bind(self, self.ShowRewardPreviewWindow))
end

function CommonRankingsDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        if next(checkTable(self.rankData)) == nil then
            CfUtils.SetActive(self.LayoutListAndMyselef, false)
            CfUtils.SetActive(self.EmptyNode, true)
        else
            CfUtils.SetActive(self.LayoutListAndMyselef, true)
            CfUtils.SetActive(self.EmptyNode, false)

            self:RefreshLoopList()
            self:FillPlayerInfo()
        end

        local titleTexts = checkTable(self.titleTexts)
        CfUtils.FillCfText(self.Text1, titleTexts[1])
        CfUtils.FillCfText(self.Text2, titleTexts[2])
        CfUtils.FillCfText(self.Text3, titleTexts[3])
        CfUtils.FillCfText(self.Text4, titleTexts[4])
        CfUtils.FillImage(self.ImgBg, self.bgPath)
    end))
    return coWait
end

function CommonRankingsDialog:OnFocus()
    
end

function CommonRankingsDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(
        util.cs_generator(
            function ()
                local argument = self.controller.Argument
                local parameters = checkTable(argument.parameters)
                self.dialogImp = parameters.impCls

                if self.dialogImp ~= nil then
                    self.rankData = self.dialogImp:GetRankData()
                    self.titleTexts = self.dialogImp:GetRankTitleTexts()
                    self.rankType = self.dialogImp:GetRankRewardType()
                    self.playerRankInfo = self.dialogImp:GetPlayerRankData()
                    self.bgPath = self.dialogImp:GetBgPath()
                end
            end
        )
    )

    return coWait
end

function CommonRankingsDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        self.controller = nil
        self:Delete()
        self = nil
    end))
    return coWait
end

function CommonRankingsDialog:RefreshLoopList()
    if not self.LoopView.IsListViewInit then
        self.LoopView:InitListView(#checkTable(self.rankData), Bind(self, self.OnRefreshListIndex))
    else
        GameUtils.ReloadData(self.LoopView, #checkTable(self.rankData))
    end
end

function CommonRankingsDialog:OnRefreshListIndex(listView, index)
    if index < 0 then
        return nil
    end

    local cell = listView:NewListViewItem("Cell")
    local data = {
        index = index, 
        input = self.rankData[index + 1]
    }

    local scr = CfUtils.GetLuaScr(cell, "Game.UI.ActivityCooking.ActivityCookingRankNode")
    if scr then
        scr:Refresh(data)
    else
        printError("[UI][CommonRankingsDialog][OnRefreshListIndex] lua script Game.UI.ActivityCooking.ActivityCookingRankNode not found")
    end

    return cell
end

function CommonRankingsDialog:FillPlayerInfo()
    local scr = CfUtils.GetLuaScr(self.MyRanking, "Game.UI.ActivityCooking.ActivityCookingRankNode")

    if scr then
        scr:Refresh(checkTable(self.playerRankInfo))
    end
end

function CommonRankingsDialog:ShowRewardPreviewWindow()
    -- local dialog = ActivityCookingConstants.CookingUIConfigs[ActivityCookingComponent.dojo.config.id].RankDialog
    local dialog = Constants.UITypeIds.CommonActivityBossRankRewardDialog
    CfUtils.DialogOpen(dialog, {
		rankType = checkNumber(self.rankType), entryMgr = self.dialogImp
	})
end

return CommonRankingsDialog
