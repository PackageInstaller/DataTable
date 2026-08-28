-------------------------------------------------------------------------------
-- 夜寻迷宫 - 出战阵容推荐弹窗 - 阵容列表项
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-05-03 22:52:44
-------------------------------------------------------------------------------

local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
local patrolMazeComp  = PatrolMazeUtils.GetComp()

local BuffListCellName = 'Cell'

--- from: Assets/BundleResources/Prefabs/Patrol/PatrolPrepareRecommendCell130201.prefab > name: PatrolPrepareRecommendCell130201
---@class PatrolEnterRecommendPlanCell
---@field Env                           	PatrolEnterRecommendPlanCell            
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field PlanTitleTxt                  	UnityEngine.RectTransform               	@ 1    方案标题文本
---@field PlanPlayerNode                	UnityEngine.RectTransform               	@ 2    方案玩家信息
---@field PlayerHeadNode                	UnityEngine.RectTransform               	@ 3    方案玩家头像
---@field PlayerNameTxt                 	UnityEngine.RectTransform               	@ 4    方案玩家名字
---@field PlanMembersNode               	UnityEngine.RectTransform               	@ 5    方案成员列表
---@field PlanBuffList                  	SuperScrollView.LoopListView2           	@ 6    方案圣物列表
---@field ApplyPlanBtn                  	UnityEngine.RectTransform               	@ 7    应用方案按钮
local PatrolEnterRecommendPlanCell = Class('PatrolEnterRecommendPlanCell')


function PatrolEnterRecommendPlanCell:__init()
    ---@type CommonPlayerHeadNode @ 玩家头像节点
    self.planPlayerHeadNode_ = nil
    
    ---@type UITeamMembersNode @ 适用阵容节点
    self.displayMembersNode_ = nil

    ---@type integer[] @ 推荐圣物id列表
    self.planRelicIdList_ = {}
end


function PatrolEnterRecommendPlanCell:__delete()
    self.displayMembersNode_ = nil
    self.planPlayerHeadNode_ = nil
    self.planRelicIdList_    = nil
end


function PatrolEnterRecommendPlanCell:Awake()
    self.planPlayerHeadNode_ = CfUtils.GetLuaScr(self.PlayerHeadNode, Constants.UILuaTablePath.ComPlayerHead)
    self.displayMembersNode_ = CfUtils.GetLuaScr(self.PlanMembersNode, Constants.UILuaTablePath.TeamMembersNode)
    SetListViewAction(self.PlanBuffList, Bind(self, self.OnUpdateBuffListCellHandler_), BuffListCellName)
    SetButtonAction(self.ApplyPlanBtn, Bind(self, self.OnClickApplyPlanButtonHandler_))
end


function PatrolEnterRecommendPlanCell:Start()
end


function PatrolEnterRecommendPlanCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function PatrolEnterRecommendPlanCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function PatrolEnterRecommendPlanCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function PatrolEnterRecommendPlanCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function PatrolEnterRecommendPlanCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer, cardId:integer):void
function PatrolEnterRecommendPlanCell:GetClickCardCB()
    return self.clickCardCallback_
end
---@param callback fun(luaIndex:integer, cardId:integer):void
function PatrolEnterRecommendPlanCell:SetClickCardCB(callback)
    self.clickCardCallback_ = callback
end


---@return fun(luaIndex:integer):void
function PatrolEnterRecommendPlanCell:GetClickRelicCB()
    return self.clickRelicCallback_
end
---@param callback fun(luaIndex:integer):void
function PatrolEnterRecommendPlanCell:SetClickRelicCB(callback)
    self.clickRelicCallback_ = callback
end


---@return fun(luaIndex:integer, relicId:integer):void
function PatrolEnterRecommendPlanCell:GetClickApplyCB()
    return self.clickApplyCallback_
end
---@param callback fun(luaIndex:integer, relicId:integer):void
function PatrolEnterRecommendPlanCell:SetClickApplyCB(callback)
    self.clickApplyCallback_ = callback
end


-------------------------------------------------
-- private

