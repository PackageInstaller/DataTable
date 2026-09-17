local this = class("modulePetStatistics", G_UIModuleBase)

function this.bind()
  return {
    damgeMax = nil,
    healingMax = nil,
    damageTakenMax = nil,
    curDamge = nil,
    txt_damage = nil,
    curHealing = nil,
    txt_healing = nil,
    curDamageTaken = nil,
    txt_damageTaken = nil
  }
end

function this.methods()
  return {}
end

function this:open()
end

function this:close()
end

function this:refreshData(data)
  self.bind.damgeMax = data.maxDamge
  self.bind.healingMax = data.maxHealing
  self.bind.damageTakenMax = data.maxDamgeTaken
  local intPart, _ = math.modf(data.damgeValue)
  self.bind.curDamge = intPart
  self.bind.txt_damage = L_HeroManager:addComma(intPart)
  intPart, _ = math.modf(data.healingValue)
  self.bind.curHealing = intPart
  self.bind.txt_healing = L_HeroManager:addComma(intPart)
  intPart, _ = math.modf(data.damgeTakenValue)
  self.bind.curDamageTaken = intPart
  self.bind.txt_damageTaken = L_HeroManager:addComma(intPart)
end

return this
