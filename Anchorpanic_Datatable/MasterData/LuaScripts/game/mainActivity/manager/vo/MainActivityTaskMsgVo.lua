--[[ 
-----------------------------------------------------
@filename       : MainActivityTaskMsgVo
@Description    : 任务 MSG Vo
@date           : 2023-05-22 15:45:15
@Author         : Tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('mainActivity.MainActivityTaskMsgVo', Class.impl())

function parseMsg(self, msg)
    -- 任务Id
    self.id = msg.id
    --  任务当前达到值
    self.count = msg.count
    -- 任务状态  "任务状态，1:未完成，0:已完成未领奖，2：已领取奖励"
    self.state = msg.state

end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]