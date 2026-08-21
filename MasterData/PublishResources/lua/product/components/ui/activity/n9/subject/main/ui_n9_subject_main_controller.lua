_class("UIN9SubjectMainController", UIController)
UIN9SubjectMainController = UIN9SubjectMainController

function UIN9SubjectMainController:LoadDataOnEnter(TT, res, uiParams)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N9, ECampaignN9ComponentID.ECAMPAIGN_N9_ANSWER_GAME)
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    self:SubjectEnd()
    return
  end
  self._cumulativeSubjectComponent = self._localProcess:GetComponent(ECampaignN9ComponentID.ECAMPAIGN_N9_ANSWER_GAME)
  self._subjectComponentInfo = self._localProcess:GetComponentInfo(ECampaignN9ComponentID.ECAMPAIGN_N9_ANSWER_GAME)
  self._endTime = self._subjectComponentInfo.m_close_time
  self:RefreshData()
end

function UIN9SubjectMainController:RefreshData()
  self._levelDatas = UIN9SubjectLevelDatas:New(self._subjectComponentInfo)
end

function UIN9SubjectMainController:_GetComponent()
  self._timeLabel = self:GetUIComponent("UILocalizationText", "Time")
  self._timeBgLabel = self:GetUIComponent("UILocalizationText", "TimeBg")
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    GameGlobal.TaskManager():StartTask(function(TT)
      self:Lock("UIN9SubjectMainController_CloseCoro")
      self:CloseDialog()
      self:UnLock("UIN9SubjectMainController_CloseCoro")
    end, self)
  end)
  local levelRoot = self:GetGameObject("Levels").transform
  self._levelItems = {}
  for i = 1, levelRoot.childCount do
    local item = levelRoot:GetChild(i - 1)
    local loader = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
    local levelItem = loader:SpawnObject("UIN9SubjectLevelItem")
    self._levelItems[#self._levelItems + 1] = levelItem
    levelItem:Refresh()
  end
end

function UIN9SubjectMainController:OnShow(uiParams)
  self:_GetComponent()
  self:InitRemainTime()
  self:RefreshLevel()
  self:AttachEvent(GameEventType.OnN9SubjectRefresh, self.RefreshSubject)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstid = roleModule:GetPstId()
  LocalDB.SetInt("UIActivityN9Subject" .. pstid, 1)
  UIN9Const.ResetNewOpenSubjectLevelStatus()
  local callback = uiParams[1]
  if callback then
    callback()
  end
end

function UIN9SubjectMainController:OnHide()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self:DetachEvent(GameEventType.OnN9SubjectRefresh, self.RefreshSubject)
end

function UIN9SubjectMainController:RefreshSubject()
  self:RefreshData()
  self:RefreshLevel()
end

function UIN9SubjectMainController:RefreshLevel()
  if not self._levelDatas then
    return
  end
  local levelDatas = self._levelDatas:GetLevelDatas()
  for i = 1, #levelDatas do
    local levelData = levelDatas[i]
    local item = self._levelItems[levelData:GetPositionIndex()]
    if item then
      item:Refresh(levelData)
    end
  end
end

function UIN9SubjectMainController:InitRemainTime()
  self:RefreshRemainTime()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self._timerHandler = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:RefreshRemainTime()
  end)
end

function UIN9SubjectMainController:RefreshRemainTime()
  if not self._endTime then
    self:SubjectEnd()
    return
  end
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(self._endTime - nowTime)
  if seconds < 0 then
    seconds = 0
  end
  if seconds == 0 then
    self:SubjectEnd()
    return
  end
  local timeStr = ""
  local day = math.floor(seconds / 3600 / 24)
  if 0 < day then
    seconds = seconds - day * 3600 * 24
    local hour = math.floor(seconds / 3600)
    timeStr = StringTable.Get("str_activity_n9_day", day)
    if 0 < hour then
      timeStr = timeStr .. StringTable.Get("str_activity_n9_hour", hour)
    end
  elseif 60 <= seconds then
    local hour = math.floor(seconds / 3600)
    seconds = seconds - hour * 3600
    if 0 < hour then
      timeStr = StringTable.Get("str_activity_n9_hour", hour)
    end
    local minus = math.floor(seconds / 60)
    if minus then
      timeStr = timeStr .. StringTable.Get("str_activity_n9_minus", minus)
    end
  else
    timeStr = StringTable.Get("str_activity_n9_less_minus")
  end
  self._timeLabel:SetText(timeStr)
  self._timeBgLabel:SetText(timeStr)
end

function UIN9SubjectMainController:SubjectEnd()
  self:CloseDialog()
end

function UIN9SubjectMainController:InfoBtnOnClick()
  self:ShowDialog("UIN9SubjecIntroduce")
end
