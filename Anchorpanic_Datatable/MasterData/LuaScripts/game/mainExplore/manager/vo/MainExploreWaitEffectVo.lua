--[[ 
-----------------------------------------------------
@filename       : MainExploreWaitEffectVo
@Description    : 返回地图后待效果表现的数据vo
@date           : 2021-08-07 14:16:01
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('mainExplore.MainExploreWaitEffectVo', Class.impl())

function setData(self, cusData)
    self.eventId = cusData.event_id
    self.paramList = cusData.args_int
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
