-------------------------------------------------------------------------------
-- 夜巡迷宫 - 道具选择角色弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-01-21 00:40:29
-------------------------------------------------------------------------------

local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
local patrolMazeComp  = PatrolMazeUtils.GetComp()

local HpAnimTweenId = 'PatrolMazeGoodsChooseRoleDialog_HpAnimTweenId'

local CardsGridCellPath = 'Game.UI.PatrolMaze.PatrolMazeGoodsChooseRoleNode'
local CardsGridCellName = 'Cell'

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/Patrol/PatrolChooseRolePopup130201.prefab > name: PatrolChooseRolePopup130201
---@class PatrolMazeGoodsChooseRoleDialog
---@field Env                           	PatrolMazeGoodsChooseRoleDialog         
---@field controller                    	Engine.UI.UILuaDialog                   
---@field ClickArea                     	UnityEngine.RectTransform               	@ 0    空白点击区域
---@field RootNode                      	UnityEngine.RectTransform               	@ 1    根节点
---@field CloseBtn                      	UnityEngine.RectTransform               	@ 2    关闭按钮
---@field UseGoodsBtn                   	UnityEngine.RectTransform               	@ 3    使用道具按钮
---@field ShowDetailBtn                 	UnityEngine.RectTransform               	@ 4    查看详情按钮
---@field CardGridView                  	SuperScrollView.LoopGridView            	@ 5    卡牌列表
local PatrolMazeGoodsChooseRoleDialog = Class('PatrolMazeGoodsChooseRoleDialog')


function PatrolMazeGoodsChooseRoleDialog:__init()
    ---@type PatrolMazeAreaDojo @ 当前所在区域dojo
    self.mapAreaDojo_ = nil

    ---@type PatrolMazeGoodsVo @ 使用的道具vo
    self.mazeGoodsVo_ = nil

    ---@type number @ 恢复的血量值
    self.recoverHpNum_ = 0

    ---@type UnityEngine.Coroutine
    self.playCardAnimCo_ = nil
end


function PatrolMazeGoodsChooseRoleDialog:__delete()
    self.mapAreaDojo_    = nil
    self.mazeGoodsVo_    = nil
    self.recoverHpNum_   = nil
    self.playCardAnimCo_ = nil
end


function PatrolMazeGoodsChooseRoleDialog:Awake()
    SetButtonAction(self.CloseBtn, Bind(self, self.OnClickCloseButtonHandler_))
    SetButtonAction(self.ClickArea, Bind(self, self.OnClickCloseButtonHandler_))
    SetButtonAction(self.UseGoodsBtn, Bind(self, self.OnClickUseGoosButtonHandler_))
    SetButtonAction(self.ShowDetailBtn, Bind(self, self.OnClickShowDetailButtonHandler_))
    SetGridViewAction(self.CardGridView, Bind(self, self.OnUpdateCardGridCellHandler_))
end


function PatrolMazeGoodsChooseRoleDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams   = CfUtils.DialogSafeParameters(self.controller)
        local mazeGoodsId  = checkInt(initParams.mazeGoodsId)
        self.mapAreaDojo_  = initParams.mapAreaDojo
        self.mazeGoodsVo_  = PatrolMazeUtils.GetMazeGoodsVo(mazeGoodsId)
        self.cardDojoList_ = {}

        for cardIndex, cardId in ipairs(checkTable(initParams.cardIdList)) do
            self.cardDojoList_[cardIndex] = self.mapAreaDojo_:GetMazeCard(cardId)
        end

        if (self.mazeGoodsVo_.effectType == PatrolMazeUtils.EffectType.RECOVER or
            self.mazeGoodsVo_.effectType == PatrolMazeUtils.EffectType.REVIVE) then
            self.recoverHpNum_ = self.mazeGoodsVo_.effectNum
        end

        local selectCardIndex = 1
        if initParams.selectCardIndex ~= nil then
            selectCardIndex = initParams.selectCardIndex
        end
        self:SetSelectCardIndex(selectCardIndex)
        self:UpdateCardGridView_()
    end)
end


