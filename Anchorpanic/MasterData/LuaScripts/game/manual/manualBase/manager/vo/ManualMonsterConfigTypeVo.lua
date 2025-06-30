--[[ 
-----------------------------------------------------
@filename       : ManualMonsterConfigTypeVo
@Description    : 图鉴怪物页签类型配置数据解析
@date           : 2022-4-20 17:43:00
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualMonsterConfigTypeVo", Class.impl())

function parseData(self, cusData)
    self.type = cusData.type
    self.lang = cusData.lang
end
return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
