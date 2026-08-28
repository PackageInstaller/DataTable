-------------------------------------------------------------------------------
-- 周年庆 - 庆典小铺（大转盘） - 兑换奖励界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-06-24 00:49:25
-------------------------------------------------------------------------------

local RewardCellNodeLuaPath = 'Game.Activity.RotaryTable.ActivityRotaryTableExchangeCell'
---@type ActivityUtils
local ActivityUtils = import("Game.Activity.ActivityUtils")
-- local anniversaryMgr = import('Game.Activity.RotaryTableAnniversaryMgr'):GetInstance()

---@class ActivityRotaryTableExchangeDojo : BaseDojo
---@field New fun():ActivityRotaryTableExchangeDojo
local ActivityRotaryTableExchangeDojo = Class('ActivityRotaryTableExchangeDojo', require('Game.Dojo.BaseDojo'))
function ActivityRotaryTableExchangeDojo:__init()
    self.id        = 0
    self.name      = ''
    ---@type integer @ 目标数量
    self.targetNum = 0
    ---@type integer @ 任务状态 0未完成 1已完成 2已领取
    self.status = 0
    ---@type table[]
    self.rewards = {}
    ---@type ActivityRotaryTableExchangeRewardVo
    self.confVo = nil
end

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/Anniversary/AnniversaryTurntableRankRewardPopup122501.prefab
---@class ActivityRotaryTableExchangeDialog
---@field Env                           	ActivityRotaryTableExchangeDialog    
---@field controller                    	Engine.UI.UILuaDialog                   
---@field FontStyleButton               	UnityEngine.RectTransform               
---@field ScrollView                    	SuperScrollView.LoopListView2               
---@field BtnClose                      	UnityEngine.UI.Button                   
---@field Root                          	UnityEngine.RectTransform               
---@field ClickClose                    	UnityEngine.RectTransform               
local ActivityRotaryTableExchangeDialog = Class('ActivityRotaryTableExchangeDialog')


function ActivityRotaryTableExchangeDialog:__init()
    ---@type ActivityDojo
    self._annivDojo = nil
    ---@type ActivityRotaryTableExchangeDojo[]
    self.rewardDataList_ = nil
    self.myrewardScore_  = 0
end


function ActivityRotaryTableExchangeDialog:__delete()
    self._annivDojo      = nil
    self.rewardDataList_ = nil
    self.myrewardScore_  = nil
end


function ActivityRotaryTableExchangeDialog:Awake()
    SetButtonAction(self.BtnClose, Bind(self, self.OnClickCloseButtonHandler_))
    SetButtonAction(self.ClickClose, Bind(self, self.OnClickCloseButtonHandler_))
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickQuickDrawButtonHandler_))
end


function ActivityRotaryTableExchangeDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        self._annivDojo  = initParams.annivDojo
        self:RequestRankData_()
    end)
end


function ActivityRotaryTableExchangeDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- private

function ActivityRotaryTableExchangeDialog:RequestRankData_()
    GameUtils.Request(Interfaces.ActivityRotaryCarnivalValueHome, {activityUuid = self._annivDojo.id}, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)
            
            -- update myScore
            self.myrewardScore_ = checkInt(responseData.myScore)

            -- rank rewardsData
            self.rewardDataList_ = {}
            for rankIndex, rankData in ipairs(checkTable(responseData.rankRewardsConf)) do
                local rankRewardDojo = ActivityRotaryTableExchangeDojo.New()
                rankRewardDojo:Fill(rankData)
                rankRewardDojo.confVo = CfUtils.GetCfVo(AutoIds.IdSetting3100, 'ActivityRotaryTableExchangeRewardVo', rankRewardDojo.id)
                self.rewardDataList_[rankIndex] = rankRewardDojo
            end

            -- init views
            self:UpdateRewardList_()
            self:CheckRewardRedPoint_()
        end
    end)
end


