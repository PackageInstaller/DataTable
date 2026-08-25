local KeeperSkillSelectPanel, Super = System.NewClass("KeeperSkillSelectPanel", FuncBattleCardInfoPanel)
KeeperSkillSelectPanel.uiResCls = UI_Battle_Panel_CardStackResource

function KeeperSkillSelectPanel:ctor(keeperSkills, title, selectCallback, cancelable)
  Super.ctor(self)
  self.keeperSkills = keeperSkills
  self.title = title
  self.selectCallback = selectCallback
  self.cancelable = cancelable
  self.selectedUids = {}
  self.cardItemList = {}
  self.selectNum = 1
  self.minNum = 1
  self.visible = true
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function KeeperSkillSelectPanel:OnBind(binder)
  self.binder = binder
  self:_OnBindShortCutComps(binder)
  self:BindTexts()
  self.ui.Btn_Confirm_New:SetActive(true)
  self.ui.Btn_Block_Window:SetActive(true)
  self:BindKeeperSkills()
  self:InitEyeToggle()
  self:InitConfirmBtns()
  self:InitUIBothSidesUI(binder)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.CommandResult, self.OnCommandResult, self)
  binder:BindEvent(EventMgr.Instance.NewRecordSegment, System.fn(self, self.OnNewRecordSegment))
  self:AutoCloseInRelayOrAutoBattle()
  self.ui.UI_Common_Btn_Back1:SetActive(self.cancelable)
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.OnBtnCancel))
end

function KeeperSkillSelectPanel:OnNewRecordSegment()
  if bg.battlePanel and bg.battlePanel.SetOpMode then
    bg.battlePanel:SetOpMode(rc.OpMode.Play)
  end
  self:Close()
end

function KeeperSkillSelectPanel:OnBtnCancel()
  if bg.battleRender then
    bg.battleRender:SendCommand(BattleCommand.lg_CancelSelectTargets, {})
  end
  self:Close()
end

function KeeperSkillSelectPanel:BindKeeperSkills()
  self.binder:BindToCircularListView(self.ui.ScrollView_CardStack, function()
    return self.keeperSkills
  end, function(itemBinder, item, index)
    local keeperSkillInfo = self.keeperSkills[index]
    local uid = keeperSkillInfo.uid
    local selected = self.cardItemList[uid] and self.cardItemList[uid].selected or false
    local configId = keeperSkillInfo.tid
    local battleDesc = CardDataUtils.GetCardDescription(configId, 1, uid, nil, nil, nil, true)
    local cost = ""
    local extraParam = {}
    if index <= 5 then
      extraParam.withoutForwardPanel = true
      extraParam.shortCutUName = "KeyCard" .. index
    end
    local cardComp = itemBinder:BindComponent(CardBaseComponent(item, uid, configId, selected, cost, battleDesc, nil, nil, nil, extraParam))
    cardComp:SetSelectShow(SystemUtils.Contain(self.selectedUids, uid))
    cardComp:SetClickCallback(function()
      if UIManager.Instance:GetWindow(Urls.CommonCardKeyWorldDescPanel) then
        UIManager.Instance:CloseByUrl(Urls.CommonCardKeyWorldDescPanel)
      end
      if not cardComp.selected then
        self:OnCardSelect(uid)
      else
        self:OnCardDeselect(uid)
      end
    end)
    self.cardItemList[uid] = cardComp
  end, function(index)
    local uid = self.keeperSkills[index].uid
    if self.cardItemList[uid] then
      self.cardItemList[uid] = nil
    end
  end)
end

function KeeperSkillSelectPanel:AutoCloseInRelayOrAutoBattle()
  if bg.isRelay or bg.isAutoBattle then
    self.binder:BindTimer(CommonDefine.ReplayCommandWaitTime, 0, nil, System.fn(self, self.Close))
  end
end

function KeeperSkillSelectPanel:OnCommandResult(msgData)
  if msgData.msgId == BattleCommand.lg_SelectTargets and msgData.selectType == bc.TargetSelectType.KeeperSkill and msgData.ret then
    print("commandresult ===== ", table.tostring(msgData))
    if bg.isReplay then
      self:OnReplaySelectKeeperSkill(msgData.targetUids)
    else
      self:Close()
    end
  end
end

function KeeperSkillSelectPanel:OnReplaySelectKeeperSkill(targetUids)
  for _, uid in ipairs(targetUids) do
    local item = self.cardItemList[uid]
    if item then
      item:SetSelectShow(true)
    end
  end
end

function KeeperSkillSelectPanel:InitEyeToggle()
  local eyeRes = Btn_Block_WindowResource(self.ui.Btn_Block_Window)
  self.eyeOpenIcon = eyeRes.Image_Open
  self.eyeCloseIcon = eyeRes.Image_Close
  self.binder:BindButtonClick(self.ui.Btn_Block_Window, function()
    self:ToggleVisible()
  end)
  self:RefreshEyeVisible()
