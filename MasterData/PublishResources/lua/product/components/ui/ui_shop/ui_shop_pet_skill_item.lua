_class("UIShopPetSkillItem", UICustomWidget)
UIShopPetSkillItem = UIShopPetSkillItem

function UIShopPetSkillItem:Constructor()
  self._index = 1
  self._skillConfigHelper = SkillConfigHelper:New()
end

function UIShopPetSkillItem:OnShow()
  self._go = self:GetGameObject()
  self._Anim = self:GetUIComponent("Animation", "Anim")
  self._imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self._txtSkill = self:GetUIComponent("UILocalizationText", "txtSkill")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._txtDesc = self:GetUIComponent("UILocalizedTMP", "txtDesc")
  
  function self._txtDesc.onHrefClick(hrefName)
    GameGlobal.UIStateManager():ShowDialog("UISkillHrefInfo", hrefName)
  end
  
  self._txtEnergy = self:GetUIComponent("UILocalizationText", "txtEnergy")
  self._energy = self:GetGameObject("energy")
  self._chain = self:GetGameObject("chain")
  self._chainSkill = self:GetUIComponent("UISelectObjectPath", "chainSkill")
  self._btnScope = self:GetGameObject("btnScope")
  self._btnScopeImg = self:GetUIComponent("Image", "btnScope")
  self._btnTex = self:GetUIComponent("UILocalizationText", "btnTex")
  self._skillIconRect = self:GetUIComponent("RectTransform", "imgIcon")
  self._sv = self:GetUIComponent("ScrollRect", "ScrollView")
  self:AttachEvent(GameEventType.OnUISkillScopeClose, self.OnUISkillScopeClose)
  self._module = self:GetModule(PetModule)
  self._chainSkillSpawns = nil
  local sop = self:GetUIComponent("UISelectObjectPath", "preattack")
  sop:SpawnObject("UIPreAttackItem")
  self.preAttackCell = sop:GetAllSpawnList()[1]
  self.preAttackCell:Enable(false)
  self._activeVar = self:GetUIComponent("UISelectObjectPath", "activeVar")
  self._activeVarGo = self:GetGameObject("activeVar")
  self._topCanvasGroup = self:GetUIComponent("CanvasGroup", "top")
  local activeVarTip = self:GetUIComponent("UISelectObjectPath", "activeVarTip")
  self._activeVarTip = activeVarTip:SpawnObject("UIActiveVarTip")
  self._activeVarTipGo = self:GetGameObject("activeVarTip")
end

function UIShopPetSkillItem:ShowInAnim()
  self._Anim:Play("uieff_UIShopPetSkillItem_in")
end

function UIShopPetSkillItem:HideAnim()
  self._topCanvasGroup.alpha = 0
end

function UIShopPetSkillItem:ShowPreAttack()
  if self.preAttackCell then
    self.preAttackCell:SetData(nil, self._skillID, true, self.pet)
  end
end

function UIShopPetSkillItem:OnHide()
  if self._imgIcon then
    self._imgIcon:DestoryLastImage()
  end
  self:DetachEvent(GameEventType.OnUISkillScopeClose, self.OnUISkillScopeClose)
end

function UIShopPetSkillItem:SetActiveVar()
  self._activeVarGo:SetActive(false)
  self._activeVarTipGo:SetActive(false)
  local cfg
  cfg = BattleSkillCfg(self._skillID)
  if cfg then
    local skillType = cfg.Type
    if skillType == PetSkillType.SkillType_Active then
      local activeVar
      local activeSkillID = self._skillID
      local activeVarTab = self.pet:GetPetVariantActiveSkill()
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
        end, UIFightSkillActiveVarFromType.Shop)
      end
    elseif skillType == PetSkillType.SkillType_ChainSkill then
      local count = table.count(self._skillList)
      if 1 < count then
        self._activeVarGo:SetActive(true)
        self._activeVarPool = self._activeVar:SpawnObject("UIFightSkillActiveVar")
        self._activeVarPool:SetData(count, self._index, function(idx)
          self:ChangeVarIdx(idx)
        end, UIFightSkillActiveVarFromType.Shop)
      end
    end
  end
