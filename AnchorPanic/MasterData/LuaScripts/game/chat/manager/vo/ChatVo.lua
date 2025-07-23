module("chat.ChatVo", Class.impl())

function onAwake(self)
end

function onRecover(self)
end

function getSn(self)
    return self.m_sn
end

function initSn(self)
    -- self.m_sn = SnMgr:getSn()
    self.m_sn = chat.ChatManager:getSn()
end

function disposeSn(self)
    -- SnMgr:disposeSn(self.m_sn)
    self.m_sn = nil
end

-- 解析消息
function parseMsgData(self, cusChatVo)
    self:initSn()
    -- 聊天频道
    self.channel = cusChatVo.channel
    -- 聊天频道房间号
    self.room = cusChatVo.room
    -- 消息内容类型
    self.contentType = cusChatVo.content_type
    -- 消息内容
    self.content = cusChatVo.content
    -- 发送人id
    self.sendId = cusChatVo.sender_id
    -- 发送人名称
    self.m_name = cusChatVo.sender_name
    -- 发送人头像
    self.m_avatar = cusChatVo.sender_avatar
    -- 头像框
    self.m_frame = cusChatVo.sender_frame
    -- 发送人称号id
    self.m_titleId = cusChatVo.sender_title_id
    -- 发送时间戳
    self.sendTime = cusChatVo.time
    --发送者的气泡
    self.chatBubbleId = cusChatVo.dialog_box_id
end

function getSendName(self)
    if(self:isOwn())then
        return role.RoleManager:getRoleVo():getPlayerName()
    else
        return self.m_name
    end
end

function getSendHead(self)
    if(self:isOwn())then
        return role.RoleManager:getRoleVo():getAvatarId()
    else
        return self.m_avatar
    end
end

function getSendHeadFrame(self)
    if(self:isOwn())then
        return role.RoleManager:getRoleVo():getAvatarFrameId()
    else
        return self.m_frame
    end
end

function getSendTitle(self)
    if(self:isOwn())then
        return role.RoleManager:getRoleVo():getTitleId()
    else
        return self.m_titleId
    end
end

function clone(self)
    local temVo = chat.ChatVo.new()
    temVo.channel = self.channel
    temVo.room = self.room
    temVo.content = self.content
    temVo.sendId = self.sendId
    temVo.m_name = self.m_name
    temVo.m_avatar = self.m_avatar
    temVo.m_frame = self.m_frame
    temVo.m_titleId = self.m_titleId
    temVo.sendTime = self.sendTime
    return temVo
end

-- 是否为自己发送的消息
function isOwn(self)
    return role.RoleManager:getRoleVo().playerId == self.sendId
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
