local this = class("situationDataContainer")

function this:ctor(param)
  self:define()
  self.data = nil
  self.guid = param.guid or L_SituationManager:getGuid()
  self:initData(param)
end

function this:define()
  self.dataType = nil
end

function this:setGuid(guid)
  self.guid = guid
end

function this:initData(param)
end

function this:record()
  local recordData = L_SituationManager:shallow_copy(self.data)
  local record = {
    guid = self.guid,
    type = self.dataType,
    data = recordData
  }
  return record
end

function this:revert(recordData)
  for i, v in pairs(recordData) do
    self.data[i] = v
  end
end

function this:apply()
end

function this:load(sceneData)
end

function this:release()
end

function this:serialize()
  local json = L_Json.encode(self.data)
  return json
end

function this:deserialize(data)
  self.data = data
end

return this
