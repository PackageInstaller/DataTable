--[[   
     debug控制器
]]
module("debug.DebugFramesController", Class.impl(Controller))
--构造函数
function ctor(self)
    super.ctor(self)
    self.m_fps = nil
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
    self:__onCloseFPSHandler()
end

--游戏开始的回调
function gameStartCallBack(self)
    self:__onCreateFPSHandler()
end

--模块间事件监听
function listNotification(self)
    super.listNotification(self)
    GameDispatcher:addEventListener(EventName.CREATE_FPS, self.__onCreateFPSHandler, self)
    debugFrames.FPS:addEventListener(debugFrames.FPS.EVENT_VISIBLE_CHANGE, self.__onFpsVisibleChangeHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {}
end

function __onCreateFPSHandler(self)
    if GameManager.IS_DEBUG then
        if self.m_fps == nil then
            self.m_fps = debugFrames.FPS.new()
        end
        self.m_fps:open()
    end
end

function __onCloseFPSHandler(self)
    if GameManager.IS_DEBUG then
        if self.m_fps ~= nil then
            self.m_fps:close()
            self.m_fps = nil
        end
    end
end

-- 关闭FPS
function __onFpsVisibleChangeHandler(self, args)
    if (args) then
        self:__onCreateFPSHandler()
    else
        self:__onCloseFPSHandler()
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
