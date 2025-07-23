--[[Brief  :好友控制器
Author :Jacob
]]
module('friend.FriendController', Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
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
end

--游戏开始的回调
function gameStartCallBack(self)
    -- 快捷提示需要一开始就获得申请列表
    -- GameDispatcher:dispatchEvent(EventName.FRIEND_APPLY_LIST_REQ)
end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_FRIEND_PANEL, self.onOpenFriendViewHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_FRIEND_BLACK_PANEL, self.onOpenFriendBlackViewHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_FRIEND_APPLY_PANEL, self.onOpenFriendApplyViewHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_FRIEND_RECOMMEND_PANEL, self.onOpenFriendRecommendViewHandler, self)
    GameDispatcher:addEventListener(EventName.FRIEND_LIST_REQ, self.onReqFriendListHandler, self)
    GameDispatcher:addEventListener(EventName.FRIEND_ADD_REQ, self.onReqFriendAddHandler, self)
    GameDispatcher:addEventListener(EventName.FRIEND_DEL_REQ, self.onReqFriendDelHandler, self)
    GameDispatcher:addEventListener(EventName.FRIEND_APPLY_LIST_REQ, self.onReqApplyListHandler, self)
    GameDispatcher:addEventListener(EventName.FRIEND_APPLY_REPLY, self.onReqApplyReplyHandler, self)
    GameDispatcher:addEventListener(EventName.FRIEND_FIND_REQ, self.onReqFindHandler, self)
    GameDispatcher:addEventListener(EventName.FRIEND_BLACK_LIST_REQ, self.onReqBlackListHandler, self)
    GameDispatcher:addEventListener(EventName.FRIEND_BLACK_ADD_REQ, self.onReqBlackAddHandler, self)
    GameDispatcher:addEventListener(EventName.FRIEND_BLACK_DEL_REQ, self.onReqBlackDelHandler, self)
    GameDispatcher:addEventListener(EventName.FRIEND_RECOMMEND_LIST_REQ, self.onReqRecommendHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_PRIVATE_CHAT_PANEL, self.onOpenPrivateChatViewHandler, self)
    GameDispatcher:addEventListener(EventName.SEND_PRIVATE_CHAT_INFO, self.onReqSendPrivateChatHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_PRIVATE_CHAT_LOG, self.onReqPrivateChatLogHandler, self)

    GameDispatcher:addEventListener(EventName.REQ_FRIEND_GIFT_SEND, self.onReqFriendGiftSendHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_FRIEND_GIFT_GAIN, self.onReqFriendGiftGainHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_FRIEND_RE_MARKS, self.onReqFriendRemarksHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 返回好友列表 15001
        SC_FRIEND_LIST = self.onMsgFriendListHandler,
        --- *s2c* 返回好友申请列表 15003
        SC_FRIEND_APPLY_LIST = self.onMsgApplyListHandler,
        --- *s2c* 收到玩家的申请请求 15006
        SC_FRIEND_APPLY_REQ = self.onMsgApplyReqHandler,
        --- *s2c* 返回添加玩家结果 15005
        SC_FRIEND_ADD = self.onMsgFriendAddHandler,
        --- *s2c* 返回删除的好友 15009
        SC_FRIEND_DEL_BACK = self.onMsgFriendDelHandler,
        --- *s2c* 返回好友黑名单列表 15013
        SC_BLACK_LIST = self.onMsgBlackListHandler,
        --- *s2c* 返回查询玩家结果 15011
        SC_FRIEND_QUERY = self.onMsgFrienQueryInfoHandler,
        --- *s2c* 返回好友推荐列表 15017
        SC_FRIEND_RECOMMEND = self.onMsgRecommendHandler,
        --- *s2c* 好友聊天返回 15020
        SC_FRIEND_CHAT = self.onMsgPrivateChatAddHandler,
        --- *s2c* 收到好友聊天 15021
        SC_RECEIVE_FRIEND_CHAT = self.onMsgReceivePrivateChatHandler,
        SC_FRIEND_CHAT_LOG = self.onMsgPrivateChatLogHandler,
        SC_FRIEND_GIFT_SEND = self.onMsgFriendGiftSendHandler,
        SC_FRIEND_GIFT_GAIN = self.onMsgFriendGiftGainHander,
        SC_FRIEND_GIFT_PANEL = self.onMsgFriendGiftInfoHander,
        SC_FRIEND_REMARKS = self.onMsgFriendMarkInfoHander,
    }
end

-- 返回好友列表
function onMsgFriendListHandler(self, msg)
    friend.FriendManager:parseFriendListMsg(msg)
end

-- 返回新增好友
function onMsgFriendAddHandler(self, msg)
    --1：发送成功，等待对方添加2：已是对方的黑名单
    -- 只要发送了都提示发送成功，不管对方是否收到
    -- if msg.friend_add_result == 1 then
    gs.Message.Show('发送成功')
    -- end
