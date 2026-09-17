local this = class("taskTpl")

function this:init(config)
  self.data = config
end

function this:getConfig()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getFilter(tpl)
  return tpl.filter
end

function this:getType(tpl)
  return tpl.type
end

function this:getTabType(tpl)
  return tpl.tabType
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getRawName(tpl)
  return tpl.name
end

function this:getTaskReward(tpl)
  return tpl.taskReward
end

function this:getTypeImageIcon(tpl)
  local tabType = self:getTabType(tpl)
  local taskTypeTpl = L_GameTpl:getTaskTypeTpl()
  local tplType = taskTypeTpl:getTplById(tabType)
  if tplType then
    return taskTypeTpl:getIcon(tplType)
  end
end

function this:getMapTaskIcon(tpl)
  local tabType = self:getTabType(tpl)
  local taskTypeTpl = L_GameTpl:getTaskTypeTpl()
  local tplType = taskTypeTpl:getTplById(tabType)
  if tplType then
    return taskTypeTpl:getMapIcon(tplType)
  end
end

function this:getMapTaskIconBg(tpl)
  local tabType = self:getTabType(tpl)
  local taskTypeTpl = L_GameTpl:getTaskTypeTpl()
  local tplType = taskTypeTpl:getTplById(tabType)
  if tplType then
    return taskTypeTpl:getMapIconBg(tplType)
  end
end

function this:getPic(tpl)
  return tpl.pic
end

function this:getWorldShow(tpl)
  return tpl.worldShow
end

function this:getMapShow(tpl)
  return tpl.mapShow
end

function this:getNewShow(tpl)
  return tpl.newShow
end

return this
