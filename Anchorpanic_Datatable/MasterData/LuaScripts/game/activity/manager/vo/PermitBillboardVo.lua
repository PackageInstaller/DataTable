module("activity.PermitBillboardVo", Class.impl())

function parseConfigData(self, key, cusData)
    self.id = key
    self.illustration = cusData.illustration
    self.funcOpenId = cusData.func_open_id
    self.uicode = cusData.uicode
    self.activityId = cusData.activity_id

    self.isOpen = true
end

function isOpenTime(self)
    return activity.ActivityManager:checkIsOpenById(self.activityId)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]