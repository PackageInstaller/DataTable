--[[ 
-----------------------------------------------------
@filename       : RankRewardVo
@Description    : 排行奖励配置数据
@date           : 2021-08-17 14:46:25
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.rank.manager.vo.RankRewardVo', Class.impl())

function parseData(self, key, cusData)
    self.id = key
    self.leftRank = cusData.left_rank
    self.rightRank = cusData.right_rank
    self.rewards = cusData.rewards
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
