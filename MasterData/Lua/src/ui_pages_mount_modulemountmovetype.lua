local this = class("moduleMountMoveType", G_UIModuleBase)
local _mountTpl = L_GameTpl:getMountTpl()
local _petTpl = L_GameTpl:getPetTpl()

function this.bind()
  return {
    list_moveType = {
      moduleName = "pages/mount/cellMountMoveType"
    }
  }
end

function this.methods()
  return {}
end

function this:setData(guid)
  local pet = L_PetStore:getPetItem(guid)
  local tpl_mount = _mountTpl:getTplById(pet.id)
  local moveType = _mountTpl:getMoveType(tpl_mount)
  local tmp = {}
  if moveType then
    for i, v in pairs(moveType) do
      if v == 6 then
        v = 2
      end
      table.insert(tmp, {
        moveType = v,
        img_icon = string.format("UI/Atlas/PetSaddle/tex_petsaddle_icon_%s.png", v)
      })
    end
  end
  self.bind.list_moveType:clear()
  self.bind.list_moveType:insert_array(tmp)
end

return this
