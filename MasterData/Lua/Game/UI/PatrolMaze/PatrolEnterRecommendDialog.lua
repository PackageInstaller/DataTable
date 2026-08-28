-------------------------------------------------------------------------------
-- 夜寻迷宫 - 出战阵容推荐弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-05-03 17:38:17
-------------------------------------------------------------------------------

local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
local patrolMazeComp  = PatrolMazeUtils.GetComp()

local PlanListCellPath = 'Game.UI.PatrolMaze.PatrolEnterRecommendPlanCell'
local PlanListCellName = 'PatrolPrepareRecommendCell130201'

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/Patrol/PatrolPrepareRecommendDialog130201.prefab > name: PatrolPrepareRecommendDialog130201
---@class PatrolEnterRecommendDialog
---@field Env                           	PatrolEnterRecommendDialog              
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field BlockArea                     	UnityEngine.RectTransform               	@ 1    空白点击区域
---@field PlanList                      	SuperScrollView.LoopListView2           	@ 2    方案列表
local PatrolEnterRecommendDialog = Class('PatrolEnterRecommendDialog')


function PatrolEnterRecommendDialog:__init()
    ---@type integer @ 区域id
    self.mapAreaId_ = 0

    ---@type table<integer, boolean> @ 区域初始卡牌map
    self.initCardMap_ = {}

    ---@type table[] @ 方案数据列表
    self.planDataList_ = {}
end


function PatrolEnterRecommendDialog:__delete()
    self.mapAreaId_    = nil
    self.initCardMap_  = nil
    self.planDataList_ = nil
end


function PatrolEnterRecommendDialog:Awake()
    SetButtonAction(self.BlockArea, Bind(self, self.OnClickBlockAreaHandler_))
    SetListViewAction(self.PlanList, Bind(self, self.OnUpdatePlanListCellHandler_), PlanListCellName)
end


function PatrolEnterRecommendDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams   = CfUtils.DialogSafeParameters(self.controller)
        self.mapAreaId_    = checkInt(initParams.areaId)
        self.planDataList_ = PatrolMazeUtils.GetMazeRecommendVoList(self.mapAreaId_)

        local areaInfoVo = PatrolMazeUtils.GetAreaInfoVo(self.mapAreaId_)
        for _, cardId in ipairs(areaInfoVo.initCards) do
            self.initCardMap_[checkInt(cardId)] = true
        end

        local requestData = {areaId = self.mapAreaId_}
        GameUtils.Request(Interfaces.OverseaMazeRecommendPlan, requestData, function(request, response)
            if checkInt(response.errCode) == 0 then

                -- insert play plan
                local responseData = checkTable(response.data)
                if checkInt(responseData.playerId) > 0 then
                    table.insert(self.planDataList_, 1, responseData)
                end

                -- reload planList
                local listDataLength = #self:GetPlanDataList()
                GameUtils.ReloadData(self.PlanList, listDataLength)
            end
        end)
    end)
end


function PatrolEnterRecommendDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

function PatrolEnterRecommendDialog:GetPlanDataList()
    return checkTable(self.planDataList_)
end


-------------------------------------------------
-- public

function PatrolEnterRecommendDialog:Close()
    CfUtils.DialogBack()
end


-------------------------------------------------
-- handler

function PatrolEnterRecommendDialog:OnClickBlockAreaHandler_()
    self:Close()
end


---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer
---@return SuperScrollView.LoopListViewItem2
function PatrolEnterRecommendDialog:OnUpdatePlanListCellHandler_(listView, luaIndex)
    local cellNode = listView:NewListViewItem(PlanListCellName)
    local cellData = self:GetPlanDataList()[luaIndex]
    ---@type PatrolEnterRecommendPlanCell
    local cellEnv = CfUtils.GetLuaScr(cellNode, PlanListCellPath)
    if isNotNull(cellEnv) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(cellData)
        cellEnv:SetClickCardCB(Bind(self, self.OnClickPlanCellCardNodeCallback_))
        cellEnv:SetClickRelicCB(Bind(self, self.OnClickPlanCellRelicNodeCallback_))
        cellEnv:SetClickApplyCB(Bind(self, self.OnClickPlanCellApplyButtonCallback_))
    end
    return cellNode
end


---@param luaIndex integer @ start at 1
---@param cardId integer
function PatrolEnterRecommendDialog:OnClickPlanCellCardNodeCallback_(luaIndex, cardId)
    local cardDojo = PatrolMazeUtils.GetMazeCardDojo(cardId)
    CardUtils.ShowCardPreview({cardDojo = cardDojo, additionMap = nil, isPureCard = true}, {
        UIArgs(Constants.UITypeIds.UIPatrolMazePrimaryMapDialog),
        UIArgs(Constants.UITypeIds.UIPatrolEnterRecommendDialog),
    })
end


---@param luaIndex integer @ start at 1
---@param relicId integer
function PatrolEnterRecommendDialog:OnClickPlanCellRelicNodeCallback_(luaIndex, relicId)
    CfUtils.DialogOpen(Constants.UITypeIds.UIPatrolEnterBuffPreviewDialog, {relicId = relicId})
end


---@param luaIndex integer @ start at 1
function PatrolEnterRecommendDialog:OnClickPlanCellApplyButtonCallback_(luaIndex)
    local cellData = self:GetPlanDataList()[luaIndex]

    ---@type PatrolMazeRecommendVo
    local recommendVo  = cellData
    local playerPlanVo = cellData
    local isPlayerPlan = cellData.playerId ~= nil

    local cardIdList = {}
    if isPlayerPlan then
        for cardIndex, cardData in ipairs(playerPlanVo.cards) do
            cardIdList[cardIndex] = checkInt(cardData.cardId)
        end
    else
        for cardIndex, planCardId in ipairs(recommendVo.cardIdList) do
            cardIdList[cardIndex] = checkInt(planCardId)
        end
    end

    -- 特意检测合法性，防止配表配置错了卡牌
    for _, cardId in pairs(cardIdList) do
        if not self.initCardMap_[cardId] then
            GameUtils.Toast(localize('该阵容中配置了当前区域不可选的卡牌'))
            return
        end
    end

    CfUtils.CookieSave(Constants.UICacheDataKeys.PATROL_ENTER_PLAN_SELECT_DATA, {
        planId      = isPlayerPlan and -1 or recommendVo.recommendIndex,
        cardIdList = cardIdList,
    })
    self:Close()
end


return PatrolEnterRecommendDialog
