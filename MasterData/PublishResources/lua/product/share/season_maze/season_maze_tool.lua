_class("SeasonMazeTool", Singleton)
SeasonMazeTool = SeasonMazeTool

function SeasonMazeTool:Constructor()
  self._id_position = UnityEngine.Shader.PropertyToID("_PlaneShadowPosition")
  self._id_normal = UnityEngine.Shader.PropertyToID("_PlaneShadowNormal")
end

function SeasonMazeTool:GetV4ByZoneMask()
  return Vector4(1, 1, 1, 1)
end

function SeasonMazeTool:GetZonesByZoneMask(zoneMask)
  return {
    1,
    2,
    3,
    4
  }
end

function SeasonMazeTool:SetMaterialProperty(shadowPlane, renderers, materialPropertyBlock)
  if shadowPlane ~= nil and materialPropertyBlock then
    local v4_position = Vector4(shadowPlane.position.x, shadowPlane.position.y, shadowPlane.position.z, 0)
    local v4_normal = Vector4(shadowPlane.up.normalized.x, shadowPlane.up.normalized.y, shadowPlane.up.normalized.z, 0)
    if 0 < renderers.Length then
      for i = 0, renderers.Length - 1 do
        local render = renderers[i]
        if 0 < render.materials.Length then
          for j = 0, render.materials.Length - 1 do
            materialPropertyBlock:Clear()
            render:GetPropertyBlock(materialPropertyBlock, j)
            materialPropertyBlock:SetVector(self._id_position, v4_position)
            materialPropertyBlock:SetVector(self._id_normal, v4_normal)
            render:SetPropertyBlock(materialPropertyBlock, j)
          end
        end
      end
    end
  end
end

function SeasonMazeTool:DisenableMeshRender(gameObject)
  if gameObject then
    local shadowRenderers = gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))
    if shadowRenderers.Length > 0 then
      for i = 0, shadowRenderers.Length - 1 do
        local render = shadowRenderers[i]
        render.enabled = false
      end
    end
  end
end

function SeasonMazeTool:SetLocalDBFloat(key, value)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  if campaignModule and not campaignModule:IsDisposed() then
    local pstid = GameGlobal.GetModule(LoginModule):GetRoleShowID()
    LocalDB.SetFloat(pstid .. 8001 .. key, value)
  end
end

function SeasonMazeTool:GetLocalDBFloat(key, defaultValue)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  if campaignModule and not campaignModule:IsDisposed() then
    local pstid = GameGlobal.GetModule(LoginModule):GetRoleShowID()
    return LocalDB.GetFloat(pstid .. 8001 .. key, defaultValue)
  end
  return defaultValue
end

function SeasonMazeTool:TryAddCover(parent, cover)
  if parent and cover then
    local coverManager = GameGlobal.GetUIModule(SeasonMazeModule):SeasonMazeManager():SeasonMazeCoverManager()
    local rawName = string.sub(cover.name, 1, string.len(cover.name) - string.len(coverManager:CoverFlag()))
    if rawName then
      if parent.name == rawName then
        coverManager:AddCover(parent, cover)
      else
        local rawTransform = parent:Find(rawName)
        if rawTransform then
          coverManager:AddCover(rawTransform, cover)
        else
          Log.warn("SeasonMazeTool TryAddCover error.", cover.name)
        end
      end
    end
  end
end

function SeasonMazeTool:TryClearCover(parent, cover)
  if parent and cover then
    local coverManager = GameGlobal.GetUIModule(SeasonMazeModule):SeasonMazeManager():SeasonMazeCoverManager()
    local rawName = string.sub(cover.name, 1, string.len(cover.name) - string.len(coverManager:CoverFlag()))
    if rawName then
      if parent.name == rawName then
        coverManager:ClearCover(parent)
      else
        local rawTransform = parent:Find(rawName)
        if rawTransform then
          coverManager:ClearCover(rawTransform)
          coverManager:AddCover(rawTransform, cover)
        end
      end
    end
  end
end

