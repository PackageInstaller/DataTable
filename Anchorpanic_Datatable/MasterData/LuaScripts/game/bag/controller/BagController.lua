module('bag.BagController', Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.__onCheckBubbleHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_BAG_PANEL, self.onOpenBagPanelHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_BAG_BREAK_VIEW, self.onOpenBagBreakPanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_BAG_BREAK_PRE_VIEW, self.onOpenBagBreakPreViewHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_USE_HEROEGG_PRO_VIEW, self.onOpenUseHeroEggViewHandler, self)
    

    bag.BagManager:addEventListener(bag.BagManager.SELECT_PROPS_GRID, self.onSelectGridHandler, self)
    bag.BagManager:addEventListener(bag.BagManager.EVENT_SELECT_TYPES_OVER, self.onBreakTypesSelectHandler, self)

    GameDispatcher:addEventListener(EventName.CLICK_NEW_ITEM, self.onClickNewItem, self)
    GameDispatcher:addEventListener(EventName.SHOW_MAIN_UI, self.onClearBagTabArg, self)
end


--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 道具初始化列表 17000
        SC_BAG_INIT = self.onResBagInitMsgHandler,
        --- *s2c* 道具更新 17001
        SC_BAG_UPDATE = self.onResBagUpdateMsgHandler,
        --- *s2c* 通用奖励获取 17013
        SC_PROP_AWARD_SEND = self.onPropsAwardMsgHandler,
    }
end


--更新装备使用情况
function onClickNewItem(self, args)
    SOCKET_SEND(Protocol.CS_CLICK_NEW_ITEM, { id = args.id })
end

-- 背包初始化
function onResBagInitMsgHandler(self, msg)
    bag.BagManager:initBag(msg)
end

-- 背包更新
function onResBagUpdateMsgHandler(self, msg)
    bag.BagManager:update(msg)
end

--- *s2c* 通用奖励获取 17013
function onPropsAwardMsgHandler(self, msg)
    ShowAwardPanel:showPropsAwardMsg(msg.award_list)
    -- UIFactory:bgMaskClose()
end

-- 点击了道具格子
function onSelectGridHandler(self, args)
    local selectPropsVo = args.selectVo:getDataVo()
    local isShowUseBtn = args.isShowUseBtn
    local rect = args.rectTransform

    if bag.BagManager.propsOpState == 1 then
        -- 出售
        if not selectPropsVo.isCanSell then
            gs.Message.Show(_TT(4001))--'该道具不能出售'
            return
        end
        if not bag.BagManager:getBreakBaseData(selectPropsVo.tid, 1) then
            gs.Message.Show(_TT(4001))--'该道具不能出售'
            return
        end
        bag.BagManager:setSellData(1, selectPropsVo.id)

    elseif bag.BagManager.propsOpState == 2 then
        if not selectPropsVo.isCanDecompose then
            gs.Message.Show(_TT(4002))--'该道具不能分解'
            return
        end

        if selectPropsVo.isLock == 1 then
            gs.Message.Show(_TT(4003))--'该道具已锁定，不能分解，先解除锁定'
            return
        end

        if not bag.BagManager:getBreakBaseData(selectPropsVo.tid, 2) then
            gs.Message.Show(_TT(4002))--'该道具不能分解'
            return
        end
        -- 分解
        bag.BagManager:setBreakProps(selectPropsVo.id)

    else
        if (selectPropsVo.type == PropsType.EQUIP) then
            TipsFactory:equipTips(selectPropsVo, nil, { rectTransform = rect }, true)
        elseif selectPropsVo.type == PropsType.ORDER then
            TipsFactory:equipTips(selectPropsVo, nil, { rectTransform = rect }, true)
        elseif selectPropsVo.type == PropsType.HERO then
            GameDispatcher:dispatchEvent(EventName.SHOW_SINGLE_HERO_INFO, { heroTid = selectPropsVo.tid })
        elseif (selectPropsVo.type ~= PropsType.EQUIP) then
            TipsFactory:propsTips({ propsVo = selectPropsVo, isShowUseBtn = isShowUseBtn }, { rectTransform = rect })
        end
    end

