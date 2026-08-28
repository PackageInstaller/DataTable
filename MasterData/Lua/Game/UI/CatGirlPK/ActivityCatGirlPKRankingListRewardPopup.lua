--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/ActivityCatGirlPK12003201/ActivityCatGirlPKRankingListRewardPopup.prefab > name: ActivityCatGirlPKRankingListRewardPopup

---@class ActivityCatGirlPKRankingListRewardPopup
---@field Env                           	ActivityCatGirlPKRankingListRewardPopup 
---@field controller                    	Engine.UI.UILuaDialog                   
---@field LoopListView                  	SuperScrollView.LoopListView2           	@ 0    
---@field RT_BtnClose1                  	UnityEngine.RectTransform               	@ 1    
---@field RT_BtnClose                   	UnityEngine.RectTransform               	@ 2    
local ActivityCatGirlPKRankingListRewardPopup = Class('ActivityCatGirlPKRankingListRewardPopup')

local util = require 'XLua.util'
local KTool = CS.Engine.Lib.KTool
local CoWait = CS.Engine.Lib.CoWait
local UIModule = CS.Engine.UI.UIModule
local Yielders = CS.Engine.Lib.Yielders
local UIEventProxy = CS.Engine.UI.UIEventProxy
local cs_coroutine = require("XLua.cs_coroutine")
---@type ActivityMgr
local ActivityMgr = import('Game.Activity.ActivityMgr'):GetInstance()
---@type ActivityVoteComponent
local ActivityVoteComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.ActivityVoteComponent)
function ActivityCatGirlPKRankingListRewardPopup:__init()
    self.listData = {nodeDataList = {}}
end


function ActivityCatGirlPKRankingListRewardPopup:__delete()
end


function ActivityCatGirlPKRankingListRewardPopup:Awake()
    SetButtonAction(self.RT_BtnClose1, function ()
        UIModule.CloseDialog(self.controller)
    end)
end


function ActivityCatGirlPKRankingListRewardPopup:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        local nodeDataList = self.listData.nodeDataList
        local levelScore = ActivityVoteComponent:GetLevelScore()
        for i, v in ipairs(levelScore) do
            nodeDataList[#nodeDataList+1] = {name = v.name , rewardsList =v.rewards , value = v.voteNum }    
        end
        if not self.LoopListView.IsListViewInit then
            self.LoopListView:InitListView(table.count(nodeDataList), Bind(self, self.OnGetItemByIndex))
        else
            GameUtils.ReloadData(self.LoopListView, table.count(nodeDataList))
        end
    end)
end

function ActivityCatGirlPKRankingListRewardPopup:OnGetItemByIndex(listView, listIndex)
    if listIndex < 0 then return end
    local cell = listView:NewListViewItem("Cell")
    ---@type CommonPreviewListNode
    local nodeEnv = CfUtils.GetLuaScr(cell.gameObject, "Game.UI.Common.CommonPreviewListNode")
    if nodeEnv then
        nodeEnv:SetData(self.listData , listIndex + 1)
        nodeEnv:Refresh()
    end
    return cell
end

function ActivityCatGirlPKRankingListRewardPopup:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


return ActivityCatGirlPKRankingListRewardPopup
