local UIAnimationController = CS.Z1Client.UIAnimationController
local TYPEOF_TMP_InputField = typeof(CS.TMPro.TMP_InputField)
local Button = CS.UnityEngine.UI.Button
local SetNamePanel, Super = System.NewClass("SetNamePanel", UIBasePanel)
SetNamePanel.uiResCls = UI_Guide_ChangeNameResource

function SetNamePanel:ctor(callFunc, gender)
  Super.ctor(self)
  self.callFunc = callFunc
  self.gender = gender
  self.isPlayAni = false
end

function SetNamePanel:PlayChangeNameOpenAnim()
  self.ui.InputBlock:SetActive(true)
  self.AnimController:PlayState("UI_Guide_ChangeName_Open", function()
    self.ui.InputBlock:SetActive(false)
    self:OnAnimOpenEnd()
  end)
end

function SetNamePanel:OnAnimOpenEnd()
  self.setNameGO.interactable = true
  Logger.Info("SetNamePanel>>>>>OnAnimEnd")
  self.isPlayAni = false
  self.binder:SetActive(self.ui.Text_C_Myself, self.NameInputField.text and #self.NameInputField.text > 0)
end

function SetNamePanel:PlayChangeNameCloseAnim()
  self.ui.InputBlock:SetActive(true)
  self.AnimController:PlayState("UI_Guide_ChangeName_Close", function()
    self.ui.InputBlock:SetActive(false)
    self:OnAnimCloseEnd()
  end)
end

function SetNamePanel:OnAnimCloseEnd()
  self.isPlayAni = false
  self:Close()
  UIManager.Instance:Reopen(Urls.SetGenderPanel, self.callFunc, self.gender)
end

function SetNamePanel:OnBind(binder)
  self.binder = binder
  self.model = self.binder:createModel(SetGenderNameModel)
  self.model:SetGender(self.gender)
  binder:LoadAllLangFont(self.ui.Text_Input)
  self.NameInputField = self.ui.InputField:GetComponent(TYPEOF_TMP_InputField)
  self.setNameGO = self.ui.Image_Confim_Nor_Bg:GetComponent(typeof(Button))
  self.AnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self:PlayChangeNameOpenAnim()
  self.binder:SetActive(self.ui.Button_Random, false)
  self.binder:SetInputText(self.ui.InputField, self.model:GetNameStr())
  self.binder:SetActive(self.ui.CGDynamic_C00_001, self.gender == CommonDefine.GenderID.Boy)
  self.binder:SetActive(self.ui.CGDynamic_C00_002, self.gender == CommonDefine.GenderID.Girl)
  self.binder:BindToVisible(self.ui.Group_Nor, function()
    return self.model:GetBtnState() == CommonDefine.BtnType.Normal
  end)
  self.binder:BindToVisible(self.ui.Group_Dis, function()
    return self.model:GetBtnState() == CommonDefine.BtnType.Disabled
  end)
  self.binder:BindToInputValueChange(self.ui.InputField, function(str)
    local subStr = StrUtils.SubStr(str, self.model:GetMaxLimit())
    if subStr ~= str then
      self.binder:SetInputText(self.ui.InputField, subStr)
    end
    self.binder:SetActive(self.ui.Text_C_Myself, str and #str > 0)
    self.model:SetNameStr(subStr)
  end)
  self.binder:SetActive(self.ui.Text_C_Myself, false)
  self.binder:SetActive(self.ui.Image_Inputable, self.NameInputField.isFocused)
  self.binder:BindTimer(0.1, -1, function()
    self.binder:SetActive(self.ui.Image_Inputable, self.NameInputField.isFocused)
  end)
  self.binder:BindButtonClick(self.ui.Image_Confim_Nor_Bg, function()
    if self.isPlayAni == true then
      return
    end
    local str = self.model:GetNameStr()
    if UIUtils.IsHaveMissingCharacter(self.ui.Text_Input) then
      Alert.Show(10804)
      return
    end
    local gender = self.model:GetGender()
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("GameRequest", "SetPlayerNameAndGender", function(data)
      DataCenter.playerData.DRole.name = data.name
      DataCenter.playerData.DRole.gender = data.gender
      DataCenter.playerData.DRole.icon = data.icon
      local roleId = PlayerDataUtils.GetPlayerUid()
      local serverId = LoginMgr.Instance.model.serverId
      local playerName = data.name
      local sdkPlayerInfo = CommonDefine.SdkPlayerInfoType.CREATEROLE
      SdkMgr.Instance:SetPlayerInfo(roleId, serverId, playerName, sdkPlayerInfo)
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
    end, nil, str, gender)
  end)
  self.binder:BindButtonClick(self.ui.Image_Confim_Dis_Bg, function()
    if self.isPlayAni == true then
      return
    end
    local tipsId = 10629
    local tipConfig = DT.TipsType[tipsId]
    local content = string.format(LT.Textf(tipConfig.Desc, self.model:GetMinLimit(), self.model:GetMaxLimit()))
    Alert.ShowStr(content)
  end)
  self:BindReturn()
  self.binder:BindTimer(0.01, 0, nil, System.fn(self, self.PlayInitAudio))
end

function SetNamePanel:PlayInitAudio()
  AudioManager.Instance:PostSoundEvent("Play_A_MUS_Funeral_Chp0")
  AudioManager.Instance:PostSoundEvent("Play_A_SFX_Amb_Rain_Smalle")
end

function SetNamePanel:BindReturn()
  self.ui.Button_Return:SetActive(true)
  self.binder:BindZ1Button(self.ui.Button_Return, System.fn(self, self.ClickReturn))
end

function SetNamePanel:ClickReturn()
  if self.isPlayAni == true then
    return
  end
  self:PlayChangeNameCloseAnim()
  self.isPlayAni = true
end

return SetNamePanel
