local Button = typeof(CS.UnityEngine.UI.Button)
local DeckCardSelectPanel, Super = System.NewClass("DeckCardSelectPanel", UIBasePanel)
DeckCardSelectPanel.uiResCls = UI_Battle_Panel_CardStackResource

function DeckCardSelectPanel:ctor(cards, extraProperties)
  Super.ctor(self)
  self.cards = Vue.ref(cards)
  self.extraProperties = extraProperties
  self.selectedCards = {}
  self.cardItemList = {}
  self.selectNum = extraProperties.selectNum
  self.minNum = math.max(0, math.min(extraProperties.minNum or 0, #cards))
  self.cancelable = extraProperties.cancelable
  self.enchantTid = extraProperties.enchantTid
  self.visible = true
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function DeckCardSelectPanel:_GetUIResCls()
  if #self.cards.value > 4 then
    self.uiResCls = UI_Battle_Panel_CardStackResource
  else
    self.uiResCls = UI_Battle_Panel_CardStackLessResource
  end
  return self.uiResCls
end

function DeckCardSelectPanel:OnBind(binder)
  self.binder = binder
  self:_OnBindShortCutComps(binder)
  self.ui.Btn_Confirm_New:SetActive(true)
  self.ui.Btn_Block_Window:SetActive(true)
  self:BindCircularList(binder)
  self.binder:SetButtonState(self.ui.Btn_Confirm_New, 0 == self.minNum and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable)
  binder:BindZ1Button(self.ui.Btn_Confirm_New, function()
    self:_OnClickConfirm()
  end, function()
    if 0 == self.minNum then
      return CommonDefine.BtnType.High
    end
    return #self.selectedCards >= self.minNum and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable
  end)
  local eyeRes = Btn_Block_WindowResource(self.ui.Btn_Block_Window)
  self.eyeOpenIcon = eyeRes.Image_Open
  self.eyeCloseIcon = eyeRes.Image_Close
  binder:BindButtonClick(self.ui.Btn_Block_Window, function()
    self:ToggleVisible()
  end)
  binder:BindToText(self.ui.Text_Chinese, function()
    if self.extraProperties.desc then
      do return LT.Text end
      return LT.Text, self.extraProperties.desc, nil, nil
    else
      do return LT.Textf, "Battle_ChooseCardToHand", tostring(self.selectNum) end
      return LT.Textf, "Battle_ChooseCardToHand", tostring(self.selectNum)
    end
  end)
  self.ui.UI_Common_Btn_Back1:SetActive(self.cancelable)
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.OnBtnCancel))
  self:RefreshEyeVisible()
  self:InitUIBothSidesUI(binder)
  bg.battleDataCenter:SetOpMode(rc.OpMode.Inspect, 9999)
  if bg.battleRender and bg.battleRender.eventMgr then
    bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.CommandResult, self.OnCommandResult, self)
  end
  binder:BindEvent(EventMgr.Instance.NewRecordSegment, System.fn(self, self.OnNewRecordSegment))
  self:AutoCloseInRelayOrAutoBattle()
end

function DeckCardSelectPanel:OnNewRecordSegment()
  if bg.battlePanel and bg.battlePanel.SetOpMode then
    bg.battlePanel:SetOpMode(rc.OpMode.Play)
  end
  self:Close()
end

function DeckCardSelectPanel:OnCommandResult(msgData)
  if msgData.msgId == BattleCommand.lg_SelectTargets and msgData.selectType == bc.TargetSelectType.Card and msgData.ret and bg.isReplay then
    self:OnReplaySelectCard(msgData.targetUids)
  end
end

function DeckCardSelectPanel:OnReplaySelectCard(targetUids)
  for _, uid in ipairs(targetUids) do
    local item = self.cardItemList[uid]
    if item then
      item:SetSelectShow(true)
    end
  end
end

function DeckCardSelectPanel:AutoCloseInRelayOrAutoBattle()
  if bg.IsRelayOrAutoBattle() then
    self.binder:BindTimer(CommonDefine.ReplayCommandWaitTime, 0, nil, System.fn(self, self.Close))
  end
end

function DeckCardSelectPanel:_OnClickConfirm()
  if #self.selectedCards < self.minNum then
    return
  end
  if self.extraProperties.callback ~= nil then
    self.extraProperties.callback(self.selectedCards)
  end
  UIManager.Instance:CloseByUrl(Urls.DbgCardFeatureInfoPanel)
  self:Close()
