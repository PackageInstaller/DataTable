local this = class("playableTypeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getTrackType(tpl)
  return tpl.trackType
end

function this:getPlayableListByTrackId(trackType)
  local result = {}
  if not trackType then
    return result
  end
  for id, tpl in pairs(self.data) do
    if self:getTrackType(tpl) == trackType then
      table.insert(result, tpl)
    end
  end
  return result
end

return this
