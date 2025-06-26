module('dup.DupEquipMainController', Class.impl(Controller))

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构函数
function dtor(self)
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_EQUIP_DUP, self.onOpenChipViewHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_DUP_DAILY_PANEL, self.onOpenDailyPanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_DUP_POTENCY_VIEW, self.onOpenPotencyViewHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_DUP_EQUIP_DROP_SELECT_VIEW, self.onOpenChipSelectViewHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --零点刷新
        SC_SYS_RESET = self.onZeroRefreshHandler
    }
end
--零点刷新
function onZeroRefreshHandler(self)
    logInfo("零点刷新了")
    GameDispatcher:dispatchEvent(EventName.ZERO_REFRESH)
end

function onOpenDailyPanelHandler(self, args)
    if args and args.isFight == true then
        -- 由战斗结算返回，记录打完的副本id
        dup.DupDailyMainManager:setLastDupId(args.dupType, args.dupId)
    end

    if self.mDailyPanel == nil then
        self.mDailyPanel = dup.DupDailyBasePanel.new()
        self.mDailyPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDailyViewHandler, self)
    end
    self.mDailyPanel:open(args)
end

-- ui销毁
function onDestroyDailyViewHandler(self)
    self.mDailyPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDailyViewHandler, self)
    self.mDailyPanel = nil
end

function onOpenChipViewHandler(self, args)
    if args and args.isFight == true then
        -- 由战斗结算返回，记录打完的副本id
        dup.DupDailyMainManager:setLastDupId(args.dupType, args.dupId)
    end
    if self.mChipView == nil then
        self.mChipView = dup.DupChipInfoView.new()
        self.mChipView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyChipViewHandler, self)
    end
    self.mChipView:open(args)
end

-- ui销毁
function onDestroyChipViewHandler(self)
    self.mChipView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyChipViewHandler, self)
    self.mChipView = nil
end
--潜能认证界面
function onOpenPotencyViewHandler(self, args)
    if args and args.isFight == true then
        -- 由战斗结算返回，记录打完的副本id
        dup.DupDailyMainManager:setLastDupId(args.dupType, args.dupId)
    end
    if self.mPotencyView == nil then
        self.mPotencyView = dup.DupPotencyView.new()
        self.mPotencyView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPotencyViewHandler, self)
    end
    self.mPotencyView:open(args)
end

-- ui销毁
function onDestroyPotencyViewHandler(self)
    self.mPotencyView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPotencyViewHandler, self)
    self.mPotencyView = nil
end

function onOpenChipSelectViewHandler(self)
    if self.mChipSelectView == nil then
        self.mChipSelectView = dup.DupChipSelectView.new()
        self.mChipSelectView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyChipSelectViewHandler, self)
    end
    self.mChipSelectView:open()
end

-- ui销毁
function onDestroyChipSelectViewHandler(self)
    self.mChipSelectView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyChipSelectViewHandler, self)
    self.mChipSelectView = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]