module("activity.BillboardConfigVo", Class.impl())

function parseConfigData(self, key, cusData)
    self.id = key
    self.illustration = cusData.illustration
    self.funcOpenId = cusData.func_open_id
    self.uicode = cusData.uicode
    self.beginTime = cusData.begin_time
    self.endTime = cusData.end_time
    self.codeParam = cusData.code_param

    self.isOpen = true
end

function isOpenTime(self)
    if not self.beginTime or #self.beginTime == 0 then
        return true
    end
    local clientTime = GameManager:getClientTime()
    if clientTime >= TimeUtil.transTime(self.beginTime) and clientTime < TimeUtil.transTime(self.endTime) then
        return true
    end
    return false
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
