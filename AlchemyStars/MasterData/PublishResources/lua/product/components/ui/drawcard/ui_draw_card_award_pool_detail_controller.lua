_class("UIDrawCardAwardPoolDetailController", UIController)
UIDrawCardAwardPoolDetailController = UIDrawCardAwardPoolDetailController

function UIDrawCardAwardPoolDetailController:OnShow(uiParam)
  self._btnStateTb = {
    false,
    false,
    false
  }
  self._poolInfo = uiParam[1]
  self._poolData = self._poolInfo.poolData
  self.cfg = Cfg.cfg_recruit_pool_view[self._poolData.performance_id]
  self._count = #self.cfg.PoolDetailSubTitle
  self.title = self:GetUIComponent("UILocalizationText", "title")
  self.title.text = StringTable.Get(self.cfg.PoolDetailTitle)
  self._intruduce = self:GetGameObject("intruduce")
  self._rate = self:GetGameObject("rate")
  self._conversion = self:GetGameObject("Conversion")
  self.content = self:GetUIComponent("UISelectObjectPath", "Content")
  self.RateContent = self:GetUIComponent("UISelectObjectPath", "RateContent")
  self.converseContent = self:GetUIComponent("UISelectObjectPath", "ConverseContent")
  self._ruletag = self:GetUIComponent("Image", "ruletag")
  self._ratetag = self:GetUIComponent("Image", "ratetag")
  self._conversiontag = self:GetUIComponent("Image", "conversiontag")
  self._rateTip = self:GetGameObject("ratetip")
  self._conversTip = self:GetGameObject("conversTip")
  self._ruleText = self:GetUIComponent("UILocalizationText", "RuleText")
  self._rateText = self:GetUIComponent("UILocalizationText", "RateText")
  self._conText = self:GetUIComponent("UILocalizationText", "ConText")
  self._atlas = self:GetAsset("UIDrawCard.spriteatlas", LoadType.SpriteAtlas)
  self:SetData()
  self._btnImgTb = {}
  table.insert(self._btnImgTb, self._ruletag)
  table.insert(self._btnImgTb, self._ratetag)
  table.insert(self._btnImgTb, self._conversiontag)
  self._textTb = {}
  table.insert(self._textTb, self._ruleText)
  table.insert(self._textTb, self._rateText)
  table.insert(self._textTb, self._conText)
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowTips)
  local tipspool = self:GetUIComponent("UISelectObjectPath", "tipspool")
  self._tipsPoolObj = self:GetGameObject("tipspool")
  self._tips = tipspool:SpawnObject("UISelectInfo")
  self.tipspool = self:GetGameObject("tipspool")
  self:RecordAllItemPos()
  self:HideAllItem()
  self:RuletagOnClick()
end

function UIDrawCardAwardPoolDetailController:SetData()
  self:StartTask(self.CreateItems, self)
end

function UIDrawCardAwardPoolDetailController:CreateItems(TT)
  self:Lock("UIDrawCardAwardPoolDetailController")
  YIELD(TT)
  self._rate:SetActive(true)
  self._rateTip:SetActive(true)
  local item = self.RateContent:SpawnObject("UIDrawCardAwardDetailItemNew")
  local gambleModule = self:GetModule(GambleModule)
  local isOpen, wishCount = gambleModule:IsOpenOptional(self._poolInfo.index)
  local wishPool
  if isOpen and wishCount == ElementType.ElementType_Yellow then
    wishPool = gambleModule:GetOptionalPool(self._poolInfo.index)
  end
  item:SetWishPool(isOpen, wishPool)
  item:SetData(self.cfg.PoolDetailSubTitle[2], self.cfg.PoolDetail[2], self._poolData.performance_id)
  self:UnLock("UIDrawCardAwardPoolDetailController")
end

function UIDrawCardAwardPoolDetailController:ShowTips(itemId, pos)
  self._tipsPoolObj:SetActive(true)
  self._tips:SetData(itemId, pos)
end

function UIDrawCardAwardPoolDetailController:OnHide()
  self:DetachEvent(GameEventType.ShowItemTips, self.ShowTips)
end

function UIDrawCardAwardPoolDetailController:ChangeState(index)
  for i, v in pairs(self._btnStateTb) do
    if v then
      local img = self._btnImgTb[i]
      img.sprite = self._atlas:GetSprite("card_pool_sm_btn02")
      local text = self._textTb[i]
      text.color = Color(0.9490196078431372, 0.9490196078431372, 0.9490196078431372)
    end
    v = false
  end
  self._btnStateTb[index] = true
  local whiteImg = self._btnImgTb[index]
  whiteImg.sprite = self._atlas:GetSprite("card_pool_sm_btn01")
  local text = self._textTb[index]
  text.color = Color(0.19607843137254902, 0.19607843137254902, 0.19607843137254902)
end

function UIDrawCardAwardPoolDetailController:CloseOnClick()
  self:CloseDialog()
end

function UIDrawCardAwardPoolDetailController:RuletagOnClick()
  self:DetachEvent(GameEventType.ShowItemTips, self.ShowTips)
  self:HideAllItem()
  self._intruduceRect.anchoredPosition = self._intruducePos
  local item = self.content:SpawnObject("UIDrawCardAwardDetailItemNew")
  item:SetData(self.cfg.PoolDetailSubTitle[1], self.cfg.PoolDetail[1])
  self:ChangeState(1)
end

function UIDrawCardAwardPoolDetailController:RatetagOnClick()
  self:DetachEvent(GameEventType.ShowItemTips, self.ShowTips)
  self:HideAllItem()
  self._rateRect.anchoredPosition = self._ratePos
  self._rateTipRect.anchoredPosition = self._rateTipPos
  self:ChangeState(2)
end

function UIDrawCardAwardPoolDetailController:ConversiontagOnClick()
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowTips)
  self:HideAllItem()
  self._conversionRect.anchoredPosition = self._conversionPos
  self._conversTipRect.anchoredPosition = self._conversTipPos
  self._tipsPoolObj:SetActive(true)
  self.converseContent:SpawnObjects("UIDrawCardAwardConversionItem", 4)
  local items = self.converseContent:GetAllSpawnList()
  for idx, value in ipairs(items) do
    value:SetData(idx)
  end
  self:ChangeState(3)
end

function UIDrawCardAwardPoolDetailController:RecordAllItemPos()
  self._intruduceRect = self._intruduce:GetComponent(typeof(UnityEngine.RectTransform))
  self._rateRect = self._rate:GetComponent(typeof(UnityEngine.RectTransform))
  self._rateTipRect = self._rateTip:GetComponent(typeof(UnityEngine.RectTransform))
  self._conversionRect = self._conversion:GetComponent(typeof(UnityEngine.RectTransform))
  self._conversTipRect = self._conversTip:GetComponent(typeof(UnityEngine.RectTransform))
  self._intruducePos = self._intruduceRect.anchoredPosition
  self._ratePos = self._rateRect.anchoredPosition
  self._rateTipPos = self._rateTipRect.anchoredPosition
  self._conversionPos = self._conversionRect.anchoredPosition
  self._conversTipPos = self._conversTipRect.anchoredPosition
end

function UIDrawCardAwardPoolDetailController:HideAllItem()
  self._intruduceRect.anchoredPosition = Vector2(9999, 9999)
  self._rateRect.anchoredPosition = Vector2(9999, 9999)
  self._rateTipRect.anchoredPosition = Vector2(9999, 9999)
  self._conversionRect.anchoredPosition = Vector2(9999, 9999)
  self._conversTipRect.anchoredPosition = Vector2(9999, 9999)
  self._tipsPoolObj:SetActive(false)
end
