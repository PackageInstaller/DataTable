_class("UILuckLandSingleCard", UICustomWidget)
UILuckLandSingleCard = UILuckLandSingleCard

function UILuckLandSingleCard:OnShow(uiParams)
  self:InitWidget()
  self._atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._elementCfg = Cfg.cfg_pet_element({})
  self._luckLandatlas = self:GetAsset("Luckland.spriteatlas", LoadType.SpriteAtlas)
  self._detailMod = false
  self.defaultResColor = Color.New(0.09411764705882353, 0.10980392156862745, 0.13333333333333333)
  self.redResColor = Color.New(0.9529411764705882, 0.3254901960784314, 0.28627450980392155)
  self.popuResColor = Color.New(0.4549019607843137, 0.3568627450980392, 0.7215686274509804)
end

function UILuckLandSingleCard:InitWidget()
  self.characterImg = self:GetUIComponent("RawImageLoader", "CharacterImg")
  self._qualityImg = self:GetUIComponent("Image", "Quality")
  self.atkImg = self:GetUIComponent("Image", "AtkImg")
  self.atkImgGO = self:GetGameObject("AtkImg")
  self.moneyImg = self:GetUIComponent("Image", "MoneyImg")
  self.moneyImgGO = self:GetGameObject("MoneyImg")
  self.recoverImg = self:GetUIComponent("Image", "RecoverImg")
  self.recoverImgGO = self:GetGameObject("RecoverImg")
  self.resDataText = self:GetUIComponent("UILocalizationText", "ResDataText")
  self.campArea = self:GetUIComponent("Image", "CampArea")
  self.campAreaText = self:GetUIComponent("UILocalizationText", "CampAreaText")
  self.attributeImg = self:GetUIComponent("Image", "AttributeImg")
  self.timeCountDown = self:GetUIComponent("Image", "TimeCountDown")
  self.countBg = self:GetUIComponent("Image", "CountBg")
  self.lifeCountDownText = self:GetUIComponent("UILocalizationText", "LifeCountDownText")
  self._deleteBtnGO = self:GetGameObject("DeleteBtn")
  self.countDownRawImage = self:GetUIComponent("RawImageLoader", "CountDownRawImage")
  self._emptyCardGO = self:GetGameObject("EmptyCard")
  self._lockCardGO = self:GetGameObject("LockCard")
  self._emptyCardGO:SetActive(false)
  self._lockCardGO:SetActive(false)
  self.resDataTextTf = self:GetUIComponent("RectTransform", "ResDataText")
  self.rootRectTf = self:GetUIComponent("RectTransform", "UILuckLandSingleCard")
  self.moneyImgTf = self:GetUIComponent("RectTransform", "MoneyImg")
  self._resRootGO = self:GetGameObject("ResRoot")
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UILuckLandSingleCard:SetData(cardData, isDelete, fromInnerGame)
  self._cardData = cardData
  self._isDelete = isDelete
  self._fromInnerGame = fromInnerGame
  self.view:GetGameObject():SetActive(self._cardData ~= nil)
  self.characterImg.gameObject:SetActive(true)
  self.characterImg:SetColor(Color(1, 1, 1, 1))
  self:RefreshUIInfo()
  self.countBg.gameObject:SetActive(false)
  if self._fromInnerGame and self._cardData then
    local petEntity = LuckLandInnerGameHelper.GetBackpackPetDataByID(self._cardData:UniqueID())
    if petEntity then
      self:SetBindEntity(petEntity)
    end
  end
  self._resRootGO:SetActive(true)
end

function UILuckLandSingleCard:SetBindEntity(entity, playAnim)
  self.BindEntity = entity
  if self.BindEntity ~= nil then
    local curCost = self.BindEntity:GetCountDown()
    if curCost ~= nil then
      self.countBg.gameObject:SetActive(true)
      if self.BindEntity:HasDeleteFlag() then
        curCost = 0
      end
      if curCost < 10 then
        self.countDownRawImage:LoadImage("n11_jnzd_sz" .. curCost)
      end
    end
    if curCost == nil then
      self.countBg.gameObject:SetActive(false)
    end
    local textValue = self.BindEntity:CalculateResBag()
    self.resDataText:SetText(textValue)
    if playAnim then
      self._anim:Play("uieff_UILuckLand_Card_in")
    end
  end
end

function UILuckLandSingleCard:PlayAnimation()
  if self._cardData then
    self._anim:Play("uieff_UILuckLand_Card_in")
  end
end

function UILuckLandSingleCard:SetPosIndex(index)
  local anchorPos = self.rootRectTf.anchoredPosition
  if self.originPos == nil then
    self.originPos = Vector2(anchorPos.x, anchorPos.y)
  else
    anchorPos = Vector2(self.originPos.x, self.originPos.y)
  end
  anchorPos.x = anchorPos.x + (index - 1) * 159.3
  self.rootRectTf.anchoredPosition = anchorPos
end

function UILuckLandSingleCard:MovePos(index)
  local anchorPos = Vector2(self.originPos.x, self.originPos.y)
  anchorPos.x = anchorPos.x + (index - 1) * 159.3
  self.rootRectTf:DOAnchorPosX(anchorPos.x, 0.5, false)
end

