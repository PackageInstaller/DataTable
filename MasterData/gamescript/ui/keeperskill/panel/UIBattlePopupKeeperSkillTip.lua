local BP = bc.BattleProperty
local UIBattlePopupKeeperSkillTip, Super = System.NewClass("UIBattlePopupKeeperSkillTip", UIBasePanel)
UIBattlePopupKeeperSkillTip.uiResCls = UI_Battle_Popup_Keeper_Skill_TipResource

function UIBattlePopupKeeperSkillTip:ctor(roleInfo)
  Super.ctor(self)
  self.roleInfo = roleInfo
end

function UIBattlePopupKeeperSkillTip:OnBind(binder)
  self.binder = binder
  self.binder:BindButtonClick(self.ui.Mask, System.fn(self, self.Close))
  self.binder:BindButtonClick(self.ui.Closure_Mask, System.fn(self, self.Close))
  self:BindRole()
  self:BindKeeperSkill()
  self:BindKeyWords()
  self:BindReviveItem()
  self:BindSomeAwakerAttrs()
  local oldPos = self.ui.uiNode.transform.localPosition
  self.ui.uiNode.transform.localPosition = CS.UnityEngine.Vector3(9999, 9999, 9999)
  FrameWaiter.OnNextFrame(function()
    if self.ui then
      self.ui.uiNode.transform.localPosition = oldPos
    end
  end, 3)
end

function UIBattlePopupKeeperSkillTip:BindRole()
  self.binder:BindToImage(self.ui.Icon_Awaker, function()
    do return GenderDataUtils.GetBattleMainHeadRes end
    return GenderDataUtils.GetBattleMainHeadRes, self.roleInfo.gender
  end)
  self.binder:BindToText(self.ui.Text_Awaker_Name, function()
    return self.roleInfo.name
  end)
end

function UIBattlePopupKeeperSkillTip:_GetKeeperSkillArgs()
  if self.roleInfo.GetKeeperSkillArgs then
    do return end
    return self.roleInfo.GetKeeperSkillArgs
  end
  return self.roleInfo.keeperSkillArgs
end

function UIBattlePopupKeeperSkillTip:BindKeeperSkill()
  self.binder:BindToImage(self.ui.Image_Icon, function()
    do return KeeperSkillUtils.GetSkillIcon, self.roleInfo.GetKeeperSkillId() end
    return KeeperSkillUtils.GetSkillIcon, self.roleInfo.GetKeeperSkillId()
  end)
  self.binder:BindToText(self.ui.Text_Skill_Name, function()
    do return KeeperSkillUtils.GetSkillName, self.roleInfo.GetKeeperSkillId() end
    return KeeperSkillUtils.GetSkillName, self.roleInfo.GetKeeperSkillId()
  end)
  self.binder:BindToText(self.ui.Text_Skill_Desc, function()
    do return KeeperSkillUtils.GetKeeperSkillDesc, self.roleInfo.GetKeeperSkillId(), self:_GetKeeperSkillArgs() end
    return KeeperSkillUtils.GetKeeperSkillDesc, self.roleInfo.GetKeeperSkillId(), self:_GetKeeperSkillArgs()
  end, nil, nil, {banKeywordBtn = true})
  self.binder:BindToText(self.ui.Text_Maniac, function()
    do return self.GetSkillManiacDesc end
    return self.GetSkillManiacDesc, self
  end)
  self.ui.Text_Maniac:SetActive(Utils.IsLangChinese())
  self.binder:SetText(self.ui.Text_Skill2_EN, LT.Textf("KeeperSkillEnergy", ""))
  self.binder:BindToText(self.ui.Text_Maniac_EN, function()
    do return self.GetSkillManiacDesc end
    return self.GetSkillManiacDesc, self
  end)
  self.ui.Text_Skill2_EN:SetActive(not Utils.IsLangChinese())
end

