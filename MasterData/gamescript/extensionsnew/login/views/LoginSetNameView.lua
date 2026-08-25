local UIAnimationController = CS.Z1Client.UIAnimationController
local TYPEOF_TMP_InputField = typeof(CS.TMPro.TMP_InputField)
local Button = CS.UnityEngine.UI.Button
local LoginSetNameView, Super = System.NewClass("LoginSetNameView", BaseView)
LoginSetNameView.uiResCls = UI_Guide_ChangeNameResource

function LoginSetNameView:ctor(callFunc, gender)
  Super.ctor(self)
  self.callFunc = callFunc
  self.gender = gender
  self.isPlayAni = false
  self.model = LoginCharacterCreateModel.Instance
end

function LoginSetNameView:OnBuildView()
  Super.OnBuildView(self)
  self.animController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.nameInputField = self.ui.InputField:GetComponent(TYPEOF_TMP_InputField)
  self.setNameGO = self.ui.Image_Confim_Nor_Bg:GetComponent(typeof(Button))
  self:LoadAllLangFont(self.ui.Text_Input)
end

function LoginSetNameView:RegisterNotifications()
  Super.RegisterNotifications(self)
end

function LoginSetNameView:RegisterEvents()
  self:AddInputValueChangeListener(self.ui.InputField, function(str)
    self:_OnInputValueChanged(str)
  end)
  self:AddButtonClickListener(self.ui.Image_Confim_Nor_Bg, System.fn(self, self._OnClickConfirm))
  self:AddButtonClickListener(self.ui.Image_Confim_Dis_Bg, System.fn(self, self._OnClickDisabledConfirm))
  self:AddButtonClickListener(self.ui.Button_Return, System.fn(self, self._ClickReturn))
end

function LoginSetNameView:OnEnterView()
  Super.OnEnterView(self)
  self.model:SetGender(self.gender)
  self.ui.Button_Random:SetActive(false)
  self:SetInputText(self.ui.InputField, self.model:GetNameStr())
  self.ui.CGDynamic_C00_001:SetActive(self.gender == CommonDefine.GenderID.Boy)
  self.ui.CGDynamic_C00_002:SetActive(self.gender == CommonDefine.GenderID.Girl)
  self.ui.Text_C_Myself:SetActive(false)
  self.ui.Image_Inputable:SetActive(self.nameInputField.isFocused)
  self:BindTimer(0.1, -1, function()
    self.ui.Image_Inputable:SetActive(self.nameInputField.isFocused)
  end)
  self.ui.Button_Return:SetActive(true)
  self:_RefreshBtnState()
  self:PlayChangeNameOpenAnim()
  self:BindTimer(0.01, 0, nil, System.fn(self, self._PlayInitAudio))
end

function LoginSetNameView:OnExitView()
  Super.OnExitView(self)
end

function LoginSetNameView:_RefreshBtnState()
  local isNormal = self.model:GetBtnState() == CommonDefine.BtnType.Normal
  self.ui.Group_Nor:SetActive(isNormal)
  self.ui.Group_Dis:SetActive(not isNormal)
end

function LoginSetNameView:_OnInputValueChanged(str)
  local subStr = StrUtils.SubStr(str, self.model:GetMaxLimit())
  if subStr ~= str then
    self:SetInputText(self.ui.InputField, subStr)
  end
  self.ui.Text_C_Myself:SetActive(str and #str > 0)
  self.model:SetNameStr(subStr)
  self:_RefreshBtnState()
end

function LoginSetNameView:PlayChangeNameOpenAnim()
  self.ui.InputBlock:SetActive(true)
  self.animController:PlayState("UI_Guide_ChangeName_Open", function()
    self.ui.InputBlock:SetActive(false)
    self:_OnAnimOpenEnd()
  end)
end

function LoginSetNameView:_OnAnimOpenEnd()
  self.setNameGO.interactable = true
  Logger.Info("LoginSetNameView>>>>>OnAnimEnd")
  self.isPlayAni = false
  self.ui.Text_C_Myself:SetActive(self.nameInputField.text and #self.nameInputField.text > 0)
end

function LoginSetNameView:PlayChangeNameCloseAnim()
  self.ui.InputBlock:SetActive(true)
  self.animController:PlayState("UI_Guide_ChangeName_Close", function()
    self.ui.InputBlock:SetActive(false)
    self:_OnAnimCloseEnd()
  end)
end

function LoginSetNameView:_OnAnimCloseEnd()
  self.isPlayAni = false
  self:Close()
  UIManager.Instance:Reopen(Urls.SetGenderPanel, self.callFunc, self.gender)
end

function LoginSetNameView:_OnClickConfirm()
  if self.isPlayAni == true then
    return
  end
  local str = self.model:GetNameStr()
  if UIUtils.IsHaveMissingCharacter(self.ui.Text_Input) then
    Alert.Show(10804)
    return
  end
  local gender = self.model:GetGender()
  LoginCharacterCreateController.Instance:ReqSetPlayerNameAndGender(str, gender, function()
    if self.callFunc then
      self.callFunc()
    end
    local introStepInfo = IntroductionDataUtils.GetStepData()
    if introStepInfo.stepType == CommonDefine.IntroStepType.AvgDialog then
      AvgStoryManager.Instance:WaitStoryStart(introStepInfo.id, function()
        self:Close()
      end)
    else
      self:Close()
    end
  end)
end

function LoginSetNameView:_OnClickDisabledConfirm()
  if self.isPlayAni == true then
    return
  end
  local tipsId = 10629
  local tipConfig = DT.TipsType[tipsId]
  local content = string.format(LT.Textf(tipConfig.Desc, self.model:GetMinLimit(), self.model:GetMaxLimit()))
  Alert.ShowStr(content)
end

function LoginSetNameView:_ClickReturn()
  if self.isPlayAni == true then
    return
  end
  self:PlayChangeNameCloseAnim()
  self.isPlayAni = true
end

function LoginSetNameView:_PlayInitAudio()
  AudioManager.Instance:PostSoundEvent("Play_A_MUS_Funeral_Chp0")
  AudioManager.Instance:PostSoundEvent("Play_A_SFX_Amb_Rain_Smalle")
end

return LoginSetNameView
