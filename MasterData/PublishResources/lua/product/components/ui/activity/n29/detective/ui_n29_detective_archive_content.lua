_class("UIN29DetectiveArchiveContent", UICustomWidget)
UIN29DetectiveArchiveContent = UIN29DetectiveArchiveContent

function UIN29DetectiveArchiveContent:Constructor()
end

function UIN29DetectiveArchiveContent:OnShow(uiParams)
  self._uiEmpty = self:GetUIComponent("RectTransform", "uiEmpty")
  self._uiArchive = self:GetUIComponent("RectTransform", "uiArchive")
  self._txtProgress = self:GetUIComponent("UILocalizationText", "txtProgress")
  self._txtTime = self:GetUIComponent("UILocalizationText", "txtTime")
  self._txtPosition = self:GetUIComponent("UILocalizationText", "txtPosition")
  self._btnLoading = self:GetUIComponent("RectTransform", "btnLoading")
end

function UIN29DetectiveArchiveContent:OnHide()
end

function UIN29DetectiveArchiveContent:BtnLoadingOnClick(go)
  self:RootUIOwner():BtnLoadingOnClick(go)
end

function UIN29DetectiveArchiveContent:SetDetectiveLocalDb(localDb)
  self._localDb = localDb
end

function UIN29DetectiveArchiveContent:SetIdReasoning(idReasoning)
  self._idReasoning = idReasoning
end

function UIN29DetectiveArchiveContent:FlushBreak(breakInfo)
  self._uiEmpty.gameObject:SetActive(false)
  self._uiArchive.gameObject:SetActive(true)
  self._btnLoading.gameObject:SetActive(false)
  self:UITime(breakInfo.cur_time)
  self:UIProgress(breakInfo.clue_list, breakInfo.fragment_list)
  self:UIPosition(self._idReasoning)
end

function UIN29DetectiveArchiveContent:FlushArchive(archiveInfo)
  local existRecord = archiveInfo.is_record
  self._uiEmpty.gameObject:SetActive(not existRecord)
  self._uiArchive.gameObject:SetActive(existRecord)
  self._btnLoading.gameObject:SetActive(true)
  if existRecord then
    local dicClue, dicFragment = self._localDb:AllClueAndFragment()
    self:UITime(archiveInfo.auto_save_record_time)
    self:UIProgress(dicClue, dicFragment)
    self:UIPosition(UIN29DetectiveLocalDb.Game_Continue_Reasoning)
  end
end

function UIN29DetectiveArchiveContent:UITime(timeValue)
  if timeValue == nil or timeValue <= 0 then
    timeValue = os.time()
  end
  local timeTextValue = TimeToDate3(timeValue, "min")
  self._txtTime:SetText(timeTextValue)
end

function UIN29DetectiveArchiveContent:UIProgress(clue_list, fragment_list)
  local countClue = 0
  local countFragment = 0
  if clue_list ~= nil then
    for k, v in pairs(clue_list) do
      countClue = countClue + 1
    end
  end
  if fragment_list ~= nil then
    for k, v in pairs(fragment_list) do
      countFragment = countFragment + 1
    end
  end
  local totalClue = 1
  local totalFragment = 1
  local allClue, allFragment = self._localDb:AllClueAndFragment()
  if allClue ~= nil then
    totalClue = 0
    for k, v in pairs(allClue) do
      totalClue = totalClue + 1
    end
  end
  if allFragment ~= nil then
    totalFragment = 0
    for k, v in pairs(allFragment) do
      totalFragment = totalFragment + 1
    end
  end
  local numberProgress = math.floor(countClue * 100 / totalClue)
  local txtPercent = string.format("%d%%%%", numberProgress)
  local valueProgress = StringTable.Get("str_n29_detective_archive_progress", txtPercent)
  self._txtProgress:SetText(valueProgress)
end

function UIN29DetectiveArchiveContent:UIPosition(idReasoning)
  local id = 0
  if idReasoning == UIN29DetectiveLocalDb.Game_Continue_Reasoning then
    id = "str_n29_detective_archive_reasoning"
  elseif idReasoning == UIN29DetectiveLocalDb.Game_Continue_ReasoningPlot then
    id = "str_n29_detective_archive_reasoning"
  else
    id = "str_n29_detective_archive_continue"
  end
  self._txtPosition:SetText(StringTable.Get(id))
end