function SeasonMazeTool:GetItemController(data, ...)
  if data then
    local rewards = {}
    for _, _effect in ipairs(data) do
      if _effect.type == SeasonMazeEffectType.SMET_Pro then
        local cfg = Cfg.cfg_season_maze_attribute[_effect.id]
        if cfg then
          local reward = {}
          reward.isSeasonMazeAtt = true
          reward.name = cfg.Name
          reward.quality = cfg.Quality
          reward.icon = cfg.ItemIcon
          reward.desc = cfg.Desc
          reward.count = _effect.value_min
          reward.effectType = _effect.type
          reward.attType = _effect.id
          table.insert(rewards, reward)
        end
      elseif _effect.type == SeasonMazeEffectType.SMET_Bead then
        local cfg = Cfg.cfg_component_season_maze_autobead[_effect.id]
        if cfg then
          local reward = {}
          reward.isSeasonMazeAtt = true
          reward.name = cfg.Name
          reward.quality = cfg.Quality
          reward.icon = cfg.Icon
          reward.desc = cfg.Desc
          reward.count = _effect.value_min
          reward.effectType = _effect.type
          reward.attType = _effect.id
          table.insert(rewards, reward)
        end
      else
        local cfg = Cfg.cfg_item[_effect.id]
        if cfg then
          local reward = {}
          reward.isSeasonMazeAtt = true
          reward.name = cfg.Name
          reward.quality = cfg.Color
          reward.icon = cfg.Icon
          reward.desc = cfg.RpIntro
          reward.count = _effect.value_min
          reward.effectType = _effect.type
          reward.attType = _effect.id
          table.insert(rewards, reward)
        end
      end
    end
    GameGlobal.UIStateManager():ShowDialog("UIGetItemController", rewards, ...)
  end
end

function SeasonMazeTool:ShowUIGetRewards(data)
  if not data then
    return
  end
  local itemList = {}
  local petIds = {}
  local relicIds = {}
  local beadIds = {}
  for _, value in ipairs(data) do
    local rewardEffect = value
    if rewardEffect.type == SeasonMazeEffectType.SMET_Bead then
      table.insert(beadIds, rewardEffect.id)
    elseif rewardEffect.type == SeasonMazeEffectType.SMET_Pro then
      local cfg = Cfg.cfg_season_maze_attribute[rewardEffect.id]
      if cfg and cfg.ItemIcon then
        local reward = {}
        reward.isSeasonMazeAtt = true
        reward.seasonMazeSortValue = 1
        local attrType = rewardEffect.id
        if attrType == SeasonMazeAttrType.SMAT_Gold then
          reward.seasonMazeSortValue = 10
        elseif attrType == SeasonMazeAttrType.SMAT_Exp then
          reward.seasonMazeSortValue = 9
        elseif attrType == SeasonMazeAttrType.SMAT_Gold_Round_Add then
          reward.seasonMazeSortValue = 6
        elseif attrType == SeasonMazeAttrType.SMAT_Ms then
          reward.seasonMazeSortValue = 5
        end
        reward.name = cfg.Name
        reward.quality = cfg.Quality
        reward.icon = cfg.ItemIcon
        reward.desc = cfg.Desc
        reward.count = rewardEffect.value_min
        reward.effectType = rewardEffect.type
        reward.attType = rewardEffect.id
        table.insert(itemList, reward)
      end
    elseif rewardEffect.type == SeasonMazeEffectType.SMET_Relic then
      table.insert(relicIds, rewardEffect.id)
    elseif rewardEffect.type == SeasonMazeEffectType.SMET_Pet then
      table.insert(petIds, rewardEffect.id)
    elseif rewardEffect.type == SeasonMazeEffectType.SMET_GetRandomPet then
      if rewardEffect.value_min > 0 then
        table.insert(petIds, rewardEffect.value_min)
      end
    elseif rewardEffect.type == SeasonMazeEffectType.SMET_Once then
      local cfgGroup = Cfg.cfg_component_season_maze_once({
        OnceID = rewardEffect.id
      })
      local cfg
      if cfgGroup and 0 < #cfgGroup then
        cfg = cfgGroup[1]
      end
      if cfg then
        local reward = {}
        reward.isSeasonMazeAtt = true
        reward.seasonMazeSortValue = 7
        reward.name = cfg.Name
        reward.quality = 1
        reward.icon = cfg.Icon
        reward.desc = cfg.Desc
        reward.count = rewardEffect.value_min
        reward.effectType = rewardEffect.type
        reward.attType = rewardEffect.id
        table.insert(itemList, reward)
      end
    elseif rewardEffect.type == SeasonMazeEffectType.SMET_Hand then
    else
      local cfg = Cfg.cfg_item[rewardEffect.id]
      if cfg then
        local reward = {}
        reward.isSeasonMazeAtt = true
        reward.seasonMazeSortValue = 1
        reward.name = cfg.Name
        reward.quality = cfg.Color
        reward.icon = cfg.Icon
        reward.desc = cfg.RpIntro
        reward.count = rewardEffect.value_min
        reward.effectType = rewardEffect.type
        reward.attType = rewardEffect.id
        table.insert(itemList, reward)
      end
    end
  end
  table.sort(itemList, function(a, b)
    return a.seasonMazeSortValue > b.seasonMazeSortValue
  end)
  SeasonMazeTool:GetInstance():ShowUIGetRewards_Pet(petIds, relicIds, beadIds, itemList)
