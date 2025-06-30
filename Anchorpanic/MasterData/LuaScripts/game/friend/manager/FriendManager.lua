--[[   
     好友数据管理
]]
module("friend.FriendManager", Class.impl(Manager))

FRIEND_UPDATE = 'FRIEND_UPDATE'
FRIEND_APPLY_UPDATE = 'FRIEND_APPLY_UPDATE'
FRIEND_QUERY_UPDATE = 'FRIEND_QUERY_UPDATE'
FRIEND_BLACK_UPDATE = 'FRIEND_BLACK_UPDATE'
FRIEND_RECOMMEND_UPDATE = 'FRIEND_RECOMMEND_UPDATE'
FRIEND_REMARSK = 'FRIEND_REMARSK'
FRIEND_INFO = 'FRIEND_INFO'
FRIEND_CHECK_INFO = "FRIEND_CHECK_INFO"

-- 私聊数据更新
PRIVATE_CHAT_UPDATE = 'PRIVATE_CHAT_UPDATE'
-- 新增一条私聊信息
PRIVATE_CHAT_ADD = 'PRIVATE_CHAT_ADD'

FRIEND_MAX = 30

--构造函数
function ctor(self)
    super.ctor(self)
    self:init()
end

--析构函数
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:init()
end

function init(self)
    -- 好友列表
    self.mFriendList = {}
    -- 好友请求列表
    self.mApplyList = {}
    -- 好友查找列表
    self.mQueryList = {}
    -- 黑名单列表
    self.mBackList = {}
    -- 推荐列表
    self.mRecommendList = {}
    -- 聊天对象列表
    self.mChatMemberList = nil
    -- 是否是一键通过
    self.mIsOneClick = false
    -- 是否是第一次初始化
    self.mIsFristInit = false
    -- 私聊记录
    self.mChatData = {}
    --是否刷新
    self.mIsUpdate = false
    --是否操作
    self.mIsOperation = 0
    self.mFlag = false

    self.mGiftMax = 0
    self.mGiftCount = 0
    self.mCurFirendId = 0
end

-- 解析好友列表
function parseFriendListMsg(self, msg)
    if #msg.friend_list <= 0 and #self.mFriendList > 0 then
        local delList = table.values(self.mFriendList)
        for _, friendVo in ipairs(delList) do
            self:delFriend(friendVo.id)
        end
    end
    if #msg.friend_list > 0 and friend.FriendManager:getIsOneClick() == false then
        if #self.mFriendList <= 0 then
            self.mFriendList = {}
        end
    end
    local tempList = {}
    for i, v in ipairs(msg.friend_list) do
        local friendVo = self:getFriendVo(v.id)
        if not friendVo then
            friendVo = LuaPoolMgr:poolGet(friend.FriendVo)
            friendVo:setData(v)
            table.insert(self.mFriendList, friendVo)
        else
            friendVo:setData(v)
            self:updateFriendListVo(friendVo)
        end
        table.insert(tempList, friendVo)
    end
    if self.mIsFristInit == true then
        self.mIsFristInit = false
        self.mFriendList = tempList
    end

    -- 每次最新好友列表同步的时候，都同时更新下缓存
    self:updateChatMemberList()
    
    self:dispatchEvent(FRIEND_UPDATE)
end

-- 删除好友
function delFriend(self, id)
    for i = #self.mFriendList, 1, -1 do
        local friendVo = self.mFriendList[i]
        if friendVo.id == id then
            LuaPoolMgr:poolRecover(friendVo)
            table.remove(self.mFriendList, i)
            break
        end
    end
    -- 删除一个聊天对象
    self:delChatMember(id)
    self:dispatchEvent(FRIEND_UPDATE)
end

-- 获取好友列表
function getFriendList(self)
    for _, vo in ipairs(self.mBackList) do
        for i, friendVo in ipairs(self.mFriendList) do
            if vo.id == friendVo.id then
                self:delFriend(friendVo.id)
            end
        end
    end
    table.sort(self.mFriendList, self.sortFriend)
    return self.mFriendList
end

-- 更新某个好友信息 用于删除后添加通过
function updateFriendListVo(self, vo)
    for k, friVo in ipairs(self.mFriendList) do
        if friVo.id == vo.id then
            table.remove(self.mFriendList, k, vo)
            table.insert(self.mFriendList, k, vo)
        end
    end
