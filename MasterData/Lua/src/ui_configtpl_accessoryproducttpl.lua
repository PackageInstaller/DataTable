local this = class("accessoryProductTpl")
local _dungeonMaterialTpl = L_GameTpl:getDungeonMaterialTpl()

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getDungeonId(tpl)
  return tpl.dungeonId
end

function this:getIcon(tpl)
  local dungeonId = self:getDungeonId(tpl)
  if not dungeonId then
    return
  end
  local dungeonMaterialTpl = _dungeonMaterialTpl:getTplById(dungeonId)
  if not dungeonMaterialTpl then
    return
  end
  local iconPath = _dungeonMaterialTpl:getIconPath(dungeonMaterialTpl)
  return _dungeonMaterialTpl:getIcon(dungeonMaterialTpl)[iconPath]
end

function this:getTime(tpl)
  return tpl.time * 60
end

function this:getSatietyScore(tpl)
  return tpl.satietyScore
end

return this
