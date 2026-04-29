_class("UIFightSkillItem", UICustomWidget)
UIFightSkillItem = UIFightSkillItem

function UIFightSkillItem:Constructor()
  self._pstId = 0
  self._skillInfo = nil
  self._index = 1
  self._chaincount = 0
  self._event = nil
  self._timer = 0
  self._skillConfigHelper = SkillConfigHelper:New()
end

function UIFightSkillItem:OnShow(uiParams)
  self._rectTransform = self:GetUIComponent("RectTransform", "UIFightSkillItem")
  self._showTipBtnImg = self:GetUIComponent("Image", "showTipBtn")
  self._skillIconRawImageLoader = self:GetUIComponent("RawImageLoader", "skillIcon")
  self._txtSkillDes = self:GetUIComponent("UILocalizedTMP", "txtSkillDes")
  
  function self._txtSkillDes.onHrefClick(hrefName)
    GameGlobal.UIStateManager():ShowDialog("UISkillHrefInfo", hrefName)
  end
  
  self._sv = self:GetUIComponent("ScrollRect", "ScrollView")
  self._skillName = self:GetUIComponent("RollingText", "skillName")
  self._skillTypeName = self:GetUIComponent("UILocalizationText", "skillTypeName")
  self._powerText = self:GetUIComponent("UILocalizationText", "powerValue")
  self._powerValueBG = self:GetUIComponent("Image", "powerValueBG")
  self._rowPool = self:GetUIComponent("UISelectObjectPath", "chainList")
  self._chain = self:GetGameObject("chainList")
  self._power = self:GetGameObject("powerValueBG")
  self._chain:SetActive(false)
  self._power:SetActive(false)
  self._timer = Cfg.cfg_global.skill_chain_time.IntValue
  self._tr = self:GetUIComponent("Transform", "showTipBtn")
  self._btnGo = self:GetGameObject("showTipBtn")
  self._btnTex = self:GetUIComponent("UILocalizationText", "btnTex")
  self._anim = self:GetUIComponent("Animation", "UIFightSkillItem")
  self._activeVar = self:GetUIComponent("UISelectObjectPath", "activeVar")
  self._activeVarGo = self:GetGameObject("activeVar")
  self._flagIconBaseGo = self:GetGameObject("flagIconBaseGo")
  self._flagIconBaseGo:SetActive(false)
  self._flagIcon = self:GetUIComponent("RawImageLoader", "flagIcon")
  local activeVarTip = self:GetUIComponent("UISelectObjectPath", "activeVarTip")
  self._activeVarTip = activeVarTip:SpawnObject("UIActiveVarTip")
  self._activeVarTipGo = self:GetGameObject("activeVarTip")
  local sop = self:GetUIComponent("UISelectObjectPath", "preattack")
  sop:SpawnObject("UIPreAttackItem")
  self.preAttackCell = sop:GetAllSpawnList()[1]
  self.preAttackCell:Enable(false)
  self:AttachEvent(GameEventType.CloseSkillScope, self.CloseSkillScope)
end

function UIFightSkillItem:OnHide()
  self:DetachEvent(GameEventType.CloseSkillScope, self.CloseSkillScope)
end

function UIFightSkillItem:CloseSkillScope()
  if self._isOpenShow then
    if self._canViewSkillScope then
      self._showTipBtnImg.sprite = self._atlas:GetSprite(self._state2sprite[2])
      self._btnTex.color = self._state2texColor[1]
    end
    self._isOpenShow = false
  end
end