function UIBattlePopupKeeperSkillTip:GetSkillManiacDesc()
  local num = 0
  if bg and bg.battleRender then
    local property = bc.RoleProperty.keeper_energy
    num = bg.battleDataCenter:GetPlayerRoleProperty(property)
  else
    num = CopyAwakerDataUtils.GetAwakerAttrs(0, "keeper_energy") or 0
  end
  local keeper_energy_cost_per = 0
  local max_keeper_energy = 0
  if bg.battleDataCenter then
    keeper_energy_cost_per = bg.battleDataCenter:GetPlayerRoleProperty(bc.RoleProperty.keeper_energy_cost_per) or 0
    max_keeper_energy = bg.battleDataCenter:GetPlayerRoleProperty(bc.RoleProperty.max_keeper_energy) or 0
  else
    keeper_energy_cost_per = CopyAwakerDataUtils.GetAwakerAttrs(0, "keeper_energy_cost_per") or 0
    max_keeper_energy = CopyAwakerDataUtils.GetAwakerAttrs(0, "max_keeper_energy") or 0
  end
  if 0 == keeper_energy_cost_per then
    do return StrUtils.ParseEmojiNumber, num end
    return StrUtils.ParseEmojiNumber, num, "Number2", nil, nil, nil, nil
  else
    local maxValue = math.floor(max_keeper_energy * (1 + keeper_energy_cost_per / 100))
    do return string.format, "%s<size=38>/</size> %s", StrUtils.ParseEmojiNumber(num, "Number2"), StrUtils.ParseEmojiNumber(maxValue, "Number2") end
    return string.format, "%s<size=38>/</size> %s", StrUtils.ParseEmojiNumber(num, "Number2"), StrUtils.ParseEmojiNumber(maxValue, "Number2")
  end
end

function UIBattlePopupKeeperSkillTip:BindKeyWords()
  local skillId = self.roleInfo.GetKeeperSkillId()
  local tips = SkillUtils.GetSkillKeyWordTips({}, skillId, 1)
  local descGroup = SkillUtils.GetKeyWordEffectDescGroup(tips)
  local descGroupList = {descGroup}
  local strList = {
    LT.Text("ResurrectionCoinSkillDescription"),
    KeeperSkillUtils.GetKeeperSkillDesc(self.roleInfo.GetKeeperSkillId(), self:_GetKeeperSkillArgs())
  }
  local schoolType, _ = self:_GetSchoolTypeAndSchoolTips()
  local isChaos = schoolType and schoolType == CommonDefine.SchoolType.Chaos
  local chaosDescInfo = self:GetChaosSchoolDescInfo()
  if chaosDescInfo then
    table.insert(descGroupList, chaosDescInfo)
  end
  self.binder:BindComponent(CommonKeyWordDescGroup(self.ui.Group_Keyword, strList, descGroupList, isChaos, {useSetHeight = true}))
end

function UIBattlePopupKeeperSkillTip:BindReviveItem()
  local reviveItemId = DT.GetConstant("RevivalItemId")
  local itemData = {
    itemTid = reviveItemId,
    itemCount = self.roleInfo.GetLivesFunc and self.roleInfo.GetLivesFunc() or 0,
    clickFunc = function()
    end
  }
  self.binder:BindComponent(CommonIconItemType2(self.ui.UI_Common_Item_WuPin_Type2, itemData))
  self.binder:BindToText(self.ui.Text_Name, function()
    do return ItemDataUtils.GetItemName end
    return ItemDataUtils.GetItemName, reviveItemId
  end)
  self.binder:BindToText(self.ui.Text_Content, function()
    do return LT.Text end
    return LT.Text, "ResurrectionCoinSkillDescription"
  end)
end

