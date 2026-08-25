local WorldStageCardSelectItem, Super = System.NewComponent("WorldStageCardSelectItem")

function WorldStageCardSelectItem:ctor(uiNode, data, callback)
  Super.ctor(self)
  self.ui = UI_Dbgcopy_Item_Select_CardResource(uiNode)
  self.data = data
  self.callback = callback
  if self.data.runeTid then
    self.runeCfg = DT.EnchantConfig[self.data.runeTid]
  end
  self.qualityToBg = {
    White = "UIResources/UIBigImages/UI_Large/UI_Card_Image_Enchant_Ordinary.png",
    Orange = "UIResources/UIBigImages/UI_Large/UI_Card_Image_Enchant_Advanced.png",
    Red = "UIResources/UIBigImages/UI_Large/UI_Card_Image_Enchant_Corrupt.png"
  }
  self.isBanBtnClick = false
  self.touchBeginX = nil
  self.touchBeginY = nil
  self.hasMoved = false
end

function WorldStageCardSelectItem:OnBind(binder)
  self.binder = binder
  self.runeTipItem = CardKeyWordItem_New_DoubleResource(self.ui.CardKeyWordItem_New_Double)
  binder:CheckUpdatePanelResource(self.ui.CardKeyWordItem_New_Double, DataCenter.gameData.CurrTextLanguage)
  binder:BindToImage(self.ui.Image_Rune, function()
    return self.imageRuneIcon
  end)
  self.ui.Btn_Selected:SetActive(self.isShowSelect)
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnBtnClick))
  binder:BindEvent(EventMgr.Instance.TouchBeginEvent, System.fn(self, self.OnTouchBegin))
  binder:BindEvent(EventMgr.Instance.TouchMoveEvent, System.fn(self, self.OnTouchMove))
  binder:BindEvent(EventMgr.Instance.TouchEndEvent, System.fn(self, self.OnTouchEnd))
  self.cardRectTransform = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.RectTransform))
  local cardTid
  local cardData = self.data.cardUid and CardDataUtils.GetCardInfo(self.data.cardUid)
  if self.data.cardTid and 0 ~= self.data.cardTid then
    cardTid = self.data.cardTid
  elseif self.data.cardUid and cardData then
    cardTid = cardData.configId
  end
  if not cardTid then
    self.ui.uiNode:SetActive(false)
    return
  end
  self.ui.uiNode:SetActive(true)
  self.cardComp = binder:BindComponent(CardBaseComponent(self.ui.Item_Card_Base, self.data.cardUid, cardTid, nil, cardData and cardData.cost))
  self.cardComp:EnableRuneList(self.data.runeTid)
  if self.cardComp.ui.Btn_Mask then
    self.cardComp.ui.Btn_Mask:SetActive(false)
  end
  local comp = GetLuaComp(self.cardComp.ui.Text_Desc, AutoAdaptionText)
  if comp then
    comp:SetBtn(self.ui.Btn_Click)
  end
  if self.runeCfg then
    self:BindRuneKeyWord()
  else
    self:BindCardKeyWord()
  end
  self:_InitUIBothSidesUI()
end

function WorldStageCardSelectItem:BindRuneKeyWord()
  local runeEffectDescGroup = CardDataUtils.GetRuneEffectDescGroup(self.runeCfg)
  self.effectDescGroup = {runeEffectDescGroup}
  local exParam = {
    closeCallback = function()
      self:SetKeyWordVisible(false)
    end
  }
  local comp = self.binder:BindComponent(CommonKeyWordDescGroup(self.ui.CardKeyWordItem_New_Double, {}, self.effectDescGroup, nil, exParam))
  self.isHaveKeyWord = not comp.isHide
end

function WorldStageCardSelectItem:BindCardKeyWord()
  local cardComp = self.cardComp
  self.effectDescGroup = CardDataUtils.GetCardEffectGroupList(cardComp.configId.value, cardComp.uid.value, cardComp.cardLv.value)
  local exParam = {
    awakerData = self.awakerData or CardDataUtils.GetCardOwner(cardComp.uid.value),
    skillLevel = cardComp.cardLv.value
  }
  local comp = self.binder:BindComponent(CommonKeyWordDescGroup(self.ui.CardKeyWordItem_New_Double, {
    cardComp:GetCardDesc()
  }, self.effectDescGroup, nil, exParam))
  self.isHaveKeyWord = not comp.isHide