function UILuckLandSingleCard:GetBindEntity()
  return self.BindEntity
end

function UILuckLandSingleCard:RefreshUIInfo()
  if self._cardData then
    self._cfg = self._cardData:Cfg()
    self.characterImg:LoadImage(self._cfg.CardIcon)
    self.attributeImg.sprite = self._atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(self._elementCfg[self._cardData:Attribute()].Icon))
    self.atkImgGO:SetActive(self._cardData:Attack() ~= nil)
    self.moneyImgGO:SetActive(self._cardData:Money() ~= nil)
    self.recoverImgGO:SetActive(self._cardData:HP() ~= nil)
    local textValue
    if self._fromInnerGame then
      local petEntity = LuckLandInnerGameHelper.GetBackpackPetDataByID(self._cardData:UniqueID())
      if petEntity then
        textValue = petEntity:CalculateResBag()
      end
    else
      textValue = self._cardData:Attack() or self._cardData:Money() or self._cardData:HP()
    end
    if textValue then
      self.resDataText:SetText(textValue)
    else
      self.resDataText:SetText("")
    end
    local campName = self._cardData:CampName()
    if campName then
      self.campAreaText:SetText(StringTable.Get(campName))
    else
      self.campAreaText:SetText("")
    end
    self._deleteBtnGO:SetActive(self._isDelete == true)
    if self._cardData:Star() == LuckLandCardStarType.One then
      self._qualityImg.sprite = self._luckLandatlas:GetSprite("n11_jnzd_di15")
    elseif self._cardData:Star() == LuckLandCardStarType.Two then
      self._qualityImg.sprite = self._luckLandatlas:GetSprite("n11_jnzd_di16")
    elseif self._cardData:Star() == LuckLandCardStarType.Three then
      self._qualityImg.sprite = self._luckLandatlas:GetSprite("n11_jnzd_di17")
    end
    local targetResColor = self.defaultResColor
    if self._cardData:Money() then
      targetResColor = self.popuResColor
    end
    if self._cardData:HP() then
      targetResColor = self.redResColor
    end
    self.resDataText.color = targetResColor
    self._emptyCardGO:SetActive(false)
    self._lockCardGO:SetActive(false)
  else
    self._emptyCardGO:SetActive(true)
  end
end

function UILuckLandSingleCard:RefreshDetailMod(isdetail)
  self._detailMod = isdetail
  self.attributeImg.gameObject:SetActive(self._detailMod)
  self.campArea.gameObject:SetActive(self._detailMod)
end

function UILuckLandSingleCard:SetEmptyCard()
  self._emptyCardGO:SetActive(true)
  self._lockCardGO:SetActive(false)
end

function UILuckLandSingleCard:SetLockCard()
  self._emptyCardGO:SetActive(false)
  self._lockCardGO:SetActive(true)
end

function UILuckLandSingleCard:SetUnlockCard()
  if self._lockCardGO.activeSelf then
    self._emptyCardGO:SetActive(true)
    self._lockCardGO:SetActive(false)
  end
end

function UILuckLandSingleCard:SkillShow()
  if self.BindEntity == nil then
    return
  end
  local curCost = self.BindEntity:GetCountDown()
  if self.BindEntity:HasDeleteFlag() then
    self.characterImg:SetColor(Color(0, 0, 0, 1))
  end
  local directGold = self.BindEntity:GetDirectGold()
  if directGold == nil then
    directGold = 0
  end
  local textValue = self.BindEntity:CalculateRes()
  if textValue then
    self.resDataText:SetText(textValue + directGold)
  else
    self.resDataText:SetText("")
  end
  self.resDataTextTf:DOPunchScale(Vector3(0.5, 0.5, 0.5), 0.2, 1)
end

function UILuckLandSingleCard:GetCurDemond()
  local directGold = self.BindEntity:GetDirectGold()
  if directGold == nil then
    directGold = 0
  end
  local textValue = self.BindEntity:CalculateRes()
  return textValue + directGold
end

function UILuckLandSingleCard:DemondFly()
  self._resRootGO:SetActive(false)
end

function UILuckLandSingleCard:CharacterImgOnClick(go)
  if self._cardData == nil then
    return
  end
  self:ShowDialog("UILuckLandCardDetailPopUp", self._cardData)
end

function UILuckLandSingleCard:DeleteBtnOnClick(go)
  local isOnlyOne = LuckLandData:GetInstance():CurCardDatas():IsOnlyOne()
  if isOnlyOne then
    ToastManager.ShowToast(StringTable.Get("str_luckland_cardbag_delete_error1"))
    return
  end
  local curCost = LuckLandData:GetInstance():CurCardDatas():CurDeleteCost()
  local curMoney = LuckLandInnerGameHelper.GetCurMoney()
  if curCost > curMoney then
    ToastManager.ShowToast(StringTable.Get("str_luckland_cardbag_delete_error"))
    return
  end
  local uniqueID = self._cardData:UniqueID()
  LuckLandData:GetInstance():CurCardDatas():DeleteCardByID(uniqueID)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.LuckLandDeleteCard, uniqueID)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnLuckLandDeleteCardSucc, uniqueID)
end

function UILuckLandSingleCard:ShowDeleteBtn(show)
  self._deleteBtnGO:SetActive(show)
end
