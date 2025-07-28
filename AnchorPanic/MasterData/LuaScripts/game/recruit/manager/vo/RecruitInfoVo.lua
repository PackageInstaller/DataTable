--[[ 
-----------------------------------------------------
@filename       : RecruitInfoVo
@Description    : 招募数据
@date           : 2021-09-26 10:09:02
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('recruit.RecruitInfoVo', Class.impl())

function parseMsg(self, cusMsg)
    -- 类型
    self.type = cusMsg.type
    -- 今日招募已抽次数
    self.recruit_daily_times = cusMsg.recruit_daily_times
    -- 活动期间累计招募已抽次数
    self.recruit_activity_times = cusMsg.recruit_activity_times
    -- 保底已抽次数
    self.guaranteed_times = cusMsg.guaranteed_times
    -- 保底最大次数
    self.guaranteed_limit = cusMsg.guaranteed_limit
    -- 大保底奖励是否已领取 1是0否
    self.is_guaranteed_award = cusMsg.is_guaranteed_award
    --已免费次数
    self.free_times = cusMsg.free_times
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
