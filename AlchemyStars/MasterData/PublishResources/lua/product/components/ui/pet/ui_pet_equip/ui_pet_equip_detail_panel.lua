_class("UIPetEquipDetailPanel", UICustomWidget)
UIPetEquipDetailPanel = UIPetEquipDetailPanel

function UIPetEquipDetailPanel:OnShow(uiParams)
  self:InitWidget()
end

function UIPetEquipDetailPanel:InitWidget()
  self._atk = self:GetUIComponent("UILocalizationText", "atkV")
  self._def = self:GetUIComponent("UILocalizationText", "defV")
  self._hp = self:GetUIComponent("UILocalizationText", "hpV")
  self._attPool = self:GetUIComponent("UISelectObjectPath", "attPool")
  self._atts = self:GetGameObject("atts")
  self._maxLv = self:GetGameObject("maxLv")
  self._skill = self:GetUIComponent("RectTransform", "skill")
  self._skillDesc = self:GetUIComponent("UILocalizedTMP", "skillDesc")
  
  function self._skillDesc.onHrefClick(hrefName)
    GameGlobal.UIStateManager():ShowDialog("UISkillHrefInfo", hrefName)
  end
  
  self._skillIcon = self:GetUIComponent("RawImageLoader", "skillIcon")
  self._skillInfoBtnGo = self:GetGameObject("skillUpInfoBtn")
  self._attInfoBtnGo = self:GetGameObject("attUpInfoBtn")
  self._refineItemPool = self:GetUIComponent("UISelectObjectPath", "refineItem")
  self.onlyIntroGo = self:GetGameObject("onlyIntroGo")
  self.introlAndUpGo = self:GetGameObject("introlAndUpGo")
  self._lv = self:GetUIComponent("UILocalizationText", "lv")
  self.animation = self:GetUIComponent("Animation", "animation")
end

function UIPetEquipDetailPanel:SetData(petData)
  self._petData = petData
  self._petId = self._petData:GetTemplateID()
  self._pstId = self._petData:GetPstID()
  self._currentEquipLv = self._petData:GetEquipLv()
  self._elem = self._petData:GetPetFirstElement()
  self._equipMaxLv = 0
  local cfg_equip = Cfg.cfg_pet_equip({
    PetID = self._petId
  })
  if cfg_equip and 0 < #cfg_equip then
    for k, subCfg in pairs(cfg_equip) do
      if subCfg.Level > self._equipMaxLv then
        self._equipMaxLv = subCfg.Level
      end
    end
  else
    Log.fatal("###[UIPetEquipDetailPanel] cfg_pet_equip is nil ! id --> ", self._petId)
  end
  self:_CheckInfoBtnActive()
  self:_ShowEquipInfo()
  self:_ShowPetRefineInfo()
end

function UIPetEquipDetailPanel:_CheckInfoBtnActive()
  local cfg_equip = Cfg.cfg_pet_equip({
    PetID = self._petId
  })
  if not cfg_equip then
    Log.fatal("###[UIPetEquipController] cfg_equip is nil ! id --> ", self._petId)
  end
  table.sort(cfg_equip, function(a, b)
    return a.Level < b.Level
  end)
  local dataCount = 0
  local skillCount = 0
  local attInfoBtnActive = false
  local skillInfoBtnActive = false
  for i = 1, #cfg_equip do
    local cfgData = cfg_equip[i]
    if 1 < cfgData.Level then
      local cfgDataLast = cfg_equip[i - 1]
      local addPro = cfgData.PropertyRestraint - cfgDataLast.PropertyRestraint
      local addAtk = cfgData.Attack - cfgDataLast.Attack
      local addDef = cfgData.Defence - cfgDataLast.Defence
      local addHp = cfgData.Health - cfgDataLast.Health
      if addPro ~= 0 or addAtk ~= 0 or addDef ~= 0 or addHp ~= 0 then
        dataCount = dataCount + 1
      end
    end
    if cfgData.IsParamImprove and cfgData.IsParamImprove == 1 then
      skillCount = skillCount + 1
    end
  end
  if 0 < dataCount then
    attInfoBtnActive = true
  end
  self._attInfoBtnGo:SetActive(attInfoBtnActive)
  if 0 < skillCount then
    skillInfoBtnActive = true
  end
  self._skillInfoBtnGo:SetActive(skillInfoBtnActive)
