--[[ 
-----------------------------------------------------
@filename       : DupImpliedDifficultyVo
@Description    : 默示之境副本数据
@date           : 2021-07-05 19:59:04
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_implied.manager.vo.DupImpliedDifficultyVo', Class.impl())

-- 解析数据
function parseData(self, cusId, cusData)
    self.diffId = cusId
    self.level = cusData.level
    self.desc = ""
    self.showDrop = AwardPackManager:getAwardListById(cusData.show_reward)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
