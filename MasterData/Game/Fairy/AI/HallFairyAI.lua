local BaseCharacterAI = require("Game.Dorm.Character.AI.Base.BaseCharacterAI")
local HallFairyAI = class("HallFairyAI", BaseCharacterAI)
local HallFairyAIConfig = require("Game.Fairy.AI.HallFairyAIStateConfig")

function HallFairyAI:ctor(aiCfg, hallFairyEntity, autoNextState)
  self.aiCfg = aiCfg
  self.hallFairyEntity = hallFairyEntity
  self.__OnCurStateExit = BindCallback(self, self.OnCurStateExit)
  self.__randNextOnExit = autoNextState
  self:InitAIData()
end

function HallFairyAI:InitAIData()
  self.desires = {}
  for k, v in ipairs(self.aiCfg.desire_init) do
    self.desires[k] = v
  end
  self.desireOpen = {}
  for i = 1, #self.desires do
    self.desireOpen[i] = true
  end
  self.state = nil
end

function HallFairyAI:GetStateClass(type)
  return HallFairyAIConfig.GetState(type)
end

return HallFairyAI