function PatrolEnterRecommendPlanCell:UpdateCellInfo_()
    local cellData = self:GetCellData()

    ---@type PatrolMazeRecommendVo
    local recommendVo  = cellData
    local playerPlanVo = cellData
    local isPlayerPlan = cellData.playerId ~= nil


    ------------------------------------------------- [title info]
    local titleText = ''
    if isPlayerPlan then
        titleText = localize('最快通关')
        CfUtils.FillText(self.PlayerNameTxt, playerPlanVo.name)
        self.planPlayerHeadNode_:FreshAvatarFrame(playerPlanVo.avatar, playerPlanVo.avatarFrame)
    else
        titleText = localize('官方推荐_num_ _descr_', {_num_ = checkInt(recommendVo.recommendIndex), _descr_ = tostring(recommendVo.recommendDescr)})
    end
    CfUtils.FillText(self.PlanTitleTxt, titleText)
    CfUtils.SetActive(self.PlanPlayerNode, isPlayerPlan)


    ------------------------------------------------- [team info]
    ---@type CardDojo[]
    local cardDojoList = {}
    local coreCardNum  = 0
    if isPlayerPlan then
        for cardIndex, cardData in ipairs(playerPlanVo.cards) do
            local cardDojo = PatrolMazeUtils.GetMazeCardDojo(cardData.cardId)
            cardDojoList[cardIndex] = cardDojo
        end
    else
        coreCardNum = recommendVo.coreCardNum
        for cardIndex, planCardId in ipairs(recommendVo.cardIdList) do
            local cardDojo = PatrolMazeUtils.GetMazeCardDojo(planCardId)
            cardDojoList[cardIndex] = cardDojo
        end
    end
    self.displayMembersNode_.isIgnoreCardSize = true
    self.displayMembersNode_:ResetCells()
    self.displayMembersNode_:Refresh(cardDojoList, false, nil, function(cardId)
        if self:GetClickCardCB() then
            self:GetClickCardCB()(self:GetLuaIndex(), cardId)
        end
    end)

    ---@param cardIndex integer
    ---@param cardHead UITeamMemberNode
    self.displayMembersNode_:EachCardHeadNode(function(cardIndex, cardHead)
        CfUtils.SetActive(cardHead.MemberBg, false)
        CfUtils.SetActive(cardHead.CardPar.transform:Find('Key'), coreCardNum >= cardIndex)
    end)


    ------------------------------------------------- [buff info]
    self.planRelicIdList_ = isPlayerPlan and playerPlanVo.relics or recommendVo.relicIdList
    local listDataLength  = #self.planRelicIdList_
    GameUtils.ReloadData(self.PlanBuffList, listDataLength)
end


-------------------------------------------------
-- handler

function PatrolEnterRecommendPlanCell:OnClickApplyPlanButtonHandler_()
    if self:GetClickApplyCB() then
        self:GetClickApplyCB()(self:GetLuaIndex())
    end
end


---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer
---@return SuperScrollView.LoopListViewItem2
function PatrolEnterRecommendPlanCell:OnUpdateBuffListCellHandler_(listView, luaIndex)
    local cellNode = listView:NewListViewItem(BuffListCellName)
    local relicId  = checkInt(self.planRelicIdList_[luaIndex])
    local relicVo  = PatrolMazeUtils.GetMazeRelicVo(relicId)
    -- update info
    CfUtils.FillImage(cellNode.transform:Find('BtnNode/ImgBuffIcon'), relicVo.iconPath)
    CfUtils.SetUISwitchImage(cellNode.transform:Find('BtnNode/ImgBgRare'), relicVo.quality)
    CfUtils.SetUISwitchImage(cellNode.transform:Find('BtnNode/ImgBgRare2'), relicVo.quality)
    SetButtonAction(cellNode.transform:Find('BtnNode'), function()
        if self:GetClickRelicCB() then
            self:GetClickRelicCB()(self:GetLuaIndex(), relicId)
        end
    end)
    return cellNode
end


return PatrolEnterRecommendPlanCell
