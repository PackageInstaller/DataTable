local DormFightCtrlBase = require("Game.Fight.Ctrl.DormFightCtrlBase")
local DormFightAudioCtrl = class("DormFightAudioCtrl", DormFightCtrlBase)

function DormFightAudioCtrl:InitDormFightAudioCtrl(pvpFightController, dormFightAudioData)
  self.fighterControllers = {}
  self.__PlayFighterAttackAudio = BindCallback(self, self.PlayFighterAttackAudio)
  self.__PlayFighterOnHitAudio = BindCallback(self, self.PlayFighterOnHitAudio)
end

function DormFightAudioCtrl:OnCreateFighter(fighterController)
  if self.fighterControllers[fighterController] ~= nil then
    self:RemoveFighterListener(fighterController)
  end
  self:AddFighterListener(fighterController)
end

function DormFightAudioCtrl:AddFighterListener(fighterController)
  self.fighterControllers[fighterController] = true
end

function DormFightAudioCtrl:OnDestroyFighter(fighterController)
  if self.fighterControllers[fighterController] ~= nil then
    self:RemoveFighterListener(fighterController)
  end
end

function DormFightAudioCtrl:RemoveFighterListener(fighterController)
  self.fighterControllers[fighterController] = nil
end

function DormFightAudioCtrl:RemoveAllListeners()
end

function DormFightAudioCtrl:PlayFighterAttackAudio(fighterController)
  AudioManager:PlayAudioById(5011)
end

function DormFightAudioCtrl:PlayFighterOnHitAudio(fighterController)
  AudioManager:PlayAudioById(5014)
end

return DormFightAudioCtrl