end

-- 修改是否进行了好友申请的统一或者一键统一操作
function setIsOperation(self, isOperation)
    self.mIsOperation = isOperation
end
-- 修改是否进行了好友申请的统一或者一键统一操作
function getIsOperation(self)
    return self.mIsOperation
end
-- 修改是否第一次初始化
function setIsFristInit(self, isFristInit)
    self.mIsFristInit = isFristInit
end

-- 获取一个好友数据
function getFriendVo(self, cusId)
    for _i, friendVo in ipairs(self.mFriendList) do
        if friendVo.id == cusId then
            return friendVo
        end
    end
    return nil
end

function sortFriend(a, b)
    if a.onlineState > b.onlineState then return true end
    if a.onlineState < b.onlineState then return false end
    if a.lvl > b.lvl then return true end
    if a.lvl < b.lvl then return false end
    if a.id < b.id then return true end
    if a.id > b.id then return false end
end

-- 检测是否是好友
function checkIsFriend(self, id)
    for i, v in ipairs(self.mFriendList) do
        if id == v.id then
            return true
        end
    end
    return false
end

-- 检测是否已拉黑
function checkIsBackFriend(self, id)
    for i, v in ipairs(self.mBackList) do
        if id == v.id then
            return true
        end
    end
    return false
end

-- 设置当前显示好友ID
function setCurFriendId(self, id)
    self.mCurFirendId = id
end
-- 获取当前显示好友ID
function getCurFriendId(self)
    return self.mCurFirendId
end
-- 好友请求列表
function parseApplyListMsg(self, msg)
    for _, v in ipairs(self.mApplyList) do
        LuaPoolMgr:poolRecover(v)
    end
    self.mApplyList = {}
    for _, v in ipairs(msg.friend_apply_list) do
        local friendVo = LuaPoolMgr:poolGet(friend.FriendVo)
        friendVo:setData(v)
        table.insert(self.mApplyList, friendVo)
    end
    self:checkFlag()
    self:dispatchEvent(FRIEND_APPLY_UPDATE)
    GameDispatcher:dispatchEvent(EventName.UPDATE_FRIEND_APPLY_RED)
    note.NoteManager:dispatchEvent(note.NoteManager.FRIEND_INIT)
end
--玩家请求（只返回一条信息）
function parseApplyInfoMsg(self, msg)
    for _, v in ipairs(self.mApplyList) do
        LuaPoolMgr:poolRecover(v)
    end
    self.mApplyList = {}
    local friendVo = LuaPoolMgr:poolGet(friend.FriendVo)
    friendVo:setData(msg.friend_apply_info)
    table.insert(self.mApplyList, friendVo)
    self:checkFlag()
    self:dispatchEvent(FRIEND_APPLY_UPDATE)
    GameDispatcher:dispatchEvent(EventName.FRIEND_APPLY_LIST_REQ)
    GameDispatcher:dispatchEvent(EventName.UPDATE_FRIEND_APPLY_RED)
    note.NoteManager:dispatchEvent(note.NoteManager.FRIEND_UPDATE)
end

-- 解析备注返回信息
function parseFriendMarkMsg(self, msg)
    local friendVo = self:getFriendVo(msg.friend_id)
    if friendVo then
        friendVo.marks = msg.new_remarks
        self:dispatchEvent(FRIEND_REMARSK, friendVo)
        friend.FriendManager:dispatchEvent(friend.FriendManager.FRIEND_UPDATE)
    end
end

-- 获取好友请求列表
function getApplyList(self)
    table.sort(self.mApplyList, self.sortFriend)
    return self.mApplyList
end

-- 获取所有好友请求id列表
function getApplyIdList(self)
    local list = {}
    for _, friendVo in ipairs(self.mApplyList) do
        table.insert(list, friendVo.id)
    end
    return list
end

-- 黑名单列表
function parseBlackListMsg(self, msg)
    for _, v in ipairs(self.mBackList) do
        LuaPoolMgr:poolRecover(v)
    end
    self.mBackList = {}

    for _, v in ipairs(msg.black_list) do
        local friendVo = LuaPoolMgr:poolGet(friend.FriendVo)
        friendVo:setData(v)
        table.insert(self.mBackList, friendVo)
    end
    self:dispatchEvent(FRIEND_BLACK_UPDATE)
