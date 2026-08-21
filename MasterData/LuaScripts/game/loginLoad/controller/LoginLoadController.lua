--[[ 
-----------------------------------------------------
@filename       : LoginLoadController
@Description    : 登录加载控制器
@date           : 2020-08-31 16:33:53
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('loginLoad.LoginLoadController', Class.impl(Controller))


--构造
function ctor(self)
    super.ctor(self)
    self:__init()
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
    self:__init()
end

function __init(self)
    self.m_callBack = nil
    self.m_callObj = nil
    self.m_callParams = nil
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {}
end

-- 是否正在显示登录的资源预加载界面
function isLoginLoading(self)
    return self.m_callBack ~= nil or self.m_callObj ~= nil or self.m_callParams ~= nil
end

-- 展示登录加载页面
function showLoading(self, callBack, callObj, callParams)
    self.m_callBack = callBack
    self.m_callObj = callObj
    self.m_callParams = callParams

    if not self.m_loadingView then
        self.m_loadingView = loginLoad.LoginLoadView.new()
    end
end

-- 开始加载
function starRunLoad(self)
    if not GameManager:getIsLoadPreResComplete() and self.m_loadingView then
        self.m_loadingView:startLoad()
    end
end

-- 关闭登录加载页面
function closeLoading(self)
    if self.m_loadingView then
        self.m_loadingView:destroy()
        self.m_loadingView = nil
    end
end

-- 关闭登录加载页面并触发回调
function destroyLoading(self)
    self:closeLoading()
    self:__runCallFun()
    UIFactory:closeScreenSaver()
end

function __runCallFun(self)
    if(self.m_callBack and self.m_callObj)then
        self.m_callBack(self.m_callObj, self.m_callParams)
        self.m_callBack = nil
        self.m_callObj = nil
        self.m_callParams = nil
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
