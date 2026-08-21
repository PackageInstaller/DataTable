_class("UIPetIntimacyLevelUp", UIController)
UIPetIntimacyLevelUp = UIPetIntimacyLevelUp

function UIPetIntimacyLevelUp:OnShow(uiParams)
  self._petTemplateID = uiParams[1]
  self._skinid = uiParams[2]
  self._lvOld = uiParams[3]
  self._lvNew = uiParams[4]
  self._txtLvOld = self:GetUIComponent("UILocalizationText", "txtLvOld")
  self._txtLvNew = self:GetUIComponent("UILocalizationText", "txtLvNew")
  self._txtA = self:GetUIComponent("UILocalizationText", "txtA")
  self._txtD = self:GetUIComponent("UILocalizationText", "txtD")
  self._txtHP = self:GetUIComponent("UILocalizationText", "txtHP")
  self._profile = self:GetGameObject("profile")
  self._voice = self:GetGameObject("voice")
  self:Flush()
end

function UIPetIntimacyLevelUp:OnHide()
  self._txtA = nil
  self._txtD = nil
  self._txtHP = nil
end

function UIPetIntimacyLevelUp:Flush()
  self._txtLvOld.text = self._lvOld
  self._txtLvNew.text = self._lvNew
  GameGlobal.TaskManager():StartTask(self.PlayNumberFlow, self)
  local tUnlockProfile = UIPetIntimacyLevelUp.GetUnlockProfile(self._petTemplateID, self._lvOld, self._lvNew)
  local isUnlockProfile = tUnlockProfile and table.count(tUnlockProfile) > 0
  self._profile:SetActive(isUnlockProfile)
  local tUnlockVoice = UIPetIntimacyLevelUp.GetUnlockVoice(self._petTemplateID, self._skinid, self._lvOld, self._lvNew)
  local isUnlockVoice = tUnlockVoice and table.count(tUnlockVoice) > 0
  self._voice:SetActive(isUnlockVoice)
end

function UIPetIntimacyLevelUp:PlayNumberFlow(TT)
  local aOld, dOld, hpOld = self:GetAttributesByIntimacyLv(self._lvOld)
  local aNew, dNew, hpNew = self:GetAttributesByIntimacyLv(self._lvNew)
  local duration = 0.6667
  YIELD(TT, 1165.5)
  if not self._txtA then
    return
  end
  DoTweenHelper.DoUpdateInt(aOld, aNew, duration, function(val)
    self._txtA.text = math.floor(val)
  end)
  YIELD(TT, 133.2)
  if not self._txtD then
    return
  end
  DoTweenHelper.DoUpdateInt(dOld, dNew, duration, function(val)
    self._txtD.text = math.floor(val)
  end)
  YIELD(TT, 133.2)
  if not self._txtHP then
    return
  end
  DoTweenHelper.DoUpdateInt(hpOld, hpNew, duration, function(val)
    self._txtHP.text = math.floor(val)
  end)
end

function UIPetIntimacyLevelUp:bgOnClick(go)
  self:CloseDialog()
end

function UIPetIntimacyLevelUp:GetAttributesByIntimacyLv(level)
  return UIPetIntimacyGift.GetAttributesByPetAffinityLv(self._petTemplateID, level)
end

function UIPetIntimacyLevelUp.GetUnlockList(conditionIds, levelLeft, levelRight)
  local tUnlock = {}
  for index, conditionId in ipairs(conditionIds) do
    if conditionId then
      local cfgCondition = Cfg.pet_intimacy_condition[conditionId]
      if cfgCondition and cfgCondition.ConditionType == 1 then
        local unlockLevel = cfgCondition.Value
        if levelLeft < unlockLevel and levelRight >= unlockLevel then
          table.insert(tUnlock, conditionId)
        end
      end
    end
  end
  return tUnlock
end

function UIPetIntimacyLevelUp.GetUnlockProfile(templateId, levelLeft, levelRight)
  local cfgFiles = Cfg.pet_intimacy_files[templateId]
  if not cfgFiles then
    Log.fatal("### pet_intimacy_files does not contains", templateId)
    return
  end
  local conditionIds = {}
  for i = 1, 6 do
    if cfgFiles["PetFiles" .. i] then
      local conditionId = cfgFiles["Condition" .. i]
      table.insert(conditionIds, conditionId)
    end
  end
  local tUnlock = UIPetIntimacyLevelUp.GetUnlockList(conditionIds, levelLeft, levelRight)
  return tUnlock
end

function UIPetIntimacyLevelUp.GetUnlockVoice(templateId, skinid, levelLeft, levelRight)
  local conditionIds = {}
  local voiceType = {
    [1] = "MainLobbyInteract",
    [2] = "Obtain",
    [3] = "LevelUp",
    [4] = "Grade1Up",
    [5] = "Grade2Up",
    [6] = "Charge",
    [7] = "Skill",
    [8] = "TeamLeaderAppear",
    [9] = "BattleSucceed",
    [10] = "BattleFail",
    [11] = "AircraftInteract",
    [12] = "Story1",
    [13] = "Story2",
    [14] = "Story3"
  }
  local voiceConfig
  local cfgs = Cfg.cfg_pet_voice({PetID = templateId, SkinID = skinid})
  if cfgs and next(cfgs) then
    voiceConfig = cfgs[1]
  else
    voiceConfig = Cfg.cfg_pet_voice({PetID = templateId, SkinID = nil})[1]
  end
  if voiceConfig then
    for j = 1, #voiceType do
      local v = voiceType[j]
      if type(voiceConfig[v]) == "table" then
        local voiceDataArr = voiceConfig[v]
        if voiceDataArr then
          for i = 1, #voiceDataArr do
            local conditionId = voiceDataArr[i][2]
            table.insert(conditionIds, conditionId)
          end
        end
      elseif voiceConfig[v] then
        local conditionId = Cfg.pet_intimacy_voice_condition[1][v]
        table.insert(conditionIds, conditionId)
      end
    end
  end
  local tUnlock = UIPetIntimacyLevelUp.GetUnlockList(conditionIds, levelLeft, levelRight)
  return tUnlock
end