end
-- 按类型分解刷选完成
function onBreakTypesSelectHandler(self, args)
    bag.BagManager:setBreakPropsList(args)
end

function onCloseSellBreakViewHandler(self)
    if self.mBreakView and self.mBreakView.isOpen then
        self.mBreakView:close()
    end
end

function onClearBagTabArg(self)
    bag.BagManager.mBagTabArge = nil
end

function onOpenBagPanelHandler(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_BAG, true) == false then
        return
    end

    if self.mBagPanel == nil then
        self.mBagPanel = bag.BagPanel.new()
        self.mBagPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBagPanelHandler, self)
    end

    local data = {}
    local tabType = args.tabType or bag.BagTabType.NORMAL
    if (tabType == bag.BagTabType.EQUIP) then
        data = { suitId = args.suitId, propsId = args.propsId }
    elseif (tabType == bag.BagTabType.NORMAL) then
        data = { propsId = args.propsId }
    elseif (tabType == bag.BagTabType.RAWMAT) then
        data = { propsId = args.propsId }
    else
        data = {}
    end
    self.mBagPanel:open({ tabType = tabType, data = data })
end

-- ui销毁
function onDestroyBagPanelHandler(self)
    self.mBagPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBagPanelHandler, self)
    self.mBagPanel = nil

    if self.mBreakView then
        self.mBreakView:destroy()
        self.mBreakView = nil
    end
end

-- 新分解
function onOpenBagBreakPanelHandler(self, args)
    local tabType = args.tabType
    bag.BagManager.propsOpState = bag.getTabOpType(tabType)
    if self.mBagBreakPanel == nil then
        if tabType == bag.BagTabType.ORDER then
            self.mBagBreakPanel = UI.new(bag.BagBreakOrderView)
        elseif tabType == bag.BagTabType.EQUIP then
            self.mBagBreakPanel = UI.new(bag.BagBreakEquipView)
        elseif tabType == bag.BagTabType.BRACELETS then
            self.mBagBreakPanel = UI.new(bag.BagBreakBraceletsView)
        elseif tabType == bag.BagTabType.HEROEGG then
            self.mBagBreakPanel = UI.new(bag.BagBreakHeroEggView)
        end
        self.mBagBreakPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBagBreakViewHandler, self)
    end
    self.mBagBreakPanel:open(args)
end

-- ui销毁
function onDestroyBagBreakViewHandler(self)
    self.mBagBreakPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBagBreakViewHandler, self)
    self.mBagBreakPanel = nil
end

-- 新分解预览
function onOpenBagBreakPreViewHandler(self, args)
    if self.mBagBreakPreView == nil then
        self.mBagBreakPreView = UI.new(bag.BagBreakPreView)
        self.mBagBreakPreView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBagBreakPreViewHandler, self)
    end
    self.mBagBreakPreView:open(args)
end

-- ui销毁
function onDestroyBagBreakPreViewHandler(self)
    self.mBagBreakPreView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBagBreakPreViewHandler, self)
    self.mBagBreakPreView = nil
end

function __onCheckBubbleHandler(self, args)
    if (args) then
        if (args.type == ReadConst.NEW_EQUIP or args.type == ReadConst.NORMALBAGITEM or args.type == ReadConst.CONSUME or args.type == ReadConst.CONSUME_TABVIEW or args.type == ReadConst.DISCOUNT_BUBBLE) then
            bag.BagManager:updateBubble()
        end
    else
        bag.BagManager:updateBubble()
    end
end


function onOpenUseHeroEggViewHandler(self,args)
    if self.mUseHeroEggView == nil then
        self.mUseHeroEggView = UI.new(bag.UseHeroEggRulePanel)
        self.mUseHeroEggView:addEventListener(View.EVENT_VIEW_DESTROY, self.onCloseUseHeroEggViewHandler, self)
    end
    self.mUseHeroEggView:open(args)
end

function onCloseUseHeroEggViewHandler(self)
    self.mUseHeroEggView:close()
    self.mUseHeroEggView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onCloseUseHeroEggViewHandler, self)
    self.mUseHeroEggView = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]