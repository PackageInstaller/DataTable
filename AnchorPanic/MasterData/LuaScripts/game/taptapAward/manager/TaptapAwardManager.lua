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
    --return true
    local isTapTap = sdk.SdkManager:getIsTaptapActivity()
    local clientTime = GameManager:getClientTime()
    local prefixVersion =
        download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.PrefixVersionKey)
    local isNoshow = StorageUtil:getBool1(prefixVersion .. "taptapNotShow") == true 
    local endTime = sysParam.SysParamManager:getValue(SysParamType.TAPTAP_ENDTIME)
    --local isNotRemind = remind.RemindManager:isTodayNotRemain(RemindConst.TAPTAP_AWARD)
    return clientTime < endTime and not isNoshow and isTapTap
end


return _M