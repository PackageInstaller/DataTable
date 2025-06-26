module("chat.ChatManager", Class.impl(Manager))

------------------------------------------------------------
--构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__initData()
end

function __initData(self)
    self.m_chatConfigDic = nil
    self.m_emojiConfigDic = nil

    -- 频道聊天信息字典
    self.m_channelChatDic = {}
    -- 聊天玩家信息字典
    self.m_playerInfoDic = {}

    -- 频道对应的房间号字典
    self.m_channelRoomDic = {}
    -- 频道对应的可以选择的房间号列表
    self.m_channelRoomListDic = {}
    -- 当前房间号的在线人数
    self.roomPeople = 0

    -- 聊天的cd管理器
    self.m_cdDic = {}
    -- 后端维护聊天的刷屏禁言cd管理器
    self.m_forbidDic = {}
    -- 前端维护聊天的刷屏禁言cd管理器
    self.m_countCdDic = {}
end

function getSn(self)
    if (not self.mChatSn) then
        self.mChatSn = 0
    end
    self.mChatSn = self.mChatSn + 1
    return self.mChatSn
end

function disposeSn(self)
    self.mChatSn = nil
    if (self.m_channelChatDic) then
        for index, chatList in pairs(self.m_channelChatDic) do
            for i = 1, #chatList do
                chatList[i]:disposeSn()
                chatList[i]:initSn()
            end
        end
    end
end

----------------------------------------------------------------------------配置相关--------------------------------------------------------------------------------------
-- 解析聊天配置表
function praseChatConfig(self)
    self.m_chatConfigDic = {}
    local baseData = RefMgr:getData("chat_data")
    for channel, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(chat.ChatConfigVo)
        vo:parseData(channel, data)
        self.m_chatConfigDic[vo.channel] = vo
    end

end

-- 获取表情字典
function getChatConfig(self, channel)
    if (not self.m_chatConfigDic) then
        self:praseChatConfig()
    end
    return self.m_chatConfigDic[channel]
end

-- 解析表情配置表
function praseEmojiConfig(self)
    self.m_emojiConfigDic = {}
    local baseData = RefMgr:getData("emoji_data")
    for id, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(chat.EmojiRo)
        ro:parseData(id, data)
        if (not self.m_emojiConfigDic[ro:getType()]) then
            self.m_emojiConfigDic[ro:getType()] = {}
        end
        if (not self.m_emojiConfigDic[ro:getType()][ro:getSubType()]) then
            self.m_emojiConfigDic[ro:getType()][ro:getSubType()] = {}
        end
        table.insert(self.m_emojiConfigDic[ro:getType()][ro:getSubType()], ro)
    end

    for type, list in pairs(self.m_emojiConfigDic) do
        for _, subList in pairs(list) do
            table.sort(subList, self.sortEmojiList)
        end
    end
end

function sortEmojiList(emojiData_1, emojiData_2)
    if (emojiData_1:getRefID() ~= emojiData_2:getRefID()) then
        return emojiData_1:getRefID() < emojiData_2:getRefID()
    end
    return false
end

-- 获取表情字典
function getEmojiConfigDic(self)
    if (not self.m_emojiConfigDic) then
        self:praseEmojiConfig()
    end

    -- 只获取已解锁表情包
    local dic = {}
    for type, list in pairs(self.m_emojiConfigDic) do
        for subType, subList in pairs(list) do
            for i, ro in ipairs(subList) do
                if table.indexof(self.mEmojiUnLockList, ro:getRefID()) ~= false then
                    if (not dic[ro:getType()]) then
                        dic[ro:getType()] = {}
                    end
                    if (not dic[ro:getType()][ro:getSubType()]) then
                        dic[ro:getType()][ro:getSubType()] = {}
                    end
                    table.insert(dic[ro:getType()][ro:getSubType()], ro)
                end
            end
        end
    end

    return dic
end

-- 获取表情字典
function getEmojiConfigList(self, type, subType)
    local dic = self:getEmojiConfigDic()
    return dic[type][subType]
end

----------------------------------------------------------------------------聊天cd管理--------------------------------------------------------------------------------------
-- 设置cd时间
function setCdEndTime(self, channel)
    local cdTime = chat.ChatManager:getChatConfig(channel).chatInterval
    local endTime = GameManager:getClientTime() + cdTime
    self.m_cdDic[channel] = endTime
end
-- 获取剩余cd时间
function getCdRemainTime(self, channel)
    if (self.m_cdDic[channel]) then
        return self.m_cdDic[channel] - GameManager:getClientTime()
    else
        return 0
    end
end

-- 后端设置禁言cd时间
function setForbidTime(self, channel, forbidTime)
    self.m_forbidDic[channel] = forbidTime
    GameDispatcher:dispatchEvent(EventName.UPDATE_CHAT_FORBID)
end
function getForbidTime(self, channel)
    return self.m_forbidDic[channel]
end

----------------------------------------------------------------------------服务器响应--------------------------------------------------------------------------------------
-- 更新聊天频道房间号
function updatePanelMsg(self, cusMsg)
    self.m_channelRoomDic[cusMsg.channel] = cusMsg.room_now
    self.m_channelRoomListDic[cusMsg.channel] = cusMsg.room_list
    self.roomPeople = cusMsg.people_count
    GameDispatcher:dispatchEvent(EventName.UPDATE_CHAT_PANEL_DATA, { channel = cusMsg.channel })
