-------------------------------------------------------------------------------
-- 和风战牌 - 编辑牌组界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-29 17:23:21
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')
local battleCardGameComp  = BattleCardGameUtils.GetComp()

local CardListCellPath = 'Game.UI.BattleCardGame.BattleCardGameDeckEditorCardCell'

local FilterTypes = {
    ALL = 0,  -- 全部的
}

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/ActivityJapaneseLevel/PokerEnter/ActivityJapanesePokerEditDialog.prefab > name: ActivityJapanesePokerEditDialog
---@class BattleCardGameDeckEditorDialog
---@field Env                           	BattleCardGameDeckEditorDialog          
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field BgNode                        	UnityEngine.RectTransform               	@ 1    背景节点
---@field DeckTitleTxt                  	UnityEngine.RectTransform               	@ 2    牌组标题文本
---@field UnlockTipsNode                	UnityEngine.RectTransform               	@ 3    解锁提示节点
---@field UnlockTipsTxt                 	UnityEngine.RectTransform               	@ 4    解锁提示文本
---@field SaveDeckBtn                   	UnityEngine.RectTransform               	@ 5    保存牌组按钮
---@field CardAddNode1                  	UnityEngine.RectTransform               	@ 6    牌组卡牌节点1
---@field CardAddNode2                  	UnityEngine.RectTransform               	@ 7    牌组卡牌节点2
---@field CardAddNode3                  	UnityEngine.RectTransform               	@ 8    牌组卡牌节点3
---@field CardAddNode4                  	UnityEngine.RectTransform               	@ 9    牌组卡牌节点4
---@field CardAddNode5                  	UnityEngine.RectTransform               	@ 10   牌组卡牌节点5
---@field TypeFilterNode                	UnityEngine.RectTransform               	@ 11   类型筛选节点
---@field LevelTabParent                	UnityEngine.RectTransform               	@ 12   等级页签父节点
---@field LevelTabCell                  	UnityEngine.RectTransform               	@ 13   等级页签子节点
---@field CardsLoopView                 	Engine.UI.AutoFixSizeListView           	@ 14   卡牌列表节点
---@field CardsEmptyNode                	UnityEngine.RectTransform               	@ 15   卡牌列表空节点
local BattleCardGameDeckEditorDialog = Class('BattleCardGameDeckEditorDialog')


function BattleCardGameDeckEditorDialog:__init()
    ---@type UICommonFilterMB @ 类型过滤按钮
    self.typeFilterEnv_ = nil

    ---@type table<integer, table<integer, BattleCardGameDeckEditorDialog.CardCellData[]>> @ 类型分组数据（key：类型id，value：数据map）(key：等级id，value：数据列表)
    self.typeGroupMap_ = {}

    ---@type BattleCardGameDeckEditorDialog.CardCellData[] @ 过滤数据列表
    self.filterDataList_ = {}

    ---@type integer @ 牌组索引
    self.editDeckIndex_ = 0

    ---@type UnityEngine.RectTransform[] @ 牌组卡牌子节点列表
    self.deckCardCells_ = {}

    ---@type UnityEngine.RectTransform[] @ 卡牌星级子节点列表
    self.cardStarCells_ = {}

    ---@type table[] @ 卡牌星级数据列表
    self.cardStarDatas_ = {}

    ---@type integer[] @ 最初的卡牌id列表
    self.originCardIdList_ = {}

    ---@type table<integer, integer> @ 卡牌id索引映射表（key：卡牌id，value：位置索引）
    self.cardIdIndexMap_ = {}
end


function BattleCardGameDeckEditorDialog:__delete()
    self.typeFilterEnv_    = nil
    self.typeGroupMap_     = nil
    self.filterDataList_   = nil
    self.editDeckIndex_    = nil
    self.deckCardCells_    = nil
    self.cardStarCells_    = nil
    self.cardStarDatas_    = nil
    self.originCardIdList_ = nil
    self.cardIdIndexMap_   = nil
end


