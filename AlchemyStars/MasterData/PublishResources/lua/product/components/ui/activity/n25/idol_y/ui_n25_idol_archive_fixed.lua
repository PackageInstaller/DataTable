_class("UIN25IdolArchiveFixed", UICustomWidget)
UIN25IdolArchiveFixed = UIN25IdolArchiveFixed

function UIN25IdolArchiveFixed:Constructor()
  self._parent = nil
  self._idArchive = nil
end

function UIN25IdolArchiveFixed:OnShow(uiParams)
  self._empty = self:GetUIComponent("RectTransform", "empty")
  self._nonempty = self:GetUIComponent("RectTransform", "nonempty")
  self._txtWeek = self:GetUIComponent("UILocalizationText", "txtWeek")
  self._txtTime = self:GetUIComponent("UILocalizationText", "txtTime")
  self._txtFansGrey = self:GetUIComponent("UILocalizationText", "txtFansGrey")
  self._txtFans = self:GetUIComponent("UILocalizationText", "txtFans")
  self._txtMusicGrey = self:GetUIComponent("UILocalizationText", "txtMusicGrey")
  self._txtMusic = self:GetUIComponent("UILocalizationText", "txtMusic")
  self._txtDanceGrey = self:GetUIComponent("UILocalizationText", "txtDanceGrey")
  self._txtDance = self:GetUIComponent("UILocalizationText", "txtDance")
  self._txtPerformGrey = self:GetUIComponent("UILocalizationText", "txtPerformGrey")
  self._txtPerform = self:GetUIComponent("UILocalizationText", "txtPerform")
end

function UIN25IdolArchiveFixed:OnHide()
end

function UIN25IdolArchiveFixed:Flush(parent, idArchive, processInfo)
  self._parent = parent
  self._idArchive = idArchive
  local isEmpty = processInfo == nil
  self._empty.gameObject:SetActive(isEmpty)
  self._nonempty.gameObject:SetActive(not isEmpty)
  if isEmpty then
  else
    local weekValue = 0
    local musicValue = 0
    local danceValue = 0
    local performValue = 0
    weekValue = math.floor((processInfo.round_index - 1) / 7) + 1
    local weekTextValue = StringTable.Get("str_n25_idol_y_loading_week", weekValue)
    if processInfo.train_data ~= nil then
      local train_data = processInfo.train_data
      if train_data[IdolTrainType.IdolTrainType_Music] ~= nil then
        musicValue = train_data[IdolTrainType.IdolTrainType_Music]
      end
      if train_data[IdolTrainType.IdolTrainType_Dance] ~= nil then
        danceValue = train_data[IdolTrainType.IdolTrainType_Dance]
      end
      if train_data[IdolTrainType.IdolTrainType_Perform] ~= nil then
        performValue = train_data[IdolTrainType.IdolTrainType_Perform]
      end
    end
    local timeValue = processInfo.note_time
    if timeValue == 0 then
      timeValue = os.time()
    end
    local timeTextValue = TimeToDate3(timeValue, "min")
    self._txtWeek:SetText(weekTextValue)
    self._txtTime:SetText(timeTextValue)
    self._txtFansGrey:SetText(string.format("%.7d", processInfo.funs_num))
    self._txtFans:SetText(processInfo.funs_num)
    self._txtMusicGrey:SetText(string.format("%.5d", musicValue))
    self._txtMusic:SetText(musicValue)
    self._txtDanceGrey:SetText(string.format("%.5d", danceValue))
    self._txtDance:SetText(danceValue)
    self._txtPerformGrey:SetText(string.format("%.5d", performValue))
    self._txtPerform:SetText(performValue)
  end
end

function UIN25IdolArchiveFixed:BtnLoadingOnClick(go)
  local idolInfo = self._parent:IdolComponent():GetComponentInfo()
  local breakInfo = idolInfo.break_info
  if breakInfo.note_time ~= 0 then
    self:ShowDialog("UIN25IdolBreakTips", breakInfo, function()
      self:DispatchEvent(GameEventType.N25IdolStartPlayGame, IdolStartType.IdolStartType_Process, self._idArchive)
    end, function()
    end)
  else
    self:DispatchEvent(GameEventType.N25IdolStartPlayGame, IdolStartType.IdolStartType_Process, self._idArchive)
  end
end
