--[[ 
-----------------------------------------------------
@filename       : InfiniteCityRankVo
@Description    : 无限城无限榜数据
@date           : 2021-03-09 11:31:59
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.infiniteCity.manager.vo.InfiniteCityRankVo', Class.impl())


function parseMsg(self, cusMsg)
    self.rank = cusMsg.rank
    self.playerId = cusMsg.player_id
    self.name = cusMsg.player_name
    self.designation = cusMsg.designation
    self.score = cusMsg.score
    self.avatar = cusMsg.avatar_id
    self.frame = cusMsg.avatar_frame
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