end

-- 获取黑名单列表
function getBlackList(self)
    table.sort(self.mBackList, self.sortFriend)
    return self.mBackList
end

-- 判断玩家是否一键删除
function getIsOneClick(self)
    return self.mIsOneClick
end
-- 修改玩家是否一键删除
function setIsOneClick(self, isOneClick)
    self.mIsOneClick = isOneClick
end

-- 判断玩家是否在黑名单
function checkInBlack(self, cusId)
    for _i, friendVo in ipairs(self.mBackList) do
        if friendVo.id == cusId then
            return true
        end
    end
    return false
end

-- 解析推荐列表
function parseRecommendMsg(self, msg)
    for _, v in ipairs(self.mRecommendList) do
        LuaPoolMgr:poolRecover(v)
    end
    self.mRecommendList = {}

    for _, v in ipairs(msg.recommend_list) do
        local friendVo = LuaPoolMgr:poolGet(friend.FriendVo)
        friendVo:setData(v)
        table.insert(self.mRecommendList, friendVo)
    end
    self:dispatchEvent(FRIEND_RECOMMEND_UPDATE)
end

-- 获取推荐列表
function getRecommendList(self)
    table.sort(self.mRecommendList, self.sortFriend)
    return self.mRecommendList
end

-- 查找数据
function parseQueryMsg(self, msg)
    for _, v in ipairs(self.mQueryList) do
        LuaPoolMgr:poolRecover(v)
    end
    self.mQueryList = {}

    for _, v in ipairs(msg.friend_query_info) do
        local friendVo = LuaPoolMgr:poolGet(friend.FriendVo)
        friendVo:setData(v)
        table.insert(self.mQueryList, friendVo)
    end
    self:dispatchEvent(FRIEND_QUERY_UPDATE)
end

-- 获取查找列表
function getQueryList(self)
    table.sort(self.mQueryList, self.sortFriend)
    return self.mQueryList
end

-- 发送私聊返回
function parseSendChatMsg(self, msg)
    local vo = friend.PrivateChatVo.new()
    vo:setData(msg.friend_id, msg, 1)

    self:addOneChatInfo(vo)
    self:dispatchEvent(PRIVATE_CHAT_ADD, msg.friend_id)
end

-- 收到好友信息
function parseReceiveChatMsg(self, msg)
    -- 没打开界面就收到好友信息，先请求聊天记录
    local list = self:getFriendChatData(msg.id)

    -- 新信息
    local friendVo = self:getFriendVo(msg.id)
    if friendVo then
        friendVo.newMessge = friendVo.newMessge + 1
    else
        -- -- 先屏蔽，因为查看之前，红点消除不了，本地最新的数据没有好友数据，数据同步会有问题，理应等后端检测并先发好友数据，再发聊天数据
        -- -- 如果最新的好友数据找不到对应，但是缓存里找得到，说明之前已经删除过，但是现在又是好友了，本地缓存的新消息数+1，便于对于缓存过已聊过天的即时显示下红点
        -- friendVo = self:getChatById(msg.id)
        -- if(friendVo)then
        --     friendVo.newMessge = friendVo.newMessge + 1
        -- end
        return
    end

    if list then
        local vo = friend.PrivateChatVo.new()
        vo:setData(msg.id, msg, 2)
        self:addOneChatInfo(vo)
    end
    self:checkFlag()
    self:dispatchEvent(PRIVATE_CHAT_ADD, msg.id)
end

-- 解析聊天记录
function onMsgPrivateChatLog(self, msg)
    if #msg.log_list <= 0 then
        -- 可能是清空聊天记录
        self.mChatData[msg.friend_id] = {}
    end
    if self.mChatData[msg.friend_id] then
        -- 聊天记录已存在，不做处理
        return
    end

    for i, v in ipairs(msg.log_list) do
        local sender = v.target_id == msg.friend_id and 1 or 2

        local vo = friend.PrivateChatVo.new()
        vo:setData(msg.friend_id, v, sender)

        self:addOneChatInfo(vo)
    end
    self:dispatchEvent(PRIVATE_CHAT_UPDATE, msg.friend_id)
