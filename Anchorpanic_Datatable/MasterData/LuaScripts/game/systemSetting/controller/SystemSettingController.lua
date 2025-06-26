module("systemSetting.SystemSettingController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_SYSTEMSETTINGPANEL, self.onOpenViewHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {}
end

--------------------------------------------------------------打开玩家信息面板(其他与角色玩家)----------------------------------------------------------------------
function onOpenViewHandler(self, args)
    if self.mSystemSettingPanel == nil then
        self.mSystemSettingPanel = systemSetting.systemSettingPanel.new()
        self.mSystemSettingPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    end
    self.mSystemSettingPanel:open(args)
end

-- ui销毁
function onDestroyViewHandler(self)
    self.mSystemSettingPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    self.mSystemSettingPanel = nil
end

---------------------------------------------------------------响应------------------------------------------------------------------

---------------------------------------------------------------请求------------------------------------------------------------------

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