function BattleCardGameDeckEditorDialog:Awake()
    self.typeFilterEnv_ = CfUtils.GetLuaScr(self.TypeFilterNode, Constants.UILuaTablePath.ComFilterMB)
    self.typeFilterEnv_:SetPageType(Constants.UIFilterPageType.DropDown)
    self.typeFilterEnv_:SetStyleType(Constants.UIFilterStyleType.White)
    self.typeFilterEnv_:SetCallback({}, function()
        local selectIndex  = self.typeFilterEnv_.selectIndex
        local sortTypeData = self.typeFilterEnv_.sortTypeList[selectIndex]
        self:SetFilterType(sortTypeData.conditionType)
    end)

    SetButtonAction(self.SaveDeckBtn, Bind(self, self.OnClickSaveDeckButtonHandler_))
    SetButtonAction(self.UnlockTipsNode, Bind(self, self.OnClickUnlockTipsNodeHandler_))
end


function BattleCardGameDeckEditorDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = CfUtils.DialogSafeParameters(self.controller)

        -- init vars
        self.editDeckIndex_    = checkInt(initParams.deckIndex)
        self.originCardIdList_ = battleCardGameComp:GetHomeDojo():GetDeckCards(self:GetEditDeckIndex())

        -- inti views
        self:InitDeckCardList_()
        self:InitCardStarList_()
        self:InitTypeGroupMap_()

        -- update views
        self:UpdateEditDeckInfo_()
        self:SetCardIdList(clone(self.originCardIdList_))
    end)
end


function BattleCardGameDeckEditorDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


