module("bag.BagPanel", Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath("bag/BagPanel.prefab")
destroyTime = -1 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
isShow3DBg = 1

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(52006))
    -- self:setBg("common_bg_015.jpg", false)
    self:setUICode(LinkCode.Bag)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mTabType = nil
    self.showTabType = 2
    self.mParams = {}
    -- 切卡组类型
    -- self.mTabTypeList = {
    --     bag.BagTabType.NORMAL,
    --     bag.BagTabType.CONSUME,
    --     bag.BagTabType.EQUIP,
    --     bag.BagTabType.HERO_FRAGMENT,
    --     bag.BagTabType.BRACELETS,
    -- }

    self.mTabTypeList = self:getOpenTabTypeList()
end

function getOpenTabTypeList(self)
    self.mTabList = {}
    table.insert(self.mTabList, bag.BagTabType.NORMAL)

    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_CONSUME, false) then
        table.insert(self.mTabList, bag.BagTabType.CONSUME)
    end
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_EQUIP, false) then
        table.insert(self.mTabList, bag.BagTabType.EQUIP)
    end
    -- if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_FRAGMENT, false) then
    --     table.insert(self.mTabList, bag.BagTabType.HERO_FRAGMENT)
    -- end
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_BRACELETS, false) then
        table.insert(self.mTabList, bag.BagTabType.BRACELETS)
    end
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_BRACELETS, false) then
        table.insert(self.mTabList, bag.BagTabType.HEROEGG)
    end
    return self.mTabList
end

function configUI(self)
    super.configUI(self)
    self.EmptyStateItem = self:getChildGO("EmptyStateItem")
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
    self.mTxtEmptyTip.text = _TT(4017) --"- 当前暂无物品 -"

    self.mTextTitle = self:getChildGO("mTextTitle"):GetComponent(ty.Text)
    self.mImgTitle = self:getChildGO("mImgTitle"):GetComponent(ty.AutoRefImage)
    self.mBtnDecompose = self:getChildGO("mBtnDecompose")
end

function onClickClose(self)
    super.close(self)
end

function initViewText(self)
    self:setBtnLabel(self.mBtnDecompose, 4049, "分解")
end

function active(self, args)
    super.active(self, args)
    bag.BagManager:addEventListener(bag.BagManager.BUBBLE_CHANGE, self.onBubbleUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.BAG_CLOSE_DECOMPOSE, self.closeDecompose, self)
    GameDispatcher:addEventListener(EventName.BAG_EMPTY_STATE, self.onShowEmptyHandler, self)
    if (bag.BagManager.mBagTabArge == nil) then
        --args.tabType = bag.BagTabType.NORMAL
    else
        args.tabType = bag.BagManager.mBagTabArge.tabType
        args.data.suitId = bag.BagManager.mBagTabArge.suitId
        args.data.propsId = bag.BagManager.mBagTabArge.propsId
    end
    self:setData(args.tabType, args.data)
    self:setTitle()
end

function deActive(self)
    super.deActive(self)
    bag.BagManager:removeEventListener(bag.BagManager.BUBBLE_CHANGE, self.onBubbleUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.BAG_CLOSE_DECOMPOSE, self.closeDecompose, self)
    GameDispatcher:removeEventListener(EventName.BAG_EMPTY_STATE, self.onShowEmptyHandler, self)
    if self.mBreakView then
        self.mBreakView:close()
    end
end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mBtnDecompose, self.onClickDecomposeHandler)
end

function isHorizon(self)
    return false
end

-- 页签父节点
function getTabBarParent(self)
    return self:getChildTrans("mTabBarNode")
end

function getTabDatas(self)
    self.tabDataList = {}

    for i = 1, #self.mTabTypeList do
        local tabType = self.mTabTypeList[i]
        table.insert(self.tabDataList, {type = tabType, content = {bag.getPageName(tabType)}, nomalIcon = bag.getPageIcon(tabType), selectIcon = bag.getPageIcon(tabType)})
    end
    return self.tabDataList
end

function getTabClass(self)
    self.tabClassDic[bag.BagTabType.NORMAL] = bag.BagNormalTabView
    self.tabClassDic[bag.BagTabType.EQUIP] = bag.BagEquipTabView
    self.tabClassDic[bag.BagTabType.CONSUME] = bag.BagConsumeTabView
    self.tabClassDic[bag.BagTabType.HERO_FRAGMENT] = bag.BagFragmentTabView
    self.tabClassDic[bag.BagTabType.HEROEGG] = bag.BagEggTabView
    self.tabClassDic[bag.BagTabType.BRACELETS] = bag.BagBraceletsTabView
    return self.tabClassDic
end

-- 点击菜单
function onClickMenuHandler(self, cusTabType)
    if (self.mTabType ~= cusTabType) then
        self.mTabType = cusTabType
        self:__updateTabView()
    else
        if (self.mTabType == bag.BagTabType.EQUIP) then
            self:__updateTabView()
        end
    end

    self:setTitle()
end

function setTitle(self)
    self.mTextTitle.text = bag.getPageName(self.mTabType)
    self.mImgTitle:SetImg(bag.getIconURL(self.mTabType), true)
end

function closeDecompose(self)
    self.mBtnDecompose:SetActive(false)
end

-- 点击分解派发
function onClickDecomposeHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_BAG_BREAK_VIEW, {tabType = self.mTabType, suitId = self.mParams.mSuitId})
end

function setData(self, cusTabType, cusParams)
    self.mTabType = cusTabType
    self.mParams = cusParams
    self:__updateTabView()
end

function __updateTabView(self)
    self:setType(self.mTabType)
    local classObj = self:getClassInsByType(self.mTabType)
    classObj:setData(self.mTabType, self.mParams)
    bag.BagManager.mBagTabArge = {tabType = self.mTabType, suitId = self.mParams.suitId, propsId = self.mParams.propsId}
    self.mParams = {}

    if self.mTabType == bag.BagTabType.EQUIP or self.mTabType == bag.BagTabType.BRACELETS or self.mTabType == bag.BagTabType.HEROEGG then
        -- if self.mTabType == bag.BagTabType.EQUIP then
        self.mBtnDecompose:SetActive(true)
    else
        self.mBtnDecompose:SetActive(false)
    end
    self:__checkIsConsumeTabOpen()
    self:updateBubbleView(bag.BagTabType.NORMAL)
    self:updateBubbleView(bag.BagTabType.CONSUME)
end

function onBubbleUpdateHandler(self, args)
    self:updateBubbleView(args.tabType)
end

-- 设置空物品提示
function onShowEmptyHandler(self, isEmpty)
    self.EmptyStateItem:SetActive(false)
    self.EmptyStateItem:SetActive(not isEmpty)
end

function updateBubbleView(self, tabType)

    local isBubble = bag.BagManager:getFlagValue(tabType)
    if (isBubble) then
        self:addBubble(tabType)
    else
        self:removeBubble(tabType)
    end
end

function __checkIsConsumeTabOpen(self)
    if self:getPage() == bag.BagTabType.CONSUME then
        if read.ReadManager:isModuleRead(ReadConst.CONSUME_TABVIEW, 1) then
            GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, {type = ReadConst.CONSUME_TABVIEW, id = 1})
        end
    end
end

function destroyPanel(self)
    super.destroyPanel(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
