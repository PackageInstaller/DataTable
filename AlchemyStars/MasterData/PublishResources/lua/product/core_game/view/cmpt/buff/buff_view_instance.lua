_class("BuffViewInstance", Object)
BuffViewInstance = BuffViewInstance

function BuffViewInstance:Constructor(entity, seq, buffID, context)
  self._seq = seq
  self._entity = entity
  self._world = entity:GetOwnerWorld()
  local sConfig = self._world:GetService("Config")
  self._buffConfigData = sConfig:GetBuffConfigData(buffID)
  self._buffLayerName = self:ParseBuffLayerName(self._buffConfigData:GetBuffEffectType())
  self._maxBuffRoundCount = self._buffConfigData:GetData().RoundCount
  self._buffRoundCount = 0
  self._show = false
  self._unload = false
  self._buffEffectEntityID = 0
  self._buffViewDic = {}
  self._buffViewContext = context
  self._maxCountDown = self._buffConfigData:GetData().CountDown
end

function BuffViewInstance:BuffSeq()
  return self._seq
end

function BuffViewInstance:AddBuffView(notify, viewName, buffResult, triggers)
  local notifyType = notify:GetNotifyType()
  local viewProto = _G["BuffView" .. viewName]
  if viewProto then
    local views = self._buffViewDic[notifyType]
    views = views or {}
    local view = viewProto:New(self, buffResult, viewName, triggers, notify)
    views[#views + 1] = view
    if 0 < #views then
      self._buffViewDic[notifyType] = views
    end
    local detailLogger = self._world:GetDetailMatchLogger()
    detailLogger:RecordAddBuffView(view)
  end
end

function BuffViewInstance:GetBuffView(notify)
  if not notify then
    return
  end
  local notifyType = notify:GetNotifyType()
  local views = self._buffViewDic[notifyType]
  local ret = {}
  local newViews = {}
  if views then
    for i, view in ipairs(views) do
      if view:CheckNotifyAndTriggers(notify) then
        ret[#ret + 1] = view
      else
        newViews[#newViews + 1] = view
      end
    end
  end
  if #newViews == 0 then
    newViews = nil
  end
  self._buffViewDic[notifyType] = newViews
  return ret
end

function BuffViewInstance:HasBuffView()
  return next(self._buffViewDic) ~= nil
end

function BuffViewInstance:SetShow()
  self._show = true
end

function BuffViewInstance:IsShow()
  return self._show
end

function BuffViewInstance:SetUnload(notifyType)
  self._unload = true
  self._unloadNotifyType = notifyType
end

function BuffViewInstance:IsUnload(notify)
  if notify and self._unloadNotifyType then
    if self._unloadNotifyType == notify:GetNotifyType() then
      return true
    else
      return false
    end
  else
    return self._unload
  end
end

function BuffViewInstance:Entity()
  return self._entity
end

function BuffViewInstance:World()
  return self._world
end

function BuffViewInstance:BuffConfigData()
  return self._buffConfigData
end

function BuffViewInstance:BuffID()
  return self._buffConfigData:GetBuffID()
end

function BuffViewInstance:GetBuffType()
  return self._buffConfigData:GetBuffType()
end

function BuffViewInstance:GetMaterialAnimationMode()
  return self._buffConfigData:GetMaterialAnimationMode()
end

function BuffViewInstance:GetBuffEffectType()
  return self._buffConfigData:GetBuffEffectType()
end

function BuffViewInstance:GetBuffIcon()
  if not GameGlobal.GetModule(SkillPerfModule):IsBeginPerf() then
    local playBuffSvc = self._world:GetService("PlayBuff")
    return playBuffSvc:ReplaceBuffIcon(self._buffConfigData, self._entity)
  end
end

function BuffViewInstance:GetBuffName()
  local playBuffSvc = self._world:GetService("PlayBuff")
  return playBuffSvc:ReplaceBuffName(self._buffConfigData, self._entity)
end

function BuffViewInstance:GetBuffDesc()
  local playBuffSvc = self._world:GetService("PlayBuff")
  return playBuffSvc:ModifyMaxLayerCountByGlobalCfg(self._buffConfigData, self._entity)
end

function BuffViewInstance:GetBuffDescParams()
  return self._buffConfigData:GetBuffDescParams()
end

function BuffViewInstance:GetShowBuffDescParams()
  local buffDescParams = self:GetBuffDescParams()
  if not buffDescParams then
    return ""
  end
  local layer = self:GetLayerCount()
  return buffDescParams * layer
end

function BuffViewInstance:GetBuffEffectEntityID()
  return self._buffEffectEntityID
end

function BuffViewInstance:SetBuffEffectEntityID(id)
  self._buffEffectEntityID = id
end

function BuffViewInstance:GetRoundCount()
  return self._buffRoundCount
end

function BuffViewInstance:SetRoundCount(cnt)
  self._buffRoundCount = cnt
end

function BuffViewInstance:GetMaxRoundCount()
  return self._maxBuffRoundCount
end

function BuffViewInstance:SetMaxRoundCount(cnt)
  self._maxBuffRoundCount = cnt
end

function BuffViewInstance:RemainRoundCount()
  return self._maxBuffRoundCount - self._buffRoundCount
end

function BuffViewInstance:GetLayerCount()
  local layer = self._entity:BuffView():GetBuffValue(self._buffLayerName)
  return layer or 0
end

function BuffViewInstance:HasLayer()
  local layer = self._entity:BuffView():GetBuffValue(self._buffLayerName)
  return layer
end

function BuffViewInstance:SetLayerCount(TT, layer, totalLayerCount, casterEntity)
  local oldlayer = self:GetLayerCount()
  self._entity:BuffView():SetBuffValue(self._buffLayerName, layer)
  local nt = NTNotifyLayerChange:New(self._buffLayerName, layer, totalLayerCount, Vector2.zero, self._entity, self._buffConfigData:GetBuffEffectType(), casterEntity)
  nt.__oldFinalLayer = oldlayer
  self._world:GetService("PlayBuff"):PlayBuffView(TT, nt)
  if self._world:Player():IsLocalTeamEntity(self._entity) and oldlayer == 0 and 0 < layer then
    local teamBuffList = self._entity:BuffView():GetBuffTeamStateShowList()
    self._world:EventDispatcher():Dispatch(GameEventType.ChangeTeamBuff, teamBuffList)
  end
end

function BuffViewInstance:SetLayerCountByLayerName(TT, layer, layerName)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, NTNotifyLayerChange:New(layerName))
  self._entity:BuffView():SetBuffValue(layerName, layer)
end

function BuffViewInstance:ParseBuffLayerName(buffEffectType)
  return "Layer" .. buffEffectType
end

function BuffViewInstance:GetRoundCountOrLayerText()
  local layer = self:GetLayerCount()
  local buffRoundCount = self:GetRoundCount()
  if self:IsShowRestRound() then
    return self:GetRoundCountText()
  end
  if self:GetMaxCountDown() then
    return self:GetCountDownText()
  end
  if not layer or layer == 0 and buffRoundCount == 0 then
    return ""
  end
  if layer ~= 0 then
    return self:GetLayerText(true)
  else
  end
  return ""
end

function BuffViewInstance:GetRoundCountText()
  local remainRoundCount = self:RemainRoundCount()
  if remainRoundCount <= 0 then
    return ""
  end
  return StringTable.Get("str_common_round_name", remainRoundCount)
end

function BuffViewInstance:GetLayerText(extend)
  local layer = self:GetLayerCount()
  if extend then
    return StringTable.Get("str_common_layer_name", layer)
  else
    local layerOneShowNum = self:IsLayerOneShowNum()
    if not layer then
      return ""
    end
    if layer == 1 and not layerOneShowNum then
      return ""
    end
    if layer < 1 then
      return ""
    end
  end
  return layer
end

function BuffViewInstance:GetBuffViewContext()
  return self._buffViewContext
end

function BuffViewInstance:GetBuffEffectLayerAnimList()
  return self._buffConfigData:GetEffectLayerAnimList()
end

function BuffViewInstance:IsLayerOneShowNum()
  return self._buffConfigData:IsLayerOneShowNum()
end

function BuffViewInstance:IsShowRestRound()
  return self._buffConfigData:IsShowRestRound()
end

function BuffViewInstance:GetMaxCountDown()
  return self._maxCountDown
end

function BuffViewInstance:GetCountDown()
  local countDown = self._entity:BuffView():GetBuffValue(self._buffLayerName .. "CountDown") or self._maxCountDown
  return countDown
end

function BuffViewInstance:SetCountDown(countDown)
  local maxCountDown = self:GetMaxCountDown()
  if not maxCountDown then
    return
  end
  if countDown < 0 then
    return
  end
  self._entity:BuffView():SetBuffValue(self._buffLayerName .. "CountDown", countDown)
end

function BuffViewInstance:GetCountDownText()
  local curCountDown = self:GetCountDown()
  if curCountDown <= 0 then
    return ""
  end
  return StringTable.Get("str_common_count_down_name", curCountDown)
end
