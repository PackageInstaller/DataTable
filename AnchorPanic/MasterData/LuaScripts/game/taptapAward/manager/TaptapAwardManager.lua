module("taptapAward.TaptapAwardManager", Class.impl(Manager))

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__initData()

end


function __initData(self)
end

-- 析构函数
function dtor(self)
end

function canOpenTaptapAwardPanel(self)
    local isTapTap = sdk.SdkManager:getIsTaptapActivity()
    local clientTime = GameManager:getClientTime()
    local isNotRemind = remind.RemindManager:isTodayNotRemain(RemindConst.TAPTAP_AWARD)
    return clientTime < 1721682000 and not isNotRemind and isTapTap
end


return _M