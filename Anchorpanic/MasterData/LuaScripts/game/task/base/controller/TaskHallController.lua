module("task.TaskHallController", Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_TASK_HALL_PANEL, self.__onOpenTaskHallPanelHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
    --- *s2c* 英雄数据 13000
    -- SC_HERO_DATA = self.__onResHeroListMsgHandler,
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 初始英雄列表
-- function __onResHeroListMsgHandler(self, msg)
--     hero.HeroManager:parseMsgHeroList(msg.hero_info)
-- end
---------------------------------------------------------------请求------------------------------------------------------------------
-- 请求英雄详细数据
-- function __onReqHeroDataHandler(self, args)
--     local heroId = args.heroId
--     --- *c2s* 请求英雄详细数据 13010
--     SOCKET_SEND(Protocol.CS_HERO_DETAIL, {id = heroId})
-- end
------------------------------------------------------------------------ 战斗地图大厅面板 ------------------------------------------------------------------------
function __onOpenTaskHallPanelHandler(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_TASK, true) == false then
        return
    end
    if not args then
        args = { type = task.TYPE_DAILY_TASK }
    end

    if self.m_hallPanel == nil then
        self.m_hallPanel = task.TaskHallPanel.new()
        self.m_hallPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHallPanelHandler, self)
    end
    self.m_hallPanel:open(args)
    -- self.m_hallPanel:setData(args == nil and task.TYPE_DAILY_TASK or args.tabType)
end

function onDestroyHallPanelHandler(self)
    self.m_hallPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHallPanelHandler, self)
    self.m_hallPanel = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
