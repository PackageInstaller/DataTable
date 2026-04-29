_class("UIN25IdolGameTraining", UIController)
UIN25IdolGameTraining = UIN25IdolGameTraining

function UIN25IdolGameTraining:_SetCommonTopButton()
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UINewCommonTopButton")
  obj:SetData(function()
    self:_Back()
  end, nil, nil, true, nil)
end

function UIN25IdolGameTraining:OnN25IdolCheckState(openDialog)
  local diaName = self:GetName()
  if diaName ~= openDialog then
    self:CloseDialog()
  end
end

function UIN25IdolGameTraining:_Back()
  if self._resultShow then
    UIWidgetHelper.PlayAnimation(self, "_anim", "uieff_UIN25IdolGameTraining_resultPool_out", 200, function()
      CutsceneManager.ExcuteCutsceneIn("UIN25Idol_Common_Switch", function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.N25IdolGameNextDay)
        CutsceneManager.ExcuteCutsceneOut()
      end)
    end)
  else
    UIWidgetHelper.PlayAnimation(self, "_anim", "uieff_UIN25IdolGameTraining_classroom_out", 367, function()
      CutsceneManager.ExcuteCutsceneIn("UIN25Idol_Common_Switch", function()
        self:CloseDialog()
        CutsceneManager.ExcuteCutsceneOut()
      end)
    end)
  end
end

function UIN25IdolGameTraining:_SetBg()
  local url = "n25_ychtfsj_di13"
  if url then
    UIWidgetHelper.SetRawImage(self, "_mainBg", url)
  end
end

function UIN25IdolGameTraining:_SetSpine()
  self._spine = UIWidgetHelper.SetSpineLoad(self, "_spine", "n25_g_lianxisheng_spine_idle")
  UIWidgetHelper.SetSpineAnimation(self._spine, 0, "idle", true)
end

function UIN25IdolGameTraining:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_N25
  self._componentId = ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, self._campaignType, {
    self._componentId
  })
  self._component = self._campaign:GetComponent(self._componentId)
  self._componentInfo = self._campaign:GetComponentInfo(self._componentId)
end

function UIN25IdolGameTraining:OnShow(uiParams)
  self._trainType = uiParams[1]
  self:_SetBg()
  self:_SetCommonTopButton()
  self:_SetSpine()
  self:_SetClassRoom()
  self:_SetClassRoomShow(true)
  self:_SetResultShow(false)
  self:AttachEvent(GameEventType.OnN25IdolCheckState, self.OnN25IdolCheckState)
  UIWidgetHelper.PlayAnimation(self, "_anim", "uieff_UIN25IdolGameTraining_classroom_in", 833, function()
    if self._trainType then
      self:_Start_PlayTrainingAnim()
    end
  end)
end

function UIN25IdolGameTraining:OnHide()
  self._spine = UIWidgetHelper.SetSpineDestroy(self, "_spine")
end

function UIN25IdolGameTraining:_Start_HandleIdolTrain(state, callback)
  local trainType = self._trainType
  local roundIndex = self._componentInfo.break_info.round_index
  self._component:Start_HandleIdolTrain(roundIndex, state, trainType, callback)
end

function UIN25IdolGameTraining:_SetClassRoom()
  local roundIndex = self._componentInfo.break_info.round_index
  local tb = {
    "_classRoom1",
    "_classRoom2",
    "_classRoom3"
  }
  for i, widgetName in ipairs(tb) do
    local trainType = i
    local value = self._component:UI_Cfg_GetTrainPointAddValue(trainType)
    local txtSong = self._component:UI_Cfg_GetTrainPointSong(trainType)
    local eventId = self._component:UI_CheckAgreedEvent(trainType)
    local info = self._component:UI_Cfg_GetEventInfo(eventId)
    local head = info and info.PetHead
    local muse = self._component:UI_Cfg_GetTrainMuse(roundIndex, trainType)
    local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIN25IdolGameTrainingClass")
    obj:SetData(trainType, value, txtSong, head, muse, function(type, go)
      go:SetBtnState(2)
      self._trainType = type
      self._oldValue = self._component:UI_GetTrainPoint(type)
      self._oldLevel = self._component:UI_GetLevel(type)
      self:_CheckSuddenlyEvent()
    end)
    if self._trainType == trainType then
      obj:SetBtnState(2)
    end
  end
