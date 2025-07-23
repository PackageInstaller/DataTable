module("battleMap.BiographyController", Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self,cusMgr)
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
    self:__onReqHeroBiographyHandler()
end

--模块间事件监听
function listNotification(self)
    -- 请求英雄回忆录列表
    GameDispatcher:addEventListener(EventName.REQ_HERO_BIOGRAPHY, self.__onReqHeroBiographyHandler, self)
    -- 请求战员关注
    GameDispatcher:addEventListener(EventName.REQ_HERO_FOLLOW, self.__onReqHeroFollowHandler, self)

    -- 打开英雄传记面板
    GameDispatcher:addEventListener(EventName.OPEN_HERO_BIOGRAPHY_PANEL, self.__onOpenHeroBiographyPanelHandler, self)
    -- 打开英雄传记章节信息面板
    GameDispatcher:addEventListener(EventName.OPEN_HERO_BIOGRAPHY_DUP_INFO_PANEL, self.__onOpenHeroBiographyDupInfoHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 战员回忆录 18007
        SC_HERO_BIOGRAPHY_INFO = self.__onResHeroBiographyMsgHandler,
    }
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 更新英雄回忆录列表
function __onResHeroBiographyMsgHandler(self, msg)
    battleMap.BiographyManager:parseMsgHeroBiography(msg)
end

---------------------------------------------------------------请求------------------------------------------------------------------
-- 请求英雄回忆录列表
function __onReqHeroBiographyHandler(self, args)
    --- *c2s* 战员回忆录 18006
    SOCKET_SEND(Protocol.CS_HERO_BIOGRAPHY_INFO, {})
end

-- 请求英雄战员关注
function __onReqHeroFollowHandler(self, args)
    --- *c2s* 战员回忆录关注战员 18014
    SOCKET_SEND(Protocol.CS_HERO_BIOGRAPHY_FOLLOW, {hero_tid = args.tid, is_follow = args.follow})
end

------------------------------------------------------------------------ 打开英雄传记面板 ------------------------------------------------------------------------
function __onOpenHeroBiographyPanelHandler(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_BIOGRAPHY, true) == false then
        return
	end

    if self.m_heroBiography == nil then
        self.m_heroBiography = battleMap.HeroBiographyPanel.new()
        self.m_heroBiography:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroBiographyPanelHandler, self)
    end
    
    self.m_heroBiography:open({heroTid = args.heroTid, biographyId = args.biographyId})
end

function onDestroyHeroBiographyPanelHandler(self)
    self.m_heroBiography:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroBiographyPanelHandler, self)
    self.m_heroBiography = nil
end

------------------------------------------------------------------------ 打开英雄传记章节挑战信息面板 ------------------------------------------------------------------------
function __onOpenHeroBiographyDupInfoHandler(self, args)
    if self.m_heroBiographyDupInfo == nil then
        self.m_heroBiographyDupInfo = battleMap.HeroBiographyDupInfoView.new()
        self.m_heroBiographyDupInfo:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroBiographyDupInfoHandler, self)
    end
    self.m_heroBiographyDupInfo:open({heroTid = args.heroTid, biographyId = args.biographyId, stageId = args.stageId})
end

-- ui销毁
function onDestroyHeroBiographyDupInfoHandler(self)
    self.m_heroBiographyDupInfo:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroBiographyDupInfoHandler, self)
    self.m_heroBiographyDupInfo = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
