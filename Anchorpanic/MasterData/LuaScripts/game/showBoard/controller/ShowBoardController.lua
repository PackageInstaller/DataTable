--[[    展示板
]]
module('showBoard.ShowBoardController', Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_SHOW_BOARD_HERO_PANEL, self.__onOpenShowBoardHeroPanel, self)
    GameDispatcher:addEventListener(EventName.REQ_CAN_SHOW_BOARD_HERO, self.__onReqCanShowBoardHeroListHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_CHANGE_SHOW_BOARD_HERO, self.__onReqChangeShowBoardHero, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 选择战员看板娘返回 13086
        SC_SELECT_HERO_BOARD_SHOW = self.__onResShowBoardHeroHandler,
        --- *s2c* 选择战员看板娘返回 13097
        SC_HERO_BOARD_CAN_SHOW = self.__onResCanShowBoardHeroListHandler,
    }
end

-- 选择战员看板娘返回
function __onResShowBoardHeroHandler(self, msg)
    if (msg.result == 1) then
        role.RoleManager:getRoleVo():setShowBoardHeroId(msg.id)
        gs.Message.Show(_TT(1010)) --替换助理成功
    -- else
    --     gs.Message.Show(_TT(1009)) --替换助理失败
    end
end

-- 返回能够展示的英雄列表
function __onResCanShowBoardHeroListHandler(self, msg)
    showBoard.ShowBoardManager:setShowBoardHeroList(msg.id_list)
end

-- 请求能够展示的英雄列表
function __onReqCanShowBoardHeroListHandler(self, data)
    --- *c2s* 请求可以更换的看板娘列表 13096
    SOCKET_SEND(Protocol.CS_HERO_BOARD_CAN_SHOW)
end

-- 请求选择战员看板娘
function __onReqChangeShowBoardHero(self, data)
    --- *c2s* 选择战员看板娘 13085
    SOCKET_SEND(Protocol.CS_SELECT_HERO_BOARD_SHOW, { id = data.heroId })
    GameDispatcher:dispatchEvent(EventName.REQ_CANNOTDEL_HERO_DATA)
end

-- 打开展示板模型界面
function __onOpenShowBoardHeroPanel(self)
    if self.m_showBoardHeroPanel == nil then
        self.m_showBoardHeroPanel = showBoard.ShowBoardHeroPanel2.new()
        self.m_showBoardHeroPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShowBoardHeroHandler, self)
    end
    self.m_showBoardHeroPanel:open()
end

-- ui销毁
function onDestroyShowBoardHeroHandler(self)
    self.m_showBoardHeroPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyShowBoardHeroHandler, self)
    self.m_showBoardHeroPanel = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