end

function UIShopPetSkillItem:ChangeVarIdx(idx)
  local cfg = BattleSkillCfg(self._skillID)
  if cfg.Type == PetSkillType.SkillType_ChainSkill then
    self._index = idx
    local skills = {}
    local len = table.count(self._skillList)
    for i, v in ipairs(self._skillList) do
      local skillData = self._skillConfigHelper:GetSkillData(v)
      local skill = {
        id = skillData:GetID(),
        name = skillData:GetSkillName(),
        desc = skillData:GetPetSkillDes(),
        icon = skillData:GetSkillIcon(),
        chainCount = skillData:GetSkillTriggerParam()
      }
      table.insert(skills, skill)
    end
    self:ImgIconDOFadeCallback(len, skills)
  else
    local skillid = self._activeVarTab[idx]
    self._skillID = skillid
    self:RefreshData()
  end
end

function UIShopPetSkillItem:RefreshData()
  local skill_cfg = BattleSkillCfg(self._skillID)
  local skillType = skill_cfg.Type
  local skillTypeStr = ""
  local id
  if skillType == PetSkillType.SkillType_Active then
    skillTypeStr = "str_pet_config_common_major_des"
    id = self._skillID
  elseif skillType == PetSkillType.SkillType_ChainSkill then
    skillTypeStr = "str_pet_config_common_chain_des"
    id = self._skillList
  elseif skillType == PetSkillType.SkillType_Passive then
    skillTypeStr = "str_pet_config_skill_equip"
    id = self._skillID
  end
  self._txtSkill:SetText(StringTable.Get(skillTypeStr))
  self._chainSkillSpawns = nil
  self._chainSkillSpawns = nil
  if skillType == PetSkillType.SkillType_ChainSkill then
    self._energy:SetActive(false)
    self._chain:SetActive(true)
    local skills = {}
    local len = table.count(id)
    self._chainSkill:SpawnObjects("UIPetChainSkillItem", len)
    self._chainSkillSpawns = self._chainSkill:GetAllSpawnList()
    for i, v in ipairs(id) do
      local skillConfigData = self._skillConfigHelper:GetSkillData(v)
      local skill = {
        id = skillConfigData:GetID(),
        name = skillConfigData:GetSkillName(),
        desc = skillConfigData:GetPetSkillDes(),
        icon = skillConfigData:GetSkillIcon(),
        chainCount = skillConfigData:GetSkillTriggerParam()
      }
      table.insert(skills, skill)
      self._chainSkillSpawns[i]:Flush(skill)
    end
    self._index = 1
    if len == 1 then
      self:FlushOtherSkill(skills[1], len, PetSkillType.SkillType_ChainSkill)
    else
      self:ImgIconDOFadeCallback(len, skills)
    end
  elseif skillType == PetSkillType.SkillType_Active then
    self._chain:SetActive(false)
    local skillConfigData = self._skillConfigHelper:GetSkillData(id)
    if skillConfigData then
      self._go:SetActive(true)
      if UILogicPetHelper.ShowSkillEnergy(skillConfigData:GetSkillTriggerType()) then
        self._energy:SetActive(true)
      else
        self._energy:SetActive(false)
      end
      local skill = {
        id = skillConfigData:GetID(),
        name = skillConfigData:GetSkillName(),
        desc = skillConfigData:GetPetSkillDes(),
        icon = skillConfigData:GetSkillIcon(),
        chainCount = skillConfigData:GetSkillTriggerParam()
      }
      self:FlushOtherSkill(skill, PetSkillType.SkillType_Active)
      self._txtEnergy:SetText(StringTable.Get("str_discovery_cool_down", skillConfigData:GetSkillTriggerParam()))
    else
      self._go:SetActive(false)
    end
  elseif skillType == PetSkillType.SkillType_Passive then
    self._energy:SetActive(false)
    self._chain:SetActive(false)
    local confV = BattleSkillCfg(id)
    if confV then
      self._go:SetActive(true)
      local skill = {
        id = confV.ID,
        name = confV.Name,
        desc = confV.Desc,
        icon = confV.Icon,
        chainCount = confV.TriggerParam
      }
      self:FlushEquipSkill(skill)
    else
      self._go:SetActive(false)
    end
  end
  if self._sv then
    self._sv.verticalNormalizedPosition = 1
  end
