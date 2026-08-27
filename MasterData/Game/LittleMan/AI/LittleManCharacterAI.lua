local BaseCharacterAI = require("Game.Dorm.Character.AI.Base.BaseCharacterAI")
local LittleManCharacterAI = class("LittleManCharacterAI", BaseCharacterAI)
local LittleManAIStateConfig = require("Game.LittleMan.AI.LittleManAIStateConfig")

function LittleManCharacterAI:ctor(aiCfg, autoNextState, littleman)
  self.littleMan = littleman
  self.aiCfg = aiCfg
  self.__OnCurStateExit = BindCallback(self, self.OnCurStateExit)
  self.__randNextOnExit = autoNextState
  self:InitAIData()
end

function LittleManCharacterAI:InitAIData()
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

function LittleManCharacterAI:GetStateClass(type)
  return LittleManAIStateConfig.GetState(type)
end

return LittleManCharacterAI
