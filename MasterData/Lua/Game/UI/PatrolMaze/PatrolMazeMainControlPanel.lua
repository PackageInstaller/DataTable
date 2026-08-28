-------------------------------------------------------------------------------
-- 夜寻迷宫 - 主界面 - 控制面板
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-01-16 20:36:11
-------------------------------------------------------------------------------

local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
local patrolMazeComp  = PatrolMazeUtils.GetComp()

local FunctionType = {
    EMPTY = 0, -- 背包
    PACK  = 1, -- 背包
    CARD  = 2, -- 卡牌
    BUFF  = 3, -- 效果
}

local BuffType = {
    Relic = 1,  -- 圣物
    Curse = 2,  -- 诅咒
    Goods = 3,  -- 道具
}

local GoodsInfoNodePath = 'Game.UI.PatrolMaze.PatrolMazeMainControlPanelGoodsPanel'

local GoodsGridCellPath = 'Game.UI.PatrolMaze.PatrolMazeMainControlPanelGoodsNode'
local GoodsGridCellName = 'Cell'

local CardGridCellPath = 'Game.UI.PatrolMaze.PatrolMazeMainControlPanelCardNode'
local CardGridCellName = 'Cell'

local BuffListCellPath = 'Game.UI.PatrolMaze.PatrolMazeMainControlPanelBuffNode'
local BuffListCellName = 'Cell'

--- from: Assets/BundleResources/Prefabs/Patrol/PartolBtnLeftNode130201.prefab > name: PartolBtnLeftNode130201
---@class PatrolMazeMainControlPanel
---@field Env                           	PatrolMazeMainControlPanel              
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field PanelCloseBtn                 	UnityEngine.RectTransform               @ 功能面板 关闭按钮
---@field PanelCardGridView             	SuperScrollView.LoopGridView            @ 功能面板 卡牌 卡牌列表
---@field PanelCardNode                 	UnityEngine.RectTransform               @ 功能面板 卡牌
---@field PanelGoodsInfoNode            	UnityEngine.RectTransform               @ 功能面板 背包 道具信息节点
---@field PanelGoodsEmptyNode           	UnityEngine.RectTransform               @ 功能面板 背包 内容空节点
---@field PanelGoodsGridView            	SuperScrollView.LoopGridView            @ 功能面板 背包 道具列表
---@field PanelPackNode                 	UnityEngine.RectTransform               @ 功能面板-背包
---@field PanelBuffListView             	SuperScrollView.LoopListView2           @ 功能面板 效果 效果列表
---@field PanelBuffEmptyNode            	UnityEngine.RectTransform               @ 功能面板 效果 空内容节点
---@field PanelBuffToggleUp             	UnityEngine.RectTransform               @ 功能面板 效果 顶部页签
---@field PanelBuffNode                 	UnityEngine.RectTransform               @ 功能面板-效果
---@field PanelBlackImg                 	UnityEngine.RectTransform               @ 功能面板 背景图
---@field LeftPanelRoot                 	UnityEngine.RectTransform               @ 功能面板 根节点
---@field FunBuffBtn                    	UnityEngine.RectTransform               @ 功能按钮 效果
---@field FunCardBtn                    	UnityEngine.RectTransform               @ 功能按钮 卡牌
---@field FunPackBtn                    	UnityEngine.RectTransform               @ 功能按钮 背包
---@field AnimRoot                      	UnityEngine.RectTransform               @ 动画根节点
---@field UIFX_BuffGet                  	UnityEngine.RectTransform               @ buff获得特效
local PatrolMazeMainControlPanel = Class('PatrolMazeMainControlPanel')


function PatrolMazeMainControlPanel:__init()
    ---@type PatrolMazeAreaDojo @ 当前所在区域dojo
    self.mapAreaDojo_ = nil

    ---@type table @ 功能定义参数字典
    self.funDefinesMap_ = {}

    ---@type CommonTabToggleUp @ 效果面板标题切换器
    self.buffToggleEnv_ = nil

    ---@type table[] @ 效果面板切换标题数据
    self.buffTabDataList_ = nil

    ---@type PatrolMazeMainControlPanelGoodsPanel @ 道具信息节点env
    self.goodsInfoNodeEnv_ = nil
end


function PatrolMazeMainControlPanel:__delete()
    self.mapAreaDojo_      = nil
    self.funDefinesMap_    = nil
    self.buffToggleEnv_    = nil
    self.buffTabDataList_  = nil
    self.goodsInfoNodeEnv_ = nil