function PatrolMazeGoodsChooseRoleDialog:OnFinalize()
    return CoWaitDo(function()
        local initParams = CfUtils.DialogSafeParameters(self.controller)
        initParams.selectCardIndex = self:GetSelectCardIndex()

        if self.playCardAnimCo_ then
            CoStop(self.playCardAnimCo_)
            self.playCardAnimCo_ = nil
        end

        CS.DG.Tweening.DOTween.Kill(HpAnimTweenId)
        CfUtils.ConditionRemove(HpAnimTweenId)
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return PatrolMazeCardDojo[]
function PatrolMazeGoodsChooseRoleDialog:GetCardDojoList()
    return self.cardDojoList_
end


---@return integer
function PatrolMazeGoodsChooseRoleDialog:GetSelectCardIndex()
    return checkInt(self.selectCardIndex_)
end
function PatrolMazeGoodsChooseRoleDialog:SetSelectCardIndex(index)
    local oldSelectIndex  = self:GetSelectCardIndex()
    local newSelectIndex  = checkInt(index)
    self.selectCardIndex_ = newSelectIndex
    self:SwitchCardSelect_(oldSelectIndex, newSelectIndex)
end


-------------------------------------------------
-- public

function PatrolMazeGoodsChooseRoleDialog:Close()
    CfUtils.DialogBack()
end


-------------------------------------------------
-- private

function PatrolMazeGoodsChooseRoleDialog:UpdateCardGridView_()
    local gridDataLength = #self:GetCardDojoList()
    GameUtils.ReloadData(self.CardGridView, gridDataLength)
end


---@param oldSelect integer
---@param newSelect integer
function PatrolMazeGoodsChooseRoleDialog:SwitchCardSelect_(oldSelect, newSelect)
    local oldCardCellNode = self.CardGridView:GetShownItemByItemIndex(oldSelect - 1)
    local newCardCellNode = self.CardGridView:GetShownItemByItemIndex(newSelect - 1)

    ---@type PatrolMazeGoodsChooseRoleNode
    local oldCardCellEnv = CfUtils.GetLuaScr(oldCardCellNode, CardsGridCellPath)
    ---@type PatrolMazeGoodsChooseRoleNode
    local newCardCellEnv = CfUtils.GetLuaScr(newCardCellNode, CardsGridCellPath)

    if oldCardCellEnv then
        oldCardCellEnv:UpdateSelectStatus(false)
        oldCardCellEnv:ShowRecoverHp(0)
    end

    if newCardCellEnv then
        newCardCellEnv:UpdateSelectStatus(true)
        newCardCellEnv:ShowRecoverHp(self.recoverHpNum_)
    end
end


---@param cardCellEnv PatrolMazeGoodsChooseRoleNode
---@param oldHp number
---@param newHp number
function PatrolMazeGoodsChooseRoleDialog:PlayCardCellHpChangeAnim_(cardCellEnv, oldHp, newHp)
    if not cardCellEnv then return end

    self.playCardAnimCo_ = CoStart(function()
        CfUtils.ConditionAppend(HpAnimTweenId)

        -- 更新头像血量
        local hpAnimTime  = 0.5
        local hpAnimTween = CfUtils.DoTween(hpAnimTime, function(value)
            cardCellEnv:UpdateHpProgress(oldHp, newHp, value)
        end)
        hpAnimTween.stringId = HpAnimTweenId
        CoYield(hpAnimTime)

        cardCellEnv:ShowRecoverHp(self.recoverHpNum_)
        CfUtils.ConditionRemove(HpAnimTweenId)
        self.playCardAnimCo_ = nil
    end)
end


---@param cardCellEnv PatrolMazeGoodsChooseRoleNode
---@param oldStar number
---@param newStar number
function PatrolMazeGoodsChooseRoleDialog:PlayCardCellStarChangeAnim_(cardCellEnv, oldStar, newStar)
    if not cardCellEnv then return end

    self.playCardAnimCo_ = CoStart(function()
        ---@type PatrolMazeCardDojo
        local mazeCardDojo = cardCellEnv:GetCellData().mazeCardDojo
        local fakeCardDojo = clone(mazeCardDojo.cardDojo)
        for star = oldStar + 1, newStar do
            ---@type CardDojo
            fakeCardDojo.star = star -1
            cardCellEnv:PlayUpStarEffect(star, fakeCardDojo)
            CoYield(0.5)
        end
        cardCellEnv:SetCellData(cardCellEnv:GetCellData())
        self.playCardAnimCo_ = nil
    end)
end


-------------------------------------------------
-- handler

function PatrolMazeGoodsChooseRoleDialog:OnClickCloseButtonHandler_()
    self:Close()
end


function PatrolMazeGoodsChooseRoleDialog:OnClickShowDetailButtonHandler_()
    local mazeCardDojo = self:GetCardDojoList()[self:GetSelectCardIndex()]
    local assistCardVo = PatrolMazeUtils.GetAssistCardVo(mazeCardDojo.assistId)
    CardUtils.ShowCardPreview({cardDojo = mazeCardDojo:GetCardDojo(), additionMap = assistCardVo.additionMap, isPureCard = true}, {
        UIArgs(Constants.UITypeIds.UIPatrolMazeMainDialog),
        UIArgs(Constants.UITypeIds.UIPatrolMazeGoodsChooseRoleDialog),
    })
end


function PatrolMazeGoodsChooseRoleDialog:OnClickUseGoosButtonHandler_()
    -- check goods isExist
    if self.mapAreaDojo_:GetBackpackGoodsNum(self.mazeGoodsVo_.goodsId) > 0 then
        local goodsEffectType = self.mazeGoodsVo_.effectType
        local selectCardIndex = self:GetSelectCardIndex()
        local mazeCardDojo    = self:GetCardDojoList()[selectCardIndex]

        if goodsEffectType == PatrolMazeUtils.EffectType.RECOVER then
            if mazeCardDojo.hpPercent >= 1 then
                GameUtils.Toast(localize('当前卡牌已经满血，无需再使用道具'))
                return
            end

        elseif goodsEffectType == PatrolMazeUtils.EffectType.REVIVE then
            if mazeCardDojo.hpPercent ~= 0 then
                GameUtils.Toast(localize('当前卡牌已经复活，无需再使用道具'))
                return
            end

        elseif goodsEffectType == PatrolMazeUtils.EffectType.UP_STAR then
            if mazeCardDojo.cardDojo.star >= Constants.CardMaxStar then
                GameUtils.Toast(localize('当前卡牌已经满星，无需再使用道具'))
                return
            end
        end

        patrolMazeComp:UseMazeGoods(self.mapAreaDojo_.areaId, self.mazeGoodsVo_.goodsId, mazeCardDojo.id, nil, nil, function(cardDataList)
            local goodsCardData = checkTable(cardDataList[1])
            local cardCellNode  = self.CardGridView:GetShownItemByItemIndex(selectCardIndex - 1)
            local mazeCardDojo  = self:GetCardDojoList()[selectCardIndex]
            self:GetCardDojoList()[selectCardIndex] = self.mapAreaDojo_:GetMazeCard(mazeCardDojo.id)

            ---@type PatrolMazeGoodsChooseRoleNode
            local cardCellEnv = CfUtils.GetLuaScr(cardCellNode, CardsGridCellPath)
            if cardCellEnv then
                cardCellEnv:GetCellData().mazeCardDojo = self:GetCardDojoList()[selectCardIndex]
                
                if goodsEffectType == PatrolMazeUtils.EffectType.RECOVER then
                    cardCellEnv:PlayRecoverEffect()
                    self:PlayCardCellHpChangeAnim_(cardCellEnv, goodsCardData.oldHpPercent, goodsCardData.newHpPercent)
                    
                elseif goodsEffectType == PatrolMazeUtils.EffectType.REVIVE then
                    cardCellEnv:PlayReviveEffect()
                    self:PlayCardCellHpChangeAnim_(cardCellEnv, goodsCardData.oldHpPercent, goodsCardData.newHpPercent)
                    
                elseif goodsEffectType == PatrolMazeUtils.EffectType.UP_STAR then
                    self:PlayCardCellStarChangeAnim_(cardCellEnv, goodsCardData.oldCardStar, goodsCardData.newCardStar)
                end
            end
        end)
    else
        GameUtils.Toast(localize('道具已经使用光了'))
    end
end


---@param gridView SuperScrollView.LoopGridView
---@param luaIndex integer
---@return SuperScrollView.LoopGridViewItem
function PatrolMazeGoodsChooseRoleDialog:OnUpdateCardGridCellHandler_(gridView, luaIndex)
    local cellNode = gridView:NewListViewItem(CardsGridCellName)
    local cellData = self:GetCardDojoList()[luaIndex]
    ---@type PatrolMazeGoodsChooseRoleNode
    local cellEnv = CfUtils.GetLuaScr(cellNode, CardsGridCellPath)
    if isNotNull(cellEnv) then
        local goodsEffectType = self.mazeGoodsVo_.effectType
        local isIgnorDeadMark = goodsEffectType == PatrolMazeUtils.EffectType.UP_STAR
        local isReviveCardHp  = goodsEffectType == PatrolMazeUtils.EffectType.REVIVE
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData({mazeCardDojo = cellData, isIgnorDead = isIgnorDeadMark, isReviveHp = isReviveCardHp})
        cellEnv:SetClickCellCB(Bind(self, self.OnClickCardGridCellCallback_))
        cellEnv:ShowRecoverHp(self:GetSelectCardIndex() == luaIndex and self.recoverHpNum_ or 0)
        cellEnv:UpdateSelectStatus(self:GetSelectCardIndex() == luaIndex)
    end
    return cellNode
end


---@param luaIndex integer
function PatrolMazeGoodsChooseRoleDialog:OnClickCardGridCellCallback_(luaIndex)
    if self:GetSelectCardIndex() ~= luaIndex then
        self:SetSelectCardIndex(luaIndex)
    end
end


return PatrolMazeGoodsChooseRoleDialog