end

function SeasonMazeTool:ShowUIGetRewards_Pet(petIds, relicIds, beadIds, itemList)
  if table.count(petIds) <= 0 then
    SeasonMazeTool:GetInstance():ShowUIGetRewards_Relic(relicIds, beadIds, itemList)
    return
  end
  local index = 0
  
  local function showNextFunc()
    index = index + 1
    if index <= #petIds then
      return petIds[index]
    end
    return nil
  end
  
  local callBackFunc
  
  function callBackFunc()
    GameGlobal.UIStateManager():CloseDialog("UISeasonMazePetRewards")
    local nextAsset = showNextFunc()
    if nextAsset then
      SeasonMazeTool:GetInstance():ShowUIGetRewards_Pet_Single(nextAsset, callBackFunc)
    else
      SeasonMazeTool:GetInstance():ShowUIGetRewards_Relic(relicIds, beadIds, itemList)
    end
  end
  
  SeasonMazeTool:GetInstance():ShowUIGetRewards_Pet_Single(showNextFunc(), callBackFunc)
end

function SeasonMazeTool:ShowUIGetRewards_Pet_Single(petId, callBackFunc)
  if not petId then
    if callBackFunc then
      callBackFunc()
    end
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UISeasonMazePetRewards", {petId}, callBackFunc)
end

function SeasonMazeTool:ShowUIGetRewards_Relic(relicIds, beadIds, itemList)
  if table.count(relicIds) <= 0 then
    SeasonMazeTool:GetInstance():ShowUIGetRewards_Bead(beadIds, itemList)
    return
  end
  local index = 0
  
  local function showNextFunc()
    index = index + 1
    if index <= #relicIds then
      return relicIds[index]
    end
    return nil
  end
  
  local callBackFunc
  
  function callBackFunc()
    GameGlobal.UIStateManager():CloseDialog("UISeasonMazeRelicRewards")
    local nextAsset = showNextFunc()
    if nextAsset then
      SeasonMazeTool:GetInstance():ShowUIGetRewards_Relic_Single(nextAsset, callBackFunc)
    else
      SeasonMazeTool:GetInstance():ShowUIGetRewards_Bead(beadIds, itemList)
    end
  end
  
  SeasonMazeTool:GetInstance():ShowUIGetRewards_Relic_Single(showNextFunc(), callBackFunc)
end

function SeasonMazeTool:ShowUIGetRewards_Relic_Single(relicId, callBackFunc)
  if not relicId then
    if callBackFunc then
      callBackFunc()
    end
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UISeasonMazeRelicRewards", {relicId}, callBackFunc)
end

function SeasonMazeTool:ShowUIGetRewards_Bead(beadIds, itemList)
  if table.count(beadIds) <= 0 then
    SeasonMazeTool:GetInstance():ShowUIGetRewards_Item(itemList)
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UISeasonMazeBeadRewards", beadIds, function()
    GameGlobal.UIStateManager():CloseDialog("UISeasonMazeBeadRewards")
    SeasonMazeTool:GetInstance():ShowUIGetRewards_Item(itemList)
  end)
  return
end

function SeasonMazeTool:ShowUIGetRewards_Item(itemList)
  if table.count(itemList) <= 0 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSeasonMazeShowRewardsFinish, 1)
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIGetItemController", itemList, function()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSeasonMazeShowRewardsFinish, 1)
  end)
end

