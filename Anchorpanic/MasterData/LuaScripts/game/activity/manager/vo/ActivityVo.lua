--[[ 
-----------------------------------------------------
@filename       : ActivityVo
@Description    : 限时活动数据
@date           : 2021-03-12 09:51:15
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.activity.manager.vo.ActivityVo', Class.impl())

function parseMsg(self, cusMsg)
    self.id = cusMsg.id
    self.startTime = cusMsg.begin_time
    self.endTime = cusMsg.end_time
    self.overTime = cusMsg.remove_time
    self.funcId = cusMsg.function_id
end

-- 功能是否开启
function isFuncOpen(self)
    return funcopen.FuncOpenManager:isOpen(self.funcId, false)
end

-- 是否活动开放状态
function isOpen(self)
    local clientTime = GameManager:getClientTime()
    if clientTime >= self.startTime and clientTime < self.overTime then
        return true
    end
    return false
end

function getEndTime(self)
    return self.endTime
end

function getOverTime(self)
    return self.overTime
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]