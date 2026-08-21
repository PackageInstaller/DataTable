require("buff_logic_base")
_class("BuffLogicAddLayerByScopeTargetCount", BuffLogicBase)
BuffLogicAddLayerByScopeTargetCount = BuffLogicAddLayerByScopeTargetCount

function BuffLogicAddLayerByScopeTargetCount:Constructor(buffInstance, logicParam)
  self._skillID = logicParam.skillID
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._buffInstance._buffLayerName = self._buffInstance._buffsvc:GetBuffLayerName(self._layerType)
  self._dontDisplay = logicParam.dontDisplay
end

function BuffLogicAddLayerByScopeTargetCount:DoLogic(notify)
  local e = self._buffInstance:Entity()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local targetSelector = self._world:GetSkillScopeTargetSelector()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(self._skillID)
  local skillTargetType = skillConfigData:GetSkillTargetType()
  local notifyPos = e:GetGridPosition()
  if notify:GetNotifyType() == NotifyType.NormalEachAttackStart or notify:GetNotifyType() == NotifyType.ChainSkillEachAttackStart or notify:GetNotifyType() == NotifyType.ActiveSkillEachAttackStart then
    notifyPos = notify:GetAttackPos()
  elseif notify:GetNotifyType() == NotifyType.PlayerBeHitStart then
    notifyPos = notify:GetTargetPos()
  end
  local scopeResult = utilScopeSvc:CalcSkillScope(skillConfigData, notifyPos, e)
  local targetEntityIDArray = targetSelector:DoSelectSkillTarget(e, skillTargetType, scopeResult, self._skillID)
  local entityIDArray = {}
  for i = 1, #targetEntityIDArray do
    if not table.icontains(entityIDArray, targetEntityIDArray[i]) then
      table.insert(entityIDArray, targetEntityIDArray[i])
    end
  end
  local targetEntityCount = 0
  for _, targetID in ipairs(entityIDArray) do
    local targetEntity = self._world:GetEntityByID(targetID)
    if targetEntity and not targetEntity:HasDeadMark() then
      targetEntityCount = targetEntityCount + 1
    end
  end
  local svc = self._world:GetService("BuffLogic")
  local curMarkLayer = svc:AddBuffLayer(e, self._layerType, targetEntityCount)
  local buffResult = BuffResultAddLayer:New(curMarkLayer, self._dontDisplay)
  if notify:GetNotifyType() == NotifyType.TrapDead or notify:GetNotifyType() == NotifyType.TrapShow then
    local nt = notify
    local notifyEntity = nt:GetNotifyEntity()
    local ntEntityID = 0
    if notifyEntity then
      ntEntityID = notifyEntity:GetID()
    end
    buffResult:SetNotifyEntityID(ntEntityID)
  end
  return buffResult
end
