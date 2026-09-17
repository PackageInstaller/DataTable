local this = class("homeResourceTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.icon)
  return icon
end

function this:getOutput(tpl)
  return tpl.output
end

function this:getParseOutPut(tpl)
  if table.isEmpty(tpl.output) then
    return {}
  end
  local list = {}
  for i, v in ipairs(tpl.output) do
    local item = {}
    item.rewardId = v[1]
    item.time = v[2]
    item.limit = v[3]
    table.insert(list, item)
  end
  return list
end

function this:getDrop(tpl)
  return tpl.drop
end

function this:getParseDrop(tpl)
  if table.isEmpty(tpl.drop) then
    return {}
  end
  local list = {}
  for i, v in ipairs(tpl.drop) do
    local item = {}
    item.dropId = v[1]
    item.time = v[2]
    item.limit = v[3]
    table.insert(list, item)
  end
  return list
end

function this:getId(tpl)
  return tpl.id
end

function this:getWorkerLimit(tpl)
  return tpl.workerLimit
end

return this