function BattleCardGameDeckEditorDialog:OnShow()
    return CoWaitDo(function()
        SetFixSizeListViewAction(self.CardsLoopView, Bind(self, self.OnUpdateCardsListCellHandler_))

        -- 默认选择全部
        local filterDatas = self:CreateFilterDatas_()
        self.typeFilterEnv_:InitSortTypeData(filterDatas)
        self.typeFilterEnv_.selectIndex = 1  -- 全部
        self.typeFilterEnv_:RefreshUI()
        CfUtils.SetActive(self.TypeFilterNode, #filterDatas > 1)

        -- 选择一个有卡的最高星级页签
        local selectStar   = #BattleCardGameUtils.CardStarNames
        local filterType   = self:GetFilterType()
        local starGroupMap = checkTable(self.typeGroupMap_[filterType])
        for _, starData in ipairs(self.cardStarDatas_) do
            local starNum = checkInt(starData.starIndex)
            if #checkTable(starGroupMap[starNum]) > 0 then
                selectStar = starNum
                break
            end
        end
        self:SetSelectStar(selectStar)
    end)
end


function BattleCardGameDeckEditorDialog:HandleBackAction()
    if self:IsDeckChanged() then
        GameUtils.SecondConfirm(localize('编辑的牌组尚未保存，是否依然退出？'), function()
            self:Close()
        end)
    else
        self:Close()
    end
end


-------------------------------------------------
-- get / set

---@return integer
function BattleCardGameDeckEditorDialog:GetEditDeckIndex()
    return checkInt(self.editDeckIndex_)
end


---@return integer
function BattleCardGameDeckEditorDialog:GetFilterType()
    return checkInt(self.filterType_)
end
function BattleCardGameDeckEditorDialog:SetFilterType(type)
    self.filterType_ = checkInt(type)
    self:UpdateFilterDataList_()
end


---@return integer
function BattleCardGameDeckEditorDialog:GetSelectStar()
    return checkInt(self.selectStar_)
end
function BattleCardGameDeckEditorDialog:SetSelectStar(star)
    self.selectStar_ = checkInt(star)
    self:UpdateCardStarList_()
    self:UpdateFilterDataList_()
end


---@return BattleCardGameDeckEditorDialog.CardCellData[]
function BattleCardGameDeckEditorDialog:GetFilterDataList()
    return checkTable(self.filterDataList_)
end


---@return integer[]
function BattleCardGameDeckEditorDialog:GetCardIdList()
    return checkTable(self.cardIdList_)
end
function BattleCardGameDeckEditorDialog:SetCardIdList(cardIdList)
    local oldCardIdList  = self:GetCardIdList()
    local newCardIdList  = checkTable(cardIdList)
    self.cardIdList_     = newCardIdList
    self.cardIdIndexMap_ = {}
    for cardIndex, cardId in ipairs(newCardIdList) do
        self.cardIdIndexMap_[cardId] = cardIndex
    end
    self:UpdateDeckCardList_(oldCardIdList, newCardIdList)
    self:UpdateCardsListSelectState_()
end


--- 根据 卡牌id 获取 位置索引
---@param cardId integer
---@return integer
function BattleCardGameDeckEditorDialog:GetCardIdIndex(cardId)
    return checkInt(self.cardIdIndexMap_[checkInt(cardId)])
end


---@return boolean
function BattleCardGameDeckEditorDialog:IsDeckCardFull()
    return #self:GetCardIdList() >= BattleCardGameUtils.DeckCardCount
end


---@return boolean
function BattleCardGameDeckEditorDialog:IsDeckChanged()
    local isDeckChanged = false
    if #self.originCardIdList_ ~= #self:GetCardIdList() then
        isDeckChanged = true
    else
        for cardIndex, originCardId in ipairs(self.originCardIdList_) do
            local editCardId = checkInt(self:GetCardIdList()[cardIndex])
            if originCardId ~= editCardId then
                isDeckChanged = true
                break
            end
        end
    end
    return isDeckChanged
end


-------------------------------------------------
-- public

function BattleCardGameDeckEditorDialog:Close()
    CfUtils.DialogClose(self.controller)
end


-------------------------------------------------
-- private

function BattleCardGameDeckEditorDialog:InitTypeGroupMap_()
    -- create type datas
    self.typeGroupMap_ = {}

    local tempGroupMap = {
        [FilterTypes.ALL] = {}
    }
    for cardId, _ in pairs(battleCardGameComp:GetHomeDojo().cardIdMap) do
        local cardVo   = BattleCardGameUtils.GetCardInfoVo(cardId)
        local cardKind = checkInt(cardVo.cardKind)
        local cardStar = checkInt(cardVo.cardStar)
        ---@class BattleCardGameDeckEditorDialog.CardCellData
        ---@field cardId integer
        ---@field cardVo BattleCardGameCardInfoVo
        ---@field cardKind integer
        ---@field cardStar integer
        local cardData = {
            cardId   = cardId,
            cardVo   = cardVo,
            cardKind = cardKind,
            cardStar = cardStar,
        }
        if not tempGroupMap[cardKind] then
            tempGroupMap[cardKind] = {}
        end
        table.insert(tempGroupMap[cardKind], cardData)
        if cardKind > 0 then
            table.insert(tempGroupMap[FilterTypes.ALL], cardData)
        end
    end

    ---@param cardDataList BattleCardGameDeckEditorDialog.CardCellData[]
    for fillterType, cardDataList in pairs(tempGroupMap) do
        -- sort card datas
        ---@param aCardData BattleCardGameDeckEditorDialog.CardCellData
        ---@param bCardData BattleCardGameDeckEditorDialog.CardCellData
        table.sort(cardDataList, function(aCardData, bCardData)
            local aPriority = 0
            local bPriority = 0
            aPriority = aPriority + (aCardData.cardId < bCardData.cardId and 1 or 0)
            bPriority = bPriority + (bCardData.cardId < aCardData.cardId and 1 or 0)
            return aPriority > bPriority
        end)

        -- create star datas
        local starGroupMap = {}
        for starIndex, _ in ipairs(BattleCardGameUtils.CardStarNames) do
            starGroupMap[starIndex] = {}
        end
        for _, cardData in ipairs(cardDataList) do
            if starGroupMap[cardData.cardStar] then
                table.insert(starGroupMap[cardData.cardStar], cardData)
            end
        end
        self.typeGroupMap_[fillterType] = starGroupMap
    end
end


---@return table[]
function BattleCardGameDeckEditorDialog:CreateFilterDatas_()
    local filterDatas = {
        {conditionType = FilterTypes.ALL, typeDesc = localize('全部')},
    }
    for filterType, _ in pairs(self.typeGroupMap_) do
        if filterType ~= FilterTypes.ALL then
            local cardKindVo = BattleCardGameUtils.GetCardKindVo(filterType)
            table.insert(filterDatas, {conditionType = filterType, typeDesc = tostring(cardKindVo.kindName)})
        end
    end
    table.sort(filterDatas, function(aFilterData, bFilterData)
        return aFilterData.conditionType < bFilterData.conditionType
    end)
    return filterDatas
end


function BattleCardGameDeckEditorDialog:InitDeckCardList_()
    self.deckCardCells_ = {}
    for cardIndex = 1, BattleCardGameUtils.DeckCardCount do
        ---@type UnityEngine.RectTransform
        local deckCardNode  = self[string.fmt('CardAddNode%1', cardIndex)]
        if isNotNull(deckCardNode) then
            CfUtils.FillText(deckCardNode:Find('ImgBg/ImgDeco/TxtNum'), cardIndex)
            SetButtonAction(deckCardNode:Find('ImgBg'), Bind(self, self.OnClickDeckCardNodeHandler_, cardIndex))
            SetButtonAction(deckCardNode:Find('Card/PokerCardNode'), Bind(self, self.OnClickDeckCardNodeHandler_, cardIndex))
            self.deckCardCells_[cardIndex] = deckCardNode
        end
    end
end
function BattleCardGameDeckEditorDialog:UpdateDeckCardList_(oldCardIdList, newCardIdList)
    for cardIndex, deckCardNode in ipairs(self.deckCardCells_) do
        local oldCardId = checkInt(oldCardIdList[cardIndex])
        local newCardId = checkInt(newCardIdList[cardIndex])
        local hasCard   = newCardId > 0
        CfUtils.SetActive(deckCardNode:Find('Card'), hasCard)
        CfUtils.SetActive(deckCardNode:Find('ImgBg'), not hasCard)
        if hasCard and oldCardId ~= newCardId then
            BattleCardGameUtils.UpcateBattleCardNode(deckCardNode:Find('Card/PokerCardNode'), newCardId)
        end
    end
end


function BattleCardGameDeckEditorDialog:InitCardStarList_()
    self.cardStarCells_ = {}
    self.cardStarDatas_ = {}
    local cardStarNames = BattleCardGameUtils.CardStarNames
    for starIndex = #cardStarNames, 1, -1 do
        local starCellObj  = CfUtils.InstantiateGo(self.LevelTabCell, self.LevelTabParent)
        local starCellNode = CfUtils.GetOrAddComponent(starCellObj, CS.UnityEngine.RectTransform)
        starCellNode.name  = 'CardStarCell' .. starIndex
        CfUtils.FillText(starCellNode:Find('TxtTitle'), cardStarNames[starIndex])
        SetButtonAction(starCellNode, Bind(self, self.OnClickCardStarTabCellHandler_, starIndex))
        CfUtils.SetActive(starCellNode, true)
        table.insert(self.cardStarCells_, starCellNode)
        table.insert(self.cardStarDatas_, {starIndex = starIndex})
    end
end
function BattleCardGameDeckEditorDialog:UpdateCardStarList_()
    for starIndex, starCellNode in pairs(self.cardStarCells_) do
        local starData = checkTable(self.cardStarDatas_[starIndex])
        local starNum  = checkInt(starData.starIndex)
        local isSelect = self:GetSelectStar() == starNum
        CfUtils.SetActive(starCellNode:Find('ImgSelect'), isSelect)
        CfUtils.SetUISwitchText(starCellNode:Find('TxtTitle'), isSelect and 2 or 1)
    end
end


function BattleCardGameDeckEditorDialog:UpdateEditDeckInfo_()
    -- update title name
    CfUtils.FillText(self.DeckTitleTxt, localize('牌组_num_', {_num_ = self:GetEditDeckIndex()}))

    -- update unlock tips
    local deckLevel  = battleCardGameComp:GetHomeDojo():GetDeckLevel()
    local deckInfoVo = BattleCardGameUtils.GetDeckInfoVo(deckLevel)
    CfUtils.FillText(self.UnlockTipsTxt, localize('牌组解锁等级：_num_', {_num_ = tostring(deckInfoVo.levelText)}))
end


function BattleCardGameDeckEditorDialog:UpdateFilterDataList_()
    local filterType     = self:GetFilterType()
    local selectStar     = self:GetSelectStar()
    local starGroupMap   = checkTable(self.typeGroupMap_[filterType])
    self.filterDataList_ = checkTable(starGroupMap[selectStar])

    -- update cards list
    self:UpdateCardsList_()
end


function BattleCardGameDeckEditorDialog:UpdateCardsList_()
    local listDataLength = #self:GetFilterDataList()
    CfUtils.SetActive(self.CardsEmptyNode, listDataLength == 0)
    CfUtils.SetActive(self.CardsLoopView, listDataLength > 0)
    if listDataLength > 0 then
        GameUtils.ReloadData(self.CardsLoopView, listDataLength)
    end
end


function BattleCardGameDeckEditorDialog:UpdateCardsListSelectState_()
    self.CardsLoopView:RefreshAllShownItem()
end


-------------------------------------------------
-- handler

function BattleCardGameDeckEditorDialog:OnClickUnlockTipsNodeHandler_()
    CfUtils.DialogOpen(Constants.UITypeIds.UIActivityJapanesePokerLvRulePopup)
end


function BattleCardGameDeckEditorDialog:OnClickCardStarTabCellHandler_(cardStar)
    if self:GetSelectStar() ~= cardStar then
        self:SetSelectStar(cardStar)
    end
end


function BattleCardGameDeckEditorDialog:OnClickDeckCardNodeHandler_(cardIndex)
    local cardId = checkInt(self:GetCardIdList()[cardIndex])
    if cardId > 0 then
        -- remove card
        local newCardIdList = clone(self:GetCardIdList())
        table.remove(newCardIdList, cardIndex)
        self:SetCardIdList(newCardIdList)
    else
        GameUtils.Toast(localize('请从右侧列表中选择战牌'))
    end
end


function BattleCardGameDeckEditorDialog:OnClickSaveDeckButtonHandler_(cardIndex)
    if not self:IsDeckCardFull() then
        GameUtils.Toast(localize('牌组需要填满才可以保存'))
        return
    end

    local isDeckChanged = self:IsDeckChanged()
    if isDeckChanged then
        -- save deck cards
        battleCardGameComp:SaveDeckData(self:GetEditDeckIndex(), self:GetCardIdList(), function()
            GameUtils.Toast(localize('牌组_num_保存成功', {_num_ = self:GetEditDeckIndex()}))
            self:Close()
        end)
    else
        GameUtils.Toast(localize('牌组没有变化，无需保存'))
    end
end


---@param cellNode UnityEngine.GameObject
---@param luaIndex integer
function BattleCardGameDeckEditorDialog:OnUpdateCardsListCellHandler_(cellNode, luaIndex)
    local cellData = checkTable(self:GetFilterDataList()[luaIndex])
    ---@type BattleCardGameDeckEditorCardCell
    local cellEnv = CfUtils.GetLuaScr(cellNode, CardListCellPath)
    if isNotNull(cellEnv) then
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(cellData)
        cellEnv:SetClickCardCb(Bind(self, self.OnClickCardsListCardNodeHandler_))
        cellEnv:SetSelectState(self:GetCardIdIndex(cellData.cardId) > 0)
    end
end


function BattleCardGameDeckEditorDialog:OnClickCardsListCardNodeHandler_(luaIndex)
    local cellData  = checkTable(self:GetFilterDataList()[luaIndex])
    local cardId    = checkInt(cellData.cardId)
    local cardStar  = checkInt(cellData.cardStar)
    local cardIndex = self:GetCardIdIndex(cardId)

    if cardIndex > 0 then
        -- remove card
        self:OnClickDeckCardNodeHandler_(cardIndex)

    else
        -- check fulled
        if self:IsDeckCardFull() then
            GameUtils.Toast(localize('牌组已满，请先卸下其他战牌再尝试'))

        else
            local deckLevel  = battleCardGameComp:GetHomeDojo():GetDeckLevel()
            local deckInfoVo = BattleCardGameUtils.GetDeckInfoVo(deckLevel)
            if cardStar > deckInfoVo.levelLimit then

                -- cheeck level limit
                local freeCount = 0
                local freeLimit = BattleCardGameUtils.DeckFreeLimit
                for _, cardId in ipairs(self:GetCardIdList()) do
                    local cardVo = BattleCardGameUtils.GetCardInfoVo(cardId)
                    if checkInt(cardVo.cardStar) > deckInfoVo.levelLimit then
                        freeCount = freeCount + 1
                    end
                end
                if freeCount >= freeLimit then
                    GameUtils.Toast(localize('已存在_num1_张任意等级卡牌，其余卡牌需遵从当前等级解锁限制，不可超过_num2_级', {_num1_ = freeCount, _num2_ = deckInfoVo.levelLimit}))
                    return
                end
            end
            
            -- append card
            local newCardIdList = clone(self:GetCardIdList())
            table.insert(newCardIdList, cardId)
            self:SetCardIdList(newCardIdList)
        end
    end
end


return BattleCardGameDeckEditorDialog
