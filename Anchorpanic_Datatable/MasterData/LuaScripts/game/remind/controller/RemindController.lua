--[[ 
    每日提示控制器
    @author Zzz
]]
module("remind.RemindController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.REQ_ADD_NOT_REMIND, self.onReqAddNotRemindHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 今日不再提示模块列表 12006
        SC_TODAY_NOT_NOTICE = self.onResNotRemindListHandler,
        --- *s2c* 加入今日不再提示 12008
        SC_ADD_TODAY_NOT_NOTICE = self.onResNotRemindResultHandler,
    }
end

------------------------------------------------------------------------ 响应 ------------------------------------------------------------------------
---今日不再提示模块列表返回
function onResNotRemindListHandler(self, msg)
    remind.RemindManager:parseNotRemindListMsg(msg.not_notice_list)
end

---加入今日不再提示返回
function onResNotRemindResultHandler(self, msg)
    remind.RemindManager:parseNotRemindResultMsg(msg)
end

------------------------------------------------------------------------ 请求 ------------------------------------------------------------------------
---请求今日不再提示模块列表
function onReqNotRemindListHandler(self, args)
    --- *c2s* 今日不再提示模块列表 12005
    SOCKET_SEND(Protocol.CS_TODAY_NOT_NOTICE, {})
end

---请求加入今日不再提示
function onReqAddNotRemindHandler(self, args)
    local moduleId = args.moduleId and args.moduleId or 0
    --- *c2s* 加入今日不再提示 12007
    SOCKET_SEND(Protocol.CS_ADD_TODAY_NOT_NOTICE, {function_id = moduleId})
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
