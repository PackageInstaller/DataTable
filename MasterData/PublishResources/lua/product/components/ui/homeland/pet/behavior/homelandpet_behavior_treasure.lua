require("homelandpet_behavior_base")
_class("HomelandPetBehaviorTreasure", HomelandPetBehaviorBase)
HomelandPetBehaviorTreasure = HomelandPetBehaviorTreasure

function HomelandPetBehaviorTreasure:Constructor(behaviorType, pet)
  self._animationComponent = self:GetComponent(HomelandPetComponentType.Animation)
  self._bubbleComponent = self:GetComponent(HomelandPetComponentType.Bubble)
  self._modeChangeProcessType = HomelandPetModeChangeProcessType.Custom
end

function HomelandPetBehaviorTreasure:Enter()
  HomelandPetBehaviorTreasure.super.Enter(self)
  self._animationComponent:Play(HomelandPetAnimName.Stand)
  local bid = Cfg.cfg_homeland_global.TreasureBoardBubblePrefabID.IntValue
  self._bubbleComponent:SetBubbleID(bid)
  self._bubbleComponent:Show()
  local tmng = self._homelandClient:TreasureManager()
  local _, param = self._pet:IsOccupied()
  local trinfo = tmng:GetTreasure(param)
  if trinfo ~= nil then
    local rota = trinfo:GetPetRota()
    self._pet:AgentTransform():DORotate(rota, 0.5, DG.Tweening.RotateMode.Fast):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
      self._pet:SetEuler(rota)
    end)
  end
end

function HomelandPetBehaviorTreasure:Exit()
  HomelandPetBehaviorTreasure.super.Exit(self)
end

function HomelandPetBehaviorTreasure:CanInterrupt()
  return true
end

function HomelandPetBehaviorTreasure:ExitBubble()
  self._bubbleComponent:SetBubbleID(0)
  self._bubbleComponent:Exit()
end
