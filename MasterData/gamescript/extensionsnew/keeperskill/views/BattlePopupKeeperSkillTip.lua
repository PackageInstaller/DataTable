local BP = bc.BattleProperty
local BattlePopupKeeperSkillTip, Super = NewClass("BattlePopupKeeperSkillTip", BaseView)
BattlePopupKeeperSkillTip.uiResCls = UI_Battle_Popup_Keeper_Skill_TipResource

function BattlePopupKeeperSkillTip:ctor(roleInfo)
  Super.ctor(self)
  self._roleInfo = roleInfo
end

function BattlePopupKeeperSkillTip:OnBuildView()
  Super.OnBuildView(self)
end

function BattlePopupKeeperSkillTip:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnKeeperSkillEnergyChanged, self._RefreshKeeperSkill, self)
end

function BattlePopupKeeperSkillTip:RegisterEvents()
  self:AddButtonClickListener(self.ui.Mask, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Closure_Mask, System.fn(self, self.Close))
end

function BattlePopupKeeperSkillTip:OnEnterView()
  self:_RefreshRole()
  self:_RefreshKeeperSkill()
  self:_RefreshKeyWordsItem()
  self:_RefreshReviveItem()
  self:_RefreshSomeAwakerAttrs()
  self:_RefreshLaterShow()
end

function BattlePopupKeeperSkillTip:OnExitView()
  Super.OnExitView(self)
end

function BattlePopupKeeperSkillTip:_RefreshRole()
  local awakerIcon = GenderDataUtils.GetBattleMainHeadRes(self._roleInfo.gender)
  self:SetImage(self.ui.Icon_Awaker, awakerIcon)
  local awakenName = self._roleInfo.name
  self:SetText(self.ui.Text_Awaker_Name, awakenName)
end

function BattlePopupKeeperSkillTip:_RefreshKeeperSkill()
  local skillIcon = KeeperSkillUtils.GetSkillIcon(self._roleInfo.GetKeeperSkillId())
  self:SetImage(self.ui.Image_Icon, skillIcon)
  local skillName = KeeperSkillUtils.GetSkillName(self._roleInfo.GetKeeperSkillId())
  self:SetText(self.ui.Text_Skill_Name, skillName)
  local skillDesc = KeeperSkillUtils.GetKeeperSkillDesc(self._roleInfo.GetKeeperSkillId(), self._roleInfo.keeperSkillArgs)
  self:SetText(self.ui.Text_Skill_Desc, skillDesc, nil, nil, {banKeywordBtn = true})
  local maniacDesc = self:_GetSkillManiacDesc()
  self:SetText(self.ui.Text_Maniac, maniacDesc)
  local isChinese = Utils.IsLangChinese()
  self.ui.Text_Maniac:SetActive(isChinese)
  self.ui.Text_Skill2_EN:SetActive(not isChinese)
  self:SetText(self.ui.Text_Skill2_EN, LT.Textf("KeeperSkillEnergy", ""))
  local maniacDescEN = self:_GetSkillManiacDesc()
  self:SetText(self.ui.Text_Maniac_EN, maniacDescEN)
end

function BattlePopupKeeperSkillTip:_RefreshKeyWordsItem()
  local skillId = self._roleInfo.GetKeeperSkillId()
  local tips = SkillUtils.GetSkillKeyWordTips({}, skillId, 1)
  local descGroup = SkillUtils.GetKeyWordEffectDescGroup(tips)
  local descGroupList = {descGroup}
  local strList = {
    LT.Text("ResurrectionCoinSkillDescription"),
    KeeperSkillUtils.GetKeeperSkillDesc(self._roleInfo.GetKeeperSkillId(), self._roleInfo.keeperSkillArgs)
  }
  local schoolType, _ = self:_GetSchoolTypeAndSchoolTips()
  local isChaos = schoolType and schoolType == CommonDefine.SchoolType.Chaos
  local chaosDescInfo = self:_GetChaosSchoolDescInfo()
  if chaosDescInfo then
    table.insert(descGroupList, chaosDescInfo)
  end
  self:AddViewComponentOnce(self.ui.Group_Keyword, CommonKeyWordDescGroupItem, strList, descGroupList, isChaos, {useSetHeight = true})
end

function BattlePopupKeeperSkillTip:_RefreshReviveItem()
  local reviveItemId = DT.GetConstant("RevivalItemId")
  local itemData = {
    itemTid = reviveItemId,
    itemCount = self._roleInfo.GetLivesFunc and self._roleInfo.GetLivesFunc() or 0,
    clickFunc = function()
    end
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Item_WuPin_Type2, CompPublicIconItemType2, itemData)
  local reviveItemName = ItemDataUtils.GetItemName(reviveItemId)
  self:SetText(self.ui.Text_Name, reviveItemName)
  self:SetText(self.ui.Text_Content, LT.Text("ResurrectionCoinSkillDescription"))
end

function BattlePopupKeeperSkillTip:_RefreshSomeAwakerAttrs()
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
    local comp = self:AddViewComponentOnce(uiNode, CompAwakerAttrItem, itemData)
    AutoAdaptionText.StartAutoAdaptionText(comp.ui.Text_Name)
  end
end

function BattlePopupKeeperSkillTip:_RefreshLaterShow()
  local oldPos = self.ui.uiNode.transform.localPosition
  self.ui.uiNode.transform.localPosition = CS.UnityEngine.Vector3(9999, 9999, 9999)
  FrameWaiter.OnNextFrame(function()
    if self.ui then
      self.ui.uiNode.transform.localPosition = oldPos
    end
  end, 3)
end

function BattlePopupKeeperSkillTip:_GetSkillManiacDesc()
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

function BattlePopupKeeperSkillTip:_GetChaosSchoolDescInfo()
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

function BattlePopupKeeperSkillTip:_HasNewChaosAwaker()
  local cmdParser = BattleCmdParserClient({})
  return cmdParser:GetSpecialSchoolAwakerNum("NewChaosSchoolAwakerList") > 0
end

function BattlePopupKeeperSkillTip:_ShouldShowChaosSchoolTips()
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

function BattlePopupKeeperSkillTip:_GetSchoolTypeAndSchoolTips()
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

return BattlePopupKeeperSkillTip
