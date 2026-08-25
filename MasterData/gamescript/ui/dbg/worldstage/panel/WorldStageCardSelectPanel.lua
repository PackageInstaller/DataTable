local UIBasePanel = require("Managers.UI.UIBasePanel")
local System = require("System.System")
local EventMgr = require("Managers.EventManager.EventMgr")
local SystemUtils = require("System.SystemUtils")
local DT = require("System.DataTable")
local UIManager = require("Managers.UI.UIManager")
local Urls = require("Managers.UI.Urls")
local LT = require("System.LangTable")
local Logger = require("Utility.Logger")
local UI_Dbgcopy_Panel_StoreResource = require("UI.UIPackages.UI_Dbgcopy_Panel_StoreResource")
local Alert = require("System.Alert")
local CommonDefine = require("World.Enums.CommonDefine")
local WorldStageCardSelectPanel, Super = System.NewClass("WorldStageCardSelectPanel", UIBasePanel)
WorldStageCardSelectPanel.uiResCls = UI_Dbgcopy_Panel_StoreResource

function WorldStageCardSelectPanel:ctor(cards, extraProperties)
  Super.ctor(self)
  self.cards = Vue.ref(cards)
  self.extraProperties = extraProperties
  self.totalCard = #cards
  self.selectedCards = {}
  self.cardItemList = {}
  self.selectNum = extraProperties.selectNum
  self.minSelectNum = extraProperties.minSelectNum or 0
end

