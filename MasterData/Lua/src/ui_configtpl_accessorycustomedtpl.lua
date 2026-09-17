local this = class("accessoryCustomedTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getAccessoryIdById(id)
  if self.data[id] then
    return self.data[id].accessoryId
  end
end

function this:getIsGold(id)
  return self.data[id].extra == 1
end

return this
