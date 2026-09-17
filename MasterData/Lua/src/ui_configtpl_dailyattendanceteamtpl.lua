local this = class("dailyAttendanceTeamTpl")

function this:init(config)
  self.data = config
  self.groupData = {}
  for i, v in pairs(self.data) do
    if self.groupData[v.teamId] == nil then
      self.groupData[v.teamId] = {}
    end
    self.groupData[v.teamId][v.day] = v
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getReward(tpl)
  return tpl.reward
end

function this:getDay(tpl)
  return tpl.day
end

function this:getImportant(tpl)
  return tpl.important
end

function this:getTeamId(tpl)
  return tpl.teamId
end

function this:getGroupRewards(teamId)
  return self.groupData[teamId]
end

function this:getTplByDay(teamId, day)
  return self.groupData[teamId] and self.groupData[teamId][day]
end

return this
