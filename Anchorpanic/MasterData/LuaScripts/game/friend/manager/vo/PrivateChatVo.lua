--[[
-----------------------------------------------------
@filename       : PrivateChatVo
@Description    : 好友私聊数据
@date           : 2020-08-14 16:05:44
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('friend.PrivateChatVo', Class.impl())

function ctor(self)
    -- 好友id
    self.friendId = nil
    -- 聊天内容
    self.content = nil
    -- 聊天发送时间
    self.time = nil
    -- 发送方 1-本人 2-好友
    self.sender = nil
    -- 赠送礼物tid 0-无礼物
    self.tid = nil
    -- 礼物赠送状态 1-赠送 2-领取
    self.state = nil
end

function setData(self, cusId, cusMsg, sender)
    -- 好友id
    self.friendId = cusId
    -- 聊天内容
    self.content = cusMsg.content
    -- 聊天发送时间
    self.time = cusMsg.time
    -- 赠送礼物tid 0-无礼物
    self.tid = cusMsg.tid
    -- 礼物赠送状态 1-赠送 2-领取
    self.state = cusMsg.state
    -- 发送方 1-本人 2-好友
    self.sender = sender
    -- 聊天内容类型
    self.contentType = cusMsg.content_type
    --聊天气泡id
    self.chatBubbleId = cusMsg.dialog_box_id
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
