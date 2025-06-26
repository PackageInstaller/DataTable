--[[ 
-----------------------------------------------------
@filename       : DupApostlesWarGoalVo
@Description    : 使徒之战目标奖励
@date           : 2021-08-13 10:28:47
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_apostles_war.manager.vo.DupApostlesWarGoalVo', Class.impl())

-- 解析数据
function parseData(self, cusId, cusData)
    self.id = cusId
    self.param = cusData.param
    self.langId = cusData.language

    self.rewards = AwardPackManager:getAwardListById(cusData.drop)

    self.state = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
