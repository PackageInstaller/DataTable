--[[ 
-----------------------------------------------------
@filename       : DupCodeHopeRewardVo
@Description    : 代号希望奖励配置
@date           : 2021-07-14 20:03:23
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_codeHope.manager.vo.DupCodeHopeRewardVo', Class.impl())

function parseData(self, key, cusData)
    self.id = key
    self.leftRank = cusData.left_rank
    self.rightRank = cusData.right_rank
    self.rewards = cusData.rewards
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