function UIFightSkillItem:SetData(skillInfo, petData, idx, hideTop, equipLv, grade, bbreak)
  self._petData = petData
  self._equipLv = equipLv
  self._pstId = self._petData:GetPstID()
  self._petId = self._petData:GetTemplateID()
  self._grade = grade
  if self._grade then
    self._usePetID = self._petId
  else
    self._usePetID = nil
  end
  self._awaking = bbreak
  if skillInfo == nil then
    return
  end
  self._skillInfo = skillInfo
  self._skillID = self._skillInfo.skillList[1]
  self:SetActiveVar()
  self:RefreshData()
  self:ShowPreAttack()
  self._isOpenShow = false
  if idx then
    if idx == 1 then
      self._anim:Play("uieff_HelpPet_Skill1")
    elseif idx == 2 then
      self._anim:Play("uieff_HelpPet_Skill2")
    elseif idx == 3 then
      self._anim:Play("uieff_HelpPet_Skill3")
    elseif idx == 4 then
      self._anim:Play("uieff_HelpPet_Skill4")
    end
  end
  if hideTop then
    local skillTypeGo = self:GetGameObject("skillTypeName")
    local skillNameGo = self:GetGameObject("skillRect")
    skillTypeGo:SetActive(false)
    skillNameGo:SetActive(false)
  end
end

function UIFightSkillItem:RefreshData()
  self:CanViewSkillScope()
  self:SetText()
  self:ShowChain()
  self:ShowPower()
end

function UIFightSkillItem:CanViewSkillScope()
  local petModule = GameGlobal.GetModule(PetModule)
  self._canViewSkillScope = petModule:CanSkillPreview(self._skillID)
  self._btnGo:SetActive(self._canViewSkillScope or false)
  if self._canViewSkillScope then
    if not self._atlas then
      self._atlas = self:GetAsset("UIPetDetail.spriteatlas", LoadType.SpriteAtlas)
    end
    self._state2sprite = {
      [1] = "spirit_xiangqing_btn4",
      [2] = "spirit_xiangqing_btn3"
    }
    self._state2texColor = {
      [1] = Color(1, 1, 1, 1),
      [2] = Color(0.5686274509803921, 0.5686274509803921, 0.5686274509803921, 1)
    }
  end
end

function UIFightSkillItem:SetActiveVar()
  self._activeVarGo:SetActive(false)
  self._activeVarTipGo:SetActive(false)
  local cfg
  cfg = BattleSkillCfg(self._skillID)
  if cfg then
    local skillType = cfg.Type
    if skillType == PetSkillType.SkillType_Active then
      local activeVar
      local activeSkillID = self._skillID
      local activeVarTab
      if self._skillInfo.param then
        activeVarTab = self._skillInfo.param
      else
        activeVarTab = self._petData:GetPetVariantActiveSkill()
      end
      if activeVarTab and table.count(activeVarTab) > 0 then
        activeVar = activeVarTab[activeSkillID]
      end
      if activeVar and table.count(activeVar) > 0 then
        self._activeVarIdx = 1
        self._activeVarTab = {}
        table.insert(self._activeVarTab, self._skillID)
        for index, value in ipairs(activeVar) do
          table.insert(self._activeVarTab, value)
        end
        self._activeVarTipGo:SetActive(true)
        self._activeVarGo:SetActive(true)
        self._activeVarPool = self._activeVar:SpawnObject("UIFightSkillActiveVar")
        local count = #self._activeVarTab
        self._activeVarPool:SetData(count, self._activeVarIdx, function(idx)
          self:ChangeVarIdx(idx)
        end, UIFightSkillActiveVarFromType.Detail)
      end
    elseif skillType == PetSkillType.SkillType_ChainSkill then
      local count = table.count(self._skillInfo.skillList)
      if 1 < count then
        self._activeVarGo:SetActive(true)
        self._activeVarPool = self._activeVar:SpawnObject("UIFightSkillActiveVar")
        self._activeVarPool:SetData(count, self._index, function(idx)
          self:ChangeVarIdx(idx)
        end, UIFightSkillActiveVarFromType.Detail)
      end
    end
  end
end

function UIFightSkillItem:ShowPreAttack()
  if self.preAttackCell then
    self.preAttackCell:SetData(self._pstId, self._skillID, true, nil, self._usePetID, self._grade, self._awaking)
  end
end

