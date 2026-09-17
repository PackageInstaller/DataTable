local this = class("fishQteTpl")

function this:init(config)
  self.data = config
  self.groupData = {}
  for i, v in pairs(config) do
    self.groupData[v.teamId] = self.groupData[v.teamId] or {}
    self.groupData[v.teamId][v.order] = v
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getScore(tpl)
  return tpl.score
end

function this:getId(tpl)
  return tpl.id
end

function this:getInterval(tpl)
  return tpl.interval
end

function this:getDisappear(tpl)
  return tpl.disappear
end

function this:getTplByTeamAndOrder(teamId, order)
  return self.groupData[teamId][order]
end

function this:getTplTeam(teamId)
  return self.groupData[teamId]
end

function this:getCoordinate(tpl)
  return L_Vector3.new(tpl.coordinate[1], tpl.coordinate[2], 0)
end

return this
