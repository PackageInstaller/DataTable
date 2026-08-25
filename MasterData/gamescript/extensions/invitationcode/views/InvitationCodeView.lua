local InvitationCodeView, Super = NewClass("InvitationCodeView", BaseView)
InvitationCodeView.uiResCls = UI_InvitationCode_Popup_MainResource
local Tab_Invite = 1
local Tab_Binding = 2

function InvitationCodeView:ctor()
  Super.ctor(self)
  self._tabIndex = nil
  self._inviteModel = InvitationCodeModel.Instance
end

function InvitationCodeView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnInvitationTaskDataChanged, self.OnInvitationTaskDataChanged, self)
  self:RegisterLocalNotify(NotifyId.OnInvitorChanged, self.OnInvitorChanged, self)
end

function InvitationCodeView:RegisterEvents()
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Invite, System.fn(self, self.OnToggleInvite))
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Binding, System.fn(self, self.OnToggleBinding))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Question, System.fn(self, self.OnBtnHelp))
  self:AddButtonClickListener(self.ui.Btn_Copy, System.fn(self, self.OnBtnCopy))
  self:AddButtonClickListener(self.ui.Btn_Share, System.fn(self, self.OnBtnShare))
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self.OnBtnConfirm))
  self:AddButtonClickListener(self.ui.Btn_InvitationList, System.fn(self, self.OnOpenInvitationList))
  self:AddButtonClickListener(self.ui.Btn_InvitationList2, System.fn(self, self.OnOpenInvitationList))
  self:AddButtonClickListener(self.ui.Btn_Clean, System.fn(self, self.OnBtnClean))
  self:AddButtonClickListener(self.ui.Btn_Paste, System.fn(self, self.OnBtnPaste))
  self:AddButtonClickListener(self.ui.UI_Summon_Btn_Jump, System.fn(self, self.OnSummonBtnJump))
end

function InvitationCodeView:OnBuildView()
  Super.OnBuildView(self)
  self:CreateTaskTableView()
  self:BindTimer(0.1, -1, System.fn(self, self.OnCheckCleanAndPaste))
  self:SetText(self.ui.Text_Paste, LT.Text("FriendInvitationPaste"))
  self:SetText(self.ui.Text_Confirm, LT.Text("Common_Button_Confirm"))
end

function InvitationCodeView:OnEnterView()
  Super.OnEnterView(self)
  self:LoadAllLangFont(self.ui.Text_BindingPlayer)
  self:RefresToggle()
  self:SetDefaultToggle()
  self:SetMyCode()
  self:UpdateMyInvitorInfo()
  self:RefreshTaskTableView()
  InvitationCodeController.Instance:ReqGetInviteTaskList()
  self:RefreshInvitationCoin()
  self:UpdateBindingCodeLeftTime()
  self:RefreshSkinJump()
  self:OnInvitationTaskDataChanged()
  self:SetActive(self.ui.Com_RedDotBinding, RedPointDataUtils.IsFeatureFirstOpen(cd.FeatureId.FriendInvitation))
  if ApplicationUtils.IsWindows() then
    self:SetActive(self.ui.Btn_Share, false)
  end
end

function InvitationCodeView:OnExitView()
  Super.OnExitView(self)
end

function InvitationCodeView:UpdateBindingCodeLeftTime()
  if not self._updateLeftTimer then
    self._updateLeftTimer = self:BindTimer(1, -1, System.fn(self, self.UpdateBindingCodeLeftTime))
  end
  if self._inviteModel:GetMyInvitorName() then
    self:SetActive(self.ui.Text_Time, false)
    self:StopUpdateTimer()
    return
  end
  local leftTime = self._inviteModel:GetBindingCodeLeftTime()
  if leftTime > 0 then
    local timeStr = TimeUtils.ActivityCountDownFormat(leftTime)
    self:SetText(self.ui.Text_Time, timeStr)
  else
    self:RefresToggle()
    self:SetDefaultToggle()
    self:SetText(self.ui.Text_Time, LT.Text("ActivityIsEnd"))
    RedPointDataUtils.ClearFeatureFirstOpen(cd.FeatureId.FriendInvitation)
    self:StopUpdateTimer()
  end
end

