_class("BuffConfigData", Object)
BuffConfigData = BuffConfigData

function BuffConfigData:Constructor(buffID)
  self._cfg = Cfg.cfg_buff[buffID]
  if not self._cfg then
    Log.exception(self._className, "buff config is nil buff id=", buffID)
  end
end

function BuffConfigData:GetCacheTable()
  local viewParams = self._cfg.ViewParams
  local t = {}
  if viewParams then
    if viewParams.LoadEffectID then
      table.insert(t, {
        Cfg.cfg_effect[viewParams.LoadEffectID].ResPath,
        1
      })
    end
    if viewParams.ExecEffectID then
      table.insert(t, {
        Cfg.cfg_effect[viewParams.ExecEffectID].ResPath,
        1
      })
    end
    if viewParams.UnloadEffectID then
      table.insert(t, {
        Cfg.cfg_effect[viewParams.UnloadEffectID].ResPath,
        1
      })
    end
    if viewParams.CacheEffectIDList then
      for index, effectID in ipairs(viewParams.CacheEffectIDList) do
        table.insert(t, {
          Cfg.cfg_effect[effectID].ResPath,
          1
        })
      end
    end
  end
  return t
end

function BuffConfigData:GetSoundCacheTable()
end

function BuffConfigData:GetCacheSkillIds()
  local skillIds = {}
  local Logics = {
    self._cfg.LoadLogic,
    self._cfg.ActiveLogic,
    self._cfg.DeactiveLogic,
    self._cfg.ExecLogic,
    self._cfg.UnloadLogic
  }
  for i, logics in pairs(Logics) do
    for _, logic in pairs(logics) do
      if logic.logic == "CastSkill" then
        table.insert(skillIds, logic.skillID)
      end
      if logic.logic == "ChangePetChainSkill" then
        if logic.type == 1 and logic.skillId then
          table.insert(skillIds, logic.logic.skillId)
        elseif logic.type == 2 and logic.param then
          for sourceID, newID in pairs(logic.param) do
            table.insert(skillIds, newID)
          end
        end
      end
    end
  end
  return skillIds
end

function BuffConfigData:GetCacheBuffIds()
  local buffIds = {}
  local Logics = {
    self._cfg.LoadLogic,
    self._cfg.ActiveLogic,
    self._cfg.DeactiveLogic,
    self._cfg.ExecLogic,
    self._cfg.UnloadLogic
  }
  for i, logics in ipairs(Logics) do
    for _, logic in ipairs(logics) do
      if logic.logic == "AddBuff" then
        table.insert(buffIds, logic.buffID)
      end
    end
  end
  return buffIds
end

function BuffConfigData:GetBuffID()
  return self._cfg.ID
end

function BuffConfigData:GetLoadLogic()
  return self._cfg.LoadLogic
end

function BuffConfigData:GetActiveLogic()
  return self._cfg.ActiveLogic
end

function BuffConfigData:GetDeactiveLogic()
  return self._cfg.DeactiveLogic
end

function BuffConfigData:GetExecLogic()
  return self._cfg.ExecLogic
end

function BuffConfigData:GetUnloadLogic()
  return self._cfg.UnloadLogic
end

function BuffConfigData:GetData()
  return self._cfg
end

function BuffConfigData:GetBuffIcon()
  return self._cfg.Icon
end

function BuffConfigData:GetBuffEffectType()
  return self._cfg.BuffEffectType
end

function BuffConfigData:GetBuffName()
  return self._cfg.Name
end

function BuffConfigData:GetBuffDesc()
  return self._cfg.Desc
end

function BuffConfigData:GetBuffDescParams()
  return self._cfg.DescParams
end

function BuffConfigData:GetBuffType()
  return self._cfg.BuffType
end

function BuffConfigData:GetBuffPriority()
  return self._cfg.Priority
end

function BuffConfigData:IsDebuff()
  return self._cfg.IsDebuff
end

function BuffConfigData:GetBuffShowBuffIcon()
  return self._cfg.ShowBuffIcon
end

function BuffConfigData:GetBuffShowTeamState()
  return self._cfg.ShowTeamState
end

function BuffConfigData:GetViewParams()
  return self._cfg.ViewParams
end

function BuffConfigData:GetLoadEffectID()
  if self._cfg.ViewParams then
    return self._cfg.ViewParams.LoadEffectID
  end
end

function BuffConfigData:GetEffectLayerAnimList()
  if self._cfg.ViewParams then
    return self._cfg.ViewParams.EffectLayerAnimList
  end
end

function BuffConfigData:GetUnloadEffectID()
  if self._cfg.ViewParams then
    return self._cfg.ViewParams.UnloadEffectID
  end
end

function BuffConfigData:GetExecEffectID()
  if self._cfg.ViewParams then
    return self._cfg.ViewParams.ExecEffectID
  end
end

function BuffConfigData:GetMaterialAnimation()
  if self._cfg.ViewParams then
    return self._cfg.ViewParams.MaterialAnim
  end
end

function BuffConfigData:GetMaterialAnimationMode()
  return self._cfg.MaterialAnimationMode or BuffMaterialAnimationMode.Normal
end

function BuffConfigData:IsLayerOneShowNum()
  if self._cfg.ViewParams then
    return self._cfg.ViewParams.LayerOneShowNum and self._cfg.ViewParams.LayerOneShowNum == 1
  end
end

function BuffConfigData:GetMaxLayerCount()
  return self._cfg.LayerCount
end

function BuffConfigData:IsShowRestRound()
  if self._cfg.ViewParams then
    return self._cfg.ViewParams.ShowRestRound and self._cfg.ViewParams.ShowRestRound == 1
  end
end
