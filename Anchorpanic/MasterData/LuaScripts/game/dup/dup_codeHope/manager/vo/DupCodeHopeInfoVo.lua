--[[ 
-----------------------------------------------------
@filename       : DupCodeHopeInfoVo
@Description    : 代号希望副本服务器数据
@date           : 2021-07-14 16:56:52
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_codeHope.manager.vo.DupCodeHopeInfoVo', Class.impl())

function parseMsg(self, cusMsg)
    -- 城池id
    self.dupId = cusMsg.city_id
    -- 本轮通关时间
    self.roundPassTime = cusMsg.round_pass_time
    -- 首通标识0-从未通过1-之前通过过
    self.firstPassFlag = cusMsg.first_pass_flag
    -- 历史最短通关时间
    self.histroyPassTime = cusMsg.history_pass_time
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