end

function UIPetEquipDetailPanel:_ShowEquipInfo()
  self:_CheckMaxLv()
  self._lv:SetText(StringTable.Get("str_pet_equip_Lv") .. self._currentEquipLv)
  local isShowAtt = self:_IsShowAtt()
  if isShowAtt then
    self._atts:SetActive(true)
    self:_ShowAttInfo()
  else
    self._atts:SetActive(false)
  end
  self:_ShowSkillInfo()
end

function UIPetEquipDetailPanel:_CheckMaxLv()
  if self._currentEquipLv >= self._equipMaxLv then
    self.onlyIntroGo:SetActive(true)
    self.introlAndUpGo:SetActive(false)
  else
    self.onlyIntroGo:SetActive(false)
    self.introlAndUpGo:SetActive(true)
  end
end

function UIPetEquipDetailPanel:_IsShowAtt()
  return true
end

function UIPetEquipDetailPanel:_ShowAttInfo()
  local cfg_pet_equip = Cfg.cfg_pet_equip({
    PetID = self._petId,
    Level = self._currentEquipLv
  })
  if not cfg_pet_equip then
    Log.fatal("###[UIPetEquipController]cfg_pet_equip is nil ! id --> ", self._petId, "|level --> ", self._currentEquipLv)
    return
  end
  local atk = cfg_pet_equip[1].Attack
  local def = cfg_pet_equip[1].Defence
  local hp = cfg_pet_equip[1].Health
  self._atk:SetText("+" .. atk)
  self._def:SetText("+" .. def)
  self._hp:SetText("+" .. hp)
  local elemValue = cfg_pet_equip[1].PropertyRestraint
  local attItem = self._attPool:SpawnObject("UIPetEquipElemItem")
  attItem:SetData(self._elem, elemValue)
end

function UIPetEquipDetailPanel:_ShowSkillInfo()
  local skillID = self._petData:GetPetPassiveSkill()
  local cfg = BattleSkillCfg(skillID)
  if cfg then
    self._skillIcon:LoadImage(cfg.Icon)
    self._skillDesc:SetText(HelperProxy:GetInstance():GetPetSkillDescFull(self._petData, skillID, true))
  end
end

function UIPetEquipDetailPanel:_ShowPetRefineInfo()
  if not UIPetEquipHelper.HasRefine(self._petId) then
    return
  end
  if not self._refineItem then
    self._refineItem = self._refineItemPool:SpawnObject("UIPetEquipLvIcon")
  end
  self._refineItem:SetData(self._petData)
end

function UIPetEquipDetailPanel:UpBtnOnClick()
  local aps = GameGlobal.GetModule(SerialAutoFightModule):GetApsData()
  aps:SetTrack(true)
  self:ShowDialog("UIPetEquipUpLevelController", self._petData)
end

function UIPetEquipDetailPanel:IntrBtnOnClick(go)
  self:ShowDialog("UIPetEquipIntrController", self._petId)
end

function UIPetEquipDetailPanel:IntrBtn2OnClick(go)
  self:ShowDialog("UIPetEquipIntrController", self._petId)
end

function UIPetEquipDetailPanel:SkillUpInfoBtnOnClick(go)
  local skillID = self._petData:GetPetPassiveSkill()
  self:ShowDialog("UIPetEquipUpLvInfoController", self._petData, self._currentEquipLv, skillID)
end

function UIPetEquipDetailPanel:AttUpInfoBtnOnClick(go)
  self:ShowDialog("UIPetEquipUpLvInfoController", self._petData, self._currentEquipLv)
end

function UIPetEquipDetailPanel:PlayAni(aniName)
  if self.animation then
    self.animation:Play(aniName)
  end
end