function WorldStageCardSelectPanel:OnBind(binder)
  self.binder = binder
  binder:BindResponse(self, "World", "OnSyncCard", System.fn(self, self.OnSyncCard))
  binder:BindToText(self.ui.Text_Title, function()
    if self.extraProperties.desc then
      do return LT.Text end
      return LT.Text, self.extraProperties.desc, nil, nil
    else
      do return string.format, LT.Text("Battle_ChooseCardToHand"), tostring(self.selectNum) end
      return string.format, LT.Text("Battle_ChooseCardToHand"), tostring(self.selectNum)
    end
  end)
  self.ui.Text_Remove:SetActive(false)
  self.ui.Image_Icon:SetActive(false)
  self.ui.Text_Enchant:SetActive(false)
  binder:SetActive(self.ui.UI_Common_Item_Btn_2, true)
  binder:BindToText(self.ui.Text_Remove, function()
    return self.extraProperties.tip or ""
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Card, function()
    return self.cards.value
  end, function(itemBinder, gameObj, index)
    local card = self.cards.value[index]
    if card then
      local uid = card.uid
      local selected = self.cardItemList[uid] and self.cardItemList[uid].selected or false
      local configId = card.configId
      local cardComp = itemBinder:BindComponent(require("UI.Card.Component.CardBaseComponent")(gameObj, uid, configId, selected, card.cost, nil))
      cardComp:SetClickCallback(function()
        self:OnClickCard(cardComp, uid)
        if not table.contains(self.selectedCards, uid) then
          self:OnCardSelect(uid)
        else
          self:OnCardDeselect(uid)
        end
      end)
      cardComp:SetSelectShow(SystemUtils.Contain(self.selectedCards, uid))
      self.cardItemList[uid] = cardComp
    end
  end, function(index)
    local uid = self.cards.value[index].uid
    if self.cardItemList[uid] then
      self.cardItemList[uid] = nil
    end
  end)
  self.btnState = Vue.ref(CommonDefine.BtnType.Unclickable)
  self.ui.UI_Common_Item_Btn_2.transform.anchoredPosition = CS.UnityEngine.Vector2(620, -338)
  binder:BindZ1Button(self.ui.UI_Common_Item_Btn_2, function()
    if #self.selectedCards < self.minSelectNum and #self.selectedCards < self.totalCard then
      Logger.Info("没有选择卡牌", #self.selectedCards, self.minSelectNum)
      return
    end
    if self.btnState.value == CommonDefine.BtnType.Unclickable then
      Logger.Info("按钮不可点")
      return
    end
    if self.extraProperties.callback then
      self.extraProperties.callback(self.selectedCards)
    end
    if self.extraProperties.desc == "Card_Select_Copy_Tips1_Ruins" then
      AudioManager.Instance:PostSoundEvent("Play_SFX_UI_Enchant_Advanced_Card")
    end
    self:Close()
  end, function()
    return self.btnState.value
  end, function()
    do return LT.Text end
    return LT.Text, "Common_Button_Confirm"
  end, nil, nil, nil)
  self:EnableConfirmButton(false)
  binder:BindEvent(EventMgr.Instance.SelectedCard, function(selected, uid)
    Logger.Debug(string.format("uid:%d, selected:%s", uid, tostring(selected)))
    if selected then
      self:OnCardSelect(uid)
    else
      self:OnCardDeselect(uid)
    end
  end)
  binder:BindToVisible(self.ui.Btn_Closure, function()
    return false
  end)
end

function WorldStageCardSelectPanel:OnSyncCard(syncData)
  self.binder:BindTimer(0.05, 0, nil, function()
    local cards = self.cards.value or {}
    for i = #cards, 1, -1 do
      local uid = cards[i].uid
      if not CardDataUtils.GetCardInfo(uid) then
        self.cardItemList[uid] = nil
        table.removeByValue(self.selectedCards, uid)
        table.remove(cards, i)
      end
    end
  end)
end

function WorldStageCardSelectPanel:SetCardItemSelectShow(uid, show)
  if self.cardItemList[uid] == nil then
    return
  end
  self.cardItemList[uid]:SetSelectShow(show)
end

function WorldStageCardSelectPanel:OnClickCard(cardComp, cardUid)
  if self.isBanBtnClick == true then
    Logger.Info("WorldStageCardSelectPanel BtnClicked")
    return
  end
  local cardDesc = cardComp:GetCardDesc()
  if StrUtils.CheckDescContainKeywords(cardDesc) then
    local awakerData = CardDataUtils.GetCardOwner(cardUid)
    local exParam = {
      withoutMask = true,
      skillTid = cardComp.configId.value,
      skillLevel = cardComp.cardLv.value,
      awakerData = awakerData,
      effectDescGroupList = {},
      margin = -5,
      marginRight = -22
    }
    UIManager.Instance:Reopen(Urls.CommonCardKeyWorldDescPanel, {cardDesc}, cardComp.ui.uiNode, exParam)
  end
end

function WorldStageCardSelectPanel:EnableConfirmButton(enabled)
  if 0 == #self.cards.value or #self.cards.value < (self.selectNum or 1) then
    enabled = true
  end
  if 0 == self.minSelectNum then
    enabled = true
  end
  if enabled then
    self.btnState.value = CommonDefine.BtnType.High
  else
    self.btnState.value = CommonDefine.BtnType.Unclickable
  end
end

function WorldStageCardSelectPanel:OnCardSelect(uid)
  if self.selectNum <= 0 then
    return
  end
  if 1 == self.selectNum and 1 == #self.selectedCards then
    self:OnCardDeselect(self.selectedCards[1])
  end
  if #self.selectedCards < self.selectNum then
    table.insert(self.selectedCards, uid)
    self:SetCardItemSelectShow(uid, true)
  else
    local desc = LT.Textf(DT.TipsType[10168].Desc, self.selectNum)
    Alert.Show(10168, nil, nil, nil, desc)
  end
  self:EnableConfirmButton(#self.selectedCards >= self.selectNum or #self.selectedCards >= self.totalCard)
end

function WorldStageCardSelectPanel:OnCardDeselect(uid)
  for index, value in ipairs(self.selectedCards) do
    if value == uid then
      table.remove(self.selectedCards, index)
      self:SetCardItemSelectShow(uid, false)
      break
    end
  end
  self:EnableConfirmButton(#self.selectedCards >= self.selectNum or #self.selectedCards >= self.totalCard)
end

return WorldStageCardSelectPanel