function ActivityRotaryTableExchangeDialog:UpdateRewardList_()
    -- sort rewardsData
    ---@param aData ActivityRotaryTableExchangeDojo
    ---@param bData ActivityRotaryTableExchangeDojo
    table.sort(self.rewardDataList_, function(aData, bData)
        local aStatus = checkInt(aData.status)
        local bStatus = checkInt(bData.status)
        if aStatus == bStatus then
            return aData.targetNum < bData.targetNum
        else
            aStatus = aStatus == 1 and -1 or aStatus
            bStatus = bStatus == 1 and -1 or bStatus
            return aStatus < bStatus
        end
    end)

    -- reload listView
    if not self.ScrollView.IsListViewInit then
        self.ScrollView:InitListView(#self.rewardDataList_, Bind(self, self.OnUpdateRewardListCellHandler_))
    else
        GameUtils.ReloadData(self.ScrollView, #self.rewardDataList_)
    end
end


function ActivityRotaryTableExchangeDialog:DrawExchangeReward_(cellIndexList)
    local rewardIdList = {}
    for _, cellIndex in ipairs(cellIndexList) do
        local cellData = self.rewardDataList_[cellIndex]
        table.insert(rewardIdList, cellData.id)
    end
    local requestData = {activityUuid = self._annivDojo.id , rewardId = #rewardIdList > 1 and 0 or rewardIdList[1]}
    GameUtils.Request(Interfaces.ActivityRotaryDrawCarnivalValueRewards, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)
            local rewardList   = checkTable(responseData.rewards)

            -- update data
            for _, cellIndex in ipairs(cellIndexList) do
                local cellData = self.rewardDataList_[cellIndex]
                cellData.status = 2
            end

            -- update view
            -- self:UpdateRewardList_()
            self:CheckRewardRedPoint_()

            -- draw rewards
            GoodsUtils.DrawRewards(rewardList, true)
            CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, { rewards = rewardList, cb = function()
                self:RequestRankData_()
            end})
        end
    end)
end


function ActivityRotaryTableExchangeDialog:CheckRewardRedPoint_()
    local hasReward = false
    for cellIndex, cellData in ipairs(self.rewardDataList_) do
        if cellData.status == 1 then
            hasReward = true
            break
        end
    end
    ActivityUtils.UpdateActivityMainRedPointState(self._annivDojo.id, hasReward and 0 or -1)
end


-------------------------------------------------
-- handler

function ActivityRotaryTableExchangeDialog:OnClickCloseButtonHandler_()
    CfUtils.DialogBack()
end


---@param listView SuperScrollView.LoopListView2
---@param listIndex integer @ start with 0
function ActivityRotaryTableExchangeDialog:OnUpdateRewardListCellHandler_(listView, listIndex)
    if listIndex < 0 then return end
    local cellNode = listView:NewListViewItem("Cell")
    ---@type ActivityRotaryTableExchangeCell
    local cellEnv = CfUtils.GetLuaScr(cellNode.gameObject, RewardCellNodeLuaPath)
    if cellEnv then
        local luaIndex = listIndex + 1
        local cellData = checkTable(self.rewardDataList_[luaIndex])
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(cellData)
        cellEnv:SetDrawCb(Bind(self, self.OnClickCellDrawButtonHandler_))
    end
    return cellNode
end


---@param cellEnv ActivityRotaryTableExchangeCell
function ActivityRotaryTableExchangeDialog:OnClickCellDrawButtonHandler_(cellEnv)
    local cellData = cellEnv:GetCellData()
    if cellData.status == 1 then
        self:DrawExchangeReward_({cellEnv:GetLuaIndex()})
    else
        GameUtils.Toast('奖励已领取')
    end
end


function ActivityRotaryTableExchangeDialog:OnClickQuickDrawButtonHandler_()
    local drawIndexList = {}
    for cellIndex, cellData in ipairs(self.rewardDataList_) do
        if cellData.status == 1 then
            table.insert(drawIndexList, cellIndex)
        end
    end
    if #drawIndexList > 0 then
        self:DrawExchangeReward_(drawIndexList)
    else
        GameUtils.Toast('无奖励领取')
    end
end


return ActivityRotaryTableExchangeDialog
