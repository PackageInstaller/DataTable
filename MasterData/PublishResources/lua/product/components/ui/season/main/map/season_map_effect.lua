_class("SeasonMapEffect", Object)
SeasonMapEffect = SeasonMapEffect

function SeasonMapEffect:OnInit(seasonID, bBacktrack, seasonComponnetID, compInfo)
  self._seasonID = seasonID
  self._seasonComponentID = seasonComponnetID
  self._compInfo = compInfo
  self._mapEffectCfgs = {}
  self._effObjects = {}
  self._effRenderers = {}
  self._defaultEffectName = nil
  local cfg = Cfg.cfg_season_map[seasonID]
  if cfg.DefaultSceneEffect then
    self._defaultEffectName = cfg.DefaultSceneEffect[1]
  end
  if not self._defaultEffectName then
    return
  end
  if bBacktrack then
    return
  end
  local cfgs = Cfg.cfg_component_season({
    ComponentID = self._componentID
  })
  for k, v in pairs(cfgs) do
    local missionId = v.MissionID
    local cfgMission = Cfg.cfg_season_mission[missionId]
    if self:_CheckValid(cfgMission) then
      local cfgEventPoint = Cfg.cfg_season_map_eventpoint[missionId]
      local mapEffect
      for progress = SeasonEventPointProgress.SEPP_Begin + 1, SeasonEventPointProgress.SEPP_End - 1 do
        local effNames = cfgEventPoint["SceneEffect" .. progress]
        if effNames then
          mapEffect = mapEffect or {}
          mapEffect[progress] = effNames[1]
        end
      end
      if mapEffect then
        mapEffect.missionId = missionId
        table.insert(self._mapEffectCfgs, mapEffect)
      end
    end
  end
  table.sort(self._mapEffectCfgs, function(a, b)
    return a.missionId < b.missionId
  end)
  local root = GameObjectHelper.Find("SceneRoot/AtmosphericEffect")
  if root then
    local rootTrans = root.transform
    local childCount = rootTrans.childCount
    for i = 0, childCount - 1 do
      local subTrans = rootTrans:GetChild(i)
      self._effObjects[subTrans.name] = subTrans.gameObject
      local renderers = subTrans.gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))
      local rendererList = {}
      if 0 < renderers.Length then
        for k = 0, renderers.Length - 1 do
          table.insert(rendererList, renderers[k])
        end
      end
      self._effRenderers[subTrans.name] = rendererList
    end
  end
end

function SeasonMapEffect:_CheckValid(cfgMission)
  if not cfgMission then
    return false
  end
  if not cfgMission.Mode then
    return false
  end
  if #cfgMission.Mode ~= 1 or cfgMission.Mode[1] ~= 1 then
    return false
  end
  if cfgMission.Type == 1 or cfgMission.Type == 3 then
    return true
  end
  return false
end

function SeasonMapEffect:Dispose()
  self._mapEffectCfgs = nil
end

function SeasonMapEffect:OnRefreshMapEffect()
  if not self._defaultEffectName then
    return
  end
  local stageInfo = self._compInfo.m_stage_info
  local showEffectName
  local len = #self._mapEffectCfgs
  for i = len, 1, -1 do
    local effCfg = self._mapEffectCfgs[i]
    local missionId = effCfg.missionId
    local progress = stageInfo[missionId]
    if progress then
      showEffectName = effCfg[progress]
      Log.debug("season map 前景特效 missionId " .. missionId .. "  progress .. " .. progress .. "  effName ", showEffectName)
      break
    end
  end
  showEffectName = showEffectName or self._defaultEffectName
  local lastShowEffect = self:GetCurEffect()
  for effName, effGo in pairs(self._effObjects) do
    if effName == showEffectName then
      self:_ShowEffect(effName, showEffectName ~= lastShowEffect)
    else
      self:_HideEffect(effName, showEffectName == lastShowEffect)
    end
  end
end

function SeasonMapEffect:_ShowEffect(effName, withAni)
  local go = self._effObjects[effName]
  local renderers = self._effRenderers[effName]
  if go then
    go:SetActive(true)
  end
  if renderers then
    for k, r in pairs(renderers) do
      if r.material then
        if withAni then
          r.material:DOFloat(1, "AlphaValue", 1)
        else
          r.material:SetFloat("AlphaValue", 1)
        end
      end
    end
  end
end

function SeasonMapEffect:_HideEffect(effName, withAni)
  local renderers = self._effRenderers[effName]
  if renderers then
    for k, r in pairs(renderers) do
      if r.material then
        if withAni then
          r.material:DOFloat(0, "AlphaValue", 1)
        else
          r.material:SetFloat("AlphaValue", 0)
        end
      end
    end
  end
  local go = self._effObjects[effName]
  GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(1000)
    if go and self._mapEffectCfgs then
      go:SetActive(false)
    end
  end)
end

function SeasonMapEffect:GetEffKey()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. self._seasonID .. "season_map_effect"
  return key
end

function SeasonMapEffect:GetCurEffect()
  local key = self:GetEffKey()
  local effName
  if UnityEngine.PlayerPrefs.HasKey(key) then
    effName = UnityEngine.PlayerPrefs.GetString(key)
  else
    effName = self._defaultEffectName
  end
end

function SeasonMapEffect:SetCurEffect(effName)
  local key = self:GetEffKey()
  UnityEngine.PlayerPrefs.SetString(key, effName)
end
