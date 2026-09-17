local this = class("moduleBattleBossTip", G_UIModuleBase)
local _skillTpl = L_GameTpl:getSkillTpl()

function this.bind()
  return {txt_skill = "", goContent = false}
end

function this.methods()
  return {}
end

function this:created(...)
  this.super.created(self, ...)
end

function this:open()
end

function this:close()
  self:resetTimer()
end

function this:showSkill(skillId, time)
  self:resetTimer()
  local skill = _skillTpl:getTplById(skillId)
  self.bind.txt_skill = _skillTpl:getName(skill)
  self.bind.goContent = true
  self.bindComponents.showAnim:Play("anim_battle_bosstip_show")
  self.timer = Timer.once(time, self.hideSkill, self)
end

function this:hideSkill()
  self.bindComponents.showAnim:Play("anim_battle_bosstip_hide")
end

function this:hideContent()
  self.bind.goContent = false
end

function this:resetTimer()
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
end

function this:refresh()
end

return this
