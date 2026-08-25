local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local AwakerInfoPanelNew, Super = System.NewClass("AwakerInfoPanelNew", UIBasePanel)
AwakerInfoPanelNew.uiResCls = UI_Battle_Popup_Record_Tip_NewResource

function AwakerInfoPanelNew:ctor(awakerInfoModel)
  Super.ctor(self)
  self.awakerInfoModel = awakerInfoModel
  self.strList = {}
end

function AwakerInfoPanelNew:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Mask, System.fn(self, self.Close))
  binder:BindButtonClick(self.ui.Closure_Mask, System.fn(self, self.Close))
  self:_InitSuperUtlSkillInfo(binder)
  self:OnBindAwaker(binder)
  self:OnBindUltiSkill(binder)
  self:OnBindAttr(binder)
  self:OnBindGroupDetail(binder)
  self:OnBindAwakening(binder)
  self:OnBindWeapon(binder)
  self:OnBindTrinket(binder)
  self:OnBindKeyWords(binder)
  self:OnBindAwakerTalent(binder)
  self:OnBindTouch(binder)
  local oldPos = self.ui.uiNode.transform.localPosition
  self.ui.uiNode.transform.localPosition = CS.UnityEngine.Vector3(9999, 9999, 9999)
  FrameWaiter.OnNextFrame(function()
    if self.ui then
      self.ui.uiNode.transform.localPosition = oldPos
    end
  end, 1)
end

function AwakerInfoPanelNew:_InitSuperUtlSkillInfo(binder)
  local energyNormalUltlSkillMax, needEnergySuperUtlSkillMax = self:_CalSkillManiacMax()
  self.energyNormalUltlSkillMax = energyNormalUltlSkillMax
  self.needEnergySuperUtlSkillMax = needEnergySuperUtlSkillMax
  if self:_IsActivePotencySuperUtlSkill() then
    local model = binder:createModel(AwakerModel)
    self.skillModel = binder:createModel(AwakerSkillModel, model)
  end
end

function AwakerInfoPanelNew:OnBindAwaker(binder)
  binder:BindToText(self.ui.Text_Awaker_Name, function()
    do return self.awakerInfoModel.GetAwakerName end
    return self.awakerInfoModel.GetAwakerName, self.awakerInfoModel
  end)
  binder:BindToImage(self.ui.Icon_Awaker, function()
    do return self.awakerInfoModel.GetAwakerIcon end
    return self.awakerInfoModel.GetAwakerIcon, self.awakerInfoModel
  end)
  binder:BindToText(self.ui.Text_Awaker_School, function()
    do return LT.Textf, "Team_AwakerLevel", self.awakerInfoModel:GetAwakerLevel() end
    return LT.Textf, "Team_AwakerLevel", self.awakerInfoModel:GetAwakerLevel()
  end)
  binder:BindToImage(self.ui.Icon_Awaker_School, function()
    if bg.isPVP then
      return
    end
    do return self.awakerInfoModel.GetSchoolIcon end
    return self.awakerInfoModel.GetSchoolIcon, self.awakerInfoModel
  end)
  binder:BindToVisible(self.ui.Text_Awaker_School, function()
    return not bg.isPVP
  end)
  binder:BindToVisible(self.ui.Icon_Awaker_School, function()
    return not bg.isPVP
  end)
  binder:BindToImage(self.ui.Icon_School_Pvp, function()
    if not bg.isPVP then
      return
    end
    do return self.awakerInfoModel.GetPVPPositionIcon end
    return self.awakerInfoModel.GetPVPPositionIcon, self.awakerInfoModel
  end)
  binder:BindToVisible(self.ui.Image_Intention, function()
    return bg.isPVP
  end)
end

function AwakerInfoPanelNew:OnBindTouch(binder)
  local touchBeginTime, touchx, touchy = 0, 0, 0
  binder:BindEvent(EventMgr.Instance.TouchBeginEvent, function(x, y)
    touchBeginTime = TimerManager.totalTime
    touchx, touchy = x, y
    if UIManager.Instance:GetWindow(Urls.CommonCardKeyWorldDescPanel) then
      touchBeginTime = touchBeginTime - 1
    end
  end)
  binder:BindEvent(EventMgr.Instance.TouchSwipeEvent, function(x, y)
    touchBeginTime = 0
  end)
  binder:BindEvent(EventMgr.Instance.TouchEndEvent, function(x, y)
    if UIManager.Instance:GetWindow(Urls.CommonCardKeyWorldDescPanel) then
      return
    end
    if TimerManager.totalTime - touchBeginTime < 0.5 and math.abs(x - touchx) <= 30 and math.abs(y - touchy) <= 30 then
      self:Close()
    end
  end)