end


function PatrolMazeMainControlPanel:Awake()
    self.buffToggleEnv_    = CfUtils.GetLuaScr(self.PanelBuffToggleUp, Constants.UILuaTablePath.ComUpToggle)
    self.goodsInfoNodeEnv_ = CfUtils.GetLuaScr(self.PanelGoodsInfoNode, GoodsInfoNodePath)
    self.goodsInfoNodeEnv_:SetGoodsUseCb(Bind(self, self.OnClickGoodsUseButtonHandler_))
    SetButtonAction(self.FunCardBtn, Bind(self, self.OnClickMazeCardButtonHandler_))
    SetButtonAction(self.FunBuffBtn, Bind(self, self.OnClickMazeBuffButtonHandler_))
    SetButtonAction(self.FunPackBtn, Bind(self, self.OnClickMazePackButtonHandler_))
    SetButtonAction(self.PanelCloseBtn, Bind(self, self.OnClickFunCloseButtonHandler_))
    SetButtonAction(self.PanelBlackImg, Bind(self, self.OnClickFunCloseButtonHandler_))
    SetGridViewAction(self.PanelCardGridView, Bind(self, self.OnUpdateCardGridCellHandler_))
    SetGridViewAction(self.PanelGoodsGridView, Bind(self, self.OnUpdateGoodsGridCellHandler_))
    SetListViewAction(self.PanelBuffListView, Bind(self, self.OnUpdateBuffListCellHandler_), BuffListCellName)
    self.eventsDecorated_ = CfUtils.EventsDecorated({
        [PatrolMazeUtils.EventsName.MAZE_GOODS_USED] = Bind(self, self.OnMazeGoodsUsedHandler_),
    })
end


function PatrolMazeMainControlPanel:Start()
    self.funDefinesMap_ = {
        [FunctionType.PACK] = {button = self.FunPackBtn, panel = self.PanelPackNode},
        [FunctionType.CARD] = {button = self.FunCardBtn, panel = self.PanelCardNode},
        [FunctionType.BUFF] = {button = self.FunBuffBtn, panel = self.PanelBuffNode},
    }

    local initBuffIndex   = 1
    self.buffTabDataList_ = {
        {
            text = '----',
            type = BuffType.Relic,
            func = Bind(self, self.OnClickBuffToggleHandler_),
            getIdList = function()
                return self.mapAreaDojo_ and self.mapAreaDojo_.mazeRelicIdList or {}
            end,
            nameFunc = function(num)
                return localize('增益效果（_num_）', {_num_ = checkInt(num)})
            end
        },
        {
            text = '----',
            type = BuffType.Curse,
            func = Bind(self, self.OnClickBuffToggleHandler_),
            getIdList = function()
                return self.mapAreaDojo_ and self.mapAreaDojo_.mazeCurseIdList or {}
            end,
            nameFunc = function(num)
                return localize('减益效果（_num_）', {_num_ = checkInt(num)})
            end
        },
        {
            text = '----',
            type = BuffType.Goods,
            func = Bind(self, self.OnClickBuffToggleHandler_),
            getIdList = function()
                return self.mapAreaDojo_ and self.mapAreaDojo_.effectGoodsList or {}
            end,
            nameFunc = function(num)
                return localize('道具效果（_num_）', {_num_ = checkInt(num)})
            end
        },
    }
    self.buffToggleEnv_:FillToggles(self.buffTabDataList_, initBuffIndex)
    self:SetSelectBuffTabIndex(initBuffIndex)

    if self:GetMainDialog() then
        self:OnInitialize()
    end
end


function PatrolMazeMainControlPanel:OnInitialize()
    -- init select type
    local initParams = CfUtils.DialogSafeParameters(self:GetMainDialog().controller)
    if initParams.controlPanelSelectFunType ~= nil then
        self:SetSelectFunType(initParams.controlPanelSelectFunType)
    end
    if initParams.controlPanelSelectGoodsIndex ~= nil then
        self:SetSelectGoodsIndex(initParams.controlPanelSelectGoodsIndex)
    end
    if initParams.controlPanelGoodsGridViewPos ~= nil then
        self.PanelGoodsGridView.ContainerTrans.anchoredPosition = initParams.controlPanelGoodsGridViewPos
    end
end


