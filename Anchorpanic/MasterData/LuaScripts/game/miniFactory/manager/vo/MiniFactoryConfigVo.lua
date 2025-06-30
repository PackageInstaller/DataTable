--[[ 
-----------------------------------------------------
@filename       : MiniFacVo
@Description    : 迷你工厂数据解析
@date           : 2022-2-28 
@Author         : lyx
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("miniFac.MiniFactoryConfigVo", Class.impl())

function parseData(self, cusData)
    -- 类型
    self.type = cusData.fact_type
    -- 功能id
    self.funcId = cusData.func_id
    -- 对应语言包id(正常)
    self.showName = cusData.fact_lang
    --对应语言包id(开头大写)
    self.showTipsName = cusData.fact_tips_lang
    -- 显示的文本
    self.funcLimit = cusData.func_lang
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
