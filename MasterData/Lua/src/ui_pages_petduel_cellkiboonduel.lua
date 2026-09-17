local this = class("cellKiBoOnDuel", G_UIModuleBase)
local petTpl = L_GameTpl:getPetTpl()
local _, playerHealthColor = C_ColorUtility.TryParseHtmlString("#4c9aff")
local _, enemyHealthColor = C_ColorUtility.TryParseHtmlString("#ff5b5c")

function this.bind()
  return {
    active_cell = true,
    petIcon = "",
    healthAmount = 1,
    color_health = nil,
    deadMaskActive = false
  }
end

function this.methods()
  return {}
end

function this:open()
  L_TimerManager:newOrResetTimer(self, "cellKiBoOnDuelUpdate", handler(self, self.update), 0.1, -1)
end

function this:close()
  L_TimerManager:stopTimer(self, "cellKiBoOnDuelUpdate")
end

function this:refresh()
end

function this:refreshCell(kiboData)
  if not self.isBind then
    return
  end
  if kiboData == nil then
    return
  end
  self.guid = kiboData.guid
  self.entityId = kiboData.entityId
  self.petConfigId = kiboData.petConfigId
  self.isPlayerPet = kiboData.isPlayerPet
  if self.petConfigId == 0 then
    self:refreshCellActive(false)
    return
  end
  self:refreshCellActive(true)
  self:refreshHealthColor()
  self:refreshPetIcon()
  self:update()
end

function this:refreshCellActive(isActive)
  if self.oldIsActive == isActive then
    return
  end
  self.bind.active_cell = isActive
  self.oldIsActive = isActive
end

function this:refreshHealthColor()
  if self.oldIsPlayerPet == self.isPlayerPet then
    return
  end
  self.bind.color_health = self.isPlayerPet and playerHealthColor or enemyHealthColor
  self.oldIsPlayerPet = self.isPlayerPet
end

function this:refreshPetIcon()
  if self.oldPetConfigId == self.petConfigId then
    return
  end
  local tpl = petTpl:getTplById(self.petConfigId)
  local special = 0
  if self.guid ~= nil then
    local petItem = L_PetStore:getPetItem(self.guid)
    if petItem ~= nil then
      special = petItem:isSpecialPet()
    end
  end
  self.bind.petIcon = petTpl:getPetIcon(tpl, special)
  self.oldPetConfigId = self.petConfigId
end

function this:update()
  if not self.isBind or self.entityId == nil then
    return
  end
  local csEntity = C_EntityManager.GetEntity(self.entityId)
  if csEntity == nil then
    self.bind.healthAmount = 1
    return
  end
  local aliveProperty = csEntity.data.aliveProperty
  local hp = aliveProperty.luaHp
  if hp <= 0 then
    self.bind.healthAmount = 0
    return
  end
  self.bind.healthAmount = hp / aliveProperty.luaMaxHp
end

return this
