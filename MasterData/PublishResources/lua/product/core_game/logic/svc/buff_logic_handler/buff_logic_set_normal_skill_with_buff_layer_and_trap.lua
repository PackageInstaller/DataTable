_class("BuffLogicSetNormalSkillWithBuffLayerAndTrap", BuffLogicBase)
BuffLogicSetNormalSkillWithBuffLayerAndTrap = BuffLogicSetNormalSkillWithBuffLayerAndTrap

function BuffLogicSetNormalSkillWithBuffLayerAndTrap:Constructor(buffInstance, logicParam)
  self._trapIDs = logicParam.trapIDs
  self._buffEffectType = logicParam.buffEffectType
  self._addLayer = logicParam.addLayer
  self._skillList = logicParam.skillList
end

function BuffLogicSetNormalSkillWithBuffLayerAndTrap:DoLogic(notify)
  local e = self._buffInstance:Entity()
  local buffCmpt = e:BuffComponent()
  local setSkillParam
  local svc = self._world:GetService("BuffLogic")
  local layerCount = svc:GetBuffLayer(e, self._buffEffectType)
  if layerCount and 0 < layerCount then
    setSkillParam = {}
    setSkillParam.buffEffectType = self._buffEffectType
    setSkillParam.curLayerCount = layerCount
    setSkillParam.trapIDs = self._trapIDs
    setSkillParam.addLayer = self._addLayer
    setSkillParam.skillList = self._skillList
  end
  buffCmpt:SetBuffValue("ChangeNormalSkillWithBuffLayerAndTrap", setSkillParam)
end