function PatrolMazeMainControlPanel:OnDestroy()
    CfUtils.EventsUndecorated(self.eventsDecorated_)
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


function PatrolMazeMainControlPanel:OnFinalize()
    local initParams = CfUtils.DialogSafeParameters(self:GetMainDialog().controller)
    initParams.controlPanelSelectFunType    = self:GetSelectFunType()
    initParams.controlPanelSelectGoodsIndex = self:GetSelectGoodsIndex()
    initParams.controlPanelGoodsGridViewPos = self.PanelGoodsGridView:GetContainerMovedDistance()
end


-------------------------------------------------
-- get / set

---@return PatrolMazeMainDialog
function PatrolMazeMainControlPanel:GetMainDialog()
    return self.mainDialog_
end
function PatrolMazeMainControlPanel:SetMainDialog(mainDialog)
    self.mainDialog_  = mainDialog
    self.mapAreaDojo_ = self:GetMainDialog():GetMapAreaDojo()
    self.goodsInfoNodeEnv_:SetMainDialog(mainDialog)
    if self.buffTabDataList_ then
        self:OnInitialize()
    end
end


---@return integer
function PatrolMazeMainControlPanel:GetSelectFunType()
    return checkInt(self.selectFunType_)
end
function PatrolMazeMainControlPanel:SetSelectFunType(funType)
    self.selectFunType_ = checkInt(funType)
    self:UpdateSelectFunType_()
end


---@return integer
function PatrolMazeMainControlPanel:GetSelectBuffTabIndex()
    return checkInt(self.selectBuffTabIndex_)
end
function PatrolMazeMainControlPanel:SetSelectBuffTabIndex(index)
    self.selectBuffTabIndex_ = checkInt(index)
end


---@return integer
function PatrolMazeMainControlPanel:GetSelectGoodsIndex()
    return checkInt(self.selectGoodsIndex_)
end
function PatrolMazeMainControlPanel:SetSelectGoodsIndex(index)
    local oldSelectIndex   = self:GetSelectGoodsIndex()
    local newSelectIndex   = checkInt(index)
    self.selectGoodsIndex_ = newSelectIndex
    self:SwitchPackGoodsSelect_(oldSelectIndex, newSelectIndex)
end


-------------------------------------------------
-- public

function PatrolMazeMainControlPanel:PlayBuffReceiveAnim()
    CfUtils.SetActive(self.UIFX_BuffGet, false)
    CfUtils.SetActive(self.UIFX_BuffGet, true)
end


-------------------------------------------------
-- private

function PatrolMazeMainControlPanel:UpdateSelectFunType_()
    local selectFunType  = self:GetSelectFunType()
    local functionDefine = self.funDefinesMap_[selectFunType]

    -- update select state
    for funType, funDefine in ipairs(self.funDefinesMap_) do
        local isSelectType = funType == selectFunType
        CfUtils.SetActive(funDefine.panel, isSelectType)
        if selectFunType == FunctionType.EMPTY then
            CfUtils.SetCanvasGroupAlpha(funDefine.button, 1)
        else
            CfUtils.SetCanvasGroupAlpha(funDefine.button, isSelectType and 1 or 0.5)
        end
    end
    CfUtils.SetActive(self.LeftPanelRoot, selectFunType ~= FunctionType.EMPTY)
    
    -- show fun panel
    if selectFunType == FunctionType.PACK then
        self:UpdateMazePackPanelInfo_()
    elseif selectFunType == FunctionType.CARD then
        self:UpdateMazeCardPanelInfo_()
    elseif selectFunType == FunctionType.BUFF then
        self:UpdateMazeBuffPanelInfo_()
    end

    -- 关闭事件信息面板
    if self:GetMainDialog() then
        self:GetMainDialog():CloseQuestEventDialog()
    end
end


function PatrolMazeMainControlPanel:UpdateMazePackPanelInfo_()
    self:SetSelectGoodsIndex(1)
    self:UpdateMazePackPanelGoodsList_()
end


function PatrolMazeMainControlPanel:UpdateMazePackPanelGoodsList_()
    local gridDataLength = self.mapAreaDojo_ and #self.mapAreaDojo_.mazeBackpackList or 0
    CfUtils.SetActive(self.PanelGoodsInfoNode, gridDataLength > 0)
    CfUtils.SetActive(self.PanelGoodsEmptyNode, gridDataLength == 0)
    GameUtils.ReloadData(self.PanelGoodsGridView, gridDataLength)
