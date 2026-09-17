local this = class("cellDuelResult", G_UIModuleBase)
local petTpl = L_GameTpl:getPetTpl()

function this.bind()
  return {
    petIcon = "",
    txt_petName = "",
    deadIconActive = false
  }
end

function this.methods()
  return {}
end

function this:open()
end

function this:close()
end

function this:setPet(data, isShowDead)
  if data == nil then
    return
  end
  local petConfigId = data.petConfigId
  if math.isEmpty(petConfigId) then
    printf("cellDuelResult", "guid: " .. data.guid .. " petConfigId: " .. (petConfigId or 0))
    return
  end
  self.bind.deadIconActive = isShowDead
  local guid = data.guid
  local tpl = petTpl:getTplById(petConfigId)
  local special = 0
  if guid ~= nil then
    local petItem = L_PetStore:getPetItem(guid)
    if petItem ~= nil then
      special = petItem:isSpecialPet()
    end
  end
  self.bind.petIcon = petTpl:getPetIcon(tpl, special)
  self.bind.txt_petName = petTpl:getName(tpl, special)
end

return this
