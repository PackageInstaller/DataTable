_class("UILuckLandSelectCardPopUp", UIController)
UILuckLandSelectCardPopUp = UILuckLandSelectCardPopUp

function UILuckLandSelectCardPopUp:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UILuckLandSelectCardPopUp:OnShow(uiParams)
  self.cardDataList = LuckLandData:GetInstance():CurCardDatas()
  self.buildDataLevel = LuckLandData:GetInstance():CurBuildingDatas()
  self.gameData = LuckLandData:GetInstance():CurGameData()
  self.finishCB = uiParams[1]
  self._curIndex = nil
  self._extraDrawCardCount = 0
  self:InitWidget()
  LuckLandInnerGameHelper.ResetReDrawCount()
  self:InitUI()
end

function UILuckLandSelectCardPopUp:InitWidget()
  self._anim = self:GetGameObject("_anim")
  self.cardPool = self:GetUIComponent("UISelectObjectPath", "CardPool")
  self.titleText = self:GetUIComponent("UILocalizationText", "TitleText")
  self.skipBtnText = self:GetUIComponent("UILocalizationText", "SkipBtnText")
  self.reExtractBtnText = self:GetUIComponent("UILocalizationText", "ReExtractBtnText")
  self.curMoneyText = self:GetUIComponent("UILocalizationText", "CurMoneyText")
  self.checkGetBtn = self:GetUIComponent("Image", "CheckGetBtn")
  self.checkGetBtnText = self:GetUIComponent("UILocalizationText", "CheckGetBtnText")
  self.toggleGroup = self:GetUIComponent("ToggleGroup", "CardPool")
  self.reExtractBtnObj = self:GetGameObject("ReExtractBtn")
  self.skipBtnObj = self:GetGameObject("SkipBtn")
  self.quickPop = self:GetGameObject("QuickPop")
  self.quickPop:SetActive(false)
  self.tipsTextRootRect = self:GetUIComponent("RectTransform", "TipsTextRoot")
  self.tipsText1 = self:GetUIComponent("UILocalizationText", "TipsText1")
  self.tipsText2 = self:GetUIComponent("UILocalizationText", "TipsText2")
  self.tipsText3 = self:GetUIComponent("UILocalizationText", "TipsText3")
end

function UILuckLandSelectCardPopUp:InitUI()
  self.curCost = 0
  self.curMoney = LuckLandInnerGameHelper.GetCurMoney()
  self.curCost = LuckLandInnerGameHelper.GetReDrawCost()
  if self.curCost then
    if self.curCost <= self.curMoney then
      self.reExtractBtnText:SetText("<color=#d5c5ff>" .. self.curCost .. "</color>/" .. self.curMoney)
    else
      self.reExtractBtnText:SetText("<color=#ff5d5d>" .. self.curCost .. "</color>/" .. self.curMoney)
    end
  end
  self.curMoneyText:SetText(StringTable.Get("str_luckland_cardbag_cost", self.curMoney))
  local getCardCount = 3
  self.CardAreaList = UIWidgetHelper.SpawnObjects(self, "CardPool", "UILuckLandSingleSelectCardItem", getCardCount)
  local module = LuckLandInnerGameHelper.GetLuckLandGameModule()
  local tempCardDatas = module:GetDrawCardResult()
  for i = 1, #self.CardAreaList do
    local item = self.CardAreaList[i]
    item:SetData(tempCardDatas[i], i, self.toggleGroup, function(index)
      self:OnToggleChange(index)
    end)
  end
  self:DrawCardShow()
  if LuckLandInnerGameHelper.CheckWord(LuckLandWordType.LockRedrawCard) then
    self.reExtractBtnObj:SetActive(false)
  end
  if LuckLandInnerGameHelper.CheckWord(LuckLandWordType.LockSkip) then
    self.skipBtnObj:SetActive(false)
  end
end