end


---@param oldSelect integer
---@param newSelect integer
function PatrolMazeMainControlPanel:SwitchPackGoodsSelect_(oldSelect, newSelect)
    local oldGoodsCellNode = self.PanelGoodsGridView:GetShownItemByItemIndex(oldSelect - 1)
    local newGoodsCellNode = self.PanelGoodsGridView:GetShownItemByItemIndex(newSelect - 1)

    ---@type PatrolMazeMainControlPanelGoodsNode
    local oldGoodsCellEnv  = CfUtils.GetLuaScr(oldGoodsCellNode, GoodsGridCellPath)
    ---@type PatrolMazeMainControlPanelGoodsNode
    local newGoodsCellEnv  = CfUtils.GetLuaScr(newGoodsCellNode, GoodsGridCellPath)

    if oldGoodsCellEnv then
        oldGoodsCellEnv:UpdateSelectStatus(false)
    end

    if newGoodsCellEnv then
        newGoodsCellEnv:UpdateSelectStatus(true)
    end

    self.goodsInfoNodeEnv_:SetSelectIndex(newSelect)
end


function PatrolMazeMainControlPanel:UpdateMazePackCurrentInfo_()
    -- check goods isExist
    local goodsIndex  = self:GetSelectGoodsIndex()
    local mazeGoodsId = checkInt(self.mapAreaDojo_.mazeBackpackList[goodsIndex])
    if self.mapAreaDojo_:GetBackpackGoodsNum(mazeGoodsId) > 0 then

        -- update goodsGrid cell
        local goodsCellNode = self.PanelGoodsGridView:GetShownItemByItemIndex(goodsIndex - 1)
        ---@type PatrolMazeMainControlPanelGoodsNode
        local goodsCellEnv = CfUtils.GetLuaScr(goodsCellNode, GoodsGridCellPath)
        if goodsCellEnv then
            goodsCellEnv:UpdateGoodsNum()
        end
    
        -- update goodsInfoPanel
        self.goodsInfoNodeEnv_:SetSelectIndex(self:GetSelectGoodsIndex())
        
    else
        -- refresh packPanelInfo
        self:UpdateMazePackPanelInfo_()
    end
end


function PatrolMazeMainControlPanel:UpdateMazeCardPanelInfo_()
    local gridDataLength = self.mapAreaDojo_ and #self.mapAreaDojo_.mazeCardDojoList or 0
    GameUtils.ReloadData(self.PanelCardGridView, gridDataLength)
end


function PatrolMazeMainControlPanel:UpdateMazeBuffPanelInfo_()
    for buffTabIndex, buffTabData in ipairs(self.buffTabDataList_) do
        local buffNum = #buffTabData.getIdList()
        self.buffToggleEnv_:RefresCellhName(buffTabIndex, buffTabData.nameFunc(buffNum))
    end
    self:UpdateMazeBuffPanelBuffList_()
end


function PatrolMazeMainControlPanel:UpdateMazeBuffPanelBuffList_()
    local selectBuffData = checkTable(self.buffTabDataList_[self:GetSelectBuffTabIndex()])
    local gridDataLength = #selectBuffData.getIdList()
    CfUtils.SetActive(self.PanelBuffEmptyNode, gridDataLength == 0)
    GameUtils.ReloadData(self.PanelBuffListView, gridDataLength)
end


-------------------------------------------------
-- handler

function PatrolMazeMainControlPanel:OnClickFunCloseButtonHandler_()
    if self:GetSelectFunType() ~= FunctionType.EMPTY then
        self:SetSelectFunType(FunctionType.EMPTY)
    end
end


function PatrolMazeMainControlPanel:OnClickMazeCardButtonHandler_()
    if self.mapAreaDojo_:IsPassedAll() then return end
    if self:GetSelectFunType() ~= FunctionType.CARD then
        self:SetSelectFunType(FunctionType.CARD)
    end
end


function PatrolMazeMainControlPanel:OnClickMazeBuffButtonHandler_()
    if self.mapAreaDojo_:IsPassedAll() then return end
    if self:GetSelectFunType() ~= FunctionType.BUFF then
        self:SetSelectFunType(FunctionType.BUFF)
    end
end


