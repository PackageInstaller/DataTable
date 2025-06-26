--[[ 
-----------------------------------------------------
@filename       : InfiniteCityTargetVo
@Description    : 无限城目标奖励数据
@date           : 2021-03-10 11:08:19
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.infiniteCity.manager.vo.InfiniteCityTargetVo', Class.impl())

function ctor(self)

    -- 当前值
    self.countNow = nil
    -- 状态0-未完成1-已完成未领取2-已领取
    self.state = nil
end

function parseData(self, cusId, cusData)
    self.id = cusId
    self.taskType = cusData.task_type
    self.type = cusData.type
    self.args = cusData.args
    self.star = cusData.star
    self.des = cusData.describe
    self.rewards = cusData.rewards
    self.uiCode = cusData.ui_code
end


function parseMsg(self, cusMsg)
    self.countNow = cusMsg.count_now
    self.state = cusMsg.state
end


-- 任务描述
function getDes(self)
    return _TT(self.des)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