function SeasonMazeTool:Effect2Asset(effect, count)
  local type = effect.type
  count = count or effect.value_min
  if type == SeasonMazeEffectType.SMET_Pro then
    local attrID = effect.id
    local awardCfg = Cfg.cfg_season_maze_attribute[attrID]
    return SeasonMazeAsset:New(type, awardCfg.Name, count, awardCfg.Icon, awardCfg.Desc, attrID)
  elseif type == SeasonMazeEffectType.SMET_Bead_LV then
    return SeasonMazeAsset:New(SeasonMazeEffectType.SMET_Bead, nil, count, nil, nil, effect.id)
  elseif type == SeasonMazeEffectType.SMET_Bead then
    local cfg = Cfg.cfg_component_season_maze_autobead[effect.id]
    return SeasonMazeAsset:New(type, cfg.Name, count, cfg.Desc, cfg.Icon, effect.id)
  elseif type == SeasonMazeEffectType.SMET_Relic then
    local relicCfg = Cfg.cfg_item[effect.id]
    return SeasonMazeAsset:New(type, relicCfg.Name, count, relicCfg.Icon, relicCfg.Intro, effect.id)
  elseif type == SeasonMazeEffectType.SMET_Hand then
    local name = "str_season_maze_bag_active_card_title"
    return SeasonMazeAsset:New(type, name, count, nil, nil, effect.id)
  elseif type == SeasonMazeEffectType.SMET_Once_Shoe or type == SeasonMazeEffectType.SMET_Once_Sprint or type == SeasonMazeEffectType.SMET_Once_Retrun or type == SeasonMazeEffectType.SMET_Once_Bomb then
    local propCfg = Cfg.cfg_component_season_maze_once({
      OnceID = effect.id
    })[1]
    return SeasonMazeAsset:New(type, propCfg.Name, count, propCfg.Icon, propCfg.Desc, effect.id)
  elseif type == SeasonMazeEffectType.SMET_HandStepRaiseReward then
    local attrID = SeasonMazeAttrType.SMAT_Gold_Round_Add
    local awardCfg = Cfg.cfg_season_maze_attribute[attrID]
    return SeasonMazeAsset:New(SeasonMazeEffectType.SMET_Pro, awardCfg.Name, count, awardCfg.Icon, awardCfg.Desc, attrID)
  else
    Log.error("不支持的效果类型:", type, effect.id)
  end
end

function SeasonMazeTool:GetEffectObject(effectID, returnList)
  local cfgs = Cfg.cfg_component_season_maze_effect({ID = effectID})
  if cfgs and 0 < #cfgs then
    local cfg = cfgs[1]
    local effects = cfg.EffectList
    for i = 1, #effects do
      local obj = SeasonMazeEffect:New()
      obj.type = effects[i][1]
      obj.id = effects[i][2]
      obj.value_min = effects[i][3]
      obj.value_max = effects[i][4]
      table.insert(returnList, obj)
    end
  else
    Log.exception("Can not find effectID in cfg_component_season_maze_effect --->", effectID)
  end
end

function SeasonMazeTool:SortAsset(assets)
  table.sort(assets, function(a, b)
    local weight_a = 100
    local weight_b = 100
    if a._type == SeasonMazeEffectType.SMET_Pro then
      if a._subParam == SeasonMazeAttrType.SMAT_Gold then
        weight_a = 3
      elseif a._subParam == SeasonMazeAttrType.SMAT_Exp then
        weight_a = 4
      elseif a._subParam == SeasonMazeAttrType.SMAT_Ms then
        weight_a = 8
      elseif a._subParam == SeasonMazeAttrType.SMAT_Gold_Round_Add then
        weight_a = 7
      end
    elseif a._type == SeasonMazeEffectType.SMET_Bead then
      weight_a = 2
    elseif a._type == SeasonMazeEffectType.SMET_Relic then
      weight_a = 1
    elseif a._type == SeasonMazeEffectType.SMET_Hand then
      weight_a = 5
    elseif a._type == SeasonMazeEffectType.SMET_Once then
      weight_a = 6
    end
    if b._type == SeasonMazeEffectType.SMET_Pro then
      if b._subParam == SeasonMazeAttrType.SMAT_Gold then
        weight_b = 3
      elseif b._subParam == SeasonMazeAttrType.SMAT_Exp then
        weight_b = 4
      elseif b._subParam == SeasonMazeAttrType.SMAT_Ms then
        weight_b = 8
      elseif b._subParam == SeasonMazeAttrType.SMAT_Gold_Round_Add then
        weight_b = 7
      end
    elseif b._type == SeasonMazeEffectType.SMET_Bead then
      weight_b = 2
    elseif b._type == SeasonMazeEffectType.SMET_Relic then
      weight_b = 1
    elseif b._type == SeasonMazeEffectType.SMET_Hand then
      weight_b = 5
    elseif b._type == SeasonMazeEffectType.SMET_Once then
      weight_b = 6
    end
    if weight_a == weight_b then
      return a._subParam < b._subParam
    end
    return weight_a < weight_b
  end)