end

function DeckCardSelectPanel:_OnBindShortCutComps(binder)
  local extraParam = {withoutForwardPanel = true}
  binder:BindComponent(ShortCutComp(self.ui.Text_Confirm_ShortCut, "KeyConfirm", System.fn(self, self._OnClickConfirm), extraParam))
end

function DeckCardSelectPanel:BindCircularList(binder)
  binder:BindToCircularListView(self.ui.ScrollView_CardStack, function()
    return self.cards.value
  end, function(itemBinder, item, index)
    local card = self.cards.value[index]
    local uid = card.uid
    local selected = self.cardItemList[uid] and self.cardItemList[uid].selected or false
    local configId = card.configId
    local battleDesc
    local cost = card:GetCost()
    if DataCenter.barrierData.InBattle then
      battleDesc = card:GetCardDescription()
    end
    local extraParam = {
      runeTid = self.enchantTid
    }
    if index <= 5 then
      extraParam.withoutForwardPanel = true
      extraParam.shortCutUName = "KeyCard" .. index
    end
    local cardComp = itemBinder:BindComponent(CardBaseComponent(item, uid, configId, selected, cost, battleDesc, nil, nil, nil, extraParam))
    cardComp:SetSelectShow(SystemUtils.Contain(self.selectedCards, uid))
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
    local uid = self.cards.value[index].uid
    if self.cardItemList[uid] then
      self.cardItemList[uid] = nil
    end
  end)
end

function DeckCardSelectPanel:OnBtnCancel()
  if bg.battleRender then
    bg.battleRender:SendCommand(BattleCommand.lg_CancelSelectTargets, {})
  end
  self:Close()
end

function DeckCardSelectPanel:ToggleVisible()
  self.visible = not self.visible
  self:RefreshEyeVisible()
end

function DeckCardSelectPanel:RefreshEyeVisible()
  self.eyeOpenIcon:SetActive(self.visible)
  self.eyeCloseIcon:SetActive(not self.visible)
  self.ui.Group_Panel_Content:SetActive(self.visible)
end

function DeckCardSelectPanel:SetCardItemSelectShow(uid, show)
  if self.cardItemList[uid] == nil then
    return
  end
  self.cardItemList[uid]:SetSelectShow(show)
end

function DeckCardSelectPanel:OnClickBtnReturn()
  self:Close()
end

function DeckCardSelectPanel:OnCardSelect(uid)
  if self.selectNum <= 0 then
    return
  end
  if 1 == self.selectNum and 1 == #self.selectedCards then
    self:OnCardDeselect(self.selectedCards[1])
  end
  if #self.selectedCards < self.selectNum then
    table.insert(self.selectedCards, uid)
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
  self.binder:SetButtonState(self.ui.Btn_Confirm_New, #self.selectedCards >= self.minNum and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable)
end

function DeckCardSelectPanel:OnCardDeselect(uid)
  for index, value in ipairs(self.selectedCards) do
    if value == uid then
      table.remove(self.selectedCards, index)
      self:SetCardItemSelectShow(uid, false)
      break
    end
  end
  self.binder:SetButtonState(self.ui.Btn_Confirm_New, #self.selectedCards >= self.minNum and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable)
end

function DeckCardSelectPanel:OnUnbind()
  if self.timer then
    self.binder:StopTimer(self.timer)
    self.timer = nil
  end
  if bg.battleDataCenter then
    bg.battleDataCenter:SetOpMode(rc.OpMode.Play)
  end
  Super.OnUnbind(self)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

function DeckCardSelectPanel:InitUIBothSidesUI()
  local leftUIGroup = {}
  local rightUIGroup = {
    [self.ui.Btn_Block_Window] = 0
  }
  leftUIGroup, rightUIGroup = UIManager.Instance:InitBothSidesUIOriPos(leftUIGroup, rightUIGroup)
  UIManager.Instance:UIBothSidesAdaptation(leftUIGroup, rightUIGroup, CommonDefine.BothSideUILimitDeltaLen.Batltle)
  if bg.battleRender and bg.battleRender.eventMgr then
    bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
  end
end

return DeckCardSelectPanel
