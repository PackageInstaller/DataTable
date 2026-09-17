local this = class("modulePetSkill", G_UIModuleBase)
local _enemyTpl = L_GameTpl:getEnemyTpl()

function this.bind()
  return {
    txt_skill = "",
    goSkill = false,
    img_petSkill = ""
  }
end

function this.methods()
  return {}
end

function this:open()
end

function this:close()
end

function this:petSkillOpen(param)
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
  self.bind.goSkill = true
  local tpl = L_GameTpl:getPetTpl():getTplById(param.petId)
  local petItem = L_PetStore:getPetItem(param.petGuid)
  local icon = L_GameTpl:getPetTpl():getPetBattleIcon(tpl, 2, petItem and petItem:isSpecialPet() or false)
  self.bind.txt_skill = L_GameTpl:getSkillTpl():getName(L_GameTpl:getSkillTpl():getTplById(param.skillId))
  self.bind.img_petSkill = icon
  self.timer = Timer.once(3, function()
    self.bind.goSkill = false
    self.timer = nil
  end, self)
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

return this