function PatrolMazeMainControlPanel:OnClickMazePackButtonHandler_()
    if self.mapAreaDojo_:IsPassedAll() then return end
    if self:GetSelectFunType() ~= FunctionType.PACK then
        self:SetSelectFunType(FunctionType.PACK)
    end
end


---@param gridView SuperScrollView.LoopGridView
---@param luaIndex integer
---@return SuperScrollView.LoopGridViewItem
function PatrolMazeMainControlPanel:OnUpdateGoodsGridCellHandler_(gridView, luaIndex)
    local cellNode = gridView:NewListViewItem(GoodsGridCellName)
    local cellData = self.mapAreaDojo_.mazeBackpackList[luaIndex]
    ---@type PatrolMazeMainControlPanelGoodsNode
    local cellEnv = CfUtils.GetLuaScr(cellNode, GoodsGridCellPath)
    if isNotNull(cellEnv) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData({mapAreaDojo = self.mapAreaDojo_, goodsId = cellData})
        cellEnv:SetClickCellCB(Bind(self, self.OnClickGoodsGridCellCallback_))
        -- update state
        cellEnv:UpdateSelectStatus(luaIndex == self:GetSelectGoodsIndex())
    end
    return cellNode
end


---@param luaIndex integer
function PatrolMazeMainControlPanel:OnClickGoodsGridCellCallback_(luaIndex)
    if self:GetSelectGoodsIndex() ~= luaIndex then
        self:SetSelectGoodsIndex(luaIndex)
    end
end


function PatrolMazeMainControlPanel:OnMazeGoodsUsedHandler_(eventData)
    if eventData.mapAreaId == self.mapAreaDojo_.areaId then
        if self.mapAreaDojo_:GetBackpackGoodsNum(eventData.mazeGoodsId) > 0 then
            self:UpdateMazePackCurrentInfo_()
        else
            self:UpdateMazePackPanelInfo_()
        end
    end
end


---@param luaIndex integer
function PatrolMazeMainControlPanel:OnClickGoodsUseButtonHandler_(luaIndex)
    local mazeGoodsId = checkInt(self.mapAreaDojo_.mazeBackpackList[luaIndex])
    local mazeGoodsVo = PatrolMazeUtils.GetMazeGoodsVo(mazeGoodsId)

    if (mazeGoodsVo.effectType == PatrolMazeUtils.EffectType.RECOVER or    -- 回血
        mazeGoodsVo.effectType == PatrolMazeUtils.EffectType.REVIVE or     -- 复活
        mazeGoodsVo.effectType == PatrolMazeUtils.EffectType.UP_STAR) then -- 升星
        ---@type PatrolMazeCardDojo[]
        local cardDojoList = {}
        if mazeGoodsVo.effectType == PatrolMazeUtils.EffectType.RECOVER then
            for _, mazeCardDojo in ipairs(self.mapAreaDojo_.mazeCardDojoList) do
                if mazeCardDojo.hpPercent > 0 and mazeCardDojo.hpPercent < 1 then
                    table.insert(cardDojoList, mazeCardDojo)
                end
            end
            ---@param aCardDojo PatrolMazeCardDojo
            ---@param bCardDojo PatrolMazeCardDojo
            table.sort(cardDojoList, function(aCardDojo, bCardDojo)
                return aCardDojo.hpPercent < bCardDojo.hpPercent
            end)
            if #cardDojoList == 0 then
                GameUtils.Toast(localize('没有需要恢复血量的角色'))
                return
            end
        elseif mazeGoodsVo.effectType == PatrolMazeUtils.EffectType.REVIVE then
            for _, mazeCardDojo in ipairs(self.mapAreaDojo_.mazeCardDojoList) do
                if mazeCardDojo.hpPercent == 0 then
                    table.insert(cardDojoList, mazeCardDojo)
                end
            end
            if #cardDojoList == 0 then
                GameUtils.Toast(localize('没有需要复活的角色'))
                return
            end
        elseif mazeGoodsVo.effectType == PatrolMazeUtils.EffectType.UP_STAR then
            for _, mazeCardDojo in ipairs(self.mapAreaDojo_.mazeCardDojoList) do
                if mazeCardDojo.cardDojo.star < Constants.CardMaxStar then
                    table.insert(cardDojoList, mazeCardDojo)
                end
            end
            ---@param aCardDojo PatrolMazeCardDojo
            ---@param bCardDojo PatrolMazeCardDojo
            table.sort(cardDojoList, function(aCardDojo, bCardDojo)
                return aCardDojo.cardDojo.star < bCardDojo.cardDojo.star
            end)
            if #cardDojoList == 0 then
                GameUtils.Toast(localize('没有需要提升星级的角色'))
                return
            end
        end
        -- convert to idList
        local cardIdList = {}
        for cardDojoIndex, cardDojoList in ipairs(cardDojoList) do
            cardIdList[cardDojoIndex] = cardDojoList.id
        end
        CfUtils.DialogOpen(Constants.UITypeIds.UIPatrolMazeGoodsChooseRoleDialog, {
            mapAreaDojo = self.mapAreaDojo_, 
            cardIdList  = cardIdList, 
            mazeGoodsId = mazeGoodsId,
        })

    elseif mazeGoodsVo.effectType == PatrolMazeUtils.EffectType.ERASURE then
        if #self.mapAreaDojo_.mazeCurseIdList > 0 then
            patrolMazeComp:UseMazeGoods(self.mapAreaDojo_.areaId, mazeGoodsId, nil, function(removeCurses)
                local curseNameList = {}
                for curseIndex, curseId in ipairs(removeCurses) do
                    curseNameList[curseIndex] = PatrolMazeUtils.GetMazeCurseVo(curseId).name
                end
                GameUtils.Toast(localize('清除掉了诅咒【_names_】', {_names_ = table.concat(curseNameList, ', ')}))
            end)
        else
            GameUtils.Toast(localize('身上没有诅咒可以清除'))
        end
        
    elseif mazeGoodsVo.effectType == PatrolMazeUtils.EffectType.UP_ATTR then
        if not self.mapAreaDojo_:HasEffectGoods(mazeGoodsId) then
            patrolMazeComp:UseMazeGoods(self.mapAreaDojo_.areaId, mazeGoodsId, nil, nil, function()
                GameUtils.Toast(mazeGoodsVo.descr)
            end)
        else
            GameUtils.Toast(localize('身上已经拥有该效果，不能重复添加'))
        end

    elseif mazeGoodsVo.effectType == PatrolMazeUtils.EffectType.RELIC_UP then
        patrolMazeComp:UseMazeGoods(self.mapAreaDojo_.areaId, mazeGoodsId, nil, nil, nil, nil, function()
            GameUtils.Toast(mazeGoodsVo.descr)
        end)

    else
        GameUtils.Toast('Debug：不要乱吃捡到的东西')
    end
