_class("UIPetIntimacyFilesItem", UICustomWidget)
UIPetIntimacyFilesItem = UIPetIntimacyFilesItem

function UIPetIntimacyFilesItem:_GetComponents(item)
  self._item = item
  local titleTran = item.transform:Find("TitleBg/TitlePanel/Title")
  self._titleLabel = titleTran:GetComponent("UILocalizationText")
  local audioAuthorTran = item.transform:Find("TitleBg/TitlePanel/AudioAuthor")
  self._audioAuthorLabel = audioAuthorTran:GetComponent("UILocalizationText")
  self._audioAuthorGo = audioAuthorTran.gameObject
  local des1Tran = item.transform:Find("DesBg/Des1")
  self._des1Label = des1Tran:GetComponent("UILocalizationText")
  self._des1Go = des1Tran.gameObject
  local des2Tran = item.transform:Find("DesBg/Des2")
  self._des2Label = des2Tran:GetComponent("UILocalizationText")
  self._des2Go = des2Tran.gameObject
  local desVoiceTran = item.transform:Find("DesBg/DesVoice")
  self._desVoiceLabel = desVoiceTran:GetComponent("UILocalizationText")
  self._desVoiceGo = desVoiceTran.gameObject
  local conditionTran = item.transform:Find("DesBg/Condition")
  self._conditionLabel = conditionTran:GetComponent("UILocalizationText")
  self._conditionGo = conditionTran.gameObject
  self._gameObject = item.transform.gameObject
  local btnPlay = desVoiceTran:Find("ButtonPlay")
  self._btnPlayGo = btnPlay.gameObject
  local btnStopPlay = desVoiceTran:Find("ButtonStopPlay")
  self._btnStopPlayGo = btnStopPlay.gameObject
  local etl = UICustomUIEventListener.Get(self._btnPlayGo)
  self:AddUICustomEventListener(etl, UIEvent.Click, function(go)
    self._petIntimacyFiles:PlayVoice(self._fileData, self)
  end)
  local etl = UICustomUIEventListener.Get(self._btnStopPlayGo)
  self:AddUICustomEventListener(etl, UIEvent.Click, function(go)
    self._petIntimacyFiles:StopPlayVoice()
  end)
end

function UIPetIntimacyFilesItem:Refresh(fileData, petIntimacyfiles, petData, item)
  self:_GetComponents(item)
  self._petData = petData
  self._fileData = fileData
  self._petIntimacyFiles = petIntimacyfiles
  if not self._fileData then
    self._gameObject:SetActive(false)
  end
  self._gameObject:SetActive(true)
  local condition
  local isOpen = true
  if self._fileData.condition then
    condition = Cfg.pet_intimacy_condition[self._fileData.condition]
    if condition then
      if condition.ConditionType == 1 then
        if self._petData:GetPetAffinityLevel() < condition.Value then
          isOpen = false
        end
      elseif condition.ConditionType == 2 then
        if self._petData:GetPetGrade() < condition.Value then
          isOpen = false
        end
      elseif condition.ConditionType == 3 and not self._petData:IsFinishedStory(condition.Value) then
        isOpen = false
      end
    end
  end
  self._titleLabel.text = StringTable.Get(self._fileData.title)
  self._audioAuthorGo:SetActive(false)
  if isOpen then
    local roleModule = self:GetModule(RoleModule)
    local roleName = roleModule:GetName()
    roleName = roleName or ""
    self._conditionGo.gameObject:SetActive(false)
    local des1Content = self._fileData.des1
    local des2Content = self._fileData.des2
    local desVoiceContent = self._fileData.desVoiceContent
    self._des1Go:SetActive(false)
    self._des2Go:SetActive(false)
    self._desVoiceGo:SetActive(false)
    if self._fileData.isAudioAuthor then
      self._audioAuthorLabel.text = des1Content
      self._audioAuthorGo:SetActive(true)
    else
      if des1Content then
        self._des1Go:SetActive(true)
        self._des1Label.text = string.gsub(des1Content, "%%s", roleName)
      end
      if des2Content then
        self._des2Go:SetActive(true)
        self._des2Label.text = string.gsub(des2Content, "%%s", roleName)
      end
      if desVoiceContent then
        self._desVoiceGo:SetActive(true)
        self._desVoiceLabel.text = string.gsub(desVoiceContent, "%%s", roleName)
      end
    end
  else
    self._des1Go:SetActive(false)
    self._des2Go:SetActive(false)
    self._desVoiceGo:SetActive(false)
    local lable = StringTable.Get(condition.Des)
    if condition.ConditionType == 3 then
      local event = Cfg.cfg_pet_affinity_event({
        PetID = self._petData:GetTemplateID(),
        AffinityLevel = condition.Value
      })
      local story = Cfg.cfg_pet_story[event[1].StoryEventID]
      if story then
        local storyName = StringTable.Get(story.Title)
        lable = string.format(lable, storyName)
      end
    end
    self._conditionLabel.text = lable
    self._conditionGo:SetActive(true)
  end
  self:RefreshButtonStatus()
end

function UIPetIntimacyFilesItem:RefreshButtonStatus()
  self._btnPlayGo:SetActive(not self._fileData.isPlaying)
  self._btnStopPlayGo:SetActive(self._fileData.isPlaying)
end
