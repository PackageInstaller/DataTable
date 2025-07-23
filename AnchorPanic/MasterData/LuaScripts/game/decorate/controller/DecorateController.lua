module('decorate.DecorateController', Class.impl(Controller))

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
    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.__onCheckBubbleHandler, self)
    -- 打开装饰面板
    --GameDispatcher:addEventListener(EventName.OPEN_DECORATE_PANEL, self.__onOpenDecoratePanelHandler, self)
    --打开个性头像页面
    GameDispatcher:addEventListener(EventName.OPEN_ROLE_HEAD_VIEW, self.onOpenChangeAvatarPanelHandler, self)
    -- 请求获取头像列表
    GameDispatcher:addEventListener(EventName.REQ_GAIN_ROLE_HEAD_LIST, self.onReqHeadListHandler, self)

    -- 请求获取聊天气泡列表
    GameDispatcher:addEventListener(EventName.REQ_CHATBUBBLE_LIST, self.onReqChatBubbleList, self)

    -- 请求获取头像框列表
    GameDispatcher:addEventListener(EventName.REQ_GAIN_ROLE_HEAD_FRAME_LIST, self.onReqHeadFrameListHandler, self)
    -- -- 请求获取称号列表
    -- GameDispatcher:addEventListener(EventName., self.onReqTitleListHandler, self)

    -- 请求设置喜欢的外观
    GameDispatcher:addEventListener(EventName.REQ_SET_LIKE_DECORATE, self.onReqSetLikeDecorateHandler, self)
    -- 请求取消喜欢的外观
    GameDispatcher:addEventListener(EventName.REQ_CANCEL_LIKE_DECORATE, self.onReqCancelLikeDecorateHandler, self)
    -- 请求设置外观
    GameDispatcher:addEventListener(EventName.REQ_SET_DECORATE, self.onReqSetDecorateHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 获取头像列表 12018
        SC_GET_AVATAR_LIST = self.onResHeadListHandler,
        --- *s2c* 获取头像框列表 12021
        SC_GET_AVATAR_FRAME_LIST = self.onResHeadFrameListHandler,
        --- *s2c* 获取称号列表 12025
        SC_GET_DESIGNATION_LIST = self.onResTitleListHandler,

        --- *s2c* 喜爱外观 12024
        SC_LIKE_APPEARANCE = self.onResSetLikeHeadHandler,
        --- *s2c* 取消喜爱外观 12026
        SC_UNLIKE_APPEARANCE = self.onResCancelLikeHeadHandler,
        --- *s2c* 设置外观 12028
        SC_SET_APPEARANCE = self.onResSetDecorateHandler,
        --- *s2c* 获取背景图列表 12067
        SC_GET_BACKGROUND_LIST = self.onResBackGroundListHandler,
        --- *s2c* 外观过期 12066
        SC_APPEARANCE_EXPIRE = self.onResExpireDecorateHandler,

        SC_GET_DIALOG_BOX_LIST = self.onResChatBubbleListHandler,
    }
end

--------------------------------------------------------------模块功能响应----------------------------------------------------------------------
-- 响应获取激活的头像列表
function onResHeadListHandler(self, msg)
    decorate.DecorateManager:praseDecorateListMsg(decorate.ModuleType.HEAD, msg.avatar_list)
end

-- 响应获取激活的头像框列表
function onResHeadFrameListHandler(self, msg)
    decorate.DecorateManager:praseDecorateListMsg(decorate.ModuleType.HEAD_FRAME, msg.avatar_frame_list)
end

-- 响应获取激活的称号列表
function onResTitleListHandler(self, msg)
    decorate.DecorateManager:praseDecorateListMsg(decorate.ModuleType.TITLE, msg.designation_list)
end

-- 喜爱外观 12024
function onResSetLikeHeadHandler(self, msg)
    if (msg.result == 1) then
        if (msg.type == decorate.ModuleType.HEAD) then
            gs.Message.Show("设置喜欢头像成功")
        elseif (msg.type == decorate.ModuleType.HEAD_FRAME) then
            gs.Message.Show("设置喜欢头像框成功")
        elseif (msg.type == decorate.ModuleType.TITLE) then
            gs.Message.Show("设置喜欢称号成功")
        elseif decorate.ModuleType.BACKGROUND then
            gs.Message.Show("设置喜欢背景成功")
        end
    else
        if (msg.type == decorate.ModuleType.HEAD) then
            gs.Message.Show("设置喜欢头像失败")
        elseif (msg.type == decorate.ModuleType.HEAD_FRAME) then
            gs.Message.Show("设置喜欢头像框失败")
        elseif (msg.type == decorate.ModuleType.TITLE) then
            gs.Message.Show("设置喜欢称号失败")
        elseif decorate.ModuleType.BACKGROUND then
            gs.Message.Show("设置喜欢背景失败")
        end
    end
end

-- 取消喜爱外观 12026
function onResCancelLikeHeadHandler(self, msg)
    if (msg.result == 1) then
        if (msg.type == decorate.ModuleType.HEAD) then
            gs.Message.Show("取消喜欢头像成功")
        elseif (msg.type == decorate.ModuleType.HEAD_FRAME) then
            gs.Message.Show("取消喜欢头像框成功")
        elseif (msg.type == decorate.ModuleType.TITLE) then
            gs.Message.Show("取消喜欢称号成功")
        end
    else
        if (msg.type == decorate.ModuleType.HEAD) then
            gs.Message.Show("取消喜欢头像失败")
        elseif (msg.type == decorate.ModuleType.HEAD_FRAME) then
            gs.Message.Show("取消喜欢头像框失败")
        elseif (msg.type == decorate.ModuleType.TITLE) then
            gs.Message.Show("取消喜欢称号失败")
        end
    end
