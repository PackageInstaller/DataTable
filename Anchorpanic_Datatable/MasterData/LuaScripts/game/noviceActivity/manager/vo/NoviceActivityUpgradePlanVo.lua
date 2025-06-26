--[[ 
-----------------------------------------------------
@filename       : NoviceActivityUpgradePlanVo
@Description    : 新手活动升格计划解析
@date           : 2023-6-6 13:56:35
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.noviceActivity.manager.vo.NoviceActivityUpgradePlanVo', Class.impl())

function parseConfig(self, id, cusData)
    self.id = id
    self.upgradeTarget = cusData.upgrade_target
    self.num = cusData.num
    self.des = cusData.des
    self.reward = cusData.reward
    self.state = 1--进行中
    self.count = 0--当前进度
end

function getDescribe(self)
    return _TT(self.des)
end

function getTime(self)
    return self.num
end

function getState(self)
    if (self.state == 1) then
        return task.AwardRecState.UN_REC
    elseif (self.state == 0) then
        return task.AwardRecState.CAN_REC
    elseif (self.state == 2) then
        return task.AwardRecState.HAS_REC
    end
end
--是否已领取
function getIsCanRecived(self)
    if self.state > 1 then
        return true
    end
    return false
end

function getCurCount(self)
    return self.count
end

function getAwardList(self)
    return self.reward
end

function setState(self, state)
    self.state = state
end

function setCount(self, count)
    self.count = count
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]