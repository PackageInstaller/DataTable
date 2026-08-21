--[[ 
-----------------------------------------------------
@filename       : NoviceActivityVo
@Description    : 新手活动解析
@date           : 2023-6-5 16:50:35
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.noviceActivity.manager.vo.NoviceActivityVo', Class.impl())

function parseMsg(self, cusMsg)
    self.id = cusMsg.id
    self.upgradeTarget = cusMsg.upgrade_target
    self.endTime = cusMsg.end_time
    self.funcId = cusMsg.function_id
end

-- 功能是否开启
function isFuncOpen(self)
    return funcopen.FuncOpenManager:isOpen(self.funcId, false)
end

-- 是否活动开放状态
function isOpen(self)
    local clientTime = GameManager:getClientTime()
    if clientTime >= self.startTime and clientTime < self.endTime then
        return true
    end
    return false
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