end

-- 返回删除好友id列表
function onMsgFriendDelHandler(self, msg)
    friend.FriendManager:delFriend(msg.id)
end

-- 返回申请列表
function onMsgApplyListHandler(self, msg)
    friend.FriendManager:parseApplyListMsg(msg)
end

--- *s2c* 收到玩家的申请请求 15006
function onMsgApplyReqHandler(self, msg)
    friend.FriendManager:parseApplyInfoMsg(msg)
end

--- *s2c* 返回好友黑名单列表 15013
function onMsgBlackListHandler(self, msg)
    friend.FriendManager:parseBlackListMsg(msg)
end

--- *s2c* 返回好友推荐列表 15017
function onMsgRecommendHandler(self, msg)
    friend.FriendManager:parseRecommendMsg(msg)
end

--- *s2c* 返回查询玩家结果 15011
function onMsgFrienQueryInfoHandler(self, msg)
    friend.FriendManager:parseQueryMsg(msg)
end

--- *s2c* 好友聊天返回 15020
function onMsgPrivateChatAddHandler(self, msg)
    friend.FriendManager:parseSendChatMsg(msg)
end

--- *s2c* 收到好友聊天 15021
function onMsgReceivePrivateChatHandler(self, msg)
    friend.FriendManager:parseReceiveChatMsg(msg)
end

--- *s2c* 好友聊天记录返回 15023
function onMsgPrivateChatLogHandler(self, msg)
    friend.FriendManager:onMsgPrivateChatLog(msg)
end

--- *s2c* 汇总好友礼物面板 15028
function onMsgFriendGiftInfoHander(self, msg)
    friend.FriendManager:parseFriendGiftInfoMsg(msg)
end

--- *s2c* 领取好友礼物结果返回 15027
function onMsgFriendGiftGainHander(self, msg)
    local list = {}
    for _, v in ipairs(msg.award_list) do
        local propsVo = LuaPoolMgr:poolGet(props.PropsVo)
        propsVo:setPropsAwardMsgData(v)
        table.insert(list, propsVo)
    end
    ShowAwardPanel:showPropsList(list)
end

--- *s2c* 赠送好友礼物结果返回 15025
function onMsgFriendGiftSendHandler(self, msg)
    -- gs.Message.Show('赠送成功')
    gs.Message.Show(_TT(25157))
end

--- *s2c* 好友备注返回 15031
function onMsgFriendMarkInfoHander(self, msg)
    if msg.result == 1 then
        friend.FriendManager:parseFriendMarkMsg(msg)
        gs.Message.Show(_TT(174))
    else
        -- gs.Message.Show('备注失败')
        gs.Message.Show(_TT(25158))
    end
end

-- 返回添加好友结果
function __onMsgAddFriendResult(self, msg)
    if msg.rec_result == 0 then

    elseif msg.rec_result == 1 then
        -- gs.Message.Show('好友不在线')
        gs.Message.Show(_TT(25159))
    elseif msg.rec_result == 2 then
        -- gs.Message.Show('对方好友数量已满')
        gs.Message.Show(_TT(25160))
    end
end

-- 请求好友列表
function onReqFriendListHandler(self)
    SOCKET_SEND(Protocol.CS_FRIEND_LIST, {}, Protocol.SC_FRIEND_LIST)
end

-- 请求添加好友
function onReqFriendAddHandler(self, id)
    SOCKET_SEND(Protocol.CS_FRIEND_ADD, {id = id}, Protocol.SC_FRIEND_ADD)
end

-- 请求删除好友
function onReqFriendDelHandler(self, id)
    SOCKET_SEND(Protocol.CS_FRIEND_DEL, {friend_id = id}, Protocol.SC_FRIEND_DEL_BACK)
end

-- 请求申请列表
function onReqApplyListHandler(self, id)
    SOCKET_SEND(Protocol.CS_FRIEND_APPLY_LIST, {}, Protocol.SC_FRIEND_APPLY_LIST)
end

-- 请求好友申请反馈
function onReqApplyReplyHandler(self, data)
    if table.empty(data) then
        return
    end
    SOCKET_SEND(Protocol.CS_FRIEND_APPLY_REPLY, {apply_reply_list = data})
end

-- 请求查找好友
function onReqFindHandler(self, id)
    SOCKET_SEND(Protocol.CS_FRIEND_QUERY, {show_id = id}, Protocol.SC_FRIEND_QUERY)
end

-- 请求黑名单列表
function onReqBlackListHandler(self)
    SOCKET_SEND(Protocol.CS_BLACK_LIST)
end

