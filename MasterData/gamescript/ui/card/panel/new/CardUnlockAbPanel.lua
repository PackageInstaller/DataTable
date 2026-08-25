local UIAnimationController = CS.Z1Client.UIAnimationController
local CardUnlockAbPanel, Super = System.NewClass("CardUnlockAbPanel", UIBasePanel)
CardUnlockAbPanel.uiResCls = UI_Dbgcopy_Panel_Select_ArousalResource

function CardUnlockAbPanel:ctor(cardInfo, callback, userData, cancelCallback)
  Super.ctor(self)
  self.cardInfo = cardInfo
  self.callback = callback
  self.cancelCallback = cancelCallback
  self.userData = userData
  if userData.selectCount and 0 ~= userData.selectCount then
    self.selectCount = userData.selectCount
  else
    self.selectCount = 1
  end
  self.selectTab = {}
  self.selectOne = nil
  self.cardItems = {}
  for i = #self.cardInfo, 1, -1 do
    local uid = self.cardInfo[i].uid
    local lock = CardDataUtils.GetCardInfo(uid).lock
    local selectType = lock and 1 or 0
    if selectType ~= self.userData.cardType then
      table.remove(self.cardInfo, i)
    end
  end
  self.selectCount = math.min(self.selectCount, #self.cardInfo)
end

function CardUnlockAbPanel:OnBind(binder)
  self.uiAniController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  local MAX_RELIC_NUM = DT.GetConstant("RelicMaximumNumber")
  local maxLit = CopyAwakerDataUtils.GetAwakerAttrs(0, "relic_num_limit")
  if MAX_RELIC_NUM < maxLit then
    self.uiAniController:PlayState("UI_Dbgcopy_Panel_Select_Arousal_Title")
  end
  UICommonBtnVibes.BindCommonBtnVibes(binder, self.ui.UI_Common_Btn_Vibes)
  FrameWaiter.OnNextFrame(function()
    if self.ui then
      local layoutGroup = self.ui.Group_Wake:GetComponent(typeof(CS.UnityEngine.UI.HorizontalLayoutGroup))
      layoutGroup.enabled = false
    end
  end)
  binder:BindToText(self.ui.Text_Not, function()
    if 1 == self.userData.cardType then
      do return LT.Text end
      return LT.Text, "AllAwakerAwaked"
    else
      do return LT.Text end
      return LT.Text, "NoAwakerAwaked"
    end
  end)
  binder:SetActive(self.ui.Text_Not, 0 == #self.cardInfo)
  self.btn1State = Vue.ref(CommonDefine.BtnType.Unclickable)
  binder:BindZ1Button(self.ui.UI_Common_Item_Btn_1, System.fn(self, self.OnClickGain), function()
    return self.btn1State.value
  end, function()
    do return LT.Text end
    return LT.Text, "Choose"
  end, nil, nil, nil)
  binder:BindZ1Button(self.ui.UI_Common_Item_Btn_2, function()
    self:Close()
  end, function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "UniversalCancelButton"
  end, nil, nil, nil)
  self.btn3State = Vue.ref(CommonDefine.BtnType.Unclickable)
  binder:BindZ1Button(self.ui.UI_Common_Item_Btn_3, System.fn(self, self.OnClickGain), function()
    return self.btn3State.value
  end, function()
    do return LT.Text end
    return LT.Text, "Choose"
  end, nil, nil, nil)
  binder:BindToVisible(self.ui.UI_Common_Item_Btn_1, function()
    return not self.userData.price
  end)
  binder:BindToVisible(self.ui.UI_Common_Item_Btn_2, function()
    return self.userData.price
  end)
  binder:BindToVisible(self.ui.UI_Common_Item_Btn_3, function()
    return self.userData.price
  end)
  for index = 1, 4 do
    if not self.cardInfo[index] or self.cardInfo[index].uid == nil then
      binder:SetActive(self.ui["Card_" .. index], false)
    else
      binder:SetActive(self.ui["Card_" .. index], true)
      local data = CardDataUtils.GetCardInfo(self.cardInfo[index].uid)
      local item = binder:BindComponent(WorldStageCardSelectItem(self.ui["Card_" .. index], {
        cardUid = self.cardInfo[index].uid,
        cardTid = self.cardInfo[index].tid
      }, System.fn(self, self.RuneClickCb)))
      self.cardItems[data.uid] = item
    end
  end
  if self.userData.titleStr then
    self.binder:SetText(self.ui.Text_Desc, self.userData.titleStr)
  end
  self:SetPrice(self.userData.price)
  self:HideCancelBtn(self.userData.hideCancelBtn)
end

function CardUnlockAbPanel:SetPrice(_)
end

function CardUnlockAbPanel:HideCancelBtn(_)
end

function CardUnlockAbPanel:RuneClickCb(item, data)
  local uid = data.cardUid
  local lock = CardDataUtils.GetCardInfo(uid).lock
  local selectType = lock and 1 or 0
  if selectType == self.userData.cardType then
    if 1 == self.selectCount then
      self.selectOne = uid
      for _, v in pairs(self.cardItems) do
        v:EnableSelectShow(false)
      end
      item:EnableSelectShow(true)
    elseif self.selectCount > 1 then
      for idx, v in ipairs(self.selectTab) do
        if v == uid then
          table.remove(self.selectTab, idx)
          self.cardItems[uid]:EnableSelectShow(false)
          return
        end
      end
      if #self.selectTab >= self.selectCount then
        Alert.Show("SelectedAwakensAndCardsExceedLimit")
      else
        table.insert(self.selectTab, uid)
        self.cardItems[uid]:EnableSelectShow(true)
      end
    end
    self:UpdateBtnState()
  else
    Logger.Info("选择的卡牌和你传进来的类型不匹配")
  end
end

function CardUnlockAbPanel:UpdateBtnState()
  if self.selectOne == nil and 0 == #self.selectTab then
    self.btn1State.value = CommonDefine.BtnType.Unclickable
    self.btn3State.value = CommonDefine.BtnType.Unclickable
  else
    self.btn1State.value = CommonDefine.BtnType.High
    self.btn3State.value = CommonDefine.BtnType.High
  end
end

function CardUnlockAbPanel:OnClickGain()
  if self.selectOne == nil and 0 == #self.selectTab and self.selectCount > 0 then
    Alert.Show(10726)
    return
  end
  self:Close()
  if self.callback then
    if 1 == self.selectCount then
      self.callback(self.selectOne)
    else
      self.callback(self.selectTab)
    end
  end
end

return CardUnlockAbPanel