end


---@param gridView SuperScrollView.LoopGridView
---@param luaIndex integer
---@return SuperScrollView.LoopGridViewItem
function PatrolMazeMainControlPanel:OnUpdateCardGridCellHandler_(gridView, luaIndex)
    local cellNode = gridView:NewListViewItem(CardGridCellName)
    local cellData = self.mapAreaDojo_.mazeCardDojoList[luaIndex]
    ---@type PatrolMazeMainControlPanelCardNode
    local cellEnv = CfUtils.GetLuaScr(cellNode, CardGridCellPath)
    if isNotNull(cellEnv) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData({mapAreaDojo = self.mapAreaDojo_, mazeCardDojo = cellData})
        cellEnv:SetClickCellCB(Bind(self, self.OnClickCardGridCellCallback_))
    end
    return cellNode
end


---@param luaIndex integer
function PatrolMazeMainControlPanel:OnClickCardGridCellCallback_(luaIndex)
end


---@param toggleIndex integer
function PatrolMazeMainControlPanel:OnClickBuffToggleHandler_(toggleIndex)
    if self:GetSelectBuffTabIndex() ~= toggleIndex then
        self:SetSelectBuffTabIndex(toggleIndex)
        self:UpdateMazeBuffPanelBuffList_()
    end
end


---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer
---@return SuperScrollView.LoopListViewItem2
function PatrolMazeMainControlPanel:OnUpdateBuffListCellHandler_(listView, luaIndex)
    local cellNode = listView:NewListViewItem(BuffListCellName)
    local buffData = self.buffTabDataList_[self:GetSelectBuffTabIndex()]
    local cellData = buffData.getIdList()[luaIndex]
    ---@type PatrolMazeMainControlPanelBuffNode
    local cellEnv = CfUtils.GetLuaScr(cellNode, BuffListCellPath)
    if isNotNull(cellEnv) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData({buffType = buffData.type, buffId = cellData})
    end
    return cellNode
end


return PatrolMazeMainControlPanel
