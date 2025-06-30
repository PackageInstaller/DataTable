module("WelfareOptGoldWishingServerVo",Class.impl())


function parseGoldWishingServerData(self,cusData)
    --今日已经祈愿次数
    self.hadWishTimes = cusData.had_wish_times
    --累计祈愿次数
    self.accWishTimes = cusData.acc_wish_times
    --0-未开始1-祈愿中2-已完成未领取
    self.state = cusData.state
    --祈愿完成的目标时间戳
    self.wishEndTime = cusData.wish_end_time
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
