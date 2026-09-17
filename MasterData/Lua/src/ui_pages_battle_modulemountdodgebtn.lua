local this = class("moduleMountDodgeBtn", G_UIModuleBase)

function this.bind()
  return {
    txt_skillCd = "0",
    fill_maskSkill = 0,
    go_skillCd = false
  }
end

function this.methods()
  return {}
end

function this:created(...)
  this.super.created(self, ...)
end

function this:open()
  self.updateHandle = handler(self, self.update)
  C_UpdateSource.AddUpdateEventHandler(self.updateHandle, "movement.moduleMountDodgeBtn.update")
end

function this:close()
  C_UpdateSource.RemoveUpdateEventHandler(self.updateHandle)
end

function this:update()
  local controlEntity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  if not controlEntity then
    return
  end
  local entityType = controlEntity.data.entityType
  if entityType ~= C_EEntityType.Pet then
    return
  end
  local coolDown = controlEntity.data.dodgeCoolDown
  self.bind.go_skillCd = false
  local ready = coolDown:Ready()
  if ready then
  else
    self.bind.go_skillCd = true
    local coolTime = C_MyFloatUtility.GetFloat(coolDown.coolTime)
    local coolDown = C_MyFloatUtility.GetFloat(coolDown.coolDown)
    self.bind.txt_skillCd = tostring(math.round(coolTime * 10) * 0.1)
    self.bind.fill_maskSkill = coolTime / coolDown
  end
end

return this
