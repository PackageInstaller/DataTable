local UINUltSkillMpParticleItem = class("UINUltSkillMpParticleItem", UIBaseNode)
local base = UIBaseNode

function UINUltSkillMpParticleItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.moveTween.onComplete:AddListener(BindCallback(self, self.OnMoveTweenComplete))
  self.psEmission = self.ui.particle.emission
  self.psEmBurst = self.psEmission:GetBurst(0)
end

function UINUltSkillMpParticleItem:InitUltSkillMpParticle(startPos, posX, posY, ratio, completeEvent)
  self.completeEvent = completeEvent
  self.transform.anchoredPosition = startPos
  self.ui.moveTween.tween:ChangeEndValueV3(posX, posY, 0, true)
  self.ui.moveTween:DORestart()
  local particleCount = math.ceil(ratio / self.ui.perParticleRatio)
  particleCount = math.min(particleCount, self.ui.maxParticleCount)
  if self.psEmBurst.minCount ~= particleCount or self.psEmBurst.maxCount ~= particleCount then
    self.psEmBurst.minCount = particleCount
    self.psEmBurst.maxCount = particleCount
    self.psEmission:SetBurst(0, self.psEmBurst)
  end
  self.ui.particle:Play()
end

function UINUltSkillMpParticleItem:OnMoveTweenComplete()
  if self.completeEvent ~= nil then
    self.completeEvent(self)
  end
end

function UINUltSkillMpParticleItem:OnDelete()
  base.OnDelete(self)
end

return UINUltSkillMpParticleItem
