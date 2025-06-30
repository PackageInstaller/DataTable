module("recruit.RecruitReslutVo", Class.impl())

function ctor(self)
end

function parseMsgData(self, cusData)
    -- 英雄tid
    self.heroTid = cusData.tid
    -- 转换的道具列表（战员转化为碎片）
    self.propsList = {}
    for i = 1, #cusData.item_list do
        local propsVo = props.PropsVo.new()
        propsVo:setPropsAwardMsgData(cusData.item_list[i])
        table.insert(self.propsList, propsVo)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
