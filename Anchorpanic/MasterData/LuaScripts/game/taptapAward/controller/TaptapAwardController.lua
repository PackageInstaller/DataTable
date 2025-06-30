module("taptapAward.TaptapAwardController", Class.impl(Controller))

-- 构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)

end

-- 析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

-- 游戏开始的回调
function gameStartCallBack(self)

    -- GameDispatcher:addEventListener(EventName.OPEN_TAPTAP_AWARD_PANEL,self.onOpenTaptapAwardPanel,self)
end

-- 模块间事件监听
function listNotification(self)
end

-- 注册server发来的数据
function registerMsgHandler(self)
    return {
    }
end

-- function onOpenTaptapAwardPanel(self,args)
--     if self.mTaptapAwardPanel == nil then
--         self.mTaptapAwardPanel = taptapAward.TaptapAwardPanel.new()
--         self.mTaptapAwardPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryTaptapAwardPanel,self)
--     end
--     self.mTaptapAwardPanel:open(args)
-- end

-- function onDestoryTaptapAwardPanel(self,args)
--     self.mTaptapAwardPanel:removeEventListener(View.EVENT_VIEW_DESTROY,self.onDestoryTaptapAwardPanel,self)
--     self.mTaptapAwardPanel = nil
-- end

return _M