function UIBattlePopupKeeperSkillTip:BindSomeAwakerAttrs()
  local stageData = WorldStageManager.Instance:GetCurStageData()
  if not stageData then
    return
  end
  if bg.isReplay then
    return
  end
  self.ui.Group_Nature:SetActive(true)
  self.ui.UI_Battle_Item_Buff_Entry2:SetActive(false)
  local awakerTidList = {}
  local awakerLevelDict = {}
  local playerLevel = stageData.role.level
  for _, awakerInfo in pairs(stageData.role.awakerInfos) do
    table.insert(awakerTidList, awakerInfo.tid)
    awakerLevelDict[awakerInfo.tid] = awakerInfo.level
  end
  local attrs = {}
  attrs[bc.RoleProperty.occupation_master] = CopyAwakerDataUtils.GetAwakerAttrs(0, bc.RoleProperty.occupation_master)
  attrs[bc.RoleProperty.blackcoin_upgrade_per] = CopyAwakerDataUtils.GetAwakerAttrs(0, bc.RoleProperty.blackcoin_upgrade_per)
  attrs[bc.RoleProperty.basic_damage_per] = CopyAwakerDataUtils.GetAwakerAttrs(0, bc.RoleProperty.basic_damage_per)
  attrs[bc.RoleProperty.death_resist] = CopyAwakerDataUtils.GetAwakerAttrs(0, bc.RoleProperty.death_resist)
  attrs[bc.RoleProperty.AccountLvBattleCurve] = AttrUtils.GetAwakersAccountLvBattleCurve(awakerTidList, awakerLevelDict, playerLevel)
  local attrValueGetter = {
    [bc.RoleProperty.occupation_master] = function()
      if bg.battleDataCenter then
        local value = bg.battleDataCenter:GetPlayerRoleProperty(BP.occupation_master)
        local final_add = bg.battleDataCenter:GetPlayerRoleProperty(BP.occupation_master_final_add) or 0
        return value * (1 + final_add / 100)
      else
        do return CopyAwakerDataUtils.GetAwakerAttrs, 0 end
        return CopyAwakerDataUtils.GetAwakerAttrs, 0, bc.RoleProperty.occupation_master, BP.occupation_master_final_add
      end
    end,
    [bc.RoleProperty.blackcoin_upgrade_per] = function()
      if bg.battleDataCenter then
        do return bg.battleDataCenter.GetPlayerRoleProperty, bg.battleDataCenter end
        return bg.battleDataCenter.GetPlayerRoleProperty, bg.battleDataCenter, BP.blackcoin_upgrade_per
      else
        return stageData.role.blackcoin_upgrade_per or 0
      end
    end,
    [bc.RoleProperty.basic_damage_per] = function()
      if bg.battleDataCenter then
        do return bg.battleDataCenter.GetPlayerRoleProperty, bg.battleDataCenter end
        return bg.battleDataCenter.GetPlayerRoleProperty, bg.battleDataCenter, BP.basic_damage_per
      else
        return stageData.role.basic_damage_per or 0
      end
    end,
    [bc.RoleProperty.death_resist] = function()
      local deathResist, deathResistTimes, deathResistCoff, coffPlus
      local cfgCoff = bg.DT.GetConstant("Death_resist_coefficient", 0.5)
      if bg.battleDataCenter then
        deathResist = bg.battleDataCenter:GetPlayerRoleProperty(BP.death_resist)
        deathResistTimes = bg.battleDataCenter:GetPlayerRoleProperty(BP.death_resist_times)
        coffPlus = bg.battleDataCenter:GetPlayerRoleProperty(BP.death_resist_coefficient_plus) or 0
        deathResistCoff = 1 - (cfgCoff - coffPlus / 100)
      else
        deathResist = stageData.role.death_resist or 0
        deathResistTimes = stageData.role.death_resist_times or 0
        coffPlus = stageData.role.death_resist_coefficient_plus or 0
        deathResistCoff = 1 - (cfgCoff - coffPlus / 100)
      end
      do return math.ceil end
      return math.ceil, deathResist * deathResistCoff ^ deathResistTimes, BP.death_resist_coefficient_plus
    end,
    [bc.RoleProperty.AccountLvBattleCurve] = function()
      do return AttrUtils.GetAwakersAccountLvBattleCurve, awakerTidList, awakerLevelDict end
      return AttrUtils.GetAwakersAccountLvBattleCurve, awakerTidList, awakerLevelDict, playerLevel
    end
  }
  local datalist = AwakerDataUtils.Process2ShowAttrs(attrs)
  for index, data in ipairs(datalist) do
    local itemData = {
      clientAttr = data,
      resourceCls = UI_Battle_Item_Buff_Entry2Resource,
      getAttrValue = function()
        local getter = attrValueGetter[data.attrName]
        if getter then
          do return end
          return getter
        else
          return 0
        end
      end
    }
    local uiNode = CS.UnityEngine.GameObject.Instantiate(self.ui.UI_Battle_Item_Buff_Entry2, self.ui.Group_Nature.transform)
    uiNode:SetActive(true)
    local comp = self.binder:BindComponent(AwakerAttrItem(uiNode, itemData))
    AutoAdaptionText.StartAutoAdaptionText(comp.ui.Text_Name)
  end
