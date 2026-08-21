_class("BuffLogicPSPAddFeatureEnergy", BuffLogicBase)
BuffLogicPSPAddFeatureEnergy = BuffLogicPSPAddFeatureEnergy

function BuffLogicPSPAddFeatureEnergy:Constructor(buffInstance, logicParam)
  self._baseValue = logicParam.baseValue or 0
  self._modifyType = logicParam.modifyType or BuffPopStarProModifyType.None
end

function BuffLogicPSPAddFeatureEnergy:DoLogic()
  local popSarProSvc = self._world:GetService("PopStarProLogic")
  local count = popSarProSvc:GetCountByModifyType(self._modifyType)
  local addValue = self._baseValue * count
  local ntAdd = NTPopStarProAddFeatureEnergy:New()
  ntAdd:SetAddNum(addValue)
  local triggerSvc = self._world:GetService("Trigger")
  triggerSvc:Notify(ntAdd)
end
