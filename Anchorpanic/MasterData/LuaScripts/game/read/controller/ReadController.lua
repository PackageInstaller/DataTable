--[[ 
    设置模块id读取状态控制器
    @author Zzz
]]
module("read.ReadController", Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
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
    GameDispatcher:addEventListener(EventName.REQ_MODULE_READ, self.__onReqModuleReadHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 服务器返回所有类型的已读模块列表 10056
        SC_RES_ALL_MODULE_READ = self.__onResAllModuleReadHandler,
        --- *s2c* 服务器返回已读模块id 10058
        SC_RES_MODULE_READ = self.__onResModuleReadHandler,
        --- *s2c* 新的未读类型的id 10059
        SC_NEW_UNREAD = self.__newReadHandler,
    }
end

------------------------------------------------------------------------ 响应 ------------------------------------------------------------------------
---服务器返回所有类型的已读模块列表
function __onResAllModuleReadHandler(self, msg)
    read.ReadManager:parseAllModuleReadMsg(msg.all_module_read_list)
end

---服务器返回已读模块id
function __onResModuleReadHandler(self, msg)
    read.ReadManager:parseModuleReadMsg(msg.type, msg.id)
end

---新的未读列表
function __newReadHandler(self, msg)
    read.ReadManager:updateModuleReadMsg(msg)
end

------------------------------------------------------------------------ 请求 ------------------------------------------------------------------------
---请求设置模块id已读
function __onReqModuleReadHandler(self, args)
    local type = args.type
    local id = args.id
    --- *c2s* 通知服务器模块id已读 10057
    SOCKET_SEND(Protocol.CS_REQ_MODULE_READ, { type = type, id = id })
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]