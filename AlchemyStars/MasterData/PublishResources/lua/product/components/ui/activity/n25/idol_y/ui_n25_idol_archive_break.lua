_class("UIN25IdolArchiveBreak", UICustomWidget)
UIN25IdolArchiveBreak = UIN25IdolArchiveBreak

function UIN25IdolArchiveBreak:Constructor()
end

function UIN25IdolArchiveBreak:OnShow(uiParams)
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

function UIN25IdolArchiveBreak:OnHide()
end

function UIN25IdolArchiveBreak:Flush(breakInfo)
  local weekValue = 0
  local musicValue = 0
  local danceValue = 0
  local performValue = 0
  weekValue = math.floor((breakInfo.round_index - 1) / 7) + 1
  local weekTextValue = StringTable.Get("str_n25_idol_y_loading_week", weekValue)
  if breakInfo.train_data ~= nil then
    local train_data = breakInfo.train_data
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
  local timeValue = breakInfo.note_time
  if timeValue == 0 then
    timeValue = os.time()
  end
  local timeTextValue = TimeToDate3(timeValue, "min")
  self._txtWeek:SetText(weekTextValue)
  self._txtTime:SetText(timeTextValue)
  self._txtFansGrey:SetText(string.format("%.7d", breakInfo.funs_num))
  self._txtFans:SetText(breakInfo.funs_num)
  self._txtMusicGrey:SetText(string.format("%.5d", musicValue))
  self._txtMusic:SetText(musicValue)
  self._txtDanceGrey:SetText(string.format("%.5d", danceValue))
  self._txtDance:SetText(danceValue)
  self._txtPerformGrey:SetText(string.format("%.5d", performValue))
  self._txtPerform:SetText(performValue)
end
