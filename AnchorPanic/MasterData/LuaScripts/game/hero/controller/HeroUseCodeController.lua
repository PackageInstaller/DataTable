module("hero.HeroUseCodeController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.REQ_CANNOTDEL_HERO_DATA, self.__onReqCanNotDelHeroListHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 不能删除的英雄列表 13062
        SC_CANNOT_DEL_HERO_LIST = self.__onResCanNotDelHeroListHandler,
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 返回不能删除的英雄列表 13045
function __onResCanNotDelHeroListHandler(self, msg)
    hero.HeroUseCodeManager:parseHeroList(msg.cannot_del_hero_list)
end

---------------------------------------------------------------请求------------------------------------------------------------------
-- 请求不能删除的英雄列表 13044
function __onReqCanNotDelHeroListHandler(self)
    --- *c2s* 请求不能删除的英雄列表 13044
    SOCKET_SEND(Protocol.CS_CANNOT_DEL_HERO_LIST, {})
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
