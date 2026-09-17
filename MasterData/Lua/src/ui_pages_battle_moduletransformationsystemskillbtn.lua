local this = class("moduleTransformationSystemSkillBtn", G_UIModuleBase)

function this.bind()
  return {
    txt_skillCd = "0",
    fill_maskSkill = 0,
    go_skillCd = false
  }
end

function this:open()
  self.updateHandle = handler(self, self.update)
  C_UpdateSource.AddUpdateEventHandler(self.updateHandle, "movement.moduleTransformationSystemSkillBtn.update")
end

function this:initSkillType(skillType)
  self.skillType = skillType
end

function this:update()
  if self.skillType == nil then
    return
  end
  local controlEntity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  if not controlEntity then
    return
  end
  if controlEntity.data.entityType ~= C_EEntityType.Monster then
    return
  end
  local skillProperty = controlEntity.data.skillProperty
  self.bind.go_skillCd = false
  local skill = skillProperty:GetSkillBySlot(self.skillType)
  if skill then
    local coolDown = skill.coolDown
    local ready = coolDown:Ready()
    if not ready then
      self.bind.go_skillCd = true
      local coolTime = C_MyFloatUtility.GetFloat(coolDown.coolTime)
      local coolDown = C_MyFloatUtility.GetFloat(coolDown.coolDown)
      self.bind.txt_skillCd = tostring(math.round(coolTime))
      self.bind.fill_maskSkill = coolTime / coolDown
    end
  end
end

function this:close()
  C_UpdateSource.RemoveUpdateEventHandler(self.updateHandle)
end

return this
