_class("UIPreAttackItem", UICustomWidget)
UIPreAttackItem = UIPreAttackItem

function UIPreAttackItem:OnShow()
  self.infoGO = self:GetGameObject("info")
  self:AttachEvent(GameEventType.OnUIEmptyClose, self.OnUIEmptyClose)
end

function UIPreAttackItem:SetData(petPstId, skillId, canClick, clientPetInfo, petid, grade, bbreak)
  self._petPstId = petPstId
  self._skillId = skillId
  self._canClick = canClick
  self._clientPetInfo = clientPetInfo
  self._usePetID = petid
  self._grade = grade
  self._break = bbreak
  self:ShowPreAttack()
end

function UIPreAttackItem:OnHide()
  self:DetachEvent(GameEventType.OnUIEmptyClose, self.OnUIEmptyClose)
end

function UIPreAttackItem:bgOnClick()
  if self._canClick then
    self.infoGO:SetActive(true)
    if not self._pos then
      self._pos = self:GetUIComponent("RectTransform", "info")
    end
    if not self._safe then
      self._safe = self:FindParentWithName(self._pos)
    end
    local posOffset = self._pos.position - self._safe.position
    self:ShowDialog("UIEmptyController", posOffset, self._pos.sizeDelta)
  end
end

function UIPreAttackItem:OnUIEmptyClose()
  self.infoGO:SetActive(false)
end

function UIPreAttackItem:FindParentWithName(trans)
  if trans.parent.name == "SafeArea" then
    return trans.parent
  else
    return self:FindParentWithName(trans.parent)
  end
end

function UIPreAttackItem:_IsPetSkillPreemptive()
  if not self._petPstId then
    return self._clientPetInfo and self._clientPetInfo:HasPreEmptiveAttack()
  end
  local matchModule = self:GetModule(MatchModule)
  local enterData = matchModule:GetMatchEnterData()
  if GameGlobal:GetInstance():IsCoreGameRunning() and enterData then
    local matchPlayerInfo = enterData:GetLocalPlayerInfo()
    local petList = matchPlayerInfo.pet_list
    for _, matchPetInfo in ipairs(petList) do
      if matchPetInfo.pet_pstid == self._petPstId then
        local resourceHelper = ResourceHelper:GetInstance()
        local petSkill = resourceHelper:GetPetSKill()
        local cfgPetSkill = petSkill:GetSKill(matchPetInfo.template_id, matchPetInfo.grade, matchPetInfo.awakening)
        if not cfgPetSkill.IntensifyBuff then
          return false
        end
        local activeType, activeSkill = self:IsActiveOrExtraSkill(matchPetInfo.template_id, matchPetInfo.grade, matchPetInfo.awakening)
        if activeType then
          if activeSkill then
            return table.icontains(cfgPetSkill.IntensifyBuff, BattleConst.PreAttackBuffId)
          else
            return table.icontains(cfgPetSkill.IntensifyBuff, BattleConst.PreAttackBuffIdForExtra)
          end
        end
        return false
      end
    end
  end
  local petModule = self:GetModule(PetModule)
  local pet = petModule:GetPet(self._petPstId)
  if not pet then
    return false
  end
  local tid = pet:GetTemplateID()
  local grade = pet:GetPetGrade()
  local awake = pet:GetAwakeMatch()
  local skillRes = ResourceHelper:GetInstance():GetPetSKill()
  local list = skillRes:GetIntensifyBuffList(tid, grade, awake)
  local isSkillPreemptive = false
  if list then
    local i
    local activeType, activeSkill = self:IsActiveOrExtraSkill(tid, grade, awake)
    if activeType then
      if activeSkill then
        i = table.ikey(list, BattleConst.PreAttackBuffId)
      else
        i = table.ikey(list, BattleConst.PreAttackBuffIdForExtra)
      end
    end
    if i then
      isSkillPreemptive = 0 < i
    else
      isSkillPreemptive = false
    end
  else
    isSkillPreemptive = false
  end
  return isSkillPreemptive
end

function UIPreAttackItem:IsActiveOrExtraSkill(petid, grade, awake)
  local cfg = BattleSkillCfg(self._skillId)
  if cfg then
    local type = cfg.Type
    if type == PetSkillType.SkillType_Active then
      local subType = cfg.SubType
      if subType and subType == PetSkillSubType.SkillType_Extra then
        return true, false
      else
        return true, true
      end
    end
  end
  return false, false
end

function UIPreAttackItem:ShowPreAttack()
  local isSkillPreemptive = false
  if self._usePetID then
    local skillRes = ResourceHelper:GetInstance():GetPetSKill()
    local list = skillRes:GetIntensifyBuffList(self._usePetID, self._grade, self._break)
    if list then
      local i
      local activeType, activeSkill = self:IsActiveOrExtraSkill(self._usePetID, self._grade, self._break)
      if activeType then
        if activeSkill then
          i = table.ikey(list, BattleConst.PreAttackBuffId)
        else
          i = table.ikey(list, BattleConst.PreAttackBuffIdForExtra)
        end
      end
      if i then
        isSkillPreemptive = 0 < i
      else
        isSkillPreemptive = false
      end
    else
      isSkillPreemptive = false
    end
  else
    isSkillPreemptive = self:_IsPetSkillPreemptive()
  end
  local cfg = BattleSkillCfg(self._skillId)
  local isActive = cfg and cfg.Type == PetSkillType.SkillType_Active
  if isActive and isSkillPreemptive then
    self:Enable(true)
  else
    self:Enable(false)
  end
end