end

function AwakerInfoPanelNew:OnBindUltiSkill(binder)
  binder:BindToRaw(function(_, desc)
    local isConfuse = self.awakerInfoModel:IsUltiSkillConfuse()
    if isConfuse and #desc > 0 then
      math.randomseed(#desc)
      desc = desc:sub(1, math.random(50, 70))
    end
    binder:SetText(self.ui.Text_Skill_Desc, desc, nil, nil, {
      OpenConfuseText = isConfuse,
      awakerData = self.awakerInfoModel:GetAwakerDataModel(),
      skillTid = self.awakerInfoModel:GetUltiSkillId(),
      skillLevel = self.awakerInfoModel:GetUltiSkillLevel()
    })
    binder:RemoveUnderline(self.ui.Text_Skill_Desc)
    StrUtils.SetPreferredHeight(self.ui.Text_Skill_Desc)
  end, function()
    local desc = ""
    if self:_IsActiveSuperUtlSkill() then
      desc = self.awakerInfoModel:GetSuperUltlSkillDesc()
    else
      desc = self.awakerInfoModel:GetUltiSkillDesc()
    end
    table.insert(self.strList, desc)
    return desc
  end)
  binder:BindToText(self.ui.Text_Maniac, function()
    do return self.GetSkillManiacDesc end
    return self.GetSkillManiacDesc, self
  end)
  binder:BindToText(self.ui.Text_Maniac_EN, function()
    do return self.GetSkillManiacDesc end
    return self.GetSkillManiacDesc, self
  end)
  self.binder:SetText(self.ui.Text_Skill2_EN, LT.Textf("CurUenergyValue", ""))
  binder:BindToRaw(function(_, name)
    local isConfuse = self.awakerInfoModel:IsUltiSkillConfuse()
    if isConfuse and #name > 0 then
      math.randomseed(#name)
      name = name:sub(1, math.random(2, 8))
    end
    binder:SetText(self.ui.Text_Skill_Name, name, nil, nil, {OpenConfuseText = isConfuse})
    local preferedWidth = binder:GetTextPreferredWH(self.ui.Text_Skill_Name)
    local isShowManiacEn = preferedWidth > 260 or not Utils.IsLangChinese()
    binder:SetActive(self.ui.Text_Maniac, not isShowManiacEn)
    binder:SetActive(self.ui.Text_Skill2_EN, isShowManiacEn)
  end, function()
    if self:_IsActiveSuperUtlSkill() then
      local awakerTid = self.awakerInfoModel:GetAwakerTid()
      local info = AwakerDataUtils.GetSuperUltiSkillInfo(awakerTid)
      if info and info.name then
        do return LT.Text end
        return LT.Text, info.name
      end
      do return self.awakerInfoModel.GetUltiSkillName end
      return self.awakerInfoModel.GetUltiSkillName, self.awakerInfoModel
    else
      do return self.awakerInfoModel.GetUltiSkillName end
      return self.awakerInfoModel.GetUltiSkillName, self.awakerInfoModel, self.awakerInfoModel.GetUltiSkillName, self.awakerInfoModel
    end
  end)
  local isActiveSuperUtlSkill = self:_IsActiveSuperUtlSkill()
  if isActiveSuperUtlSkill then
    self.ui.Group_Deepen:SetActive(false)
    self.ui.Image_SkillBg:SetActive(false)
    self.ui.Image_OverrunSkillBg:SetActive(true)
    self.binder:SetText(self.ui.Text_Skill_Tag, LT.Text("SuperUltlSkillName"))
    self.binder:SetTextColorType(self.ui.Text_Skill_Tag, CommonDefine.ColorType.Light)
  else
    self.ui.Image_SkillBg:SetActive(true)
    self.ui.Image_OverrunSkillBg:SetActive(false)
    self.binder:SetText(self.ui.Text_Skill_Tag, LT.Text("UltlSkillName"))
    self.binder:SetTextColorType(self.ui.Text_Skill_Tag, CommonDefine.ColorType.Dark)
    self.ui.Group_Deepen:SetActive(self:_IsActivePotencySuperUtlSkill())
    if self:_IsActivePotencySuperUtlSkill() then
      local desc = self:_GetActivePotencySuperUtlSkillDesc()
      local showStr = string.format("%s：%s", LT.Text("OverLimitUtlSkill"), desc)
      self.binder:SetText(self.ui.Text_Deepen_Desc, showStr)
      self.binder:SetText(self.ui.Text_SuperSkill_Name, self:_GetActivePotencySuperUtlSkillName())
    end
  end
  self.scrollView = self.ui.ScrollView_RoleInfo:GetComponent(T_ScrollRect)
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Group_Content)
  self.scrollView.verticalNormalizedPosition = 1
end

function AwakerInfoPanelNew:_GetActivePotencySuperUtlSkillName()
  local awakerTid = self.awakerInfoModel:GetAwakerTid()
  do return AwakerDataUtils.GetPotencyUtlSkillName end
  return AwakerDataUtils.GetPotencyUtlSkillName, awakerTid
end

function AwakerInfoPanelNew:_GetActivePotencySuperUtlSkillDesc()
  if not self:_IsActivePotencySuperUtlSkill() then
    return ""
  end
  local awakerTid = self.awakerInfoModel:GetAwakerTid()
  local potency = AwakerDataUtils.GetPotencyUtlSkillTid(awakerTid)
  local mode = CommonDefine.AwakerSkillMode.DBG
  do return AwakerDataUtils.GetPotencyDesc, awakerTid, potency, mode end
  return AwakerDataUtils.GetPotencyDesc, awakerTid, potency, mode, self.skillModel
end

function AwakerInfoPanelNew:_IsActivePotencySuperUtlSkill()
  return self.needEnergySuperUtlSkillMax > self.energyNormalUltlSkillMax
end

function AwakerInfoPanelNew:_IsActiveSuperUtlSkill()
  local ultiSkillLevelUp = self.awakerInfoModel:GetProperty("ulti_skill_level_up") or 0
  if ultiSkillLevelUp > 0 then
    return true
  end
  return self:_IsActivePotencySuperUtlSkill() and self.awakerInfoModel:GetProperty("ulti_energy") >= self.needEnergySuperUtlSkillMax
end

function AwakerInfoPanelNew:GetSkillManiacDesc()
  do return string.format, "%s/%s", (self.awakerInfoModel:GetProperty("ulti_energy")) end
  return string.format, "%s/%s", self.awakerInfoModel:GetProperty("ulti_energy"), self.needEnergySuperUtlSkillMax, "ulti_energy"
end

function AwakerInfoPanelNew:_CalSkillManiacMax()
  local params = {}
  if bg.battleScene then
    params.ulti_energy_cost_per = self.awakerInfoModel:GetProperty("ulti_energy_cost_per") or 0
    params.ulti_energy_cost_flat = self.awakerInfoModel:GetProperty("ulti_energy_cost_flat") or 0
    params.ulti_energy_max = self.awakerInfoModel:GetProperty(bc.BattleProperty.ulti_energy_max) or 0
    params.ulti_energy_max_per = self.awakerInfoModel:GetProperty(bc.BattleProperty.ulti_energy_max_per) or 0
  else
    local stageData = WorldStageManager.Instance:GetCurStageData()
    local tid = self.awakerInfoModel:GetAwakerTid()
    if tid and stageData and stageData.role and stageData.role.roleAttrsList and stageData.role.roleAttrsList[tid] then
      params.ulti_energy_cost_per = stageData.role.roleAttrsList[tid].ulti_energy_cost_per or 0
      params.ulti_energy_cost_flat = stageData.role.roleAttrsList[tid].ulti_energy_cost_flat or 0
      params.ulti_energy_max = stageData.role.roleAttrsList[tid].ulti_energy_max or 0
      params.ulti_energy_max_per = stageData.role.roleAttrsList[tid].ulti_energy_max_per or 0
    else
      params.ulti_energy_cost_per = 0
      params.ulti_energy_cost_flat = 0
      params.ulti_energy_max = 0
      params.ulti_energy_max_per = 0
    end
  end
  do return BattleSkillUtils.CalcSkillManiacMax end
  return BattleSkillUtils.CalcSkillManiacMax, params, stageData.role.roleAttrsList[tid].ulti_energy_max_per or 0
end

function AwakerInfoPanelNew:OnBindAttr(binder)
  local attrList = self.awakerInfoModel:GetAttrList()
  if bg.isPVP and self.awakerInfoModel.GetPVPAttrList then
    attrList = self.awakerInfoModel:GetPVPAttrList()
  end
  local maxAttr = 20
  for index = 1, maxAttr do
    local attrUINode = self.ui["Item_Attr_" .. index]
    local attrData = attrList[index]
    if attrUINode then
      attrUINode:SetActive(nil ~= attrData)
      local uiRes = UI_Battle_Item_Buff_EntryResource(attrUINode)
      if attrData then
        local attrCfg = attrData.attrCfg
        binder:SetText(uiRes.Text_Name, attrData.attrName)
        AutoAdaptionText.StartAutoAdaptionText(uiRes.Text_Name)
        local countText = attrData.attrValue
        if attrCfg.Name == bc.BattleProperty.crit then
          local crit_per = self.awakerInfoModel:GetProperty(bc.BattleProperty.crit_per) / 100
          countText = countText * (1 + crit_per)
        end
        if attrCfg.Name == bc.BattleProperty.crit_damage then
          countText = countText * (1 + self.awakerInfoModel:GetProperty(bc.BattleProperty.crit_damage_per) / 100)
        end
        if attrCfg.Percentage then
          countText = string.format("%s%%", math.ceil(countText))
        end
        binder:SetText(uiRes.Text_Count, countText)
        binder:BindToImage(uiRes.Image_Icon, function()
          return attrData.attrIcon
        end)
      end
    end
  end
end

function AwakerInfoPanelNew:OnBindGroupDetail(binder)
  if bg.isPVP then
    binder:BindToVisible(self.ui.ScrollView_Weapon, function()
      do return self.GetWeaponState end
      return self.GetWeaponState, self
    end)
  else
    binder:BindToVisible(self.ui.ScrollView_Weapon, function()
      local slotType = CommonDefine.WeaponSlotType
      local isAwakeSkillVisible = self.awakerInfoModel:IsAwakeSkillVisible()
      local isHaveWeaponPrimary = self.awakerInfoModel:IsHaveWeapon(slotType.Primary)
      local isHaveWeaponSecondary = self.awakerInfoModel:IsHaveWeapon(slotType.Secondary)
      local isShowTrinket = self.awakerInfoModel:IsShowTrinket()
      print("aaaa : %s %s, %s, %s", isAwakeSkillVisible, isHaveWeaponPrimary, isHaveWeaponSecondary, isShowTrinket)
      return isAwakeSkillVisible or isHaveWeaponPrimary or isHaveWeaponSecondary or isShowTrinket
    end)
  end
  local scrollGo = self.ui.ScrollView_Weapon:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
  scrollGo.verticalNormalizedPosition = 1
end

function AwakerInfoPanelNew:OnBindAwakening(binder)
  binder:BindToRaw(function(childBinder, isVisible)
    self.ui.Group_Awakening:SetActive(isVisible)
    if not isVisible then
      return
    end
    childBinder:BindToRaw(function(_, desc)
      table.insert(self.strList, desc)
      childBinder:SetText(self.ui.Text_Awakening_Desc, desc, nil, function()
        childBinder:SetActive(self.ui.Group_Keyword, not self.ui.Group_Keyword.activeSelf)
      end)
      StrUtils.SetPreferredHeight(self.ui.Text_Awakening_Desc, 5)
    end, function()
      do return self.awakerInfoModel.GetAwakeCardDesc end
      return self.awakerInfoModel.GetAwakeCardDesc, self.awakerInfoModel
    end)
    childBinder:BindToText(self.ui.Text_Awakening_Name, function()
      do return self.awakerInfoModel.GetAwakerCardName end
      return self.awakerInfoModel.GetAwakerCardName, self.awakerInfoModel
    end)
  end, function()
    do return self.awakerInfoModel.IsAwakeSkillVisible end
    return self.awakerInfoModel.IsAwakeSkillVisible, self.awakerInfoModel
  end)
end

function AwakerInfoPanelNew:OnBindWeapon(binder)
  if bg.isPVP then
    binder:SetActive(self.ui.Group_Secondary_Weapon, false)
    binder:SetActive(self.ui.Image_Quality_Primary, true)
    binder:BindToRaw(function(cBinder, state)
      cBinder:SetActive(self.ui.Group_Weapon, state)
      cBinder:SetActive(self.ui.Group_Primary_Weapon, state)
      if state then
        local stateId = state.stateId
        local stateCfg = DT.State[stateId] or {}
        if not stateCfg.BelongWeapon or not DT.PVPCollect[stateCfg.BelongWeapon] then
          return
        end
        local collectCfg = DT.PVPCollect[stateCfg.BelongWeapon]
        local itemCfg = DT.Item[collectCfg.Item]
        cBinder:SetImage(self.ui.Icon_Article_Primary, itemCfg.Icon)
        cBinder:SetImage(self.ui.Image_Quality_Primary, DT.ItemQuality[itemCfg.Quality].BlackBgBottomQualityFrame)
        cBinder:SetText(self.ui.Text_Primary_Weapon_Name, stateCfg.Name)
        local stateUid = state.stateUid
        local stateDesc = bg.battleDataCenter.stateData:GetStateDesc(stateUid)
        cBinder:SetText(self.ui.Text_Primary_Weapon_Desc, stateDesc, nil, nil, {isForceRight = true, isCenterY = true})
        StrUtils.SetPreferredHeight(self.ui.Text_Primary_Weapon_Desc, 5)
      end
    end, function()
      do return self.GetWeaponState end
      return self.GetWeaponState, self
    end)
  else
    binder:BindToVisible(self.ui.Group_Weapon, function()
      return self.awakerInfoModel:IsHaveWeapon(CommonDefine.WeaponSlotType.Primary) or self.awakerInfoModel:IsHaveWeapon(CommonDefine.WeaponSlotType.Secondary)
    end)
    binder:BindToRaw(function(childBinder, isHaveWeapon)
      self.ui.Group_Primary_Weapon:SetActive(isHaveWeapon)
      if not isHaveWeapon then
        return
      end
      local slotType = CommonDefine.WeaponSlotType
      local primaryWeaponConfig = self.awakerInfoModel:GetWeaponConfig(slotType.Primary)
      childBinder:BindToText(self.ui.Text_Primary_Weapon_Name, function()
        return primaryWeaponConfig.Name
      end)
      childBinder:BindToRaw(function(_, desc)
        table.insert(self.strList, desc or "")
        childBinder:SetText(self.ui.Text_Primary_Weapon_Desc, desc or "", nil, nil, {isForceRight = true, isCenterY = true})
        StrUtils.SetPreferredHeight(self.ui.Text_Primary_Weapon_Desc, 5)
      end, function()
        if bg.battleData and bg.battleData.isMock then
          local desc = self.awakerInfoModel:GetWeaponStateDesc(slotType.Primary)
          return desc
        end
        local awakerCfg = self:_EquippedByPreviousAwaker(primaryWeaponConfig.ID)
        if awakerCfg then
          local awakerName = LT.Text(awakerCfg.Name)
          do return LT.Textf, "WeaponInvalidPrompt" end
          return LT.Textf, "WeaponInvalidPrompt", awakerName
        else
          local desc = self.awakerInfoModel:GetWeaponStateDesc(slotType.Primary)
          return desc
        end
      end)
      childBinder:BindToImage(self.ui.Icon_Article_Primary, function()
        return primaryWeaponConfig.Icon
      end)
      childBinder:BindToImage(self.ui.Image_Quality_Primary, function()
        do return self.awakerInfoModel.GetWeaponQualityImage, self.awakerInfoModel end
        return self.awakerInfoModel.GetWeaponQualityImage, self.awakerInfoModel, slotType.Primary
      end)
    end, function()
      do return self.awakerInfoModel.IsHaveWeapon, self.awakerInfoModel end
      return self.awakerInfoModel.IsHaveWeapon, self.awakerInfoModel, CommonDefine.WeaponSlotType.Primary
    end)
    binder:BindToRaw(function(childBinder, isHaveWeapon)
      self.ui.Group_Secondary_Weapon:SetActive(isHaveWeapon)
      if not isHaveWeapon then
        return
      end
      local slotType = CommonDefine.WeaponSlotType
      local secondaryWeaponConfig = self.awakerInfoModel:GetWeaponConfig(slotType.Secondary)
      childBinder:BindToText(self.ui.Text_Secondary_Weapon_Name, function()
        return secondaryWeaponConfig.Name
      end)
      childBinder:BindToRaw(function(_, desc)
        table.insert(self.strList, desc)
        childBinder:SetText(self.ui.Text_Secondary_Weapon_Desc, desc, nil, function()
          childBinder:SetActive(self.ui.Group_Keyword, not self.ui.Group_Keyword.activeSelf)
        end)
        StrUtils.SetPreferredHeight(self.ui.Text_Secondary_Weapon_Desc, 5)
      end, function()
        local awakerCfg = self:_EquippedByPreviousAwaker(secondaryWeaponConfig.ID)
        if awakerCfg then
          local awakerName = LT.Text(awakerCfg.Name)
          do return LT.Textf, "WeaponInvalidPrompt" end
          return LT.Textf, "WeaponInvalidPrompt", awakerName
        else
          local desc = self.awakerInfoModel:GetWeaponStateDesc(slotType.Secondary)
          return desc
        end
      end)
      childBinder:BindToImage(self.ui.Icon_Article_Secondary, function()
        return secondaryWeaponConfig.Icon
      end)
      childBinder:BindToImage(self.ui.Image_Quality_Secondary, function()
        do return self.awakerInfoModel.GetWeaponQualityImage, self.awakerInfoModel end
        return self.awakerInfoModel.GetWeaponQualityImage, self.awakerInfoModel, slotType.Secondary
      end)
    end, function()
      do return self.awakerInfoModel.IsHaveWeapon, self.awakerInfoModel end
      return self.awakerInfoModel.IsHaveWeapon, self.awakerInfoModel, CommonDefine.WeaponSlotType.Secondary
    end)
  end
end

function AwakerInfoPanelNew:_EquippedByPreviousAwaker(weaponTid)
  local currAwakerTid = self.awakerInfoModel:GetAwakerTid()
  local stageData = WorldStageManager.Instance:GetCurStageData()
  if stageData.role.awakerInfos then
    for _, awakerInfo in ipairs(stageData.role.awakerInfos) do
      if awakerInfo.tid == currAwakerTid then
        return
      end
      if AwakerDataUtils.GetWeaponSlotData(awakerInfo) then
        for _, slot in ipairs(AwakerDataUtils.GetWeaponSlotData(awakerInfo)) do
          if slot.tid == weaponTid then
            return DT.AwakerConfig[awakerInfo.tid]
          end
        end
      end
    end
  end
end

function AwakerInfoPanelNew:OnBindTrinket(binder)
  binder:BindToRaw(function(childBinder, isShowTrinket, _)
    self.ui.Group_Trinket:SetActive(isShowTrinket)
    if not isShowTrinket then
      return
    end
    local trinketInfo = self.awakerInfoModel:GetTrinketInfo()
    childBinder:BindToText(self.ui.Text_Trinket_Suit_Name, function()
      return trinketInfo.Name
    end)
    childBinder:BindToRaw(function(_, desc)
      table.insert(self.strList, trinketInfo.Desc)
      childBinder:SetText(self.ui.Text_Trinket_Suit_Desc, desc, nil, function()
        childBinder:SetActive(self.ui.Group_Keyword, not self.ui.Group_Keyword.activeSelf)
      end)
      StrUtils.SetPreferredHeight(self.ui.Text_Trinket_Suit_Desc, 5)
    end, function()
      local duplicateSuitEffectAwakerName = self:_GetDuplicateSuitValidAwakerName(trinketInfo.SuitId)
      if nil ~= duplicateSuitEffectAwakerName then
        local replaceDesc = LT.Textf("TrinketInvalidPrompt", trinketInfo.Name, duplicateSuitEffectAwakerName)
        return replaceDesc
      end
      return trinketInfo.Desc
    end)
    childBinder:BindToImage(self.ui.Icon_Trinket_Suit, function()
      return trinketInfo.Icon
    end)
  end, function()
    do return self.awakerInfoModel.IsShowTrinket end
    return self.awakerInfoModel.IsShowTrinket, self.awakerInfoModel
  end)
end

function AwakerInfoPanelNew:OnBindKeyWords(binder)
  local descGroup = self.awakerInfoModel:GetKeyWordEffectDescGroup()
  local ultiSkillId = self.awakerInfoModel:GetUltiSkillId()
  local ultiSkillLevel = self.awakerInfoModel:GetUltiSkillLevel()
  local exParam = {
    useSetHeight = true,
    awakerData = self.awakerInfoModel:GetAwakerDataModel(),
    skillId = ultiSkillId,
    skillLevel = ultiSkillLevel
  }
  if bg.isPVP then
    binder:BindComponent(CommonKeyWordDescGroup(self.ui.Group_Keyword, {}, {descGroup}, nil, exParam))
  else
    local stateDescGroup = self.awakerInfoModel:GetAwakerStateDescGroup()
    local effectDescGroupList = stateDescGroup and {stateDescGroup, descGroup} or {descGroup}
    binder:BindComponent(CommonKeyWordDescGroup(self.ui.Group_Keyword, self.strList, effectDescGroupList, nil, exParam))
  end
end

function AwakerInfoPanelNew:OnBindAwakerTalent(binder)
  local awakerTid = self.awakerInfoModel:GetAwakerTid()
  local awakerData = CopyAwakerDataUtils.GetBattleAwakerData(awakerTid)
  local talents = awakerData and awakerData.talents
  if not table.next(talents or {}) then
    self.ui.Group_Talent:SetActive(false)
    return
  end
  self.ui.Group_Talent:SetActive(true)
  local index = 0
  local stageChapter = WorldStageManager.Instance:GetCurStageChapter()
  local baseGameObj = self.ui.Item_Battle_Talent
  for talentTid, talentInfo in pairs(talents) do
    local talentCfg = DT.AwakerTalent[talentTid]
    local talentSeason = talentCfg and talentCfg.data_list[1].Season
    if talentCfg and (not talentSeason or talentSeason == stageChapter) then
      index = index + 1
      local lv = talentInfo.lv
      local talentName = AwakerTalentExtModel.Instance:GetTalentNameById(talentTid, lv)
      local talentDesc = AwakerTalentExtModel.Instance:GetTalentDescById(talentTid, lv)
      local gameObj = 1 == index and baseGameObj or binder:Instantiate(baseGameObj, baseGameObj.transform.parent)
      gameObj:SetActive(true)
      local ui = Item_Battle_TalentResource(gameObj)
      binder:SetText(ui.Text_Talent_Name, talentName)
      binder:SetText(ui.Text_Talent_Desc, talentDesc)
      binder:SetText(ui.Text_Talent_Lv, "Lv." .. lv)
      AutoAdaptionText.StartAutoAdaptionText(ui.Text_Talent_Name)
      StrUtils.SetPreferredHeight(ui.Text_Talent_Desc)
    end
  end
end

function AwakerInfoPanelNew:GetWeaponState()
  if self.weaponState then
    return self.weaponState
  end
  local awakerUid = self.awakerInfoModel:GetPvPAwakerUid()
  for _, state in pairs(bg.battleDataCenter.stateData:GetStateListByOwner(awakerUid)) do
    local stateCfg = DT.State[state.stateId] or {}
    local sc = BattleStateDataClient(state)
    if not sc:ShowJudgement() then
    elseif stateCfg.ShowType and stateCfg.ShowType == CommonDefine.StateShowType.WeaponIconAndDesc then
      self.weaponState = state
      return state
    end
  end
end

function AwakerInfoPanelNew:_GetDuplicateSuitValidAwakerName(suitId)
  local isUniqueEffectSuit = AwakerTrinketDataUtils.CheckTrinketEffectTeamUnique(suitId)
  if not isUniqueEffectSuit then
    return
  end
  local curAwakerTid = self.awakerInfoModel:GetAwakerTid()
  local validSuitAwakerTid
  local stageData = WorldStageManager.Instance:GetCurStageData()
  if stageData and stageData.role and stageData.role.awakerInfos then
    for _, awakerInfo in ipairs(stageData.role.awakerInfos) do
      if nil ~= validSuitAwakerTid then
        break
      end
      local awakerTid = awakerInfo and awakerInfo.tid
      local trinketSuitId = AwakerTrinketDataUtils.GetTrinketSuitId(awakerInfo)
      if not awakerTid or not trinketSuitId then
      elseif trinketSuitId ~= suitId then
      else
        validSuitAwakerTid = awakerTid
      end
    end
  end
  if validSuitAwakerTid and validSuitAwakerTid ~= curAwakerTid then
    local awakerName = AwakerDataUtils.GetAwakerName(validSuitAwakerTid)
    return awakerName
  end
  return
end

return AwakerInfoPanelNew