function InvitationCodeView:StopUpdateTimer()
  if self._updateLeftTimer then
    self:StopTimer(self._updateLeftTimer)
    self._updateLeftTimer = nil
  end
end

function InvitationCodeView:CreateTaskTableView()
  local rewardItemGo = self.ui.UI_InvitationCode_Item_Award
  local sizeDelta = rewardItemGo.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self.taskTable = self:CreateTableview(self.ui.RewardView, function()
    return #self._inviteModel:GetRewardTaskList()
  end, function(view, index)
    local cell = self:DequeueCell(view, rewardItemGo)
    local taskList = self._inviteModel:GetRewardTaskList()
    local taskId = taskList[index]
    self:AddViewComponentOnce(cell.gameObject, InvitationTaskItem, taskId)
    return cell
  end, function()
    return w, h
  end)
  
  function self.taskTable.reloadFinishCallback()
    local taskList = self._inviteModel:GetRewardTaskList()
    for i, taskId in ipairs(taskList) do
      if TaskDataUtils.IsCanGetRward(taskId) then
        self.taskTable:MoveCellToCenter(i)
        break
      end
    end
  end
end

function InvitationCodeView:RefreshTaskTableView()
  if self.taskTable then
    self.taskTable:ReloadData()
  end
end

function InvitationCodeView:RefreshSkinJump()
  local skinItem = self._inviteModel:GetSkinRewardItem()
  self:SetActive(self.ui.UI_Summon_Btn_Jump, nil ~= skinItem)
  if skinItem then
    self:_SetSkinJumpButtonInfo(self.ui.UI_Summon_Btn_Jump, skinItem)
  end
end

function InvitationCodeView:_SetSkinJumpButtonInfo(summonBtnGo, skinTid)
  local summonBtnUI = UI_Summon_Btn_JumpResource(summonBtnGo)
  self.binder:SetActive(summonBtnUI.Image_Icon, true)
  self.binder:SetActive(summonBtnUI.Image_Positioning, true)
  self.binder:SetImage(summonBtnUI.Image_Positioning, CommonRes.SkinIcon)
  self.binder:SetActive(summonBtnUI.Image_Bg, true)
  skinTid = AwakerSkinUtils.UnifyToSkinTid(skinTid)
  local skinCfg = AwakerSkinUtils.GetSkinConfig(skinTid)
  self.binder:SetActive(summonBtnUI.Text_Name, true)
  self.binder:SetText(summonBtnUI.Text_Name, LT.Text(skinCfg.Name))
  summonBtnUI.Image_SSR:SetActive(false)
  summonBtnUI.Image_Up:SetActive(false)
end

function InvitationCodeView:OnSummonBtnJump()
  local skinItem = self._inviteModel:GetSkinRewardItem()
  if not skinItem then
    return
  end
  local skinTid = AwakerSkinUtils.UnifyToSkinTid(skinItem)
  UIManager.Instance:Reopen(Urls.AwakerPaintingView, nil, nil, skinTid)
end

function InvitationCodeView:OnBtnHelp()
  PlayerDataUtils.OpenIllustrate(nil, LT.Text("FriendInvitationRule"))
end

function InvitationCodeView:SetMyCode()
  InvitationCodeController.Instance:ReqGetInviteCode(function(code)
    if not self.ui then
      return
    end
    self:SetText(self.ui.Text_InvitationCode, code)
  end)
end

function InvitationCodeView:OnInvitorChanged()
  self:UpdateMyInvitorInfo()
end

function InvitationCodeView:OnInvitationTaskDataChanged()
  local inviteeCount = self._inviteModel:GetInviteeCount()
  local maxInviteeCount = self._inviteModel:GetMaxInviteeCount()
  self:SetText(self.ui.Text_InvitedCount, string.format("%s/%s", inviteeCount, maxInviteeCount))
  local isHaveReward = self._inviteModel:IsHaveReward()
  self:SetActive(self.ui.Red_InvitedReward, isHaveReward)
  self:SetActive(self.ui.Red_InvitedReward2, isHaveReward)
  self:SetActive(self.ui.Com_RedDotInvite, isHaveReward)
end

