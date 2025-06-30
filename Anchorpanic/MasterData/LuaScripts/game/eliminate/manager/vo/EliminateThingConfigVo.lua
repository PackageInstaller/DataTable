--[[ 
-----------------------------------------------------
@filename       : EliminateThingConfigVo
@Description    : 消消乐物件配置数据
@date           : 2022-3-2 
@Author         : zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("eliminate.EliminateThingConfigVo", Class.impl())

function setData(self, type, cusData)
    self.type = type
    self.icon = cusData.icon
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
