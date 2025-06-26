--[[ 
-----------------------------------------------------
@filename       : WelfareOptNoviceMissionVo
@Description    : 新手训练营任务
@Author         : lyx
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("WelfareOptNoviceMissionVo",Class.impl())

function parseNoviceMissionData(self, cusData)
    self.id = cusData.id
    self.count = cusData.count
    self.state = cusData.state
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
