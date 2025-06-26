module("cycle.CycleHeroSelectPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("cycle/CycleHeroSelectPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 3 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    --self:setSize(0, 0)
    --self:setBg("common_bg_008.jpg", false)
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mHeroList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mHeroScroll = self:getChildGO("mHeroScroll"):GetComponent(ty.ScrollRect)
    self.mBtnOK = self:getChildGO("mBtnOK")

    --self.mBtnCancle = self:getChildGO("mBtnCancle")

    self.mEmpty = self:getChildGO("mEmpty")
end

-- 激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:dispatchEvent(EventName.SHOW_CYCLE_TOP_PANEL)

    GameDispatcher:addEventListener(EventName.UPDATE_CYCLE_HERO_SELECT_PANEL, self.onUpdateHeroSelectPanel, self)

    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_CYCLE_HERO_SELECT_PANEL, self.onUpdateHeroSelectPanel, self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    self:clearHeroItems()

    if self.tweener then
        self.tweener:Kill()
        self.tweener = nil
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnOK, self.onBtnOKClickHandler)
    --self:addUIEvent(self.mBtnCancle, self.onBtnCancleClickHandler)
end

function onUpdateHeroSelectPanel(self)
    self:showPanel()
end

function showPanel(self)
    self.selectType, self.recuritType = cycle.CycleManager:getCurTicketAndType()

    cycle.CycleManager:setRecuritClicked(false)
    if self.recuritType == RECUIT_TYPE.STEP then
        GameDispatcher:dispatchEvent(EventName.SET_CYCLE_TOP_PANEL_INFO, {
            title = _TT(27542),
            showTypeList = {TOP_SHOW_TYPE.LV, TOP_SHOW_TYPE.REASON,TOP_SHOW_TYPE.COIN,TOP_SHOW_TYPE.HOPE,TOP_SHOW_TYPE.CANCLE_RECRUIT,TOP_SHOW_TYPE.RET_MAIN,TOP_SHOW_TYPE.TOPBAR,TOP_SHOW_TYPE.BOTBAR}
        })
    elseif self.recuritType == RECUIT_TYPE.POSTWAR then
        GameDispatcher:dispatchEvent(EventName.SET_CYCLE_TOP_PANEL_INFO, {
            title = _TT(27543),
            showTypeList = {TOP_SHOW_TYPE.LV, TOP_SHOW_TYPE.REASON,TOP_SHOW_TYPE.COIN,TOP_SHOW_TYPE.HOPE,TOP_SHOW_TYPE.BUFFLIST,TOP_SHOW_TYPE.FORMATION,TOP_SHOW_TYPE.CANCLE_RECRUIT,TOP_SHOW_TYPE.RET_MAIN,TOP_SHOW_TYPE.TOPBAR,TOP_SHOW_TYPE.BOTBAR}
        })
    elseif self.recuritType == RECUIT_TYPE.EVENT then
        GameDispatcher:dispatchEvent(EventName.SET_CYCLE_TOP_PANEL_INFO, {
            title = _TT(27544),
            showTypeList = {TOP_SHOW_TYPE.LV, TOP_SHOW_TYPE.REASON,TOP_SHOW_TYPE.COIN,TOP_SHOW_TYPE.HOPE,TOP_SHOW_TYPE.BUFFLIST,TOP_SHOW_TYPE.FORMATION,TOP_SHOW_TYPE.CANCLE_RECRUIT,TOP_SHOW_TYPE.RET_MAIN,TOP_SHOW_TYPE.TOPBAR,TOP_SHOW_TYPE.BOTBAR}
        })
    elseif self.recuritType == RECUIT_TYPE.SHOP then
        GameDispatcher:dispatchEvent(EventName.SET_CYCLE_TOP_PANEL_INFO, {
            title = _TT(27545),
            showTypeList = {TOP_SHOW_TYPE.LV, TOP_SHOW_TYPE.REASON,TOP_SHOW_TYPE.COIN,TOP_SHOW_TYPE.HOPE,TOP_SHOW_TYPE.BUFFLIST,TOP_SHOW_TYPE.FORMATION,TOP_SHOW_TYPE.CANCLE_RECRUIT,TOP_SHOW_TYPE.RET_MAIN,TOP_SHOW_TYPE.TOPBAR,TOP_SHOW_TYPE.BOTBAR}
        })
    end

   



    local data = cycle.CycleManager:getCycleRecruitData(self.selectType)
    local param = data.param

    local heroList = hero.HeroManager:getHeroList()

    local cycleHeroList = cycle.CycleManager:getHeroList()

    local needHero = {}
    for i = 1, #heroList do
        -- 过滤相同元素类型 和 不在战员列表的战员
        if (table.indexof01(param, heroList[i].eleType) > 0 or param[1] == -1) and
            table.indexof01(cycleHeroList, heroList[i].id) <= 0 then
            table.insert(needHero, heroList[i])
        end
    end

    self:clearHeroItems()
    for i = 1, #needHero do
        local heroCard = cycle.CycleHeroSelectItem:poolGet()
        heroCard:setData(needHero[i])
        heroCard:setParent(self.mHeroScroll.content)
        heroCard:setScale(1)
        heroCard:setCallBack(self, self.__onClickAddGridHandler, i)
        table.insert(self.mHeroList, heroCard)
    end

    -- self.mBtnOK:SetActive(#needHero > 0)
    self.mEmpty:SetActive(#needHero == 0)

    if self.tweener then
        self.tweener:Kill()
        self.tweener = nil
    end

    local needPos = 0
    self.mHeroScroll.movementType = gs.ScrollRect.MovementType.Elastic
    self.tweener = TweenFactory:move2LPosX(self.mHeroScroll.content, needPos, 0.2)
end

function __onClickAddGridHandler(self, heroVo, heroId)
    for i = 1, #self.mHeroList do
        if i == heroId then
            self.mHeroList[i]:setSelect(true)
            self.mSelectHero = self.mHeroList[i]
        else
            self.mHeroList[i]:setSelect(false)
        end
    end

    if self.tweener then
        self.tweener:Kill()
        self.tweener = nil
    end

    local needPos = -(math.floor((heroId - 1) / 3) * (441.3 + 23))
    self.mHeroScroll.movementType = gs.ScrollRect.MovementType.Unrestricted

    self.tweener = TweenFactory:move2LPosX(self.mHeroScroll.content, needPos, 0.2)
    GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_HERO_SURE_PANEL, {
        heroVo = heroVo
    })
end

function clearHeroItems(self)
    for i = 1, #self.mHeroList do
        self.mHeroList[i]:poolRecover()
    end
    self.mHeroList = {}
end

function onBtnCancleClickHandler(self)
    if self.recuritType == RECUIT_TYPE.STEP then
        GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_STEP_INFO, {
            step = CYCLE_STEP.SELECT_RECRUIT,
            args = {0}
        })
    elseif self.recuritType == RECUIT_TYPE.POSTWAR then
        local currentCellId = cycle.CycleManager:getCurrentCell()
        GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_TRIGGER_EVENT_FINISH, {
            cellId = currentCellId,
            args = {POSTWAR_TYPE.RECUIT, self.selectType, 0}
        })
    elseif self.recuritType == RECUIT_TYPE.EVENT then
        local currentCellId = cycle.CycleManager:getCurrentCell()
        local cellMsgVo = cycle.CycleManager:getCellDataById(currentCellId)
        local currentEventId = cellMsgVo.eventId

        GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_TRIGGER_EVENT_FINISH, {
            cellId = currentCellId,
            args = {0}
        })
    elseif self.recuritType == RECUIT_TYPE.SHOP then
        GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_SHOP_RECRUIT_HERO, {
            heroId = 0
        })
    end