end

function SeasonMazeTool:GetBeadTypeImg(beadType)
  if beadType == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Skill then
    return "thread_junei_zdz01"
  elseif beadType == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Strong then
    return "thread_junei_zdz02"
  elseif beadType == ESeasonMazeAutoBeadType.ESeasonMazeAutoBeadType_Energy then
    return "thread_junei_zdz03"
  end
end

function SeasonMazeTool:GetHeadBg(id)
  local cfg = Cfg.cfg_player_head_bg[id]
  cfg = cfg or Cfg.cfg_player_head_bg[1]
  return cfg.Icon
end

function SeasonMazeTool:GetHeadFrame(id)
  local cfg = Cfg.cfg_item_headframe[id]
  if not cfg then
    local id = HelperProxy:GetInstance():GetHeadFrameDefaultID()
    cfg = Cfg.cfg_item_headframe[id]
  end
  return cfg.Icon
end

function SeasonMazeTool:Efts2Assets(efts)
  if not efts or #efts == 0 then
    return {}
  end
  local assets = {}
  for _, eft in ipairs(efts) do
    local asset = self:Effect2Asset(eft)
    if asset then
      if assets[asset:Type()] then
        if assets[asset:Type()][asset:SubParam()] then
          local tmp = assets[asset:Type()][asset:SubParam()]
          tmp._count = tmp._count + asset:Count()
        else
          assets[asset:Type()][asset:SubParam()] = asset
        end
      else
        assets[asset:Type()] = {
          [asset:SubParam()] = asset
        }
      end
    end
  end
  local results = {}
  for type, tb in pairs(assets) do
    for subType, asset in pairs(tb) do
      if asset:Count() ~= 0 then
        table.insert(results, asset)
      end
    end
  end
  self:SortAsset(results)
  return results
end

function SeasonMazeTool:GetCardDesc(cfg_id)
  local stepDes, eftDes, extraDes
  local cfg = Cfg.cfg_component_season_maze_hand[cfg_id]
  if cfg.CopyLast == 1 then
    stepDes = nil
  else
    local min, max = cfg.Steps[1], cfg.Steps[2]
    if min == max then
      stepDes = StringTable.Get("str_season_maze_card_step_des_1", min)
    else
      stepDes = StringTable.Get("str_season_maze_card_step_des_2", min, max)
    end
  end
  if not cfg.EffectIDs or not next(cfg.EffectIDs) then
    eftDes = nil
  else
    local eftID = cfg.EffectIDs[1]
    local eftCfg = Cfg.cfg_component_season_maze_effect[eftID]
    local eft = eftCfg.EffectList[1]
    local eftType = eft[1]
    if eftType == SeasonMazeEffectType.SMET_Pro then
      local attrID = eft[2]
      local awardCfg = Cfg.cfg_season_maze_attribute[attrID]
      local name = StringTable.Get(awardCfg.Name)
      local count = eft[3]
      eftDes = StringTable.Get(cfg.Desc, name, count)
    elseif eftType == SeasonMazeEffectType.SMET_Bead_LV then
      local count = eft[3]
      eftDes = StringTable.Get(cfg.Desc, StringTable.Get("str_season_maze_bead"), count)
    elseif eftType == SeasonMazeEffectType.SMET_Once then
      local propID = eft[2]
      local propCfg = Cfg.cfg_component_season_maze_once[propID]
      local name = StringTable.Get(propCfg.Name)
      local count = eft[3]
      eftDes = StringTable.Get(cfg.Desc, name, count)
    elseif eftType == SeasonMazeEffectType.SMET_HandStepRaiseReward then
      eftDes = StringTable.Get(cfg.Desc)
    else
      eftDes = nil
    end
  end
  if cfg.CopyLast == 1 then
    extraDes = StringTable.Get(cfg.Desc)
  end
  return stepDes, eftDes, extraDes
end

function SeasonMazeTool:TryMergeBeadEft(efts)
  if not efts or #efts <= 0 then
    return false
  end
  local count = 0
  for _, eft in ipairs(efts) do
    if eft.type ~= SeasonMazeEffectType.SMET_Bead_LV and eft.type ~= SeasonMazeEffectType.SMET_Bead then
      return false
    end
    count = count + eft.value_min
  end
  local result = SeasonMazeEffect:New()
  result.type = SeasonMazeEffectType.SMET_Bead
  result.id = efts[1].id
  result.value_min = count
  result.value_max = count
  return true, result
end
