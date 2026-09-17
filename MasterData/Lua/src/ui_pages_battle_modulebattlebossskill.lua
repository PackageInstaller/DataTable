local this = class("moduleBattleBossSkill", G_UIModuleBase)
local _skillTpl = L_GameTpl:getSkillTpl()

function this.bind()
  return {
    txt_skill = "",
    goContent = false,
    imgBar_fillAmount = 0
  }
end

function this.methods()
  return {}
end

function this:showBossSkill(skillId, process, entityId)
  self.skillId = skillId
  self.entityId = entityId
  if 1 - process >= 0.9999 then
    self:hideSkill(true)
    return
  end
  local skill = _skillTpl:getTplById(skillId)
  self.bind.txt_skill = _skillTpl:getName(skill)
  self.bind.goContent = true
  self.bind.imgBar_fillAmount = 1 - process
  self.bindComponents.FX:SetAnchoredPosition(-1.995 + 251.185 * (1 - process), 0.31)
end

function this:hideSkill(bFinished)
  self.bindComponents.showAnim:Play(bFinished and "anim_battle_bossskill_finish" or "anim_battle_bossskill_hide")
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
  self.timer = Timer.once(0.4, function()
    self:hideContent()
  end, self)
end

function this:stopSkill(skillId, entityId)
  if self.skillId ~= skillId or self.entityId ~= entityId then
    return
  end
  self:hideSkill(false)
end

function this:hideContent()
  self.bind.goContent = false
end

function this:close()
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
end

return this
