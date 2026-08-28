-------------------------------------------------------------------------------
-- 夜寻迷宫 - 区域出战编队弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-12-29 16:36:34
-------------------------------------------------------------------------------

local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
local patrolMazeComp  = PatrolMazeUtils.GetComp()

local CardNodeLuaPath = 'Game.UI.FightTeam.UIFightTeamDialog.UIFightTeamTeamNode'

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/Patrol/PatrolPrepareBeforeFightPopup130201.prefab > name: PatrolPrepareBeforeFightPopup130201
---@class PatrolMazeAreaEnterTeamPopup
---@field Env                           	PatrolMazeAreaEnterTeamPopup            
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field ClickArea                     	UnityEngine.RectTransform               	@ 1    空白点击区域
---@field CloseBtn                      	UnityEngine.RectTransform               	@ 2    关闭按钮
---@field IntroTxt                      	UnityEngine.RectTransform               	@ 3    介绍文本
---@field TeamNodeRoot                  	UnityEngine.RectTransform               	@ 4    编队节点根节点
---@field EnterAreaBtn                  	UnityEngine.RectTransform               	@ 5    进入区域按钮
---@field RecommendBtn                  	UnityEngine.RectTransform               	@ 6    推荐阵容按钮
local PatrolMazeAreaEnterTeamPopup = Class('PatrolMazeAreaEnterTeamPopup')


function PatrolMazeAreaEnterTeamPopup:__init()
    ---@type integer @ 区域id
    self.mapAreaId_ = nil

    ---@type integer @ 进入区域卡牌数量
    self.enterCardNum_ = 0

    ---@type UIFightTeamTeamNode[] @ 编队头像列表
    self.cardNodeEnvList_ = {}

    ---@type CardDojo[] @ 可选卡牌数据列表
    self.allCardDojoList_ = {}

    ---@type table<integer, CardDojo> @ 可选卡牌数据字典
    self.allCardDojoMap_ = {}

    ---@type table @ 选择的方案数据
    self.selectPlanData_ = {}
end


function PatrolMazeAreaEnterTeamPopup:__delete()
    self.mapAreaId_       = nil
    self.cardNodeEnvList_ = nil
    self.allCardDojoList_ = nil
    self.allCardDojoMap_  = nil
    self.selectPlanData_  = nil
end


function PatrolMazeAreaEnterTeamPopup:Awake()
    SetButtonAction(self.CloseBtn, Bind(self, self.OnClickCloseButtonHandler_))
    SetButtonAction(self.ClickArea, Bind(self, self.OnClickCloseButtonHandler_))
    SetButtonAction(self.EnterAreaBtn, Bind(self, self.OnClickEntryButtonHandler_))
    SetButtonAction(self.RecommendBtn, Bind(self, self.OnClickRecommendButtonHandler_))
    self.eventsDecorated_ = CfUtils.EventsDecorated({
        [PatrolMazeUtils.EventsName.ENTER_TEAM_SELECT] = Bind(self, self.OnEnterTeamSelectHandler_),
    })

    self.enterCardNum_ = PatrolMazeUtils.EnterAreaCardNum
    for cardIndex = 1, self.enterCardNum_ do
        local cardNodeTf  = self.TeamNodeRoot:Find('TeamNode' .. cardIndex)
        local cardNodeEnv = CfUtils.GetLuaScr(cardNodeTf, CardNodeLuaPath)
        self.cardNodeEnvList_[cardIndex] = cardNodeEnv
    end
end


function PatrolMazeAreaEnterTeamPopup:OnInitialize()
    return CoWaitDo(function()
        local initParams = CfUtils.DialogSafeParameters(self.controller)
        self.mapAreaId_  = initParams.mapAreaId

        -- init datas
        local areaInfoVo = PatrolMazeUtils.GetAreaInfoVo(self.mapAreaId_)
        for _, cardId in ipairs(areaInfoVo.initCards) do
            local cardDojo = PatrolMazeUtils.GetMazeCardDojo(cardId)
            if cardDojo then
                cardDojo.isRecommend = checkBool(areaInfoVo.recommendMap[cardId])
                table.insert(self.allCardDojoList_, cardDojo)
                for _, cardDojo in ipairs(self.allCardDojoList_) do
                    self.allCardDojoMap_[checkInt(cardDojo.cardId)] = cardDojo
                end
            end
        end

        -- init intro
        CfUtils.FillText(self.IntroTxt, areaInfoVo.introduce)
        
        -- init cards
        local selectCardIdList = {}
        if initParams.selectCardIdList ~= nil then
            selectCardIdList = table.deserialize(initParams.selectCardIdList)
        end

        -- load planSelectData
        local planSelectData = CfUtils.CookieLoad(Constants.UICacheDataKeys.PATROL_ENTER_PLAN_SELECT_DATA) or {}
        CfUtils.CookieSave(Constants.UICacheDataKeys.PATROL_ENTER_PLAN_SELECT_DATA, nil)

        -- 如果选了新方案：记录新方案，并应用新方案
        if planSelectData.planId then
            self.selectPlanData_ = planSelectData
            selectCardIdList     = self.selectPlanData_.cardIdList

        -- 如果加载到老方案：加载老方案
        elseif initParams.planSelectData ~= nil then
            self.selectPlanData_ = table.deserialize(initParams.planSelectData)
        end

        self:SetSelectCardIdList(selectCardIdList)
    end)
