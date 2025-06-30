--[[    好友vo
]]
module('friend.FriendVo', Class.impl())

function onRecover(self)
    self:initData()
end

function ctor(self)
    self:initData()
end

function initData(self)
    -- 玩家id
    self.id = ""
    -- 玩家展示id
    self.showId = ""
    -- 玩家名
    self.name = ''
    -- 性别
    self.job = ''
    -- 玩家等级
    self.lvl = 0
    -- vip等级
    self.vipLv = 0
    -- 服务器
    self.server = 0
    -- 战斗力
    self.fight = 0
    -- 玩家头像id
    self.playerAvatarId = 0
    -- 玩家在线状态
    self.onlineState = 0
    -- 离线时间
    self.offlineTime = 0
    -- 最后一条聊天记录
    self.lastTalk = ""
    -- 最后一条聊天记录时间戳
    self.talkTime = 0
    -- 共同好友数
    self.sameFriend = 0
    -- 玩家签名
    self.signature = ""
    -- 头像框
    self.frameId = 0
    -- 称号
    self.designation = 0
    -- 好友备注
    self.marks = ""
    -- 最新唤起时间（好友点进去）
    self.lastCallTime = 0
    ---------------------- 客户端用 -------------------
    -- 新信息数
    self.newMessge = 0
    -- 是否有奖励未领取
    self.hasGift = 0
end

function setData(self, cusMsg)
    self.id = cusMsg.id
    self.showId = cusMsg.show_id
    self.name = cusMsg.name
    self.lvl = cusMsg.lvl
    self.playerAvatarId = cusMsg.avatar_id
    self.onlineState = cusMsg.is_online
    self.offlineTime = cusMsg.offline_time
    self.lastTalk = cusMsg.last_chat_info
    self.talkTime = cusMsg.last_chat_time
    self.lastTalkType = cusMsg.last_chat_type
    self.sameFriend = cusMsg.common_friend_num
    self.signature = cusMsg.player_signature
    self.frameId = cusMsg.avatar_frame
    self.designation = cusMsg.designation
    self.marks = cusMsg.remarks_name
end

function getOfflineTime(self)
    return TimeUtil.getTimeDescToDate(self.offlineTime)
end

-- 获取好友备注，没有则返回名字
function getMarks(self)
    if self.marks == "" then
        return self.name
    end
    return self.marks
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]