end

function KeeperSkillSelectPanel:InitConfirmBtns()
  self.binder:SetButtonState(self.ui.Btn_Confirm_New, 0 == self.minNum and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable)
  self.binder:BindZ1Button(self.ui.Btn_Confirm_New, function()
    self:_OnClickConfirm()
  end)
end

function KeeperSkillSelectPanel:_OnClickConfirm()
  if #self.selectedUids < self.minNum then
    return
  end
  if self.selectCallback then
    self.selectCallback(self.selectedUids)
  end
  UIManager.Instance:CloseByUrl(Urls.DbgCardFeatureInfoPanel)
  self:Close()
end

function KeeperSkillSelectPanel:BindTexts()
  self.binder:BindToText(self.ui.Text_Chinese, function()
    do return LT.Text end
    return LT.Text, self.title or "Battle_ChooseCard"
  end)
end

function KeeperSkillSelectPanel:ToggleVisible()
  self.visible = not self.visible
  self:RefreshEyeVisible()
  bg.battleDataCenter:SetOpMode(rc.OpMode.Inspect, 9999)
end

function KeeperSkillSelectPanel:RefreshEyeVisible()
  self.eyeOpenIcon:SetActive(self.visible)
  self.eyeCloseIcon:SetActive(not self.visible)
  self.ui.Group_Panel_Content:SetActive(self.visible)
end

function KeeperSkillSelectPanel:SetCardItemSelectShow(uid, show)
  if self.cardItemList[uid] == nil then
    return
  end
  self.cardItemList[uid]:SetSelectShow(show)
end

function KeeperSkillSelectPanel:OnClickBtnReturn()
  self:Close()
end

function KeeperSkillSelectPanel:_OnBindShortCutComps(binder)
  local extraParam = {withoutForwardPanel = true}
  binder:BindComponent(ShortCutComp(self.ui.Text_Confirm_ShortCut, "KeyConfirm", System.fn(self, self._OnClickConfirm), extraParam))
end

function KeeperSkillSelectPanel:OnCardSelect(uid)
  if self.selectNum <= 0 then
    return
  end
  if 1 == self.selectNum and 1 == #self.selectedUids then
    self:OnCardDeselect(self.selectedUids[1])
  end
  if #self.selectedUids < self.selectNum then
    table.insert(self.selectedUids, uid)
    self:SetCardItemSelectShow(uid, true)
    local cardComp = self.cardItemList[uid]
    if cardComp then
      local showDesc = StrUtils.SetWordEffectStr(cardComp:GetCardDesc())
      if StrUtils.CheckContainsEffectLink(showDesc) then
        local awakerData = CardDataUtils.GetCardOwner(uid)
        local exParam = {
          withoutMask = true,
          skillTid = cardComp.configId.value,
          skillLevel = cardComp.cardLv.value,
          awakerData = awakerData
        }
        if bg.battlePanel then
          exParam.effectDescGroupList = CardDataUtils.GetCardEffectGroupList(exParam.skillTid, uid)
          exParam.skillTid = nil
        end
        UIManager.Instance:Reopen(Urls.CommonCardKeyWorldDescPanel, {
          LT.Text(cardComp:GetCardDesc())
        }, cardComp.ui.uiNode, exParam)
      end
    end
  else
    local desc = LT.Textf(DT.TipsType[10168].Desc, self.selectNum)
    Alert.Show(10168, nil, nil, nil, desc)
  end
  self.binder:SetButtonState(self.ui.Btn_Confirm_New, #self.selectedUids >= self.minNum and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable)
end

function KeeperSkillSelectPanel:OnCardDeselect(uid)
  for index, value in ipairs(self.selectedUids) do
    if value == uid then
      table.remove(self.selectedUids, index)
      self:SetCardItemSelectShow(uid, false)
      break
    end
  end
  self.binder:SetButtonState(self.ui.Btn_Confirm_New, #self.selectedUids >= self.minNum and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable)
end

function KeeperSkillSelectPanel:OnUnbind()
  if self.timer then
    self.binder:StopTimer(self.timer)
    self.timer = nil
  end
  if bg.battleRender and bg.battleRender.eventMgr then
    bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
  end
  if bg.battleDataCenter then
    bg.battleDataCenter:SetOpMode(rc.OpMode.Play)
  end
  Super.OnUnbind(self)
end

function KeeperSkillSelectPanel:InitUIBothSidesUI()
  local leftUIGroup = {}
  local rightUIGroup = {
    [self.ui.Btn_Block_Window] = 0
  }
  leftUIGroup, rightUIGroup = UIManager.Instance:InitBothSidesUIOriPos(leftUIGroup, rightUIGroup)
  UIManager.Instance:UIBothSidesAdaptation(leftUIGroup, rightUIGroup, CommonDefine.BothSideUILimitDeltaLen.Batltle)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

return KeeperSkillSelectPanel