end

function WorldStageCardSelectItem:_InitUIBothSidesUI()
  local leftUIGroup = {
    [self.ui.CardKeyWordItem_New_Double] = 0
  }
  local rightUIGroup = {
    [self.ui.CardKeyWordItem_New_Double] = 0
  }
  UIManager.Instance:InitBothSidesUIOriPos(leftUIGroup, rightUIGroup)
end

function WorldStageCardSelectItem:OnBtnClick()
  Logger.Info("BtnClicked.....")
  if self.isBanBtnClick == true then
    return
  end
  local cardDesc = self.cardComp:GetCardDesc()
  if not CardDataUtils.CheckEffectDescGroupEmpty(self.effectDescGroup) or StrUtils.CheckDescContainKeywords(cardDesc) then
    local awakerData = CardDataUtils.GetCardOwner(self.data.cardUid)
    local exParam = {
      withoutMask = true,
      skillTid = self.cardComp.configId.value,
      skillLevel = self.cardComp.cardLv.value,
      awakerData = awakerData,
      effectDescGroupList = self.effectDescGroup,
      margin = -22,
      isBanMask = true,
      closeCallback = function()
        self:SetKeyWordVisible(false)
      end
    }
    UIManager.Instance:Reopen(Urls.CommonCardKeyWorldDescPanel, {cardDesc}, self.ui.uiNode, exParam)
  end
  if self.callback then
    self.callback(self, self.data)
  end
  self:_InitUIBothSidesUI()
end

function WorldStageCardSelectItem:EnableSelectShow(enable)
  self.isShowSelect = enable
  self.ui.Btn_Selected:SetActive(self.isShowSelect)
end

function WorldStageCardSelectItem:SetKeyWordVisible(visible)
  if self.ui and not IsNil(self.ui.uiNode) then
    self.ui.CardKeyWordItem_New_Double:SetActive(visible and self.isHaveKeyWord)
  end
end

function WorldStageCardSelectItem:GetIsShow()
  return self.isShowSelect
end

function WorldStageCardSelectItem:EnableBtnClick(enable)
  self.isBanBtnClick = enable
end

function WorldStageCardSelectItem:EnableEnchantShow(enable)
  if self.ui.Btn_Enchant then
    self.ui.Btn_Enchant:SetActive(enable)
  end
end

function WorldStageCardSelectItem:OnTouchBegin(x, y, index, overUI)
  if not self.cardRectTransform then
    return
  end
  local screenPos = CS.UnityEngine.Vector2(x, y)
  local uiCamera = UIRootMgr.GetUICamera()
  local isInCard = CS.UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(self.cardRectTransform, screenPos, uiCamera)
  if isInCard then
    self.touchBeginX = x
    self.touchBeginY = y
    self.hasMoved = false
  end
end

function WorldStageCardSelectItem:OnTouchMove(x, y, index, overUI)
  if self.touchBeginX and self.touchBeginY then
    local moveThreshold = 10
    local deltaX = math.abs(x - self.touchBeginX)
    local deltaY = math.abs(y - self.touchBeginY)
    if moveThreshold < deltaX or moveThreshold < deltaY then
      self.hasMoved = true
    end
  end
end

function WorldStageCardSelectItem:OnTouchEnd(x, y, index, overUI)
  if not self.touchBeginX or not self.touchBeginY then
    return
  end
  if not self.hasMoved and self.cardRectTransform then
    local screenPos = CS.UnityEngine.Vector2(x, y)
    local uiCamera = UIRootMgr.GetUICamera()
    local isInCard = CS.UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(self.cardRectTransform, screenPos, uiCamera)
    if isInCard then
      self:OnBtnClick()
    end
  end
  self.touchBeginX = nil
  self.touchBeginY = nil
  self.hasMoved = false
end

return WorldStageCardSelectItem
