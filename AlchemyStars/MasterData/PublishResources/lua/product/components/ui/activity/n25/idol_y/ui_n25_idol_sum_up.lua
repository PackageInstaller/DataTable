_class("UIN25IdolSumUp", UIController)
UIN25IdolSumUp = UIN25IdolSumUp

function UIN25IdolSumUp:Constructor()
  self._pptIndex = 0
end

function UIN25IdolSumUp:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N25)
  self._idolComponent = self._localProcess:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL)
end

function UIN25IdolSumUp:OnShow(uiParams)
  self:AttachEvent(GameEventType.UIOpen, self.OnUIOpenHandle)
  self._uiWidget = self:GetUIComponent("RectTransform", "uiWidget")
  self._uiShow = self:GetUIComponent("RectTransform", "uiShow")
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "ltBtn")
  self._pptBGLoader = self:GetUIComponent("RawImageLoader", "pptBG")
  self._ppt1 = self:GetUIComponent("RectTransform", "ppt1")
  self._ppt2 = self:GetUIComponent("RectTransform", "ppt2")
  self._txtTitle1 = self:GetUIComponent("UILocalizationText", "txtTitle1")
  self._txtTitle2 = self:GetUIComponent("UILocalizationText", "txtTitle2")
  self._txtTrain1 = self:GetUIComponent("UILocalizationText", "txtTrain1")
  self._txtTrain2 = self:GetUIComponent("UILocalizationText", "txtTrain2")
  self._pptGroup = {
    {
      root = self._ppt1,
      fnFlush = self.FlushPPT1,
      bgName = "n25_ychtfsj_di13"
    },
    {
      root = self._ppt2,
      fnFlush = self.FlushPPT2,
      bgName = "n25_ych_tu05"
    }
  }
  self:InitCommonTopButton()
  self:EnterFullScreenBg(false)
  CutsceneManager.ExcuteCutsceneOut()
  self:ShowPPT(self._pptIndex + 1)
end

function UIN25IdolSumUp:OnHide()
end

function UIN25IdolSumUp:EnterFullScreenBg(isEnter)
  self._uiWidget.gameObject:SetActive(not isEnter)
  self._uiShow.gameObject:SetActive(isEnter)
end

function UIN25IdolSumUp:InitCommonTopButton()
  self._backBtns = self._ltBtn:SpawnObject("UINewCommonTopButton")
  self._backBtns:SetData(function()
    self:SwitchState(UIStateType.UIN25IdolLogin)
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end, true, nil, function()
    self:EnterFullScreenBg(true)
  end)
end

function UIN25IdolSumUp:FlushPPT1()
  local idolInfo = self._idolComponent:GetComponentInfo()
  local breakInfo = idolInfo.break_info
  local countCome = 0
  for k, v in pairs(breakInfo.agree_events) do
    countCome = countCome + 1
  end
  local valueTrain = StringTable.Get("str_n25_idol_y_sumup_train1", countCome)
  self._txtTrain1:SetText(valueTrain)
end

function UIN25IdolSumUp:FlushPPT2()
  local idolInfo = self._idolComponent:GetComponentInfo()
  local breakInfo = idolInfo.break_info
  local valueFans = breakInfo.funs_num
  local musicValue = 0
  local danceValue = 0
  local performValue = 0
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
  local theMaxAbility = ""
  local theMaxDescription = ""
  local theMaxValue = math.max(musicValue, danceValue, performValue)
  if theMaxValue == musicValue then
    theMaxAbility = StringTable.Get("str_n25_idol_y_music")
    theMaxDescription = StringTable.Get("str_n25_idol_y_sumup_out_music")
  elseif theMaxValue == danceValue then
    theMaxAbility = StringTable.Get("str_n25_idol_y_dance")
    theMaxDescription = StringTable.Get("str_n25_idol_y_sumup_out_dance")
  elseif theMaxValue == performValue then
    theMaxAbility = StringTable.Get("str_n25_idol_y_perform")
    theMaxDescription = StringTable.Get("str_n25_idol_y_sumup_out_perform")
  end
  local valueTrain = StringTable.Get("str_n25_idol_y_sumup_train2", valueFans, theMaxAbility, theMaxDescription)
  self._txtTrain2:SetText(valueTrain)
end

function UIN25IdolSumUp:ShowPPT(pptIndex)
  self._pptIndex = pptIndex
  if self._pptIndex > #self._pptGroup then
    self:BtnSkipOnClick(nil)
    return
  end
  for k, v in pairs(self._pptGroup) do
    v.root.gameObject:SetActive(false)
  end
  local ppt = self._pptGroup[self._pptIndex]
  self._pptBGLoader:LoadImage(ppt.bgName)
  ppt.root.gameObject:SetActive(true)
  ppt.fnFlush(self)
end

function UIN25IdolSumUp:OnUIOpenHandle(uiName)
  if uiName == "UIN25IdolEndCG" then
    self:CloseDialog()
  end
end

function UIN25IdolSumUp:BtnUiShowOnClick(go)
  self:EnterFullScreenBg(false)
end

function UIN25IdolSumUp:BtnNextOnClick(go)
  self:ShowPPT(self._pptIndex + 1)
end

function UIN25IdolSumUp:BtnSkipOnClick(go)
  self:ShowDialog("UIN25IdolEndCG")
end