end

function UIShopPetSkillItem:Flush(nIndex, clientPet, skill_id_list)
  self.pet = clientPet
  self._petId = clientPet:GetTemplateID()
  self._skillList = skill_id_list
  self._skillID = skill_id_list[1]
  self:SetActiveVar()
  self:RefreshData()
  self:ShowPreAttack()
end

function UIShopPetSkillItem:ImgIconDOFadeCallback(len, skills)
  local skill = skills[self._index]
  if skill then
    self:FlushOtherSkill(skill, len)
  end
end

function UIShopPetSkillItem:FlushEquipSkill(skill, len)
  local descStr = HelperProxy:GetInstance():GetEquipSkillDesc(skill.desc, self.pet:GetTemplateID(), self.pet:GetEquipLv(), skill.id)
  self._txtDesc:SetText(descStr)
  self:FlushSkill(skill, len)
end

function UIShopPetSkillItem:FlushOtherSkill(skill, len)
  self._txtDesc:SetText(skill.desc)
  self:FlushSkill(skill, len)
end

function UIShopPetSkillItem:FlushSkill(skill, len)
  self._imgIcon:DestoryLastImage()
  self._imgIcon:LoadImage(skill.icon)
  self._txtName:SetText(StringTable.Get(skill.name))
  self._canViewSkillScope = self._module:CanSkillPreview(skill.id)
  if self._btnScope then
    self._btnScope:SetActive(self._canViewSkillScope or false)
  end
  if self._canViewSkillScope then
    self._atlas = self:GetAsset("UIShop.spriteatlas", LoadType.SpriteAtlas)
    self._state2sprite = {
      [1] = "spirit_xiangqing_btn4",
      [2] = "spirit_xiangqing_btn3"
    }
    self._state2texColor = {
      [1] = Color(1, 1, 1, 1),
      [2] = Color(0.5686274509803921, 0.5686274509803921, 0.5686274509803921, 1)
    }
  end
  if self._chainSkillSpawns then
    for i, v in ipairs(self._chainSkillSpawns) do
      v:FlushSelect(skill.id, len)
    end
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FlushSkillScope, skill.id)
end

function UIShopPetSkillItem:imgIconOnClick(go)
  Log.warn("### imgIconOnClick ")
end

function UIShopPetSkillItem:btnScopeOnClick(go)
  if self._canViewSkillScope then
    self._btnScopeImg.sprite = self._atlas:GetSprite(self._state2sprite[2])
    self._btnTex.color = self._state2texColor[2]
  end
  self._skillIconRect.sizeDelta = Vector2(162, 157)
  local cfg = BattleSkillCfg(self._skillID)
  local skillID
  if cfg.Type ~= PetSkillType.SkillType_ChainSkill then
    skillID = self._skillID
  else
    skillID = self._skillList[self._index]
  end
  self:ShowDialog("UISkillScope", skillID, nil, self._btnScope.transform, self.pet)
end

function UIShopPetSkillItem:OnUISkillScopeClose()
  if self._canViewSkillScope then
    self._btnScopeImg.sprite = self._atlas:GetSprite(self._state2sprite[1])
    self._btnTex.color = self._state2texColor[1]
  end
  self._skillIconRect.sizeDelta = Vector2(146, 141)
end
