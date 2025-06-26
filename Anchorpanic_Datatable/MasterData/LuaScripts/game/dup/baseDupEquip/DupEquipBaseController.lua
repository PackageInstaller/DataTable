module('dup.DupEquipBaseController', Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.REQ_DUP_CHIP_SELECT_SUIT, self.onReqDupChipPickSuitHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 芯片副本选择套装掉落 18062
        SC_CHIP_DUP_PICK_SUIT = self.onDupChipPickSuitHandler,
    }
end
--- *c2s* 芯片副本选择套装掉落 18061
function onReqDupChipPickSuitHandler(self, suitId)
    SOCKET_SEND(Protocol.CS_CHIP_DUP_PICK_SUIT, { suit_id = suitId })
end

--- *c2s* 芯片副本选择套装掉落 18061
function onDupChipPickSuitHandler(self, args)
    dup.DupEquipBaseManager:setUsingSuitId(args.suit_id)
    GameDispatcher:dispatchEvent(EventName.UPDATE_DUP_CHIP_SELECT_SUIT)
end

function onOpenDupPanelHandler(self, args)
    if self.gDupView == nil then
        local mgr = self:getMgr()
        self.gDupView = (mgr:getViewName()).new()
        self.gDupView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDupViewHandler, self)
        self.gDupView:addEventListener(View.EVENT_CLOSE, self.onCloseDupViewHandler, self)
    end
    self.gDupView:setPage({ type = args.dupType })
end

function onDestroyDupViewHandler(self)
    self.gDupView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDupViewHandler, self)
    self.gDupView = nil
end

-- 继承取出manager模块
function getMgr(self)
    Debug:log_error('DupDailyBaseController', '未返回副本manager模块')
    return nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]