--[[ 
-----------------------------------------------------
@filename       : DupApostlesBossDiffiVo
@Description    : 使徒之战服务器发来的boss难度数据
@date           : 2022-06-13 10:28:47
@Author         : lyx
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_apostles_war.manager.vo.DupApostlesBossDiffiVo', Class.impl())

-- 解析数据
function parseData(self, cusData)
    self.id = cusData.dup_id
    self.completedTarget = cusData.completed_target
    self.isUnlock = cusData.is_unlock
    -- print(self.id, self.isUnlock, " =============3")
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
