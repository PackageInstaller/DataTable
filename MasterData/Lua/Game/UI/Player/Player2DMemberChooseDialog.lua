---
--- Created by zou hanjie
--- DateTime: 2023/11/09 1:47 PM 
---

local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local PlayerInfoUtils = import('Game.UI.Player.PlayerInfoUtils')
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local KCookie = CS.Engine.Lib.KCookie

local MEMBER_MAX_NUM = 4

---@class Player2DMemberChooseDialog
local Player2DMemberChooseDialog = Class("Player2DMemberChooseDialog")

---@field ChooseCardsView               	UnityEngine.RectTransform
---@field FontStyleWithIconButton2      	UnityEngine.RectTransform
---@field FontStyleWithIconButton1      	UnityEngine.RectTransform
---@field CommonFilterNode              	UnityEngine.RectTransform

function Player2DMemberChooseDialog:__init()
    self.typeAscMap_        = {}
    self.selectedCardList_  = PlayerInfoUtils.GetRevealTeamData()
    self.isSelectFullCardsAtInit = false -- 进来的时候, 玩家是不是已经选中 4 张卡了
    self.selectedCardIndex_ = {}

    ----@type CardComponent
    local cardComp     = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
    self.allCardList_  = cardComp.cards
    self.showCardList_ = self.allCardList_
end

function Player2DMemberChooseDialog:__delete()
    self.controller         = nil
    self.typeAscMap_        = nil
    self.selectedCardList_  = nil
    self.allCardList_       = nil
    self.showCardList_      = nil
    self.selectedCardIndex_ = nil
end

function Player2DMemberChooseDialog:Awake()
    SetButtonAction(self.FontStyleWithIconButton1, function()
        self:OnClickConfirmBtnHandler_()
    end)
    SetButtonAction(self.FontStyleWithIconButton2, Bind(self, self.OnClickCancelBtnHandler_))
end

function Player2DMemberChooseDialog:OnFocus(focus)
    if focus then
        CfUtils.RefreshTopCommon(Bind(self, self.OnClickCancelBtnHandler_), false, true)
    end
end

function Player2DMemberChooseDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        KTool.SetRenderFeatureActiveByName(Constants.RenderFeatureNames.BLUR, true)
        Events.Broadcast(Constants.EventNames.PlayerUpdateMainBtnVisible, false)
        self:InitView()
    end))
    return coWait
end

function Player2DMemberChooseDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        CfUtils.RefreshTopCommon(nil)
        KTool.SetRenderFeatureActiveByName(Constants.RenderFeatureNames.BLUR, false)
        Events.Broadcast(Constants.EventNames.PlayerUpdateMainBtnVisible, true)
        Events.Broadcast(Constants.EventNames.Player2DShowMainDialog, true) -- 显示 2D 主界面

        self.controller = nil --删除lua层引⽤用到的c#对象,否则不不会产⽣生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要 
    end))
    return coWait
end

-------------------------------------------------- set/get

function Player2DMemberChooseDialog:GetMemberDataByIndex(index)
    return checkTable(self.showCardList_[index])
end

function Player2DMemberChooseDialog:IsSelected(cardId)
    local pos = self:GetMemberDataByIndex(cardId)
    return pos > 0
