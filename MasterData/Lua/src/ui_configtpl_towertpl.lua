local this = class("towerTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  local res = self.data[id]
  if table.isEmpty(res) then
    errorf(string.format("tower %s 系统没有配置", id))
  end
  return res
end

function this:getTowerName(tpl)
  return L_Config:provider(tpl.towerName)
end

function this:getTowerDescription(tpl)
  return L_Config:provider(tpl.towerDescription)
end

function this:getBuffDescription(tpl)
  return L_Config:provider(tpl.buffDescription)
end

function this:getVersion(tpl)
  return tpl.version
end

return this
