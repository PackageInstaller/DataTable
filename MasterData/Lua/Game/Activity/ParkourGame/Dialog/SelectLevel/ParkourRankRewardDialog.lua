

-- 微缩世界 跑酷选关界面 无限模式 排行榜奖励界面



local cs_coroutine = import('XLua.cs_coroutine')
local CriWareUtils = import('Game.Entry.CriWareUtilsFix')
local util = require 'XLua.util'



local UIModule = CS.Engine.UI.UIModule
local CoWait = CS.Engine.Lib.CoWait


--- from: Assets/BundleResources/Prefabs/OverseaParkour12001801/OverseaParkourRankRewardDialog12001801.prefab > name: OverseaParkourRankRewardDialog12001801
---@class ParkourRankRewardDialog
---@field Env                           	ParkourRankRewardDialog                 
---@field controller                    	Engine.UI.UILuaDialog                   
---@field Fuzzy                         	UnityEngine.RectTransform               	@ 0    
---@field BtnClose                      	UnityEngine.RectTransform               	@ 1    
---@field RankingLoopView               	SuperScrollView.LoopListView2           	@ 2    
---@field CommonPopupBoardDialog        	UnityEngine.RectTransform               	@ 3    
---@field Root                          	UnityEngine.RectTransform               	@ 4    
local ParkourRankRewardDialog = Class("ParkourRankRewardDialog")



function ParkourRankRewardDialog:__init()

end

function ParkourRankRewardDialog:__delete()

    self.controller = nil
end

function ParkourRankRewardDialog:Awake()

end

function ParkourRankRewardDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:InitHandler()
        self:InitData()
    end))
    return coWait
end

function ParkourRankRewardDialog:OnFocus(focus)

end

function ParkourRankRewardDialog:OnShow()
end


function ParkourRankRewardDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引⽤到的c#对象否则不会产⽣c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end




function ParkourRankRewardDialog:InitHandler()
    SetButtonAction(self.BtnClose, Bind(self, self.OnCloseHandler))
    SetButtonAction(self.Fuzzy, Bind(self, self.OnCloseHandler))
end

function ParkourRankRewardDialog:InitData()
    self._rewardsList = CfUtils.GetCf(AutoIds.IdSetting6461, "MiniWorldFreeExploreRankRewaordVo", true)
    self:RefreshUI()
end



function ParkourRankRewardDialog:OnCloseHandler()
    UIModule.CloseDialog(self.controller)
end



function ParkourRankRewardDialog:FillItemByIndex(loopView, index)
    local luaIndex = index + 1
    local cellData = self._rewardsList[luaIndex]
    local cell = loopView:NewListViewItem("Cell")
    ---@type UIActivityMidFestivalBossRankRewardCell
    local scr = CfUtils.GetLuaScr(cell, "Game.UI.ActivityCakeShopDialog.Cell.UIActivityCakeShopBossRankRewardCell")
    scr:Refresh(cellData)
    return cell
end

function ParkourRankRewardDialog:RefreshUI()
    if not self.RankingLoopView.IsListViewInit then
        self.RankingLoopView:InitListView(#self._rewardsList, Bind(self, self.FillItemByIndex))
    else
        GameUtils.ReloadData(self.RankingLoopView, #self._rewardsList)
    end
end




return ParkourRankRewardDialog