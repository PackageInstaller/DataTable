BuffHandlerType = {
  LoadHandler = 1,
  ActiveHandler = 2,
  ExecuteHandler = 3,
  DeactivateHandler = 4,
  UnloadHandler = 5
}
_class("BuffInstance", Object)
BuffInstance = BuffInstance

function BuffInstance:Constructor(buffSeq, buffID, entity, world, context, alterLayer, changeLayerCount)
  self._buffSeq = buffSeq
  self._buffID = buffID
  self._entity = entity
  self._world = world
  self._context = context
  self._active = false
  self._unload = false
  self._buffRoundCount = 0
  self._buffExecCount = 0
  local sConfig = world:GetService("Config")
  self._buffConfigData = sConfig:GetBuffConfigData(buffID)
  self._relicId = 0
  local cfg = self._buffConfigData:GetData()
  self._maxBuffRoundCount = cfg.RoundCount
  self._maxBuffExecCount = cfg.ExecCount
  self._buffsvc = world:GetService("BuffLogic")
  self._maxBuffLayerCount = self._buffsvc:ModifyMaxLayerCountByGlobalCfg(self._buffConfigData, self._entity)
  self._buffLayerName = self._buffsvc:GetBuffLayerName(self:GetBuffEffectType())
  self._init = false
  if context and context.layer and type(context.layer) == "number" then
    self:AddLayerCount(context.layer)
  end
  self._casterSnapAttackValue = 0
  self:DoSnapShotValue(context)
  self._maxCountDown = cfg.CountDown
  self._alterLayer = alterLayer
  self._changeLayerCount = changeLayerCount
end

function BuffInstance:ViewInstance()
  return self._viewInstance
end

function BuffInstance:IsInit()
  return self._init
end

function BuffInstance:GetEquipIntensifiedCfg(equipIntensifyParams)
  local cfg = self._buffConfigData:GetData()
  local tmpCfg = {}
  tmpCfg.Load = {}
  tmpCfg.Load.logic = table.cloneconf(cfg.LoadLogic) or {}
  tmpCfg.Active = {}
  tmpCfg.Active.logic = table.cloneconf(cfg.ActiveLogic) or {}
  tmpCfg.Active.trigger = table.cloneconf(cfg.ActiveTrigger)
  tmpCfg.Exec = {}
  tmpCfg.Exec.logic = table.cloneconf(cfg.ExecLogic) or {}
  tmpCfg.Exec.trigger = table.cloneconf(cfg.ExecTrigger)
  tmpCfg.Deactive = {}
  tmpCfg.Deactive.logic = table.cloneconf(cfg.DeactiveLogic) or {}
  tmpCfg.Deactive.trigger = table.cloneconf(cfg.DeactiveTrigger)
  tmpCfg.Unload = {}
  tmpCfg.Unload.logic = table.cloneconf(cfg.UnloadLogic) or {}
  tmpCfg.Unload.trigger = table.cloneconf(cfg.UnloadTrigger)
  self._buffsvc:DoEquipIntensify(self._buffID, tmpCfg, equipIntensifyParams)
  return tmpCfg
end

function BuffInstance:InitBuffHandler(equipIntensifyParams)
  self._init = true
  local tmpCfg = self:GetEquipIntensifiedCfg(equipIntensifyParams)
  self._buffHandler = {}
  self._buffHandler[BuffHandlerType.LoadHandler] = BuffLoadHandler:New(self, {
    {
      NotifyType.BuffLoad
    },
    {
      TriggerType.Always
    }
  }, tmpCfg.Load.logic)
  self._buffHandler[BuffHandlerType.ActiveHandler] = BuffActiveHandler:New(self, tmpCfg.Active.trigger, tmpCfg.Active.logic)
  self._buffHandler[BuffHandlerType.ExecuteHandler] = BuffExecuteHandler:New(self, tmpCfg.Exec.trigger, tmpCfg.Exec.logic)
  self._buffHandler[BuffHandlerType.DeactivateHandler] = BuffDeactiveHandler:New(self, tmpCfg.Deactive.trigger, tmpCfg.Deactive.logic)
  self._buffHandler[BuffHandlerType.UnloadHandler] = BuffUnloadHandler:New(self, tmpCfg.Unload.trigger, tmpCfg.Unload.logic)
  self:SetActive(false)
  self._buffHandler[BuffHandlerType.UnloadHandler]:SetActive(true)
  self._buffsvc:UpdateBuffInstanceField(self, equipIntensifyParams)
end

function BuffInstance:SetActive(active)
  self._active = active
  self._buffHandler[BuffHandlerType.ExecuteHandler]:SetActive(active)
  self._buffHandler[BuffHandlerType.DeactivateHandler]:SetActive(active)
  self._buffHandler[BuffHandlerType.ActiveHandler]:SetActive(not active)
