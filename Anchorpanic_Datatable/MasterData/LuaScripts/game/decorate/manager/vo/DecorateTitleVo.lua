module("decorate.DecorateTitleVo", Class.impl())

function praseMsgData(self, cusData)
    -- 称号id
    self.id = cusData.designation_id
    -- 过期时间
    self.expiredTime = cusData.expired_time
    -- 是否喜欢
    self.isLike = cusData.is_like == 1
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