end
function Player2DMemberChooseDialog:AddSelected(cardId, index)
    if #self.selectedCardList_ >= MEMBER_MAX_NUM then
        GameUtils.Toast(localize("可选择武装数量已达上限"))
        return
    end
    table.insert(self.selectedCardList_, cardId)
    self.selectedCardIndex_[#self.selectedCardList_] = {index = index, cardId = cardId}
    self:RefreshPosNode(index, #self.selectedCardIndex_)
    self.isTeamChanged_ = true
end
function Player2DMemberChooseDialog:GetTeamPosByCardId(cardId)
    for index, id in ipairs(self.selectedCardList_) do
        if checkInt(cardId) == checkInt(id) then
            return index
        end
    end
    return 0
end
function Player2DMemberChooseDialog:RemoveSelected(cardId, index)
    self.isTeamChanged_ = true
    for idx, id in ipairs(self.selectedCardList_) do
        if checkInt(cardId) == checkInt(id) then
            table.remove(self.selectedCardIndex_, idx)
            table.remove(self.selectedCardList_, idx)
            self:RefreshPosNode(index, 0)
            break
        end
    end
    self:RefreshAllPosNode()
end

-------------------------------------------------- handler

-- 保存按钮:
function Player2DMemberChooseDialog:OnClickConfirmBtnHandler_()
    if #self.selectedCardList_ <= 0 then
        GameUtils.Toast(localize("需至少选择一位武装"))
        return
    end

    if (self.isSelectFullCardsAtInit == true) and (#self.selectedCardList_ < MEMBER_MAX_NUM) then 
        GameUtils.Toast(localize("请选择4名战斗员进行展示"))
        return
    end

    GameUtils.Request(
            Interfaces.PlayerSetRevealTeam,
            { playerCardIds = table.concat(self.selectedCardList_, ",") },
            function(request, response)
                if checkInt(response.errCode) == 0 then
                    ---维护数据
                    local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
                    playerComponent.playerDojo.revealTeam = self.selectedCardList_

                    self:RefreshView()
                    GameUtils.Toast(localize("已保存武装变更"))
                    PlayerInfoUtils.ChangePlayerInfo()
                    self.isTeamChanged_ = false

                    KCookie.Set("Player2DIsNeedRefreshCardList",  true ) -- 要求重绘 4卡牌列表

                    UIModule.BackDialog()
                end
            end
    )
end

function Player2DMemberChooseDialog:OnClickCancelBtnHandler_()
    if self.isTeamChanged_ then
        GameUtils.SecondConfirm(localize("是否要保存当前的修改并退出？"),
                function()
                    self:OnClickConfirmBtnHandler_()
                end,
                function()
                    UIModule.BackDialog()
                end)
    else
        UIModule.BackDialog()
    end
end
-------------------------------------------------- public

function Player2DMemberChooseDialog:InitView()
    ---@type UICommonFilterMB
    local filterNodeEnv = self.CommonFilterNode.Env
    if isNull(filterNodeEnv) then
        self.CommonFilterNode:Init()
        filterNodeEnv = self.CommonFilterNode.Env
    end
    filterNodeEnv:SetCallback(self.allCardList_, function(data)
        self.showCardList_ = checkTable(data)
        self:RefreshView()
    end)
    filterNodeEnv:RestoreState(Constants.UICacheDataKeys.UICultivateEntryFilterState, function(data)
        self.showCardList_ = checkTable(data)
        self:RefreshView()
    end)
    self:RefreshView()
end

function Player2DMemberChooseDialog:RefreshView()
    local selectedMap = {}
    self.selectedCardIndex_ = {}
    for index, id in ipairs(self.selectedCardList_) do
        selectedMap[checkInt(id)] = checkInt(index)
        self.selectedCardIndex_[selectedMap[checkInt(id)]] = {index = index, cardId = id}
    end

    local temporaryDt = {}
    local index       = 1
    while (table.count(temporaryDt) < #self.selectedCardList_ and index <= #self.showCardList_) do
        local cardId = checkInt(self.showCardList_[index].id)
        if selectedMap[cardId] ~= nil then
            local data = table.remove(self.showCardList_, index)
            temporaryDt[selectedMap[cardId]] = data
        else
            index = index + 1
        end
    end

    index = 1
    for _, cardDt in pairs(temporaryDt) do
        table.insert(self.showCardList_, index, cardDt)
        index = index + 1
    end

    local num = #self.showCardList_
    if not self.ChooseCardsView.mLoopListView.IsListViewInit then
        self.ChooseCardsView:InitListView(num, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(self.ChooseCardsView, num)
    end
end


function Player2DMemberChooseDialog:OnGetItemByIndex(cell, index)
    if index < 0 then
        return
    end
    self:RefreshMemberCell(cell, index + 1)
end


function Player2DMemberChooseDialog:RefreshMemberCell(node, index)
    local memberInfo = self:GetMemberDataByIndex(index)
    KTool.SetActive(node, next(memberInfo) ~= nil)
    if next(memberInfo) ~= nil then
        ---@type UIFightChooseCardsCardCellNode
        local scr = CfUtils.GetLuaScr(node.gameObject, "Game.UI.FightTeam.UIFightChooseCardsDialog.UIFightChooseCardsCardCellNode")
        local pos = self:GetTeamPosByCardId(memberInfo.id)
        if scr then
            scr:RefreshChooseStatu(pos > 0)
            scr:RefreshCurPos(pos)
            scr:RefreshBaseData(memberInfo, function()
                if self:GetTeamPosByCardId(memberInfo.id) > 0 then
                    self:RemoveSelected(memberInfo.id, index)
                else
                    self:AddSelected(memberInfo.id, index)
                end
            end)
        end
    end
end

function Player2DMemberChooseDialog:RefreshAllPosNode()
    for pos, data in ipairs(self.selectedCardIndex_) do
        self:RefreshPosNode(data.index, pos)
    end
end

function Player2DMemberChooseDialog:RefreshPosNode(index, pos)
    local cell = self.ChooseCardsView:GetShownItemByItemIndex(index - 1)
    if not cell then
        return
    end

    if cell then
        ---@type UIFightChooseCardsCardCellNode
        local scr = CfUtils.GetLuaScr(cell.gameObject, "Game.UI.FightTeam.UIFightChooseCardsDialog.UIFightChooseCardsCardCellNode")
        if scr then
            scr:RefreshChooseStatu(pos > 0)
            scr:RefreshCurPos(pos)
        end
    end
end


return Player2DMemberChooseDialog