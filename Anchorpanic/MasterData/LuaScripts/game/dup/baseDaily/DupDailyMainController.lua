module('dup.DupDailyMainController', Class.impl(Controller))

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
    -- GameDispatcher:addEventListener(EventName.OPEN_DUP_EQUIP_PANEL, self.onOpenPanelHandler, self)
    -- GameDispatcher:addEventListener(EventName.OPEN_DAILY_DUP, self.onOpenPanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_CHIP_DORP_ROLE_VIEW, self.onOpenDupDorpViewHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
    }
end

function onOpenPanelHandler(self, args)
    if self.gPanel == nil then
        self.gPanel = dup.DupDailyMainPanel.new()
        self.gPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    end
end

-- ui销毁
function onDestroyViewHandler(self)
    self.gPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    self.gPanel = nil
end

function __onOpenDupPanelHandler(self, args)
    local mgr = dup.DupDailyUtil:getDupMgr(args.dupType)
    mgr:dispatchEvent(mgr.OPEN_DUP_PANEL, { dupType = args.dupType, dupId = args.dupId, isFight = args.isFight })
end
----------------------------------------------------------------------------------------------------------------------芯片副本-掉落规则界面-----------------------------------------------------------------------------------------
function onOpenDupDorpViewHandler(self, args)
    if self.mDupDorpRoleView == nil then
        self.mDupDorpRoleView = dup.DupChipAwardRoleView.new()
        self.mDupDorpRoleView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDupDorpViewHandler, self)
    end
    self.mDupDorpRoleView:open(args)
end
function onDestroyDupDorpViewHandler(self)
    self.mDupDorpRoleView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDupDorpViewHandler, self)
    self.mDupDorpRoleView = nil
end
return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
