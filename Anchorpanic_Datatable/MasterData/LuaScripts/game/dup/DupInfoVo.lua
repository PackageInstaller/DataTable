--[[    
    副本数据
    @author Jacob
]]
module("dup.DupInfoVo", Class.impl())

function parseData(self, pt_dup_info)
    -- 副本类型
    self.type = pt_dup_info.type
    -- 当前副本id 0表示全通关
    self.curId = pt_dup_info.curl_dup
    -- 最高通关副本id
    self.maxId = pt_dup_info.max_dup
    -- 剩余通关次数
    self.passTimes = pt_dup_info.pass_times
    -- 已购买次数
    self.buyTimes = pt_dup_info.buy_times
    -- 通关副本列表信息（需要才会有）
    self.pass_dup = pt_dup_info.pass_dup
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
