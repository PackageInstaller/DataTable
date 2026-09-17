local this = class("dailyAttendanceTpl")

function this:init(config)
  self.data = config
  self.month = {
    [1] = "JANUARY",
    [2] = "FEBRUARY",
    [3] = "MARCH",
    [4] = "APRIL",
    [5] = "MAY",
    [6] = "JUNE",
    [7] = "JULY",
    [8] = "AUGUST",
    [9] = "SEPTEMBER",
    [10] = "OCTOBER",
    [11] = "NOVEMBER",
    [12] = "DECEMBER"
  }
end

function this:getTplById(id)
  return self.data[id]
end

function this:getReward(tpl)
  return tpl.reward
end

function this:getDay(tpl)
  return tpl.day
end

function this:getEnglishMonth(id)
  return self.month[id]
end

function this:getTeamId(tpl)
  return tpl.teamId
end

function this:getId(tpl)
  return tpl.id
end

return this
