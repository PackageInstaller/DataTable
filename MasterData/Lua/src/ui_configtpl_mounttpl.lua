local this = class("mountTpl")

function this:init(luaConfig)
  self.data = luaConfig
end

function this:getList()
  local list = {}
  for i, v in pairs(self.data) do
    table.insert(list, v)
  end
  table.sort(list, function(a, b)
    return a.id < b.id
  end)
  return list
end

function this:getId(tpl)
  return tpl.id
end

function this:getTplById(id)
  local tpl = self.data[id]
  if not tpl then
    return {}
  end
  return self.data[id]
end

function this:getNameByTpl(tpl)
  local name = L_Config:provider(tpl.name)
  return name
end

function this:getMoveType(tpl)
  return tpl.moveType
end

function this:getMountCanFly(tpl)
  if not tpl.moveType then
    return false
  end
  for _, v in ipairs(tpl.moveType) do
    if v == L_Const.WorldMapPlayerMountStatusType.WMPMST_FLY then
      return true
    end
  end
  return false
end

function this:getMoveDesc(tpl)
  local moveDesc = L_Config:provider(tpl.moveDesc)
  return moveDesc
end

function this:getDescByTpl(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getQuatityByTpl(tpl)
  return tpl.rarity
end

function this:getUnitIdByTpl(tpl)
  return tpl.unitId
end

function this:getIdByTpl(tpl)
  return tpl.id
end

function this:getSlotCharacterByTpl(tpl)
  return L_Config:provider(tpl.slot_character)
end

function this:getSlotMountByTpl(tpl)
  return L_Config:provider(tpl.slot_mount)
end

function this:getIconByTpl(tpl)
  local icon = L_Config:getPathByHash(tpl.icon[2])
  if string.isEmpty(icon) then
    return "UI/Atlas/Item/tex_mount_head_default.png"
  end
  return icon
end

function this:getHalfIconByTpl(tpl)
  local icon = L_Config:getPathByHash(tpl.icon[1])
  if string.isEmpty(icon) then
    return "UI/Atlas/Item/tex_mount_head_default.png"
  end
  return icon
end

function this:getHalfIconFrameByTpl(tpl)
  return string.format("MountIcon/tex_mount_frame_%s", L_Const.qualityToKey[tpl.rarity])
end

function this:getSlotPosByTpl(tpl)
  return string.toVector3(tpl.slot_pos, "#")
end

function this:getSlotRotateByTpl(tpl)
  return string.toVector3(tpl.slot_rotate, "#")
end

function this:getCharacterActionByTpl(tpl)
  return tpl.character_action
end

function this:getCharacterActionGroupByTpl(tpl)
  return tpl.character_action_group
end

function this:getFastMoveSpeedByTpl(tpl)
  return tpl.fast_move_speed
end

function this:getJumpSpeedByTpl(tpl)
  return tpl.jump_speed
end

function this:getJumpGravityByTpl(tpl)
  return tpl.jump_gravity
end

function this:getJumpResistanceByTpl(tpl)
  return tpl.jump_resistance
end

function this:getJumpMassByTpl(tpl)
  return tpl.jump_mass
end

function this:getUnlock(tpl)
  return tpl.unlock
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

function this:getHomeLevelShow(tpl)
  return tpl.homelevelshow
end

function this:isMount(petId)
  return self.data[petId] ~= nil
end

return this