end

-- 设置外观 12028
function onResSetDecorateHandler(self, msg)
    if (msg.result == 1) then
        if (msg.type == decorate.ModuleType.HEAD) then
            gs.Message.Show("设置头像成功")
        elseif (msg.type == decorate.ModuleType.HEAD_FRAME) then
            gs.Message.Show("设置头像框成功")
        elseif (msg.type == decorate.ModuleType.TITLE) then
            gs.Message.Show("设置称号成功")
        elseif (msg.type == decorate.ModuleType.BACKGROUND) then
            GameDispatcher:dispatchEvent(EventName.REQ_PLAYER_HOMEPAGE_INFO)
            --gs.Message.Show("设置背景成功")
        end
    else
        if (msg.type == decorate.ModuleType.HEAD) then
            gs.Message.Show("设置头像失败")
        elseif (msg.type == decorate.ModuleType.HEAD_FRAME) then
            gs.Message.Show("设置头像框失败")
        elseif (msg.type == decorate.ModuleType.TITLE) then
            gs.Message.Show("设置称号失败")
        elseif (msg.type == decorate.ModuleType.BACKGROUND) then
            GameDispatcher:dispatchEvent(EventName.REQ_PLAYER_HOMEPAGE_INFO)
            gs.Message.Show("设置背景失败")
        end
    end
end

--- *s2c* 外观过期 12066
function onResExpireDecorateHandler(self, msg)
    decorate.DecorateManager:praseDecorateDelMsg(msg.type, msg.id)
end
--- *s2c* 背景图列表返回 12067
function onResBackGroundListHandler(self, msg)
    decorate.DecorateManager:parseBackGroundKistMsg(msg)
end

--- *s2c* 聊天气泡列表返回 12036
function onResChatBubbleListHandler(self, msg)
    decorate.DecorateManager:praseChatBubbleMsg(msg)
    GameDispatcher:dispatchEvent(EventName.RES_CHATBUBBLE_LIST)
end
--------------------------------------------------------------模块功能请求----------------------------------------------------------------------
--请求聊天气泡列表
function onReqChatBubbleList(self)
    SOCKET_SEND(Protocol.CS_GET_DIALOG_BOX_LIST, {}, Protocol.SC_GET_DIALOG_BOX_LIST)
end

-- 请求获取激活的头像列表
function onReqHeadListHandler(self, args)
    --- *c2s* 获取头像列表 12017
    SOCKET_SEND(Protocol.CS_GET_AVATAR_LIST, {})
end

-- 请求获取激活的头像框列表
function onReqHeadFrameListHandler(self, args)
    --- *c2s* 获取头像框列表 12019
    SOCKET_SEND(Protocol.CS_GET_AVATAR_FRAME_LIST, {})
end

-- 请求获取激活的称号列表
function onReqTitleListHandler(self, args)
    --- *c2s* 获取称号列表 12024
    SOCKET_SEND(Protocol.CS_GET_DESIGNATION_LIST, {})
end

-- 请求设置喜爱外观 12023
function onReqSetLikeDecorateHandler(self, args)
    --- *c2s* 设置喜爱外观 12023
    SOCKET_SEND(Protocol.CS_LIKE_APPEARANCE, {type = args.moduleType, id = args.id})
end
-- 请求取消喜爱外观 12025
function onReqCancelLikeDecorateHandler(self, args)
    --- *c2s* 消喜爱外观 12025
    SOCKET_SEND(Protocol.CS_UNLIKE_APPEARANCE, {type = args.moduleType, id = args.id})
end
-- 请求设置外观 12027
function onReqSetDecorateHandler(self, args)
    --- *c2s* 设置外观 12027
    SOCKET_SEND(Protocol.CS_SET_APPEARANCE, {type = args.moduleType, id = args.id})
end

------------------------------------------------------------------------ 装饰面板 ------------------------------------------------------------------------
function __onOpenDecoratePanelHandler(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HOME_HEAD, false) == false then
        return
    end
    if self.m_decoratePanel == nil then
        self.m_decoratePanel = decorate.DecoratePanel.new()
        self.m_decoratePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroRecruitPanelHandler, self)
    end
    local tabType = decorate.TabType.HEAD
    if (args and args.type) then
        tabType = args.type
    end
    self.m_decoratePanel:open({type = tabType})
end

function onDestroyHeroRecruitPanelHandler(self)
    self.m_decoratePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyHeroRecruitPanelHandler, self)
    self.m_decoratePanel = nil
end
------------------------------------------------------------------------ 个性装扮 ------------------------------------------------------------------------
function onOpenChangeAvatarPanelHandler(self)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HOME_HEAD, false) == false then
        return
    end
    if self.mChangeAvatarPanel == nil then
        self.mChangeAvatarPanel = role.ChangeAvatarPanel.new()
        self.mChangeAvatarPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyChangeAvatarPanelHandler, self)
    end
    self.mChangeAvatarPanel:open()
end

function onDestroyChangeAvatarPanelHandler(self)
    self.mChangeAvatarPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyChangeAvatarPanelHandler, self)
    self.mChangeAvatarPanel = nil
end

function __onCheckBubbleHandler(self, args)
    if (args) then
        if (args.type == ReadConst.NEW_HEAD or args.type == ReadConst.NEW_HEAD_FRAME or args.type == ReadConst.NEW_TITLE) then
            decorate.DecorateManager:updateBubble()
        end
    else
        decorate.DecorateManager:updateBubble()
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
