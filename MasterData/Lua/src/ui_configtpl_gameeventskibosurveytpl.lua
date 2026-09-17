local this = class("gameEventsKiboSurveyTpl")

function this:init(config)
  self.data = config
  self.groupData = {}
  for i, v in pairs(config) do
    if self.groupData[self:getGroupId(v)] == nil then
      self.groupData[self:getGroupId(v)] = {}
    end
    table.insert(self.groupData[self:getGroupId(v)], v)
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getGroupData(groupId)
  return self.groupData[groupId]
end

function this:getKiboMission(tpl)
  return tpl.kiboMission
end

function this:getDropId(tpl)
  return tpl.dropId
end

function this:getKiboMissionSelect(tpl)
  return tpl.kiboMissionSelect
end

function this:getUnlockTime(tpl)
  return tpl.unlockTime
end

return this
