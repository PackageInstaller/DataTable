require("buff_logic_base")
_class("BuffLogicAddAlchemyAP", BuffLogicBase)
BuffLogicAddAlchemyAP = BuffLogicAddAlchemyAP

function BuffLogicAddAlchemyAP:Constructor(buffinstance, logicParam)
  self._count = logicParam.count
end

function BuffLogicAddAlchemyAP:DoLogic(notify)
  local lsvcFeature = self._world:GetService("FeatureLogic")
  local retBuffInsList = lsvcFeature:AddAlchemyAP(self._count)
  local result = BuffResultAddAlchemyAP:New()
  result:AddAlchemyAP(lsvcFeature:GetAlchemyAP(), lsvcFeature:GetAlchemyLevel(), self._count)
  if retBuffInsList and retBuffInsList ~= {} then
    for i, inst in ipairs(retBuffInsList) do
      result:AddBuffData(inst:Entity():GetID(), inst:BuffSeq())
    end
  end
  return result
end
