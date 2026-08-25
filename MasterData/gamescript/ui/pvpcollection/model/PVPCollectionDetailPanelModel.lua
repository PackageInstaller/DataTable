local PVPCollectionType = CommonDefine.PVPCollectionType

local function createPVPCollectionDetailPanelModelState(data)
  local state = {}
  
  function state.collectionTid()
    if data and data.currCollectTidFunc then
      do return end
      return data.currCollectTidFunc, nil
    end
    return 0
  end
  
  function state.SHOW_ATTR_ID()
    for tid, cfg in pairs(DT.ActorAttrType) do
      if cfg and cfg.Name == "hp" then
        return tid
      end
    end
    return nil
  end
  
  state.SHOW_SKILL_NUM = 4
  
  function state.pvpSkillTypeList()
    local collectTid = state.collectionTid
    if not collectTid or 0 == collectTid then
      return {}
    end
    local awakerTid = PvpCollectCfgUtils.GetCollectAwakerTid(collectTid)
    if not awakerTid then
      return {}
    end
    local awakerConfig = AwakerDataUtils.GetAwakerConfig(awakerTid)
    if not awakerConfig or not awakerConfig.PVPSkillList then
      return {}
    end
    local map = {}
    local list = {}
    for idx, tid in ipairs(awakerConfig.PVPSkillList) do
      local skillType = data:GetSkillType(tid)
      if skillType then
        if not map[skillType] then
          map[skillType] = {
            tid = tid,
            idx = idx,
            num = 0
          }
        end
        map[skillType].num = map[skillType].num + 1
      end
    end
    for _, skillInfo in pairs(map) do
      table.insert(list, skillInfo)
    end
    table.sort(list, function(a, b)
      return a.idx < b.idx
    end)
    return list
  end
  
  state.selectAwakerSkillTid = 0
  state.showUltiSkillDesc = false
  return state
end

local function createPVPCollectionDetailPanelModelViews(data)
  local views = {}
  
  function views:GetCollectionType(tid)
    if not tid then
      return
    end
    do return PvpCollectCfgUtils.GetCollectionType end
    return PvpCollectCfgUtils.GetCollectionType, tid
  end
  
  function views:GetSkillType(tid)
    local skillConfig = DT.Skill[tid]
    return skillConfig and skillConfig.Type and skillConfig.Type[1]
  end
  
  function views:GetAwakerAttrIcon()
    if not data.SHOW_ATTR_ID then
      return
    end
    local config = DT.ActorAttrType[data.SHOW_ATTR_ID]
    return config and config.Icon
  end
  
  function views:GetAwakerAttrName()
    if not data.SHOW_ATTR_ID then
      return
    end
    local config = DT.ActorAttrType[data.SHOW_ATTR_ID]
    return config and LT.Text(config.Text)
  end
  
  function views:GetAwakerAttrValue()
    do return PvpCollectCfgUtils.GetCollectAwakerHp end
    return PvpCollectCfgUtils.GetCollectAwakerHp, data.collectionTid
  end
  
  function views:GetAwakerPVPUltiSkillTid()
    do return PvpCollectCfgUtils.GetCollectAwakerUltiSkillTid end
    return PvpCollectCfgUtils.GetCollectAwakerUltiSkillTid, data.collectionTid
  end
  
  function views:GetAwakerUltiSkillName()
    local skillTid = data:GetAwakerPVPUltiSkillTid()
    if not skillTid then
      return
    end
    local skillConfig = DT.Skill[skillTid]
    do return BattleSkillUtils.GetSkillName, skillConfig, 0 end
    return BattleSkillUtils.GetSkillName, skillConfig, 0, 0
  end
  
  function views:GetAwakerUltiSkillDesc()
    local skillTid = data:GetAwakerPVPUltiSkillTid()
    if not skillTid then
      return
    end
    local awakerTid = PvpCollectCfgUtils.GetCollectAwakerTid(data.collectionTid)
    if not awakerTid then
      return
    end
    local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
    if not awakerData then
      return
    end
    do return SkillUtils.GetAwakerSkillDesc, awakerData, skillTid end
    return SkillUtils.GetAwakerSkillDesc, awakerData, skillTid, 1
  end
  
  function views:GetSkillTypeInfoList(collectionTid)
    do return PvpCollectCfgUtils.GetCollectAwakerSkillInfoList end
    return PvpCollectCfgUtils.GetCollectAwakerSkillInfoList, collectionTid
  end
  
  function views:GetCollectionCost()
    local collectionTid = data.collectionTid
    local collectionType = self:GetCollectionType(collectionTid)
    if not collectionType or collectionType == PVPCollectionType.Awaker then
      return
    end
    local config = PvpCollectCfgUtils.GetCfg(collectionTid)
    local itemConfig = ItemDataUtils.GetItemConfig(config.Item)
    local skillTid = itemConfig.PVPSkill[1]
    local skillConfig = DT.Skill[skillTid]
    return skillConfig.Cost or 0
  end
  
  function views:GetWeaponOrKeeperSkillDesc()
    local collectionTid = data.collectionTid
    local config = PvpCollectCfgUtils.GetCfg(collectionTid)
    local itemCfg = ItemDataUtils.GetItemConfig(config.Item)
    if not (itemCfg and itemCfg.PVPSkill) or not itemCfg.PVPSkill[1] then
      return
    end
    local skillTid = itemCfg.PVPSkill[1]
    do return SkillUtils.GetAwakerSkillDesc, {}, skillTid end
    return SkillUtils.GetAwakerSkillDesc, {}, skillTid, 1
  end
  
  function views:GetWeaponOrKeeperSkillStory()
    local collectionTid = data.collectionTid
    local collectionType = self:GetCollectionType(collectionTid)
    if not collectionType or collectionType == PVPCollectionType.Awaker then
      return
    end
    local config = PvpCollectCfgUtils.GetCfg(collectionTid)
    local itemConfig = ItemDataUtils.GetItemConfig(config.Item)
    return itemConfig and itemConfig.StoryDesc and LT.Text(itemConfig.StoryDesc)
  end
  
  return views
end

local function createPVPCollectionDetailPanelModelActions(data)
  local actions = {}
  
  function actions:SetAwakerCollectionSelectedSkill(skillTid)
    skillTid = skillTid or 0
    data.selectAwakerSkillTid = skillTid
  end
  
  function actions:SetUltiSkillDescShow(show)
    if nil == show then
      show = false
    end
    data.showUltiSkillDesc = show
  end
  
  return actions
end

local function onSetup(_, _)
end

local PVPCollectionDetailPanelModel = Vue.model("PVPCollectionDetailPanelModel", createPVPCollectionDetailPanelModelState):views(createPVPCollectionDetailPanelModelViews):actions(createPVPCollectionDetailPanelModelActions):setup(onSetup)
return PVPCollectionDetailPanelModel