end


function PatrolMazeAreaEnterTeamPopup:OnFinalize()
    return CoWaitDo(function()
        -- save dialog cache
        local initParams = self.controller.Argument.parameters
        initParams.selectCardIdList = table.serialize(self:GetSelectCardIdList())
        initParams.planSelectData   = table.serialize(self.selectPlanData_)

        CfUtils.EventsUndecorated(self.eventsDecorated_)
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return integer[]
function PatrolMazeAreaEnterTeamPopup:GetSelectCardIdList()
    return checkTable(self.selectCardIdList_)
end
function PatrolMazeAreaEnterTeamPopup:SetSelectCardIdList(cardIdList)
    self.selectCardIdList_ = {}
    for index, cardId in ipairs(checkTable(cardIdList)) do
        self.selectCardIdList_[index] = checkInt(cardId)
    end

    -- 检测是否有修改方案，被修改则视为丢弃方案选择
    local isModifyPlanData = false
    for cardIndex, cardId in ipairs(self.selectPlanData_.cardIdList or {}) do
        if self:GetSelectCardIdList()[cardIndex] ~= checkInt(cardId) then
            isModifyPlanData = true
            break
        end
    end
    if isModifyPlanData then
        self.selectPlanData_ = {}
    end

    self:UpdateSelectCardNodes_()
end


-------------------------------------------------
-- public

function PatrolMazeAreaEnterTeamPopup:Close()
    CfUtils.DialogBack()
end


-------------------------------------------------
-- private

function PatrolMazeAreaEnterTeamPopup:UpdateSelectCardNodes_()
    for cardIndex, cardNodeEnv in ipairs(self.cardNodeEnvList_) do
        local clickNodeCb  = Bind(self, self.OnClickTeamNodeHandler_, cardIndex)
        local selectCardId = checkInt(self:GetSelectCardIdList()[cardIndex])
        cardNodeEnv:Refresh(self.allCardDojoMap_[selectCardId], clickNodeCb, clickNodeCb, cardIndex)
    end
end


-------------------------------------------------
-- handler

---@param newSelectIds string[]
function PatrolMazeAreaEnterTeamPopup:OnEnterTeamSelectHandler_(newSelectIds)
    self:SetSelectCardIdList(newSelectIds)
end


function PatrolMazeAreaEnterTeamPopup:OnClickCloseButtonHandler_()
    Events.Broadcast(PatrolMazeUtils.EventsName.ENTER_TEAM_CLOSE)
    self:Close()
end


function PatrolMazeAreaEnterTeamPopup:OnClickEntryButtonHandler_()
    if self.enterCardNum_ ~= #self:GetSelectCardIdList() then
        GameUtils.Toast(localize('请选择_num_名战斗员', {_num_ = self.enterCardNum_}))
        return
    end

    local requestData = {areaId = self.mapAreaId_, cards = table.concat(self:GetSelectCardIdList(), ','), planId = self.selectPlanData_.planId}
    GameUtils.Request(Interfaces.OverseaMazeEnterAreaTeam, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)

            ---@type PatrolMazeAreaDojo
            local areaDojo = patrolMazeComp:GetHomeDojo():GetAreaDojo(self.mapAreaId_)
            areaDojo.isEntered   = true
            areaDojo.hasAreaTeam = true

            Events.Broadcast(PatrolMazeUtils.EventsName.ENTER_TEAM_ENTER, self.mapAreaId_)
            self:Close()
        end
    end)
end


function PatrolMazeAreaEnterTeamPopup:OnClickTeamNodeHandler_()
    local selectCount = #self.cardNodeEnvList_
    CfUtils.DialogOpen(Constants.UITypeIds.UIFightTeamCardChoose, {
        levelId         = Constants.SpecialQuestId.PatrolMazeInitId,
        chooseCardStatu = Constants.ChooseCardStatus.Custom,
        customCardDojos = self.allCardDojoList_,
        customSelectIds = self:GetSelectCardIdList(),
        customLeastNum  = selectCount,
        customLimitNum  = selectCount,
        customCheckSame = true,
        confirmCb       = function(newSelectIds)
            Events.Broadcast(PatrolMazeUtils.EventsName.ENTER_TEAM_SELECT, newSelectIds)
        end
    })
end


function PatrolMazeAreaEnterTeamPopup:OnClickRecommendButtonHandler_()
    CfUtils.DialogOpen(Constants.UITypeIds.UIPatrolEnterRecommendDialog, {areaId = self.mapAreaId_}, {
        UIArgs(Constants.UITypeIds.UIPatrolMazeEnterTeamPopup)
    })
end


return PatrolMazeAreaEnterTeamPopup
