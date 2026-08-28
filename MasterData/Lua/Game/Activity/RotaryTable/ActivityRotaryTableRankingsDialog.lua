-------------------------------------------------------------------------------
-- 周年庆 - 庆典小铺（大转盘） - 排行榜界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-06-23 22:53:18
-------------------------------------------------------------------------------

local RankCellNodeLuaPath = 'Game.Activity.RotaryTable.ActivityRotaryTableRankingsCell'

---@type PlayerComponent
local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)

---@class ActivityRotaryTablePlayerDojo : BaseDojo
---@field New fun():ActivityRotaryTablePlayerDojo
local ActivityRotaryTablePlayerDojo = Class('ActivityRotaryTablePlayerDojo', require('Game.Dojo.BaseDojo'))
function ActivityRotaryTablePlayerDojo:__init()
    self.playerId       = 0
    self.name           = ''
    self.level          = 0
    self.avatar         = 0
    self.avatarFrame    = 0
    self.rank           = 0  -- 名次
    self.score          = 0  -- 当前积分
    self.goodsId        = 0  -- 用于排名的道具ID
end


--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/Anniversary/AnniversaryTurntableRankingsDialog.prefab
---@class ActivityRotaryTableRankingsDialog
---@field Env                           	ActivityRotaryTableRankingsDialog    
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RewardsButtonRedPoint         	UnityEngine.RectTransform               @ 奖励一览按钮红点
---@field RewardsButton                 	UnityEngine.RectTransform               @ 奖励一览按钮
---@field EmptyNode                     	UnityEngine.RectTransform               @ 空内容节点
---@field LayoutListAndMyselef          	UnityEngine.RectTransform               @ 排行内容父节点
---@field MyRanking                     	UnityEngine.RectTransform               @ 自己信息节点
---@field LoopView                      	SuperScrollView.LoopListView2           @ 排行列表
local ActivityRotaryTableRankingsDialog = Class('ActivityRotaryTableRankingsDialog')


function ActivityRotaryTableRankingsDialog:__init()
    ---@type ActivityDojo
    self._annivDojo = nil
    ---@type ActivityRotaryTablePlayerDojo[]
    self.rankDojoList_ = {}
    ---@type ActivityRotaryTablePlayerDojo
    self.myRankDojo_   = ActivityRotaryTablePlayerDojo.New()
end


function ActivityRotaryTableRankingsDialog:__delete()
    self._annivDojo    = nil
    self.rankDojoList_ = nil
    self.myRankDojo_   = nil
end


function ActivityRotaryTableRankingsDialog:Awake()
    SetButtonAction(self.RewardsButton, Bind(self, self.OnClickRewardsPreviewHandler_))
    self._annivRedPointChangeHandler = Events.AddListener(Constants.EventNames.ActivityRedPointChange, Bind(self, self.OnAnnivRedPointChangeHandler))
end


function ActivityRotaryTableRankingsDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        self._annivDojo  = initParams.annivDojo

        self:RequestRankData_()
        self:UpdateRankRedPoint_()
    end)
end


function ActivityRotaryTableRankingsDialog:OnFinalize()
    return CoWaitDo(function()
        Events.RemoveListener(Constants.EventNames.ActivityRedPointChange, self._annivRedPointChangeHandler)
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- private

function ActivityRotaryTableRankingsDialog:RequestRankData_()
    GameUtils.Request(Interfaces.ActivityRotaryRank, {activityUuid = self._annivDojo.id}, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)

            -- other rankData
            local rankGoodsId  = 0
            self.rankDojoList_ = {}
            for rankIndex, rankData in ipairs(responseData.rankList or {}) do
                local rankPlayerDojo = ActivityRotaryTablePlayerDojo.New()
                rankPlayerDojo:Fill(rankData)
                self.rankDojoList_[rankIndex] = rankPlayerDojo
                rankGoodsId = rankPlayerDojo.goodsId
            end

            -- myself rankData
            local playerDojo = playerComponent:GetPlayerDojo()
            self.myRankDojo_:Fill(responseData.myRank)
            self.myRankDojo_.playerId    = playerDojo.playerId
            self.myRankDojo_.name        = playerDojo.playerName
            self.myRankDojo_.level       = playerDojo.level
            self.myRankDojo_.avatar      = playerDojo.playerAvatar
            self.myRankDojo_.avatarFrame = playerDojo.playerAvatarFrame
            self.myRankDojo_.goodsId     = rankGoodsId

            -- init views
            self:UpdateRankList_()
        end
    end)
end


function ActivityRotaryTableRankingsDialog:UpdateRankList_()
    local rankListSize = #self.rankDojoList_
    local hasRankData  = rankListSize > 0
    CfUtils.SetActive(self.EmptyNode, not hasRankData)
    CfUtils.SetActive(self.LayoutListAndMyselef, hasRankData)

    if hasRankData then
        -- update rankList
        if not self.LoopView.IsListViewInit then
            self.LoopView:InitListView(rankListSize, Bind(self, self.OnUpdateRankListCellHandler_))
        else
            self.LoopView:MovePanelToItemIndex(0)
        end
        
        -- update myRank
        local myCellEnv = CfUtils.GetLuaScr(self.MyRanking.gameObject, RankCellNodeLuaPath)
        myCellEnv:SetMyRank(true)
        myCellEnv:SetCellData(self.myRankDojo_)
    end
end


function ActivityRotaryTableRankingsDialog:UpdateRankRedPoint_()
    local closeRankRed = CfUtils.GetLocalData(Constants.PlayerPrefsType.ActivityRotaryTableRankRed, '0')
    CfUtils.SetActive(self.RewardsButtonRedPoint, checkInt(closeRankRed) ~= 1)
end


-------------------------------------------------
-- handler

function ActivityRotaryTableRankingsDialog:OnAnnivRedPointChangeHandler()
    self:UpdateRankRedPoint_()
end


function ActivityRotaryTableRankingsDialog:OnUpdateRankListCellHandler_(listView, listIndex)
    if listIndex < 0 then return end
    local cellNode = listView:NewListViewItem("Cell")
    ---@type LadderCompetionRankCellNode
    local cellEnv = CfUtils.GetLuaScr(cellNode.gameObject, RankCellNodeLuaPath)
    if cellEnv then
        local luaIndex = listIndex + 1
        local cellData = checkTable(self.rankDojoList_[luaIndex])
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(cellData)
    end
    return cellNode
end


function ActivityRotaryTableRankingsDialog:OnClickRewardsPreviewHandler_()
    CfUtils.WriteLocalData(Constants.PlayerPrefsType.ActivityRotaryTableRankRed, '1')
    Events.Broadcast(Constants.EventNames.ActivityRedPointChange)

    CfUtils.DialogOpen(Constants.UITypeIds.UIActivityRotaryTableRankRewardPopup)
end


return ActivityRotaryTableRankingsDialog