function UIFightSkillItem:showTipBtnOnClick(go)
  if self._isOpenShow == false then
    self._isOpenShow = true
    if self._canViewSkillScope then
      self._showTipBtnImg.sprite = self._atlas:GetSprite(self._state2sprite[1])
      self._btnTex.color = self._state2texColor[2]
    end
    local cfg = BattleSkillCfg(self._skillID)
    local skillID
    if cfg.Type ~= PetSkillType.SkillType_ChainSkill then
      skillID = self._skillID
    else
      skillID = self._skillInfo.skillList[self._index]
    end
    self:ShowDialog("UISkillScope", skillID, self._pstId, self._tr, self._petData)
  end
end

function UIFightSkillItem:SetText()
  local skillTypeStr, cfg
  cfg = BattleSkillCfg(self._skillID)
  if cfg then
    local skillType = cfg.Type
    if skillType == PetSkillType.SkillType_ChainSkill then
      skillTypeStr = "str_pet_config_skill_chain"
    elseif skillType == PetSkillType.SkillType_Active then
      skillTypeStr = "str_pet_config_skill_major"
    elseif skillType == PetSkillType.SkillType_Passive then
      skillTypeStr = "str_pet_config_skill_equip"
    end
    if skillType == PetSkillType.SkillType_ChainSkill or skillType == PetSkillType.SkillType_Active then
      local skillConfigData = self._skillConfigHelper:GetSkillData(self._skillID)
      self._skillName:RefreshText(StringTable.Get(skillConfigData:GetSkillName()))
      self._skillIconRawImageLoader:LoadImage(skillConfigData:GetSkillIcon())
      if skillType == PetSkillType.SkillType_Active and self._flagIconBaseGo then
        local variantSkillFlagCfg = Cfg.cfg_variant_skill_flag_icon[self._skillID]
        if variantSkillFlagCfg then
          local flagIconID = variantSkillFlagCfg.FlagIcon
          self._flagIconBaseGo:SetActive(true)
          self._flagIcon:LoadImage(flagIconID)
        else
          self._flagIconBaseGo:SetActive(false)
        end
      end
      if not self:CheckRefineSkillReplace(self._skillID) then
        local descForceParam = {}
        if skillType == PetSkillType.SkillType_Active then
          local extraParam = skillConfigData:GetSkillTriggerExtraParam()
          if extraParam and extraParam[SkillTriggerTypeExtraParam.SanChangeByRoundCastTimes] then
            local baseCost = extraParam[SkillTriggerTypeExtraParam.SanValue]
            local modCost = extraParam[SkillTriggerTypeExtraParam.SanChangeByRoundCastTimes]
            local curTimes = 0
            local curCost = baseCost + modCost * curTimes
            table.insert(descForceParam, tostring(curCost))
          end
        end
        self._txtSkillDes:SetText(skillConfigData:GetPetSkillDes(descForceParam))
      end
    else
      self._skillName:RefreshText(StringTable.Get(cfg.Name))
      self._skillIconRawImageLoader:LoadImage(cfg.Icon)
      local equipLv
      if self._equipLv then
        equipLv = self._equipLv
      else
        equipLv = self._petData:GetEquipLv()
      end
      if equipLv == 0 then
        equipLv = 1
      end
      if not self:CheckRefineSkillReplace(self._skillID) then
        local descStr = HelperProxy:GetInstance():GetEquipSkillDesc(cfg.Desc, self._petData:GetTemplateID(), equipLv, self._skillID)
        self._txtSkillDes:SetText(descStr)
      end
    end
    self._skillTypeName:SetText(StringTable.Get(skillTypeStr))
  end
  if self._sv then
    self._sv.verticalNormalizedPosition = 1
  end
end

function UIFightSkillItem:ChangeVarIdx(idx)
  local cfg = BattleSkillCfg(self._skillID)
  if cfg.Type == PetSkillType.SkillType_ChainSkill then
    self._index = idx
    self:TimerEndCallBack()
  else
    local skillid = self._activeVarTab[idx]
    self._skillID = skillid
    self:RefreshData()
  end
end