end
-- 新增一条聊天记录
function addOneChatInfo(self, cusVo)
    if not self.mChatData[cusVo.friendId] then
        self.mChatData[cusVo.friendId] = {}
    end
    table.insert(self.mChatData[cusVo.friendId], cusVo)
end

-- 解析每日好友赠送数据
function parseFriendGiftInfoMsg(self, msg)
    self.mGiftMax = msg.gift_max
    self.mGiftCount = msg.gift_count
    self.can_gain_friend_id = msg.can_gain_friend_id

    for i, vo in ipairs(self.mFriendList) do
        if table.indexof(msg.can_gain_friend_id, vo.id) ~= false then
            vo.hasGift = msg.tid
        else
            vo.hasGift = 0
        end
    end
    self:checkFlag()
    self:dispatchEvent(FRIEND_UPDATE)
end
-- 好友赠礼每日最高领取次数
function getGiftMax(self)
    return self.mGiftMax
end
-- 好友赠礼已领取次数
function getGiftCount(self)
    return self.mGiftCount
end
-- 有礼物未领取的好友id列表
function getCanGainFriendList(self)
    return self.can_gain_friend_id
end

-- 取好友聊天记录
function getFriendChatData(self, cusId)
    local list = self.mChatData[cusId]
    if not list then
        GameDispatcher:dispatchEvent(EventName.REQ_PRIVATE_CHAT_LOG, cusId)
    else
        table.sort(list, function(a, b)
            return a.time < b.time
        end)
    end
    return list
end

-- 获取聊天有聊天记录的好友列表
function getChatList(self)
    if not self.mChatMemberList then
        self.mChatMemberList = {}
        for _, vo in ipairs(self:getFriendList()) do
            if vo.lastTalk ~= "" then
                table.insert(self.mChatMemberList, vo)
            end
        end
    end

    table.sort(self.mChatMemberList, function(a, b)
        local atime = a.lastCallTime > a.talkTime and a.lastCallTime or a.talkTime
        local btime = b.lastCallTime > b.talkTime and b.lastCallTime or b.talkTime

        return atime > btime
    end)

    return self.mChatMemberList
end

-- 获取聊天有聊天记录的好友
function getChatById(self, id)
    if self.mChatMemberList then
        for _, vo in ipairs(self.mChatMemberList) do
            if(vo.id == id)then
                return vo
            end
        end
    end
end

-- 更新一些必要的数据，确保缓存里的是最新的消息内容
function updateChatMemberList(self)
    if self.mChatMemberList then
        for i = 1, #self.mChatMemberList do
            local vo = self.mChatMemberList[i]
            if(vo)then
                local bestNewFirendVo = self:getFriendVo(vo.id)
                if(bestNewFirendVo)then
                    vo.lastTalk = bestNewFirendVo.lastTalk
                    vo.talkTime = bestNewFirendVo.talkTime
                    vo.lastTalkType = bestNewFirendVo.lastTalkType
                else
                    table.remove(self.mChatMemberList, i)
                end
            end
        end
    end
end

-- 检查一个聊天成员是否在列表，不在则将他加入列表，并返回他的位置
function checkChatMember(self, cusId)
    for i, v in ipairs(self:getChatList()) do
        if v.id == cusId then
            return i
        end
    end

    local vo = self:getFriendVo(cusId)
    if vo then
        table.insert(self.mChatMemberList, 1, vo)
        return 1
    end

    return 0 -- 不是好友
end

-- 删除一个聊天对象
function delChatMember(self, cusId)
    if self.mChatMemberList then
        for i, vo in ipairs(self.mChatMemberList) do
            if vo.id == cusId then
                table.remove(self.mChatMemberList, i)
            end
        end
    end
end

-- 清除新消息数
function clearNewMessgeCount(self, cusId)
    local friendVo = self:getFriendVo(cusId)
    if friendVo then
        friendVo.newMessge = 0
        self:checkFlag()
    end
end

function checkFlag(self)
    local isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FRIEND)
    if not isOpen then
        return false
    end
    local isFlag = false
    local applyList = friend.FriendManager:getApplyList()
    if #applyList > 0 then
        isFlag = true
    else
        local friendList = friend.FriendManager:getFriendList()
        for i, vo in ipairs(friendList) do
            if vo.newMessge > 0 or vo.hasGift > 0 then
                isFlag = true
                break;
            end
        end
    end

    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_FRIEND, isFlag)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]