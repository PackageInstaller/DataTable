-------------------------------------------------------------------------------
-- 周年庆 - 庆典小铺（大转盘） - 排名奖励界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-06-24 00:49:25
-------------------------------------------------------------------------------

local RewardCellNodeLuaPath = 'Game.Activity.RotaryTable.ActivityRotaryTableRankRewardCell'

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/Anniversary/AnniversaryTurntableRewardPreviewPopup122501.prefab
---@class ActivityRotaryTableRankRewardPopup
---@field Env                           	ActivityRotaryTableRankRewardPopup   
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ScrollView                    	SuperScrollView.LoopListView2               
---@field BtnClose                      	UnityEngine.UI.Button                   
---@field Root                          	UnityEngine.RectTransform               
---@field ClickClose                    	UnityEngine.RectTransform               
local ActivityRotaryTableRankRewardPopup = Class('ActivityRotaryTableRankRewardPopup')


function ActivityRotaryTableRankRewardPopup:__init()
    ---@type ActivityRotaryTableRankingRewardVo[]
    self.rewardDataList_ = nil
end


function ActivityRotaryTableRankRewardPopup:__delete()
    self.rewardDataList_ = nil
end


function ActivityRotaryTableRankRewardPopup:Awake()
    SetButtonAction(self.BtnClose, Bind(self, self.OnClickCloseButtonHandler_))
    SetButtonAction(self.ClickClose, Bind(self, self.OnClickCloseButtonHandler_))
end


function ActivityRotaryTableRankRewardPopup:OnInitialize()
    return CoWaitDo(function()
        self:InitRewardData_()
        self:RefreshRewardList_()
    end)
end


function ActivityRotaryTableRankRewardPopup:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- private

function ActivityRotaryTableRankRewardPopup:InitRewardData_()
    self.rewardDataList_ = {}

    ---@type ActivityRotaryTableRankingRewardVo[]
    local rewardVoList = CfUtils.GetWholeVo(AutoIds.IdSetting3200, 'ActivityRotaryTableRankingRewardVo')
    for _, rewardVo in ipairs(rewardVoList) do
        table.insert(self.rewardDataList_, rewardVo)
    end

    ---@param aData ActivityRotaryTableRankingRewardVo
    ---@param bData ActivityRotaryTableRankingRewardVo
    table.sort(self.rewardDataList_, function(aData, bData)
        return aData.upperLimit < bData.upperLimit
    end)
end


function ActivityRotaryTableRankRewardPopup:RefreshRewardList_()
    if not self.ScrollView.IsListViewInit then
        self.ScrollView:InitListView(#self.rewardDataList_, Bind(self, self.OnUpdateRewardListCellHandler_))
    else
        GameUtils.ReloadData(self.ScrollView, #self.rewardDataList_)
    end
end


-------------------------------------------------
-- handler

function ActivityRotaryTableRankRewardPopup:OnClickCloseButtonHandler_()
    CfUtils.DialogBack()
end


---@param listView SuperScrollView.LoopListView2
---@param listIndex integer @ start with 0
function ActivityRotaryTableRankRewardPopup:OnUpdateRewardListCellHandler_(listView, listIndex)
    if listIndex < 0 then return end
    local cellNode = listView:NewListViewItem("Cell")
    ---@type ActivityRotaryTableRankRewardCell
    local nodeEnv = CfUtils.GetLuaScr(cellNode.gameObject, RewardCellNodeLuaPath)
    if nodeEnv then
        local luaIndex = listIndex + 1
        local cellData = checkTable(self.rewardDataList_[luaIndex])
        -- init cell
        nodeEnv:SetLuaIndex(luaIndex)
        nodeEnv:SetCellData(cellData)
    end
    return cellNode
end


return ActivityRotaryTableRankRewardPopup
