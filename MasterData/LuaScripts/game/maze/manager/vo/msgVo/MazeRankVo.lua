module('maze.MazeRankVo', Class.impl())

function parseMsg(self, cusMsg)
    self.rank = cusMsg.rank
    self.playerId = cusMsg.player_id
    self.playerName = cusMsg.player_name
    -- 头像
    self.avatarId = cusMsg.avatar_id
    -- 头像框
    self.avatarFrame = cusMsg.avatar_frame
    -- 称号
    self.designation = cusMsg.designation
    -- 通关最短时间
    self.passTime = cusMsg.pass_cost_time
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
