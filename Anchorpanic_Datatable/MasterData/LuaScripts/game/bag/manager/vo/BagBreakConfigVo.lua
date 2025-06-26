--[[ 
-----------------------------------------------------
@filename       : BagBreakConfigVo
@Description    : 分解出售基础配置
@date           : 2020-11-17 20:13:44
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.bag.manager.vo.BagBreakConfigVo', Class.impl())

function parseData(self, key, cusData)
    -- 道具模型tid
    self.tid = key
    -- 类型1-出售 2-分解
    self.type = cusData.type
    -- 返回道具列表
    self.propsList = {}
    for i, v in ipairs(cusData.prop_list) do
        local propsVo = props.PropsManager:getPropsVo({ tid = v[1], num = v[2] })
        table.insert(self.propsList, propsVo)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
