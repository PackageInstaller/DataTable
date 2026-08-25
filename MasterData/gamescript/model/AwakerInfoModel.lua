local function createAwakerInfoModelState(dataSource)
  local state = {}
  
  state.dataSource = dataSource
  state.showingStrList = {}
  return state
end

local function createAwakerInfoViews()
  local views = {}
  
  function views:GetAwakerTid()
    local awakerConfig = self.dataSource:GetAwakerConfig()
    return awakerConfig.ID
  end
  
  function views:GetAwakerName()
    local awakerConfig = self.dataSource:GetAwakerConfig()
    do return LT.Text end
    return LT.Text, awakerConfig.Name
  end
  
  function views:GetAwakerTitle()
    local awakerConfig = self.dataSource:GetAwakerConfig()
    do return LT.Text end
    return LT.Text, awakerConfig.Title
  end
  
  function views:GetAwakerIcon()
    local awakerConfig = self.dataSource:GetAwakerConfig()
    local curSkin = self.dataSource:GetCurSkin()
    local littleIcon = require("Data.AwakerDataUtils").GetLittleIcon(awakerConfig.ID, true)
    if curSkin and 0 ~= curSkin then
      littleIcon = AwakerDataUtils.ReplaceSkinTidRes(littleIcon, awakerConfig.ID, curSkin)
    end
    return littleIcon
  end
  
  function views:GetSchoolName()
    local awakerConfig = self.dataSource:GetAwakerConfig()
    local schoolConfig = DT.SchoolConfig[awakerConfig.School]
    do return LT.Text end
    return LT.Text, schoolConfig.Name
  end
  
  function views:GetAwakerLevel()
    do return self.dataSource.GetAwakerLevel end
    return self.dataSource.GetAwakerLevel, self.dataSource
  end
  
  function views:IsAwakeSkillVisible()
    do return self.HasAwaked end
    return self.HasAwaked, self
  end
  
  function views:HasAwaked()
    do return self.dataSource.HasAwaked end
    return self.dataSource.HasAwaked, self.dataSource
  end
  
  function views:GetSchoolIcon()
    local awakerConfig = self.dataSource:GetAwakerConfig()
    local schoolConfig = DT.SchoolConfig[awakerConfig.School]
    return schoolConfig.Icon
  end
  
  function views:GetPVPPositionIcon()
    if not bg.isPVP then
      return
    end
    local awakerConfig = self.dataSource:GetAwakerConfig()
    if not awakerConfig then
      return
    end
    local posTid = awakerConfig.PVPPosition
    local posConfig = PVPPositionCfgUtils.GetCfg(posTid)
    return posConfig and posConfig.BattleDetailsPositionIcon
  end
  
  function views:GetProperty(propertyName)
    return self.dataSource:GetProperty(propertyName) or 0
  end
  
  function views:GetUltiSkillId()
    do return self.dataSource.GetUltiSkillId end
    return self.dataSource.GetUltiSkillId, self.dataSource
  end
  
  function views:GetUltiSkillLevel()
    do return self.dataSource.GetUltiSkillLevel end
    return self.dataSource.GetUltiSkillLevel, self.dataSource
  end
  
  function views:GetUltiSkillDesc()
    do return self.dataSource.GetUltiSkillDesc end
    return self.dataSource.GetUltiSkillDesc, self.dataSource
  end
  
  function views:GetSuperUltlSkillDesc()
    do return self.dataSource.GetSuperUltlSkillDesc end
    return self.dataSource.GetSuperUltlSkillDesc, self.dataSource
  end
  
  function views:GetUltiSkillName()
    do return self.dataSource.GetUltiSkillName end
    return self.dataSource.GetUltiSkillName, self.dataSource
  end
  
  function views:GetAwakeCardDesc()
    do return self.dataSource.GetAwakeCardDesc end
    return self.dataSource.GetAwakeCardDesc, self.dataSource
  end
  
  function views:GetAwakerCardName()
    do return self.dataSource.GetAwakerCardName end
    return self.dataSource.GetAwakerCardName, self.dataSource
  end
  
  function views:GetShowAttrIds()
    do return self.dataSource.GetShowAttrIds end
    return self.dataSource.GetShowAttrIds, self.dataSource
  end
  
  function views:GetAttrList()
    local attrList = {}
    local attrIds = self:GetShowAttrIds()
    for i, id in ipairs(attrIds) do
      local attrCfg = DT.ActorAttrType[id]
      table.insert(attrList, {
        attrName = attrCfg.Text,
        attrValue = self:GetProperty(attrCfg.Name),
        attrIcon = attrCfg.Icon,
        attrCfg = attrCfg
      })
    end
    return attrList
  end
  
  function views:GetPVPAttrList()
    local attrList = {}
    local hp = self:GetProperty(bc.RoleProperty.hp)
    local maxHp = self:GetProperty(bc.RoleProperty.max_hp)
    local attrCfg
    for _, cfg in pairs(DT.ActorAttrType) do
      if cfg.Name == bc.RoleProperty.hp then
        attrCfg = cfg
        break
      end
    end
    table.insert(attrList, {
      attrName = attrCfg.Text,
      attrValue = string.format("%s/%s", hp, maxHp),
      attrIcon = attrCfg.Icon,
      attrCfg = attrCfg
    })
    return attrList
  end
  
  function views:IsHaveWeapon(slotType)
    local weaponConfig = self.dataSource:GetWeaponConfig(slotType)
    return nil ~= weaponConfig
  end
  
  function views:GetWeaponConfig(slotType)
    do return self.dataSource.GetWeaponConfig, self.dataSource end
    return self.dataSource.GetWeaponConfig, self.dataSource, slotType
  end
  
  function views:GetWeaponName(slotType)
    local weaponConfig = self.dataSource:GetWeaponConfig(slotType)
    if nil == weaponConfig then
      return ""
    end
    do return LT.Text end
    return LT.Text, weaponConfig.Name
  end
  
  function views:GetWeaponQualityImage(slotType)
    local weaponConfig = self.dataSource:GetWeaponConfig(slotType)
    return weaponConfig and ItemDataUtils.GetQualityIcon(weaponConfig.ID)
  end
  
  function views:GetWeaponStoryDesc(slotType)
    local weaponConfig = self.dataSource:GetWeaponConfig(slotType)
    return weaponConfig and weaponConfig.StoryDesc
  end
  
  function views:GetWeaponAttrName(slotType)
    local weapon = self.dataSource:GetWeapon(slotType)
    if nil == weapon then
      return ""
    end
    do return ItemDataUtils.GetWeaponAttrName end
    return ItemDataUtils.GetWeaponAttrName, weapon.tid
  end
  
  function views:GetWeapponAttrValue(slotType)
    local weapon = self.dataSource:GetWeapon(slotType)
    if nil == weapon then
      return ""
    end
    do return ItemDataUtils.GetWeaponAttrValue end
    return ItemDataUtils.GetWeaponAttrValue, weapon.tid
  end
  
  function views:GetWeaponStateDesc(slotType)
    local weapon = self.dataSource:GetWeapon(slotType)
    if nil == weapon then
      return ""
    end
    local inBattle = false
    local SceneMgr = require("Managers.Scene.SceneMgr")
    if SceneMgr.Instance and SceneMgr.Instance:IsInCopies() or bg.battleScene then
      inBattle = true
    end
    local awakerUid = self.dataSource:GetAwakerUid()
    local stateDesc = SkillUtils.GetWeaponStateDesc(weapon.tid, weapon.level, inBattle, awakerUid)
    if not stateDesc or 0 == #stateDesc then
      do return self.GetWeaponStoryDesc, self end
      return self.GetWeaponStoryDesc, self, slotType, awakerUid
    end
    return stateDesc
  end
  
  function views:IsShowTrinket()
    local suitInfo = self:GetTrinketInfo()
    return nil ~= suitInfo
  end
  
  function views:GetTrinketInfo()
    local suitId = self:GetTrinketSuitID()
    if nil == suitId then
      return
    end
    local suitConfig = AwakerTrinketDataUtils.GetTrinketSuitConfig(suitId)
    if suitConfig then
      return {
        SuitId = suitId,
        Name = LT.Text(suitConfig.Name),
        Icon = suitConfig.Icon,
        Desc = suitConfig.SuitEffectDesc_2
      }
    end
  end
  
  function views:GetTrinketSuitID()
    local awakerConfig = self.dataSource:GetAwakerConfig()
    local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(awakerConfig.ID)
    if not awakerData then
      Logger.Warn("GetTrinketSuitID failed", awakerConfig.ID)
      return
    end
    local suitId = AwakerTrinketDataUtils.GetTrinketSuitId(awakerData)
    return suitId
  end
  
  function views:GetPvPAwakerUid()
    do return self.dataSource.GetPvPAwakerUid end
    return self.dataSource.GetPvPAwakerUid, self.dataSource
  end
  
  function views:IsUltiSkillConfuse()
    if self.dataSource.IsUltiSkillConfuse then
      do return self.dataSource.IsUltiSkillConfuse end
      return self.dataSource.IsUltiSkillConfuse, self.dataSource
    end
    return false
  end
  
  function views:GetAwakerDataModel()
    do return self.dataSource.GetAwakerDataModel end
    return self.dataSource.GetAwakerDataModel, self.dataSource
  end
  
  function views:GetKeyWordTips()
    if bg.isPVP and self.dataSource.GetPVPKeyWordTips then
      local kwTips = self.dataSource:GetPVPKeyWordTips()
      return kwTips or {}
    end
    local ultiSkillId = self.dataSource:GetUltiSkillId()
    local ultiSkillLevel = self.dataSource:GetUltiSkillLevel()
    local awakerData = self:GetAwakerDataModel()
    do return SkillUtils.GetSkillKeyWordTips, awakerData, ultiSkillId end
    return SkillUtils.GetSkillKeyWordTips, awakerData, ultiSkillId, ultiSkillLevel
  end
  
  function views:GetKeyWordEffectDescGroup()
    local tips = self:GetKeyWordTips()
    do return SkillUtils.GetKeyWordEffectDescGroup end
    return SkillUtils.GetKeyWordEffectDescGroup, tips
  end
  
  function views:GetAwakerStateDescGroup()
    local awakerTid = self:GetAwakerTid()
    local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(awakerTid)
    if not awakerData or not awakerData.uid then
      return nil
    end
    local awakerUid = awakerData.uid
    local stateList = {}
    if bg.battleScene then
      stateList = bg.battleDataCenter.stateData:GetStateListByOwner(awakerUid)
    else
      stateList = DataCenter.stateData and DataCenter.stateData.stateList or {}
    end
    if not stateList or 0 == #stateList then
      return nil
    end
    local affixStates = {}
    for _, state in ipairs(stateList) do
      local showType = StateCfgUtils.GetCfgField("ShowType", state.stateId)
      if state.ownerUid == awakerUid and showType == CommonDefine.StateShowType.AwakerAffix then
        table.insert(affixStates, state)
      end
    end
    if 0 == #affixStates then
      return nil
    end
    table.sort(affixStates, function(a, b)
      return (a.stateUid or 0) > (b.stateUid or 0)
    end)
    local descList = {}
    for _, state in ipairs(affixStates) do
      local stateDataClient = BattleStateDataClient(state, true)
      if stateDataClient and stateDataClient.configData then
        local effectDesc = {}
        if stateDataClient.configData.Icon ~= nil then
          effectDesc.icon = bc.ICON_PATH_PERFIX .. stateDataClient.configData.Icon
        end
        effectDesc.name = stateDataClient:GetBuffName()
        effectDesc.desc = stateDataClient:GetDesc()
        local layer = state.layer or 0
        effectDesc.subDesc = layer > 0 and LT.Textf("Battle_State_Layer", layer) or ""
        table.insert(descList, effectDesc)
      end
    end
    if 0 == #descList then
      return nil
    end
    return {
      name = LT.Text("StateEffectDesc"),
      descList = descList
    }
  end
  
  return views
end

local function createAwakerInfoActions(data)
  local actions = {}
  
  function actions:SetShowingStrList(tbl)
    if not tbl then
      return
    end
    data.showingStrList = tbl
  end
  
  function actions:InsertShowingStrList(str)
    if not str then
      return
    end
    table.insert(data.showingStrList, str)
  end
  
  return actions
end

local AwakerInfoModel = Vue.model("AwakerInfoModel", createAwakerInfoModelState):views(createAwakerInfoViews):actions(createAwakerInfoActions)
return AwakerInfoModel
