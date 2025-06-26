--[[ 
-----------------------------------------------------
@filename       : DupApostlesTaskVo
@Description    : 使徒之战任务奖励列表
@date           : 2022-06-13 10:28:47
@Author         : lyx
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_apostles_war.manager.vo.DupApostlesTaskVo', Class.impl())

-- 解析数据
function parseData(self, cusId, cusData)
    self.id = cusId
    self.star = cusData.star
    self.rewards = cusData.rewards
    self.des = cusData.des
    self.title = cusData.title
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
