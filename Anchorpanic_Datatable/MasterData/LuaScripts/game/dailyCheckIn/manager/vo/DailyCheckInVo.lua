--[[ 
-----------------------------------------------------
@filename       : DailyCheckInVo
@Description    : 每日签到解析
@date           : 2023-03-13 17:37:15
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.dailyCheckIn.manager.vo.DailyCheckInVo', Class.impl())

function parseData(self, daily, msg)
    self.daily = daily
    self.awardDic = msg.award
    self.lv = self.awardDic[1].level
    self.nomalAward = self.awardDic[1].reward[1]
    self.mooncardAwardList = self.awardDic[1].reward_mooncard
end

function getLv(self)
    return self.lv
end

function getNomalAward(self)
    return self.nomalAward
end

function getMooncardAwardList(self)
    return self.mooncardAwardList
end

function getCurDaily(self)
    return self.daily
end

function getCanRecivedDaily(self)
    return dailyCheckIn.DailyCheckInManager:getCurDaily()
end

function gettDailyItemTid(self)
    return self.nomalAward[1]
end

function getDailyItemUrl(self)
    return UrlManager:getPropsIconUrl(self.nomalAward[1])
end

function getDailyItemNum(self)
    return self.nomalAward[2]
end

function getIsRecived(self)
    return dailyCheckIn.DailyCheckInManager:getIsRecivedNomalById(self.daily)
end

function getIsMoothRecived(self)
    return (purchase.MonthCardManager:getLeftDays() > 0 and self:getIsRecived()) and true or false
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]