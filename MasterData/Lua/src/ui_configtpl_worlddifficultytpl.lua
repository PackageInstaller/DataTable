local this = class("worldDifficultyTpl")

function this:init(config)
  self.data = config
end

function this:getTplList()
  local list = table.toArray(self.data)
  table.sort(list, function(a, b)
    return a.id < b.id
  end)
  return list
end

function this:getTplById(id)
  return self.data[id]
end

function this:getIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.icon)
  return icon
end

function this:getId(tpl)
  return tpl.id
end

function this:getTaskId(tpl)
  return tpl.taskId
end

function this:getNote(tpl)
  return L_Config:provider(tpl.note)
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getNote(tpl)
  return L_Config:provider(tpl.note)
end

function this:getModifierName(tpl)
  return L_Config:provider(tpl.modifierName)
end

function this:getModifierTitle1(tpl)
  return L_Config:provider(tpl.modifierTitle[1])
end

function this:getModifierTitle2(tpl)
  return L_Config:provider(tpl.modifierTitle[2])
end

function this:getImgBackground(tpl)
  local icon = L_Config:getPathByHash(tpl.imgBackground)
  return icon
end

function this:getImgForeground(tpl)
  local icon = L_Config:getPathByHash(tpl.imgForeground)
  return icon
end

return this