end

-- 返回聊天信息
function addChatMsg(self, cusChatMsg)
    if (not chat.isTypeLegal(cusChatMsg.content_type)) then
        return
    end

    local chatVo = LuaPoolMgr:poolGet(chat.ChatVo)
    chatVo:parseMsgData(cusChatMsg)

    -- 过滤黑名单消息
    local isBlack = friend.FriendManager:checkInBlack(chatVo.sendId)
    if isBlack then
        return
    end

    local index = self:__getChatIndex(chatVo.channel, chatVo.room)
    if (not self.m_channelChatDic[index]) then
        self.m_channelChatDic[index] = {}
    end
    table.insert(self.m_channelChatDic[index], chatVo)

    local delCount = #self.m_channelChatDic[index] - self:getChatConfig(chatVo.channel).maxShowCount
    if (delCount > 0) then
        for i = 1, delCount do
            local delChatVo = table.remove(self.m_channelChatDic[index], 1)
            LuaPoolMgr:poolRecover(delChatVo)
        end
    end
    GameDispatcher:dispatchEvent(EventName.CHAT_MSG_UPDATE, { chatVo = chatVo })
end

-- 返回修改频道房间结果
function changeChatRoomMsg(self, cusMsg)
    if (cusMsg.result == 1) then
        self.m_channelRoomDic[cusMsg.channel] = cusMsg.room
        self.roomPeople = cusMsg.people_count
    elseif (cusMsg.result == 2) then
        gs.Message.Show(_TT(59)) --"频道已满"
    else
        gs.Message.Show(_TT(509)) --"请输入正确房间号"
        logError("修改频道房间失败，错误码：" .. cusMsg.result)
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_CHANGE_ROOM_RESULT, { channel = cusMsg.channel, isSuccess = cusMsg.result == 1 })
end

-- 获取表情列表
function onResGetEmojiListMsg(self, msg)
    self.mEmojiUnLockList = {}
    for i, pt_emoji_info in ipairs(msg.emoji_list) do
        table.insert(self.mEmojiUnLockList, pt_emoji_info.emoji_id)
    end
end

-- 添加公告途径的聊天消息
function addChatByNotice(self, cusChannel, cusContent)
    local chatVo = LuaPoolMgr:poolGet(chat.ChatVo)
    chatVo.channel = chat.ChannelType.SYSTEM
    chatVo.content = cusContent
    chatVo.sendName = _TT(14)

    local index = self:__getChatIndex(chatVo.channel, chatVo.room)
    if (not self.m_channelChatDic[index]) then
        self.m_channelChatDic[index] = {}
    end
    table.insert(self.m_channelChatDic[index], chatVo)

    local delCount = #self.m_channelChatDic[index] - self:getChatConfig(chatVo.channel).maxShowCount
    if (delCount > 0) then
        for i = 1, delCount do
            local delChatVo = table.remove(self.m_channelChatDic[index], 1)
            LuaPoolMgr:poolRecover(delChatVo)
        end
    end

    GameDispatcher:dispatchEvent(EventName.CHAT_MSG_UPDATE, { chatVo = chatVo })
end

-- 列表排序（目前不需要排序）
function __sortChatList(chatVo_1, chatVo_2)
    if (chatVo_1 and chatVo_2) then
        -- 时间戳从小到大
        if (chatVo_1.sendTime > chatVo_2.sendTime) then
            return false
        end
        if (chatVo_1.sendTime < chatVo_2.sendTime) then
            return true
        end
    end
    return false
end

----------------------------------------------------------------------------获取服务器存储数据--------------------------------------------------------------------------------------

-- 根据频道和房间号获取聊天存储的唯一索引
function __getChatIndex(self, channel, room)
    local channelStr = tostring(channel)
    local roomStr = tostring(room)
    return channelStr .. "_" .. roomStr
end

-- 根据聊天频道获取房间号
function getChannelRoom(self, channel)
    if channel == chat.ChannelType.GUILD then
        return 0
    end
    if (self.m_channelRoomDic and self.m_channelRoomDic[channel]) then
        return self.m_channelRoomDic[channel]
    end
    return self:getChannelRoomList(channel)[1]
end

-- 根据聊天频道获取可以选择的房间号列表
function getChannelRoomList(self, channel)
    if (self.m_channelRoomListDic and self.m_channelRoomListDic[channel]) then
        return self.m_channelRoomListDic[channel]
    end
    return {}
end

-- 根据聊天频道获取聊天消息列表
function getChatListByChannel(self, cusChannel)
    local chatList = {}
    local room = self:getChannelRoom(cusChannel)
    local index = self:__getChatIndex(cusChannel, room)
    if (self.m_channelChatDic and self.m_channelChatDic[index]) then
        chatList = self.m_channelChatDic[index]
    end
    return chatList
end

function getNewChatVo()

end

-- 获取最近的一条聊天消息
function getNewMsg(self)
    local chatList = self:getChatListByChannel(chat.ChannelType.WORLD)
    local worldChatVo = chatList[#chatList]
    local chatList = self:getChatListByChannel(chat.ChannelType.GUILD)
    local guildChatVo = chatList[#chatList]
    if guildChatVo and worldChatVo and guildChatVo.sendTime > worldChatVo.sendTime then
        return guildChatVo
    end
    if guildChatVo and not worldChatVo then
        return guildChatVo
    end
    return worldChatVo
end

--析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(14):	"系统"
]]