end

function UIBattlePopupKeeperSkillTip:GetChaosSchoolDescInfo()
  local schoolType, schoolTips = self:_GetSchoolTypeAndSchoolTips()
  local isChaos = schoolType and schoolType == CommonDefine.SchoolType.Chaos
  if isChaos then
    local chaosCfg = AwakerDataUtils.GetSchoolCfgByNameEn(CommonDefine.SchoolType.Chaos)
    local descInfo = {}
    descInfo.icon = chaosCfg.SchoolBattleTipIcon
    local titleKey = self:_HasNewChaosAwaker() and "Chaos_Tips_Title2" or "Chaos_Tips_Title"
    descInfo.name = LT.Text(titleKey)
    descInfo.desc = schoolTips
    descInfo.subDesc = ""
    descInfo.layerCountList = {}
    local effectGroup = {}
    effectGroup.name = LT.Text("BattleSchoolEffectTipsTitle")
    effectGroup.descList = {descInfo}
    effectGroup.isSchool = true
    return effectGroup
  end
end

function UIBattlePopupKeeperSkillTip:_HasNewChaosAwaker()
  local cmdParser = BattleCmdParserClient({})
  return cmdParser:GetSpecialSchoolAwakerNum("NewChaosSchoolAwakerList") > 0
end

function UIBattlePopupKeeperSkillTip:_ShouldShowChaosSchoolTips()
  if bg.battleScene then
    return bg.battleDataCenter:IsPureSchool(cd.SchoolId.Choas) or self:_HasNewChaosAwaker()
  end
  local stageData = WorldStageManager.Instance:GetCurStageData()
  if not (stageData and stageData.role) or not stageData.role.awakerInfos then
    return false
  end
  local awakerTids = {}
  for _, awakerData in pairs(stageData.role.awakerInfos) do
    table.insert(awakerTids, awakerData.tid)
  end
  local schoolCounts = AwakerDataUtils.GetAwakerSchoolCounts(awakerTids)
  local choasId = cd.SchoolId.Choas
  local isPureChaos = (schoolCounts[choasId] or 0) >= #awakerTids
  return isPureChaos or self:_HasNewChaosAwaker()
end

function UIBattlePopupKeeperSkillTip:_GetSchoolTypeAndSchoolTips()
  local schoolType, schoolTips
  local choasId = cd.SchoolId.Choas
  if not self:_ShouldShowChaosSchoolTips() then
    return schoolType, schoolTips
  end
  if bg.battleScene then
    local playerRole = bg.battleScene:GetPlayerRole()
    schoolType = playerRole:GetSchoolEn(choasId)
    schoolTips = playerRole:GetSchoolTips(choasId)
  else
    local stageData = WorldStageManager.Instance:GetCurStageData()
    schoolType = DT.SchoolConfig[choasId].NameEn
    local schoolArgs = stageData.role.schoolArgs and stageData.role.schoolArgs[choasId]
    schoolTips = AwakerDataUtils.GetSchoolTips(choasId, true, schoolArgs)
  end
  return schoolType, schoolTips
end

return UIBattlePopupKeeperSkillTip
