--[[ 
-----------------------------------------------------
@filename       : RankBaseVo
@Description    : 排行榜解析数据
@date           : 2021-08-17 11:11:52
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.rank.manager.vo.RankBaseVo', Class.impl())

function parseMsg(self, cusMsg, type)
    -- 排名
    self.rank = cusMsg.rank
    -- 玩家id
    self.playerId = cusMsg.player_id
    -- 玩家名称
    self.playerName = cusMsg.player_name
    -- 头像
    self.avatar = cusMsg.avatar_id
    -- 头像框
    self.frame = cusMsg.avatar_frame
    -- 称号
    self.titleId = cusMsg.designation
    -- 排行值
    self.rankVal = cusMsg.rank_val
    -- 排行类型
    self.rankType = type
    -- 联盟名
    self.guildName = cusMsg.guild_name
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
