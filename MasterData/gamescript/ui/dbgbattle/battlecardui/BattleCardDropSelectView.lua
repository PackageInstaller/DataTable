local BattleCardDropSelectView, Super = NewClass("BattleCardDropSelectView", BaseView)
BattleCardDropSelectView.uiResCls = UI_Battle_Popup_CardGroupResource

function BattleCardDropSelectView:ctor(data, selectCallback)
  Super.ctor(self)
  self.data = data
  self.selectCallback = selectCallback
  self.packList = data and data.packList or {}
  self.selectMaxNum = data and data.selectMaxNum or 1
  self.selectMinNum = data and data.selectMinNum or 0
  self.targetSelectType = data and data.targetSelectType
  self.selectedPacks = {}
  self.selectedPackCount = 0
  self.packCardList = {}
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function BattleCardDropSelectView:OnBuildView()
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._OnClickConfirm))
  if self.ui.Btn_Mask then
    self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self._CloseDetailTips))
  end
  self:_InitBlockWindowBtn()
  self:_BuildPackData()
  self:_RefreshPackList()
end

function BattleCardDropSelectView:_InitBlockWindowBtn()
  if not self.ui.Btn_Block_Window then
    return
  end
  if not self.ui.Group_Content and not self.ui.UI_Common_Glass then
    return
  end
  self:SetActive(self.ui.Btn_Block_Window, true)
  self._contentVisible = true
  local eyeRes = Btn_Block_WindowResource(self.ui.Btn_Block_Window)
  self._eyeOpenIcon = eyeRes.Image_Open
  self._eyeCloseIcon = eyeRes.Image_Close
  self:AddButtonClickListener(self.ui.Btn_Block_Window, System.fn(self, self._ToggleContentVisible))
  self:_RefreshContentVisible()
end

function BattleCardDropSelectView:_ToggleContentVisible()
  self._contentVisible = not self._contentVisible
  self:_RefreshContentVisible()
end

function BattleCardDropSelectView:_RefreshContentVisible()
  if self._eyeOpenIcon then
    self._eyeOpenIcon:SetActive(self._contentVisible)
  end
  if self._eyeCloseIcon then
    self._eyeCloseIcon:SetActive(not self._contentVisible)
  end
  if self.ui.Group_Content then
    self:SetActive(self.ui.Group_Content, self._contentVisible)
  end
  if self.ui.UI_Common_Glass then
    self:SetActive(self.ui.UI_Common_Glass, self._contentVisible)
  end
  if not self._contentVisible then
    self:_CloseDetailTips()
  end
end

function BattleCardDropSelectView:_InitBothSidesUI()
  if not self.ui.Btn_Block_Window then
    return
  end
  local leftUIGroup = {}
  local rightUIGroup = {
    [self.ui.Btn_Block_Window] = 0
  }
  leftUIGroup, rightUIGroup = UIManager.Instance:InitBothSidesUIOriPos(leftUIGroup, rightUIGroup)
  UIManager.Instance:UIBothSidesAdaptation(leftUIGroup, rightUIGroup, CommonDefine.BothSideUILimitDeltaLen.Batltle)
end

function BattleCardDropSelectView:OnEnterView()
  Super.OnEnterView(self)
  self:SetText(self.ui.Text_C_Title, LT.Text(self.data.title))
  self:_RefreshConfirmBtnState()
  self:_InitBothSidesUI()
  if bg.battleRender and bg.battleRender.eventMgr then
    bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.CommandResult, self._OnCommandResult, self)
  end
  self:BindEvent(EventMgr.Instance.NewRecordSegment, System.fn(self, self._OnNewRecordSegment))
  self:AutoCloseInRelayOrAutoBattle()
  bg.battleDataCenter:SetOpMode(rc.OpMode.Inspect, 9999)
end

function BattleCardDropSelectView:_OnNewRecordSegment()
  if bg.battlePanel and bg.battlePanel.SetOpMode then
    bg.battlePanel:SetOpMode(rc.OpMode.Play)
  end
  self:Close()
end

function BattleCardDropSelectView:AutoCloseInRelayOrAutoBattle()
  if bg.IsRelayOrAutoBattle() then
    self:BindTimer(CommonDefine.ReplayCommandWaitTime, 0, nil, System.fn(self, self.Close))
  end
end

function BattleCardDropSelectView:OnExitView()
  Super.OnExitView(self)
  self:_CloseDetailTips()
  if bg.battleRender and bg.battleRender.eventMgr then
    bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
  end
  if bg.battleDataCenter then
    bg.battleDataCenter:SetOpMode(rc.OpMode.Play)
  end
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

function BattleCardDropSelectView:_BuildPackData()
  self.packCardList = {}
  local cardMgr = bg.battleRender and bg.battleRender.cardMgr
  if not cardMgr then
    return
  end
  for _, packData in ipairs(self.packList) do
    local packIndex = packData.index
    local showCardId = packData.showCardId or DT.GetConstant("SelectDropDefaultShowCard")
    local skillCfg = showCardId and DT.Skill[showCardId]
    local packInfo = {
      index = packIndex,
      showCardId = showCardId,
      cardUids = packData.cardUids or {},
      keeperSkillUids = packData.keeperSkillUids or {},
      keeperSkillInfos = packData.keeperSkillInfos or {},
      cards = {},
      skillIcon = skillCfg and skillCfg.Icon or "",
      skillName = skillCfg and skillCfg.Name or ""
    }
    for _, cardUid in ipairs(packInfo.cardUids) do
      local card = cardMgr:GetCardByUid(cardUid)
      if card then
        table.insert(packInfo.cards, card)
      end
    end
    self.packCardList[packIndex] = packInfo
  end
