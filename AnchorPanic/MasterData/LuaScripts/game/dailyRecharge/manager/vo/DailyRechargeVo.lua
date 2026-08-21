--[[ 
-----------------------------------------------------
@filename       : DailyRechargeVo
@Description    : 每日充值数据
@date           : 2026-06-01
@Author         : sxt
@copyright      : (LY) 雷焰网络
-----------------------------------------------------
]]
module("dailyRecharge.DailyRechargeVo", Class.impl())

function parseData(self, id, data)
    self.id = id
    -- 达标充值金额，配置表以分为单位
    self.leftNum = data.left_num
    -- 左侧售卖礼包对应的直购礼包 id
    self.sellGiftId = data.sell_gift_id
    -- 每日累充奖励配置
    self.payReward = data.pay_reward
end

-- 获取指定天数的奖励列表
function getPayRewardByDay(self, day)
    if not self.payReward or not self.payReward[day] then
        return {}
    end
    return self.payReward[day].rewards or {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
