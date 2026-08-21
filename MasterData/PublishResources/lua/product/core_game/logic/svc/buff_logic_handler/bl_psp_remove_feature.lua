require("buff_logic_base")
_class("BuffLogicPSPRemoveFeature", BuffLogicBase)
BuffLogicPSPRemoveFeature = BuffLogicPSPRemoveFeature

function BuffLogicPSPRemoveFeature:Constructor(buffinstance, logicParam)
  self._featureType = logicParam.featureType
end

function BuffLogicPSPRemoveFeature:DoLogic(notify)
  local featureSvc = self._world:GetService("FeatureLogic")
  featureSvc:OnBuffRemoveFeature(self._featureType)
  return true
end