end

function onBtnOKClickHandler(self)

    if self.mSelectHero == nil then
        gs.Message.Show(_TT(27546))
        return
    end

    local hopePoint = cycle.CycleManager:getResourceInfo().hope_point

    -- local needHopeSSR = sysParam.SysParamManager:getValue(4501)
    -- local needHopeSR = sysParam.SysParamManager:getValue(4502)
    -- local needHopeR = sysParam.SysParamManager:getValue(4503)

    -- local needHope = 0
    -- local color = self.mSelectHero:getData().color
    -- if color == ColorType.BLUE then
    --     needHope = needHopeR
    -- elseif color == ColorType.VIOLET then
    --     needHope = needHopeSR
    -- elseif color == ColorType.ORANGE then
    --     needHope = needHopeSSR
    -- end

    -- local cycleStrategyId = cycle.CycleManager:getCycleStrategy()
    -- local strategyVo = cycle.CycleManager:getCycleStrategyDataById(cycleStrategyId)

    -- if strategyVo.type == 1 then
    --     needHope = needHope - strategyVo.args[1]
    -- else

    -- end

    -- 商品的话不需要再判断理智值
    if self.mSelectHero.needHope > hopePoint then
        gs.Message.Show(_TT(27547))
        return
    end

    local heroId = self.mSelectHero:getData().id
    -- GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_HERO_SELECT_PANEL)
    -- GameDispatcher:dispatchEvent(EventName.OPEN_CYCLE_SHOW_ONE_PANEL,{heroId = heroId})

    if self.recuritType == RECUIT_TYPE.STEP then
        GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_STEP_INFO, {
            step = CYCLE_STEP.SELECT_RECRUIT,
            args = {heroId}
        })
    elseif self.recuritType == RECUIT_TYPE.POSTWAR then
        local currentCellId = cycle.CycleManager:getCurrentCell()
        GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_TRIGGER_EVENT_FINISH, {
            cellId = currentCellId,
            args = {POSTWAR_TYPE.RECUIT, self.selectType, heroId}
        })
    elseif self.recuritType == RECUIT_TYPE.EVENT then
        local currentCellId = cycle.CycleManager:getCurrentCell()
        -- local cellMsgVo = cycle.CycleManager:getCellDataById(currentCellId)
        -- local currentEventId = cellMsgVo.eventId

        GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_TRIGGER_EVENT_FINISH, {
            cellId = currentCellId,
            args = {heroId}
        })
    elseif self.recuritType == RECUIT_TYPE.SHOP then
        GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_SHOP_RECRUIT_HERO, {
            heroId = heroId
        })
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27547):	"理智值不够"
	语言包: _TT(27546):	"请选择一个战员"
	语言包: _TT(27545):	"商店招募"
	语言包: _TT(27544):	"事件招募"
	语言包: _TT(27543):	"战后招募"
	语言包: _TT(27542):	"初始战员"
]]
