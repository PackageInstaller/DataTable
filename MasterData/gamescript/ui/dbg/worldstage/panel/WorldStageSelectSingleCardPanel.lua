local WorldStageSelectSingleCardPanel, Super = System.NewClass("WorldStageSelectSingleCardPanel", UIBasePanel)
WorldStageSelectSingleCardPanel.uiResCls = UI_Dbgcopy_Panel_Select_vibesResource
local MaxCardCount = 5

function WorldStageSelectSingleCardPanel:ctor(cards, extraProperties)
  Super.ctor(self)
  self.cards = Vue.ref(cards)
  self.extraProperties = extraProperties
  self.selectCardUid = Vue.ref(0)
end

function WorldStageSelectSingleCardPanel:OnBind(binder)
  self.binder = binder
  self:BindConfirmButton()
  self:BindCardsListView()
  UICommonBtnVibes.BindCommonBtnVibes(binder, self.ui.UI_Common_Btn_Vibes)
  self.ui.ScrollView_Card:SetActive(false)
  binder:BindEvent(EventMgr.Instance.CSSendEvent, System.fn(self, self.OnCSEvent))
  binder:BindToText(self.ui.Text_Desc, function()
    do return LT.Text end
    return LT.Text, self.extraProperties.title or LT.Text("ResonanceSelectCard"), "ResonanceSelectCard"
  end)
  if #self.cards.value < MaxCardCount then
    self.ui.Content.transform.anchoredPosition = CS.UnityEngine.Vector2(-170, 0)
  else
    self.ui.Content.transform.anchoredPosition = CS.UnityEngine.Vector2(0, 0)
  end
end

function WorldStageSelectSingleCardPanel:SetLayoutEnabled(isEnable)
  local layoutGroup = self.ui.Content:GetComponent(typeof(CS.UnityEngine.UI.HorizontalLayoutGroup))
  layoutGroup.enabled = isEnable
end

function WorldStageSelectSingleCardPanel:BindConfirmButton()
  self.binder:SetActive(self.ui.UI_Common_Item_Btn_2, true)
  self.binder:BindZ1Button(self.ui.UI_Common_Item_Btn_2, function()
    if 0 == self.selectCardUid.value then
      Logger.Info("没有选择卡牌")
      return
    end
    if self.extraProperties.callback then
      self.extraProperties.callback(self.selectCardUid.value)
    end
    self:Close()
  end, function()
    if 0 == self.selectCardUid.value then
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.High
  end, function()
    return self.extraProperties.confirmText or LT.Text("Common_Button_Confirm")
  end)
end

function WorldStageSelectSingleCardPanel:BindCardsListView()
  self.cardComps = {}
  self:SetLayoutEnabled(true)
  for index = 1, MaxCardCount do
    local cardUINode = self.ui["Card_" .. index]
    local data = self.cards.value[index]
    if cardUINode then
      cardUINode:SetActive(nil ~= data)
    end
    if data and cardUINode then
      local comp = self.binder:BindComponent(WorldStageCardSelectItem(cardUINode, {
        runeTid = nil,
        cardUid = data.uid,
        cardTid = data.configId
      }, System.fn(self, self.RuneClickCb)))
      comp:EnableEnchantShow(false)
      self.cardComps[index] = comp
    end
  end
end

function WorldStageSelectSingleCardPanel:OnCSEvent(eventName, _)
  if "OnStartGrabScreen" ~= eventName then
    return
  end
  self.ui.ScrollView_Card:SetActive(true)
end

function WorldStageSelectSingleCardPanel:RuneClickCb(item, data)
  self:SetLayoutEnabled(false)
  self.selectCardUid.value = data.cardUid
  if self.lastSelectItem then
    self.lastSelectItem:EnableSelectShow(false)
  end
  item:EnableSelectShow(true)
  self.lastSelectItem = item
end

return WorldStageSelectSingleCardPanel