function UILuckLandSelectCardPopUp:DrawCardShow()
  self:Lock("UILuckLandSelectCardPopUp:DrawCardShow")
  for i = 1, #self.CardAreaList do
    local item = self.CardAreaList[i]
    item.view:GetGameObject():SetActive(false)
  end
  for i = 1, #self.CardAreaList do
    local item = self.CardAreaList[i]
    GameGlobal.Timer():AddEvent(50 * (i - 1), function()
      item.view:GetGameObject():SetActive(true)
      if i == #self.CardAreaList - 1 then
        self:UnLock("UILuckLandSelectCardPopUp:DrawCardShow")
      end
    end)
  end
end

function UILuckLandSelectCardPopUp:OnToggleChange(index)
  self._curIndex = index
end

function UILuckLandSelectCardPopUp:BgOnClick(go)
end

function UILuckLandSelectCardPopUp:CardBagBtnOnClick(go)
  self:ShowDialog("UILuckLandCardBag", true, false)
end

function UILuckLandSelectCardPopUp:SkipBtnOnClick(go)
  local module = LuckLandInnerGameHelper.GetLuckLandGameModule()
  if module:CheckHasExtraDrawCard() and self._extraDrawCardCount <= 0 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.LuckLandSkip)
    self._extraDrawCardCount = 1
    self:InitUI()
  else
    self:CloseDialog()
    if self.finishCB then
      self.finishCB()
    end
  end
end

function UILuckLandSelectCardPopUp:ReExtractBtnOnClick(go)
  self.curMoney = LuckLandInnerGameHelper.GetCurMoney()
  self.curCost = LuckLandInnerGameHelper.GetReDrawCost()
  local moneyStr = "<color=#5e47e1>" .. self.curMoney .. "</color>"
  local costStr = "<color=#5e47e1>" .. self.curCost .. "</color>"
  if self.curCost > self.curMoney then
    ToastManager.ShowToast(StringTable.Get("str_luckland_select_card_error"))
  else
    self:Lock("UILuckLandSelectCardPopUp")
    self:StartTask(function(TT)
      self.gameData:AddReDrawCount()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.LuckLandReDraw)
      self:InitUI()
      YIELD(TT, 1100)
      self:UnLock("UILuckLandSelectCardPopUp")
    end)
  end
end

function UILuckLandSelectCardPopUp:CheckGetBtnOnClick(go)
  if self._curIndex == nil then
    ToastManager.ShowToast(StringTable.Get("str_luckland_please_select_card"))
    return
  end
  local widget = self.CardAreaList[self._curIndex]
  if widget then
    local data = widget:CardData()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.LuckLandSelectCard, data:ID(), 1)
    local mgr = LuckLandInnerGameHelper.GetEntityMgr()
    if mgr then
      local pets = mgr:GetBackpackPets()
      if pets then
        local lastPet = pets[#pets]
        if lastPet then
          self.cardDataList:AddCardData(data:ID(), lastPet:ID(), 1)
        end
      end
    end
  end
  local module = LuckLandInnerGameHelper.GetLuckLandGameModule()
  if module:CheckHasExtraDrawCard() and self._extraDrawCardCount <= 0 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.LuckLandSkip)
    self._extraDrawCardCount = 1
    LuckLandInnerGameHelper.ResetReDrawCount()
    self:InitUI()
  else
    self:CloseDialog()
    if self.finishCB then
      self.finishCB()
    end
  end
end

function UILuckLandSelectCardPopUp:CancleRedrawBtnOnClick(go)
  self.quickPop:SetActive(false)
end

function UILuckLandSelectCardPopUp:QuickRedrawBtnOnClick(go)
  self.curMoney = LuckLandInnerGameHelper.GetCurMoney()
  self.curCost = LuckLandInnerGameHelper.GetReDrawCost()
  if self.curCost > self.curMoney then
    ToastManager.ShowToast(StringTable.Get("str_luckland_select_card_error"))
  else
    self.gameData:AddReDrawCount()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.LuckLandReDraw)
    self.quickPop:SetActive(false)
    self:InitUI()
  end
  if self.finishCB then
    self.finishCB()
  end
end