end

function BattleCardDropSelectView:_RefreshPackList()
  local ct = self.ui.Group_CardGroups.transform
  local packNum = #self.packList
  local cnt = self:ReserveChildren(ct, packNum)
  for i = 1, packNum do
    local go = ct:GetChild(i - 1).gameObject
    go:SetActive(true)
    local packData = self.packList[i]
    local packIndex = packData.index
    local packInfo = self.packCardList[packIndex]
    local isSelected = self.selectedPacks[packIndex] == true
    local itemComp = self:AddViewComponentOnce(go, UICompBattleCardDropSelectItem, function(idx, itemGo)
      self:_OnCardClick(idx, itemGo)
    end)
    itemComp:Refresh(packIndex, packInfo, isSelected)
  end
  for i = packNum + 1, cnt do
    local go = ct:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
end

function BattleCardDropSelectView:_OnCardClick(packIndex, itemGo)
  local isDeselect = self.selectedPacks[packIndex] == true
  if isDeselect then
    self:_CloseDetailTips()
  else
    self:_ShowCardDetailTips(packIndex, itemGo)
  end
  if self.selectMaxNum <= 1 then
    if self.selectedPacks[packIndex] then
      self:_DeselectPack(packIndex)
    else
      for idx, selected in pairs(self.selectedPacks) do
        if selected then
          self:_DeselectPack(idx)
        end
      end
      self:_SelectPack(packIndex)
    end
  elseif self.selectedPacks[packIndex] then
    self:_DeselectPack(packIndex)
  else
    self:_SelectPack(packIndex)
  end
  self:_RefreshConfirmBtnState()
end

function BattleCardDropSelectView:_CloseDetailTips()
  UIManager.Instance:CloseByUrl(Urls.MultNameDescTipsView)
end

function BattleCardDropSelectView:_ShowCardDetailTips(packIndex, itemGo)
  local packInfo = self.packCardList[packIndex]
  if not packInfo then
    return
  end
  local hasCardList = packInfo.cardUids and #packInfo.cardUids > 0
  local hasKeeperSkillList = packInfo.keeperSkillInfos and #packInfo.keeperSkillInfos > 0
  if not hasCardList and not hasKeeperSkillList then
    return
  end
  UIManager.Instance:Reopen(Urls.MultNameDescTipsView, {packInfo = packInfo}, itemGo)
end

function BattleCardDropSelectView:_SelectPack(packIndex)
  if self.selectedPacks[packIndex] then
    return
  end
  if self.selectedPackCount >= self.selectMaxNum then
    local desc = LT.Textf("BattleCardDropFullSelectAlert", self.selectMaxNum)
    Alert.ShowStr(desc)
    return
  end
  self.selectedPacks[packIndex] = true
  self.selectedPackCount = self.selectedPackCount + 1
  self:_RefreshPackList()
  print("[CardDrop] Select pack:", packIndex, "total:", self.selectedPackCount)
end

function BattleCardDropSelectView:_DeselectPack(packIndex)
  if not self.selectedPacks[packIndex] then
    return
  end
  self.selectedPacks[packIndex] = false
  self.selectedPackCount = self.selectedPackCount - 1
  self:_RefreshPackList()
  print("[CardDrop] Deselect pack:", packIndex, "total:", self.selectedPackCount)
end

function BattleCardDropSelectView:_RefreshConfirmBtnState()
  local canConfirm = self.selectedPackCount >= self.selectMinNum
  if canConfirm then
    self:SetButtonState(self.ui.Btn_Confirm, CommonDefine.BtnType.High)
  else
    self:SetButtonState(self.ui.Btn_Confirm, CommonDefine.BtnType.Unclickable)
  end
end

function BattleCardDropSelectView:_OnClickConfirm()
  if self.selectedPackCount < self.selectMinNum then
    return
  end
  local packIndexList = {}
  for packIndex, selected in pairs(self.selectedPacks) do
    if selected then
      table.insert(packIndexList, packIndex)
    end
  end
  table.sort(packIndexList)
  print("[CardDrop] Confirm packIndexList:", table.tostring(packIndexList))
  if self.selectCallback then
    self.selectCallback(packIndexList)
  end
  self:Close()
end

function BattleCardDropSelectView:_OnCommandResult(msgData)
  if msgData.msgId == BattleCommand.lg_SelectTargets and (msgData.selectType == bc.TargetSelectType.CardDrop or msgData.selectType == bc.TargetSelectType.KeeperSkillDrop) and msgData.ret then
    print("[CardDrop] BattleCardDropSelectView OnCommandResult success")
    if bg.isReplay then
      self:BindTimer(CommonDefine.ReplayCommandWaitTime, 0, nil, System.fn(self, self.Close))
    else
      self:Close()
    end
  end
end

return BattleCardDropSelectView
