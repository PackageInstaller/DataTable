--[[ 
-----------------------------------------------------
@filename       : DupApostlesStarVo
@Description    : 使徒之战星级奖励
@date           : 2022-06-13 10:28:47
@Author         : lyx
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_apostles_war.manager.vo.DupApostlesStarVo', Class.impl())

-- 解析数据
function parseData(self, cusId, cusData)
    self.id = cusId
    self.type = cusData.type
    self.subType = cusData.subtype
    self.des = cusData.des
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