end

function BuffInstance:IsActive()
  return self._active
end

function BuffInstance:Load()
  local notify = NTBuffLoad:New(self._entity)
  for i, h in ipairs(self._buffHandler) do
    if table.icontains(h:GetNotifyType(), NotifyType.BuffLoad) and h:GetTrigger():IsSatisfied(notify) then
      h:OnTrigger(notify)
    end
  end
  self._world:GetService("Trigger"):Notify(NTAddBuffEnd:New(self._entity, self._buffSeq, self._buffID, self:GetBuffEffectType()))
  if self:GetBuffType() == BuffType.Control then
    local nt = NTAddControlBuffEnd:New(self._entity, self._buffSeq, self._buffID, self:GetBuffEffectType())
    self._world:GetService("Trigger"):Notify(nt)
  end
end

function BuffInstance:IsUnload()
  return self._unload
end

function BuffInstance:Unload(notify, isUnloadByTrigger)
  if self._unload then
    return
  end
  if self._active then
    self:SetActive(false)
    self._buffHandler[BuffHandlerType.DeactivateHandler]:OnTrigger(notify)
  end
  if not isUnloadByTrigger then
    self._buffHandler[BuffHandlerType.UnloadHandler]:OnTrigger(notify)
  end
  self:OnUnload(notify, false)
  self._world:GetService("Trigger"):Notify(NTRemoveBuffEnd:New(self._entity, self._buffSeq, self._buffID, self:GetBuffEffectType()))
  self._unload = true
end

function BuffInstance:OnUnload(notify, checkUnload)
  if checkUnload and self._unload then
    return
  end
  for i, h in pairs(self._buffHandler) do
    h:Detach()
  end
  local nt
  if notify then
    nt = notify:GetNotifyType()
  end
  self:PrintBuffInstanceLog("buffinstance unload! entity=", self._entity:GetID(), " buffseq=", self._buffSeq, " buffid=", self._buffID, " notify=", GetEnumKey("NotifyType", nt))
  local res = DataBuffDelResult:New(self._entity:GetID(), self._buffSeq, self._buffID, nt)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, res)
end

function BuffInstance:GetUnloadNotifyType()
  local h = self._buffHandler[BuffHandlerType.UnloadHandler]
  return h:GetNotifyType()
end

function BuffInstance:GetBuffExecCount()
  return self._buffExecCount
end

function BuffInstance:AddExecuteCount(notify, val)
  local totalCount = self._maxBuffExecCount or 0
  if totalCount <= 0 then
    return
  end
  self._buffExecCount = self._buffExecCount + val
  if totalCount <= self._buffExecCount then
    self:Unload(notify)
  end
end

function BuffInstance:GetBuffRoundCount()
  return self._buffRoundCount
end

function BuffInstance:AddRoundCount(notify)
  local totalCount = self._maxBuffRoundCount or 0
  if totalCount <= 0 then
    return
  end
  self._buffRoundCount = self._buffRoundCount + 1
  if totalCount <= self._buffRoundCount then
    self:PrintBuffInstanceLog("entity=", self._entity:GetID(), " buffid=", self._buffID, " unload by round ! round count=", self._buffRoundCount)
    self:Unload(notify)
  end
  self:PrintBuffInstanceLog("KZY_ForTest: entity id =", self._entity:GetID(), " buff id =", self._buffID, " round count =", self._buffRoundCount, " notify =", GetEnumKey("NotifyType", notify))
  self._world:EventDispatcher():Dispatch(GameEventType.DataBuffRoundCount, self._entity:GetID(), self._buffSeq, self._buffRoundCount)
end

function BuffInstance:AddMaxRoundCount(cnt)
  if self._maxBuffRoundCount == 0 then
    Log.error(self._className, "unlimited round count cannot be added. ")
    return
  end
  if self._maxBuffRoundCount + cnt == 0 then
    Log.error(self._className, "cannot turn a buff into unlimited round one. ")
    return
  end
  self._maxBuffRoundCount = self._maxBuffRoundCount + cnt
  self._world:EventDispatcher():Dispatch(GameEventType.DataBuffMaxRoundCount, self._entity:GetID(), self._buffSeq, self._maxBuffRoundCount)
end

function BuffInstance:GetMaxRoundCount()
  return self._maxBuffRoundCount
end

function BuffInstance:GetBuffLayerName()
  return self._buffLayerName
end

function BuffInstance:GetLayerCount()
  return self._entity:BuffComponent():GetBuffValue(self._buffLayerName) or 0
end