function InvitationCodeView:UpdateMyInvitorInfo()
  local invitorName = self._inviteModel:GetMyInvitorName()
  if invitorName then
    self:SetText(self.ui.Text_BindingPlayer, LT.Textf("FriendInvitationTips_Accepted", invitorName))
    self:SetActive(self.ui.Group_CodeInfo, false)
  else
    self:SetText(self.ui.Text_BindingPlayer, "")
    self:SetActive(self.ui.Group_CodeInfo, true)
  end
end

function InvitationCodeView:RefreshInvitationCoin()
  self.binder:BindToText(self.ui.Text_InvitationValue, function()
    do return ItemDataUtils.GetItemNum end
    return ItemDataUtils.GetItemNum, cd.CurrencyType.InvitationCoin
  end)
end

function InvitationCodeView:OnBtnCopy()
  StrUtils.CopyToClipboard(self._inviteModel:GetInviteCode())
  Alert.Show(20353)
end

function InvitationCodeView:OnBtnShare()
  local inviteCode = self._inviteModel:GetInviteCode()
  local officialWebsite = SdkMgr.Instance:GetOfficialWebsite()
  local shareContent = LT.Textf("FriendInvitationShareText", inviteCode, officialWebsite or "")
  StrUtils.CopyToClipboard(shareContent)
  SdkMgr.Instance:GetShare():SystemShare(shareContent)
end

function InvitationCodeView:OnBtnConfirm()
  local code = self:GetInputText(self.ui.InputField_Code)
  code = string.trim(code)
  if "" == code then
    return
  end
  local myCode = self._inviteModel:GetInviteCode()
  if code == myCode then
    Alert.Show(20355)
    return
  end
  Alert.Show(20352, nil, function()
    InvitationCodeController.Instance:ReqBindInviteCode(code)
  end)
end

function InvitationCodeView:OnOpenInvitationList()
  UIManager.Instance:Reopen(Urls.InvitationPlayerView)
end

function InvitationCodeView:OnBtnClean()
  local textComp = self:GetInputFieldComp(self.ui.InputField_Code)
  if textComp then
    textComp.text = ""
  end
end

function InvitationCodeView:OnBtnPaste()
  local pasteText = StrUtils.PasteFromClipboard()
  local textComp = self:GetInputFieldComp(self.ui.InputField_Code)
  if textComp then
    textComp.text = pasteText
  end
end

function InvitationCodeView:OnCheckCleanAndPaste()
  local textComp = self:GetInputFieldComp(self.ui.InputField_Code)
  if not textComp then
    return
  end
  local curText = textComp.text
  local isHaveText = curText and "" ~= curText
  if self._isHaveText == isHaveText then
    return
  end
  self._isHaveText = isHaveText
  self:SetActive(self.ui.Btn_Clean, isHaveText)
  self:SetActive(self.ui.Btn_Paste, not isHaveText)
end

function InvitationCodeView:RefresToggle()
  local isEnableBinding = self._inviteModel:IsEnableBinding()
  local isHaveInvitor = self._inviteModel:GetMyInvitorName()
  local isShowBinding = isHaveInvitor or isEnableBinding
  self:SetActive(self.ui.Btn_Binding, isShowBinding)
  self:SetActive(self.ui.Line, isShowBinding)
end

function InvitationCodeView:SetDefaultToggle()
  self:SetZ1Toggle(self.ui.Btn_Invite, true)
end

function InvitationCodeView:OnToggleInvite()
  if self._tabIndex ~= Tab_Invite then
    self._tabIndex = Tab_Invite
    self:RefreshGroupVisible()
  end
end

function InvitationCodeView:OnToggleBinding()
  if self._tabIndex ~= Tab_Binding then
    self._tabIndex = Tab_Binding
    self:RefreshGroupVisible()
    RedPointDataUtils.ClearFeatureFirstOpen(cd.FeatureId.FriendInvitation)
    self:SetActive(self.ui.Com_RedDotBinding, false)
  end
end

function InvitationCodeView:RefreshGroupVisible()
  self:SetActive(self.ui.Group_Binding, self._tabIndex == Tab_Binding)
  self:SetActive(self.ui.Group_Invite, self._tabIndex == Tab_Invite)
end

function InvitationCodeView:RefreshView()
end

return InvitationCodeView
