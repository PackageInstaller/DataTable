--[[ 
-----------------------------------------------------
@filename       : MainActivitySignVo
@Description    : 活动签到解析
@date           : 2023-05-29 15:45:15
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]] module('game.mainActivity.manager.vo.MainActivitySignVo', Class.impl())

function parseConfigData(self, key, cusData)
    self.daily = key
    self.awradList = cusData.reward
end

function getAwardList(self)
    return self.awradList or {}
end

function getIsSign(self)
    return mainActivity.MainActivityManager:checkIsSigned(self.daily) ~= false
end

function getCanReceive(self)
    return (not self:getIsSign()) and (self.daily <= mainActivity.MainActivityManager:getLoginDay())
end

function getDaily(self)
    if self.daily < 10 then
        return "0" .. self.daily
    else
        return self.daily
    end
    -- return _TT(136509, self.daily)
    -- return string.format("%02d", self.daily)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
