_class("LuckLandBuff", Object)
LuckLandBuff = LuckLandBuff

function LuckLandBuff:Constructor(buffSeqID, buffID, entity)
  self._buffSeq = buffSeqID
  self._buffID = buffID
  self._entity = entity
  self._module = self._entity:GetLuckLandModule()
  local cfgMng = self._module:GetConfigMng()
  self._buffCfgData = cfgMng:GetBuffConfigData(buffID)
  local notifyCfg = self._buffCfgData:GetNotifyCfgData()
  local triggerCfg = self._buffCfgData:GetTriggerCfgData()
  local triggerMng = self._module:GetTriggerMng()
  self._trigger = triggerMng:CreateTrigger(self, notifyCfg, triggerCfg)
  local logicCfg = self._buffCfgData:GetLogicCfgData()
  self._buffMng = self._module:GetBuffMng()
  self._logicArray = self._buffMng:CreateBuffLogic(self, logicCfg)
  self._targetList = {}
end

function LuckLandBuff:BuffSeqID()
  return self._buffSeq
end

function LuckLandBuff:BuffID()
  return self._buffID
end

function LuckLandBuff:BuffConfigData()
  return self._buffCfgData
end

function LuckLandBuff:Entity()
  return self._entity
end

function LuckLandBuff:GetTargets()
  return self._targetList
end

function LuckLandBuff:IsTriggerSatisfied(notify)
  local notifyType = notify:GetNotifyType()
  if self._trigger:IsNotifyMatch(notifyType) then
    return self._trigger:IsSatisfied(notify)
  end
  return false
end

function LuckLandBuff:OnTrigger(notify)
  local targetType = self._buffCfgData:GetTargetType()
  local targetParam = self._buffCfgData:GetTargetParam()
  self._targetList = self._buffMng:CalculateBuffTarget(targetType, targetParam, self._entity)
  if #self._targetList < 1 then
    return
  end
  if self._logicArray then
    for _, logic in ipairs(self._logicArray) do
      local buffResult = logic:DoLogic(notify)
      if not notify or buffResult then
      end
    end
  end
end
