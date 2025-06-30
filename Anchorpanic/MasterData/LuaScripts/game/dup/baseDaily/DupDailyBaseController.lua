module('dup.DupDailyBaseController', Class.impl(Controller))

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
    -- GameDispatcher:addEventListener(EventName.OPEN_DAILY_DUP_INFO, self.__onOpenDupInfoHandler, self)
    -- GameDispatcher:addEventListener(EventName.CLOSE_DAILY_DUP_INFO, self.__onCloseDupInfoHandler, self)
    self:getMgr():addEventListener(self:getMgr().OPEN_DUP_PANEL, self.__onOpenDupPanelHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
    }
end

-- 副本信息
function __onOpenDupInfoHandler(self, cusVo)
    if (cusVo.type == self:getMgr():getDupType()) then
        if self.gInfoView == nil then
            self.gInfoView = dup.DupDailyInfoView.new()
            self.gInfoView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyInfoViewHandler, self)
        end
        self.gInfoView:setData(cusVo)
        self.gInfoView:open()
    end
end

-- ui销毁
function onDestroyInfoViewHandler(self)
    self.gInfoView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyInfoViewHandler, self)
    self.gInfoView = nil
end

function onCloseDupViewHandler(self)
    if self.gInfoView then
        self.gInfoView:close()
    end
end
-- 关闭副本信息
function __onCloseDupInfoHandler(self, cusType)
    if (cusType == self:getMgr():getDupType()) then
        self:onCloseDupViewHandler()
    end
end

function __onOpenDupPanelHandler(self, args)
    if self.gDupView == nil then
        local mgr = self:getMgr()
        self.gDupView = (mgr:getViewName()).new()
        self.gDupView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyDupViewHandler, self)
        self.gDupView:addEventListener(View.EVENT_CLOSE, self.onCloseDupViewHandler, self)
    end
    self.gDupView:open(args)
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