end

function UIN25IdolGameTraining:_SetClassRoomShow(isShow)
  self:GetGameObject("_classRoom"):SetActive(isShow)
end

function UIN25IdolGameTraining:_CheckSuddenlyEvent()
  local trainType = self._trainType
  local eventId = self._component:UI_CheckSuddenlyEvent(trainType)
  if eventId then
    self:ShowDialog("UIN25IdolGamePuppy", eventId, trainType, function()
      self:_Start_HandleIdolTrain(IdolRoundState.IdolRoundState_Play)
    end, function()
      self:_Start_PlayTrainingAnim()
    end)
  else
    self:_Start_HandleIdolTrain(IdolRoundState.IdolRoundState_Play, function()
      self:_Start_PlayTrainingAnim()
    end)
  end
end

function UIN25IdolGameTraining:_Start_PlayTrainingAnim()
  local trainType = self._trainType
  local animNames = {
    "shengyue",
    "tiaowu",
    "biaoyan"
  }
  local animName = animNames[trainType]
  local duration = 4000
  local lockName = "UIN25IdolGameTraining:_Start_PlayTrainingAnim_" .. animName
  GameGlobal.UIStateManager():Lock(lockName)
  TaskManager:GetInstance():StartTask(function(TT)
    UIWidgetHelper.SetSpineAnimation(self._spine, 0, animName, false)
    YIELD(TT, duration)
    UIWidgetHelper.SetSpineAnimation(self._spine, 0, "chenggong", true)
    self:_Start_HandleIdolTrain(IdolRoundState.IdolRoundState_End, function()
      self:_Start_PlayResultAnim()
    end)
    GameGlobal.UIStateManager():UnLock(lockName)
  end)
end

function UIN25IdolGameTraining:_Start_PlayResultAnim()
  self:_ShowResult()
  UIWidgetHelper.SetAnimationPlay(self, "_anim", "uieff_UIN25IdolGameTraining_classroom_out")
  UIWidgetHelper.PlayAnimation(self, "_anim", "uieff_UIN25IdolGameTraining_resultPool_in", 500, function()
  end)
end

function UIN25IdolGameTraining:_ShowResult()
  local trainType = self._trainType
  local level = self._component:UI_GetLevel(trainType)
  local tbTitle1 = {
    "str_n25_idol_game_training_class_music",
    "str_n25_idol_game_training_class_dance",
    "str_n25_idol_game_training_class_perform"
  }
  local tbTitle3 = {
    "str_n25_idol_game_tip_music_title",
    "str_n25_idol_game_tip_dance_title",
    "str_n25_idol_game_tip_perform_title"
  }
  local title1 = tbTitle1[trainType]
  local title3 = tbTitle3[trainType]
  local valueIcon = trainType
  local valueAdd = self._component:UI_Cfg_GetTrainPointAddValue(trainType)
  local valueFrom = self._oldValue
  local valueTo = self._component:UI_GetTrainPoint(trainType)
  local desc1, desc2 = self._component:UI_Cfg_GetTrainResult(trainType)
  desc1 = self._oldLevel ~= level and desc1 or nil
  local obj = UIWidgetHelper.SpawnObject(self, "_resultPool", "UIN25IdolCommonResultItem")
  obj:SetData(UIIdolResultType.Training, title1, title3, valueIcon, valueFrom, valueTo, desc1, desc2)
  self:_SetResultShow(true)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.HomelandAudioNormal)
  self:_SetClassRoomShow(false)
end

function UIN25IdolGameTraining:_SetResultShow(isShow)
  self._resultShow = isShow
  self:GetGameObject("_result"):SetActive(isShow)
  self:GetGameObject("_resultBtn"):SetActive(isShow)
end

function UIN25IdolGameTraining:ResultBtnOnClick(go)
  self:_Back()
end
