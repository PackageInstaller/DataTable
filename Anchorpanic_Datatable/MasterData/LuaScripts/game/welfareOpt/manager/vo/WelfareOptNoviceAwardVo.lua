--[[ 
-----------------------------------------------------
@filename       : WelfareOptNoviceAwardVo
@Description    : 新手训练营奖励
@Author         : lyx
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("WelfareOptNoviceAwardVo",Class.impl())

function parseNoviceAwardData(self, cusData)
    --{奖励道具id，奖励道具数量}
    self.mStepReward = cusData.step_reward     
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
