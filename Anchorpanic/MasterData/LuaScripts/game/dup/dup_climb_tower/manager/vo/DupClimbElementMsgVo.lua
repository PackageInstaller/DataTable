module('dup.DupClimbElementMsgVo', Class.impl())
--[[ 
    爬塔副本区域数据
]]
function ctor(self)
end

-- 解析数据
function parseData(self, cusData)
    -- 副本id
    self.id = cusData.id
    -- 当前副本id 0表示全通关
    self.curDup = cusData.cur_dup
    --最大关卡
    self.maxDup = cusData.max_dup
    -- 已挑战次数
    self.times = cusData.times
end

function getName(self)
    return _TT(self.name)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