function UIFightSkillItem:ShowChain()
  local cfg = BattleSkillCfg(self._skillID)
  if cfg == nil then
    Log.error("BattleSkillCfg no skill:" .. self._skillID)
    return
  end
  if cfg.Type ~= PetSkillType.SkillType_ChainSkill then
    self._chain:SetActive(false)
  else
    self._chain:SetActive(true)
    self._chaincount = table.count(self._skillInfo.skillList)
    if self._chaincount > 1 then
      self:InitChainItem(true)
    else
      self:InitChainItem(false)
    end
  end
end

function UIFightSkillItem:OnHide()
  self:Release()
end

function UIFightSkillItem:Release()
  self._skillInfo = nil
  self._skillIconRawImageLoader = nil
  self._txtSkillDes = nil
  self._skillName = nil
  self._skillTypeName = nil
  self._powerText = nil
  self._rowPool = nil
  self._chain = nil
  self._power = nil
  self._skillChain = nil
end

function UIFightSkillItem:InitChainItem(isMoreThanOne)
  if self._rowPool then
    self._rowPool:SpawnObjects("UIChainItem", self._chaincount)
    local rowList = self._rowPool:GetAllSpawnList()
    for itemIndex = 1, self._chaincount do
      local chainItem = rowList[itemIndex]
      if itemIndex > self._chaincount then
        chainItem:GetGameObject():SetActive(false)
      else
        self:_ShowChainItem(chainItem, itemIndex, isMoreThanOne)
      end
    end
  end
end

function UIFightSkillItem:UpdateChainItem(cfg)
  if self._rowPool then
    local rowList = self._rowPool:GetAllSpawnList()
    for itemIndex = 1, self._chaincount do
      local chainItem = rowList[itemIndex]
      chainItem:HideBright(self._index)
    end
    if self._isOpenShow then
      local skillID = self._skillInfo.skillList[self._index]
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FlushSkillScope, skillID)
    end
  end
end

function UIFightSkillItem:_ShowChainItem(chainItem, itemIndex, isMoreThanOne)
  local skillID = self._skillInfo.skillList[itemIndex]
  chainItem:SetData(skillID, self._index, itemIndex, isMoreThanOne)
end

function UIFightSkillItem:ShowPower()
  local cfg = BattleSkillCfg(self._skillInfo.skillList[self._index])
  if cfg then
    self._power:SetActive(false)
    if cfg.Type == PetSkillType.SkillType_Active then
      if UILogicPetHelper.ShowSkillEnergy(cfg.TriggerType) then
        self._power:SetActive(true)
        self._powerText:SetText(StringTable.Get("str_pet_config_skill_cold_colon") .. cfg.TriggerParam .. StringTable.Get("str_pet_config_skill_turn"))
      end
    elseif cfg.Type == PetSkillType.SkillType_Passive then
    end
  end
end

function UIFightSkillItem:TimerEndCallBack()
  local cfg = BattleSkillCfg(self._skillInfo.skillList[self._index])
  if cfg then
    self:UpdateChainItem(cfg)
    local skillConfigData = self._skillConfigHelper:GetSkillData(self._skillInfo.skillList[self._index])
    self._skillName:RefreshText(StringTable.Get(skillConfigData:GetSkillName()))
    if not self:CheckRefineSkillReplace(self._skillInfo.skillList[self._index]) then
      self._txtSkillDes:SetText(skillConfigData:GetPetSkillDes())
    end
  end
end

function UIFightSkillItem:CheckRefineSkillReplace(skillId)
  if not self._petData or not skillId then
    return false
  end
  local refineLv = self._petData:GetEquipRefineLv()
  if refineLv < 1 then
    return false
  end
  local refineConfig = UIPetEquipHelper.GetRefineCfg(self._petData:GetTemplateID(), refineLv)
  if not refineConfig then
    return false
  end
  local replaceData = refineConfig.SubstituteSkillDesc
  if not replaceData then
    return false
  end
  local newDesc
  for k, v in pairs(replaceData) do
    newDesc = v[skillId]
    if newDesc and newDesc ~= "" then
      break
    end
  end
  if newDesc then
    self._txtSkillDes:SetText(StringTable.Get(newDesc))
    return true
  end
  return false
end
