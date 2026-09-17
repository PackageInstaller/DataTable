local module = class("cellAreaLevelUnlockItem", G_UIModuleBase)

function module:ctor(...)
  module.super.ctor(self, ...)
end

function module.bind()
  return {
    txtContent = "",
    btnFind = false,
    imgLock = true,
    imgUnLock = false
  }
end

function module.methods()
  return {
    onClickFindBtn = function(self)
      self:triggerClick()
    end,
    onClickCellBtn = function(self)
      self:triggerClick()
    end
  }
end

function module:triggerClick()
  local skillId = self.bind.conentParams.skillId
  self:emit("onClick", self, skillId)
end

function module:open()
  self:refreshInfo()
end

function module:refreshInfo()
  if self.bind.contentType == L_PetDuelStore.unlockContentType.skill then
    self.bind.txtContent = self:getUnlockSkillContent(self.bind.conentParams.skillId)
    self.bind.btnFind = true
  else
    self.bind.txtContent = self.bind.conentParams.content
    self.bind.btnFind = false
  end
  self.bind.imgUnLock = self.bind.conentParams.isUnlock
  self.bind.imgLock = not self.bind.conentParams.isUnlock
end

function module:getUnlockLevelContent(level)
  return L_WordsTpl:getValue("ui_kiboduel_level_unlocklevel", {
    [0] = level
  })
end

function module:getUnlockSkillContent(skillId)
  local skillTpl = L_GameTpl:getSkillTpl()
  local tpl = skillTpl:getTplById(skillId)
  local skillName = skillTpl:getName(tpl)
  return L_WordsTpl:getValue("ui_kiboduel_level_unlockskill", {
    [0] = skillName
  })
end

function module:getRootTran()
  return self.bindComponents.rootTran
end

return module
