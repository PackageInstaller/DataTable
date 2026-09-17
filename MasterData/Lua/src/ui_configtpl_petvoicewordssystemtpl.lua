local this = class("petVoiceWordsSystemTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getIntoTeam(tpl)
  return L_Config:provider(tpl.intoTeam)
end

function this:getCaptureFail(tpl)
  return L_Config:provider(tpl.captureFail)
end

function this:getEvolve(tpl)
  return L_Config:provider(tpl.evolve)
end

function this:getTouch(tpl)
  return L_Config:provider(tpl.touch)
end

function this:getHungry(tpl)
  return L_Config:provider(tpl.hungry)
end

function this:getIdle(tpl)
  return L_Config:provider(tpl.idle)
end

function this:getSleep(tpl)
  return L_Config:provider(tpl.sleep)
end

function this:getId(tpl)
  return tpl.id
end

function this:getCaptured(tpl)
  return L_Config:provider(tpl.captured)
end

function this:getIntoWheel(tpl)
  return L_Config:provider(tpl.intoWheel)
end

function this:getIntoRide(tpl)
  return L_Config:provider(tpl.intoRide)
end

function this:getGreet(tpl)
  return L_Config:provider(tpl.greet)
end

function this:getUpgrade(tpl)
  return L_Config:provider(tpl.upgrade)
end

return this
