_class("UIPetIntimacyFiles", Object)
UIPetIntimacyFiles = UIPetIntimacyFiles

function UIPetIntimacyFiles:Constructor(intimacyMainController, petData)
  self._intimacyMainController = intimacyMainController
  self._petData = petData
  self._isInited = false
end

function UIPetIntimacyFiles:Init()
  self._scrollView = self._intimacyMainController:GetUIComponent("UIDynamicScrollView", "FileListScrollView")
  self._voiceList = {}
  self:_InitFilesData()
  self:_InitScrollView()
end

function UIPetIntimacyFiles:Refresh()
  if self._isInited then
    self._currentPlayingID = nil
    self._currentPlayFileData = nil
    self._currentPlayFileItem = nil
    self._scrollView:ResetListView()
    self._scrollView:RefreshAllShownItem()
  else
    self:Init()
    self._isInited = true
  end
end

function UIPetIntimacyFiles:CloseWindow()
  self:StopPlayVoice()
end

function UIPetIntimacyFiles:Destroy()
  self:StopPlayVoice()
  if self._voiceList then
    local l_res_map = {}
    for _, v in pairs(self._voiceList) do
      local l_res = AudioHelperController.GetResNameByAudioId(v)
      if l_res ~= nil and not l_res_map[l_res] then
        l_res_map[l_res] = true
        AudioHelperController.ReleaseUIVoiceByResName(l_res)
      end
    end
  end
  self._voiceList = {}
end

function UIPetIntimacyFiles:Update()
  if self._currentPlayFileData and self._currentPlayingID then
    local isPlaying = AudioHelperController.CheckUIVoicePlaying(self._currentPlayingID)
    if not isPlaying then
      self:StopPlayVoice()
      self._currentPlayingID = nil
    end
  end
end

function UIPetIntimacyFiles:PetDataChanged(petData)
  self._petData = petData
  if self._isInited then
    self:_InitFilesData()
  end
end

function UIPetIntimacyFiles:_InitFilesData()
  self._fileDatas = {}
  local index = 1
  local fileConfig = Cfg.pet_intimacy_files[self._petData:GetTemplateID()]
  if fileConfig then
    local fileTitleConfig = Cfg.pet_intimacy_files_titile_name[fileConfig.TitleId]
    local audioAuthor = {}
    audioAuthor.title = fileTitleConfig.AudioAuthor
    audioAuthor.des1 = StringTable.Get(fileConfig.AudioAuthor)
    audioAuthor.isAudioAuthor = true
    audioAuthor.isPlaying = false
    audioAuthor.condition = nil
    self._fileDatas[index] = audioAuthor
    index = index + 1
    local baseData = {}
    baseData.title = fileTitleConfig.BasicData
    baseData.des = fileConfig.BasicData
    baseData.isPlaying = false
    self:_RefreshFileDes(baseData)
    baseData.condition = nil
    self._fileDatas[index] = baseData
    index = index + 1
    local intialReport = {}
    intialReport.title = fileTitleConfig.IntialReport
    intialReport.des = fileConfig.IntialReport
    intialReport.isPlaying = false
    self:_RefreshFileDes(intialReport)
    intialReport.condition = nil
    self._fileDatas[index] = intialReport
    index = index + 1
    for i = 1, 6 do
      if fileConfig["PetFiles" .. i] then
        local fileData = {}
        fileData.title = fileTitleConfig["PetFiles" .. i]
        fileData.des = fileConfig["PetFiles" .. i]
        fileData.isPlaying = false
        self:_RefreshFileDes(fileData)
        fileData.condition = fileConfig["Condition" .. i]
        self._fileDatas[index] = fileData
        index = index + 1
      end
    end
  end
  self._filesCount = #self._fileDatas
  local l_res_map = {}
  for _, v in pairs(self._voiceList) do
    local l_res = AudioHelperController.GetResNameByAudioId(v)
    if l_res ~= nil and not l_res_map[l_res] then
      l_res_map[l_res] = true
      AudioHelperController.RequestUIVoiceByResName(l_res)
    end
  end
end

function UIPetIntimacyFiles:_RefreshFileDes(fileData)
  local desContent = HelperProxy:GetInstance():ReplacePlayerName(StringTable.Get(fileData.des))
  if desContent then
    local startIndex, endIndex = string.find(desContent, "<voice>")
    if startIndex then
      local des1Content = string.sub(desContent, 1, startIndex - 1)
      fileData.des1 = des1Content
      local voiceIdStartIndex, voiceIdEndIndex
      startIndex, voiceIdStartIndex = string.find(desContent, "<voiceid=")
      voiceIdEndIndex, endIndex = string.find(desContent, "voiceid/>")
      fileData.voiceId = tonumber(string.sub(desContent, voiceIdStartIndex + 1, voiceIdEndIndex - 1))
      table.insert(self._voiceList, fileData.voiceId)
      startIndex, _ = string.find(desContent, "</voice>")
      fileData.desVoiceContent = string.sub(desContent, endIndex + 1, startIndex - 1)
      startIndex, endIndex = string.find(desContent, "</voice>")
      local des2Content = string.sub(desContent, endIndex + 1)
      fileData.des2 = des2Content
    else
      fileData.des1 = desContent
    end
  end
end

function UIPetIntimacyFiles:_InitScrollView()
  self._scrollView:InitListView(self._filesCount, function(scrollview, index)
    return self:_OnGetFilesItem(scrollview, index)
  end)
end

function UIPetIntimacyFiles:_OnGetFilesItem(scrollView, index)
  local item = scrollView:NewListViewItem("UIPetIntimacyFiles")
  local rowPool = self._intimacyMainController:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIPetIntimacyFilesItem", 1)
  end
  local rowList = rowPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local itemIndex = index + 1
    if itemIndex > self._filesCount then
      itemWidget:GetGameObject():SetActive(false)
    else
      itemWidget:Refresh(self._fileDatas[index + 1], self, self._petData, item)
    end
  end
  UIHelper.RefreshLayout(item:GetComponent("RectTransform"))
  return item
end

function UIPetIntimacyFiles:PlayVoice(fileData, fileItem)
  if not fileData or not fileItem then
    return
  end
  self:StopPlayVoice()
  self._currentPlayFileData = fileData
  self._currentPlayFileItem = fileItem
  self._currentPlayFileData.isPlaying = true
  self._currentPlayFileItem:RefreshButtonStatus()
  self._currentPlayingID = AudioHelperController.PlayUIVoiceByAudioId(fileData.voiceId, false)
end

function UIPetIntimacyFiles:StopPlayVoice()
  if self._currentPlayFileData then
    self._currentPlayFileData.isPlaying = false
  end
  self._currentPlayFileData = nil
  if self._currentPlayFileItem then
    self._currentPlayFileItem:RefreshButtonStatus()
  end
  self._currentPlayFileItem = nil
  if self._currentPlayingID then
    AudioHelperController.StopUIVoice(self._currentPlayingID)
  end
  self._currentPlayingID = nil
end
