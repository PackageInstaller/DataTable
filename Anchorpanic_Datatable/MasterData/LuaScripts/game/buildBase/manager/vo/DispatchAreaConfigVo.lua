--派遣坞每个区域Vo
module("buildBase.DispatchAreaConfigVo", Class.impl())

function parseConfigData(self, id, need_level)
    -- 区域id
    self.exploreId = id
    -- 解锁等级
    self.unlockLevel = need_level
end

return _M