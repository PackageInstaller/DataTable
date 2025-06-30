-- 战员信息
module("rogueLike.RogueLikeTaskScoreVo", Class.impl())

function parseData(self, id, cusData)
    self.id = id
    -- 任务类型
    self.score = cusData.target_score
    -- 完成次数
    self.scoreReward = cusData.score_reward
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