function BuffInstance:AddLayerCount(layer)
  local old_layer = self:GetLayerCount()
  local new_layer = layer + old_layer
  local overflowLayer = 0
  if 0 < self._maxBuffLayerCount and new_layer > self._maxBuffLayerCount then
    overflowLayer = new_layer - self._maxBuffLayerCount
    new_layer = self._maxBuffLayerCount
  end
  self:SetLayerCount(new_layer)
  local changeLayer = new_layer - old_layer
  return new_layer, changeLayer, overflowLayer
end

function BuffInstance:SetLayerCount(layer)
  if layer < 0 or 0 < self._maxBuffLayerCount and layer > self._maxBuffLayerCount then
    return
  end
  local before = self._entity:BuffComponent():GetBuffValue(self._buffLayerName) or 0
  if self._entity and self._entity:HasSkillInfo() and layer < before then
    local cSkillInfo = self._entity:SkillInfo()
    if cSkillInfo:IsBuffIDPassiveCount(self._buffID) then
      local sub = before - layer
      local cBuff = self._entity:BuffComponent()
      local passiveSkillRecord = cBuff:GetBuffValue("PassiveSkillCostCountByRound") or {}
      local roundCount = self._world:BattleStat():GetLevelTotalRoundCount()
      if not passiveSkillRecord[roundCount] then
        passiveSkillRecord[roundCount] = sub
      else
        passiveSkillRecord[roundCount] = passiveSkillRecord[roundCount] + sub
      end
      cBuff:SetBuffValue("PassiveSkillCostCountByRound", passiveSkillRecord)
    end
  end
  self._entity:BuffComponent():SetBuffValue(self._buffLayerName, layer)
end

function BuffInstance:SetMaxBuffLayerCount(maxBuffLayerCount)
  self._maxBuffLayerCount = maxBuffLayerCount
end

function BuffInstance:GetMaxBuffLayerCount()
  return self._maxBuffLayerCount
end

function BuffInstance:DoOverlap(buffID, context, equipIntensifyParams)
  local baseCfg = self._world:GetService("Config"):GetBuffConfigData(buffID)
  local tmpCfg = self:GetEquipIntensifiedCfg(equipIntensifyParams)
  self._buffHandler[BuffHandlerType.LoadHandler]:DoOverlap(tmpCfg.Load.logic, context)
end

function BuffInstance:BuffSeq()
  return self._buffSeq
end

function BuffInstance:BuffID()
  return self._buffID
end

function BuffInstance:BuffConfigData()
  return self._buffConfigData
end

function BuffInstance:World()
  return self._world
end

function BuffInstance:Entity()
  return self._entity
end

function BuffInstance:Context()
  return self._context
end

function BuffInstance:SetContext(context)
  self._context = context
end

function BuffInstance:GetBuffTargetEntityID()
  return self._entity:GetID()
end

function BuffInstance:GetBuffType()
  return self._buffConfigData:GetBuffType()
end

function BuffInstance:GetBuffEffectType()
  return self._buffConfigData:GetBuffEffectType()
end

function BuffInstance:GetBuffPriority()
  return self._buffConfigData:GetBuffPriority()
end

function BuffInstance:SetRelicID(relicID)
  self._relicId = relicID
end

function BuffInstance:PrintBuffInstanceLog(...)
  if self._world and self._world:IsDevelopEnv() then
    Log.debug(...)
  end
end

function BuffInstance:DoSnapShotValue(context)
  if not context then
    return
  end
  if context.casterEntity then
    local attrCmpt = context.casterEntity:Attributes()
    if attrCmpt then
      self._casterSnapAttackValue = attrCmpt:GetAttribute("Attack")
    end
  end
end

function BuffInstance:GetSnapCasterAttack()
  return self._casterSnapAttackValue
end

function BuffInstance:GetMaxCountDown()
  return self._maxCountDown
end

function BuffInstance:AddCountDown(countDown)
  local maxCountDown = self:GetMaxCountDown()
  if not maxCountDown then
    return
  end
  local old_countDown = self:GetCountDown()
  local new_countDown = countDown + old_countDown
  self:SetCountDown(new_countDown)
  local changecountDown = new_countDown - old_countDown
  return new_countDown, changecountDown
end

function BuffInstance:GetCountDown()
  local countDown = self._entity:BuffComponent():GetBuffValue(self._buffLayerName .. "CountDown") or self._maxCountDown
  return countDown
end

function BuffInstance:SetCountDown(countDown)
  local maxCountDown = self:GetMaxCountDown()
  if not maxCountDown then
    return
  end
  if countDown < 0 then
    return
  end
  self._entity:BuffComponent():SetBuffValue(self._buffLayerName .. "CountDown", countDown)
end

function BuffInstance:GetAlterLayerOnLoad()
  return self._alterLayer
end

function BuffInstance:GetChangeLayerCount()
  return self._changeLayerCount
end