-- 请求增加黑名单
function onReqBlackAddHandler(self, id)
    SOCKET_SEND(Protocol.CS_BLACK_ADD, {player_id = id})
end

-- 请求移除黑名单
function onReqBlackDelHandler(self, id)
    SOCKET_SEND(Protocol.CS_BLACK_DEL, {black_id = id})
end

-- 请求推荐列表
function onReqRecommendHandler(self, id)
    SOCKET_SEND(Protocol.CS_FRIEND_RECOMMEND)
end

--- *c2s* 好友聊天 15019
function onReqSendPrivateChatHandler(self, cusData)
    local content = FilterWordUtil:filter(cusData.content)
    local cmd = {id = cusData.id, friend_id = cusData.friendId, content_type = cusData.contentType, content = content}
    SOCKET_SEND(Protocol.CS_FRIEND_CHAT, cmd)
end

--- *c2s* 好友聊天记录 15022
function onReqPrivateChatLogHandler(self, id)

    if not friend.FriendManager.mChatData[id] then
        SOCKET_SEND(Protocol.CS_FRIEND_CHAT_LOG, {friend_id = id})
    end
end

--- *c2s* 赠送好友礼物 15024
function onReqFriendGiftSendHandler(self, id)
    SOCKET_SEND(Protocol.CS_FRIEND_GIFT_SEND, {friend_id = id})
end

--- *c2s* 领取好友礼物 15026
function onReqFriendGiftGainHandler(self, id)
    SOCKET_SEND(Protocol.CS_FRIEND_GIFT_GAIN, {friend_id = id})
end

--- *c2s* 好友备注 15030
function onReqFriendRemarksHandler(self, args)
    local id = args.id
    local mark = args.marks
    SOCKET_SEND(Protocol.CS_FRIEND_REMARKS, {friend_id = id, new_remarks = mark})
end

---------------------------UI相关---------------------------------------
-- 打开好友界面
function onOpenFriendViewHandler(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FRIEND, true) == false then
        return
    end
    if self.mFriendPanel == nil then
        self.mFriendPanel = UI.new(friend.FriendPanel)
        self.mFriendPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFriendViewHandler, self)
    end
    self.mFriendPanel:open(args)
end
-- ui销毁
function onDestroyFriendViewHandler(self)
    self.mFriendPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFriendViewHandler, self)
    self.mFriendPanel = nil
end

-- 打开黑名单
function onOpenFriendBlackViewHandler(self)
    if self.mFriendBlack == nil then
        self.mFriendBlack = UI.new(friend.FriendBlackView)
        self.mFriendBlack:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFriendBlackViewHandler, self)
    end
    self.mFriendBlack:open()
end
-- ui销毁
function onDestroyFriendBlackViewHandler(self)
    self.mFriendBlack:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFriendBlackViewHandler, self)
    self.mFriendBlack = nil
end

-- 打开申请页面
function onOpenFriendApplyViewHandler(self)
    if self.mFriendApply == nil then
        self.mFriendApply = UI.new(friend.FriendApplyView)
        self.mFriendApply:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFriendApplyViewHandler, self)
    end
    self.mFriendApply:open()
end
-- ui销毁
function onDestroyFriendApplyViewHandler(self)
    self.mFriendApply:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFriendApplyViewHandler, self)
    self.mFriendApply = nil
end

-- 打开好友搜索页面
function onOpenFriendRecommendViewHandler(self)
    if self.mFriendRecommend == nil then
        self.mFriendRecommend = UI.new(friend.FriendRecommendView)
        self.mFriendRecommend:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFriendRecommendViewHandler, self)
    end
    self.mFriendRecommend:open()
end

-- ui销毁
function onDestroyFriendRecommendViewHandler(self)
    self.mFriendRecommend:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFriendRecommendViewHandler, self)
    self.mFriendRecommend = nil
end

-- 打开好友查找界面
function __onOpenFriendFindView(self, id)
    if self.mFriendFindPanel == nil then
        self.mFriendFindPanel = UI.new(friend.FriendFindPanel)
        self.mFriendFindPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFindViewHandler, self)
    end
    self.mFriendFindPanel:open()
end
-- ui销毁
function onDestroyFindViewHandler(self)
    self.mFriendFindPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFindViewHandler, self)
    self.mFriendFindPanel = nil
end

-- 打开好友查找界面
function onOpenPrivateChatViewHandler(self, cusId)
    if self.mPrivateChatPanel == nil then
        self.mPrivateChatPanel = UI.new(friend.PrivateChatPanel)
        self.mPrivateChatPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPrivateChatHandler, self)
    end
    self.mPrivateChatPanel:open({id = cusId})
end
-- ui销毁
function onDestroyPrivateChatHandler(self)
    self.mPrivateChatPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyPrivateChatHandler, self)
    self.mPrivateChatPanel = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
