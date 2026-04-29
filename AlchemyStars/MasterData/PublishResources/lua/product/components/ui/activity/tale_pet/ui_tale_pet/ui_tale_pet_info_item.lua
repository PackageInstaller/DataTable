_class("UITalePetInfoItem", UICustomWidget)
UITalePetInfoItem = UITalePetInfoItem

function UITalePetInfoItem:OnShow(uiParams)
  self.ElementSpriteName = {
    [ElementType.ElementType_Blue] = "bing_color",
    [ElementType.ElementType_Red] = "huo_color",
    [ElementType.ElementType_Green] = "sen_color",
    [ElementType.ElementType_Yellow] = "lei_color",
    [ElementType.ElementType_AnyNone] = "wu_color"
  }
  self.NameBgSpriteName = {
    [1] = "legend_sixiang_btn7",
    [2] = "legend_sixiang_btn4",
    [3] = "legend_sixiang_btn6",
    [4] = "legend_sixiang_btn5",
    [6] = "legend_sixiang_btn9"
  }
  self.atlas = self:GetAsset("UITalePet.spriteatlas", LoadType.SpriteAtlas)
  self.talePetModule = GameGlobal.GetModule(TalePetModule)
  self:InitWidget()
  self:AttachEvent(GameEventType.TalePetInfoDataChange, self.InfoDataChange)
end

function UITalePetInfoItem:OnHide()
  self:DetachEvent(GameEventType.TalePetInfoDataChange)
end

function UITalePetInfoItem:InfoDataChange()
  self:SetTalePetState()
  self:PetInfoRedController()
end

function UITalePetInfoItem:InitWidget()
  self._rectTransform = self:GetUIComponent("RectTransform", "bg")
  self.prop1 = self:GetUIComponent("Image", "prop1")
  self.prop2 = self:GetUIComponent("Image", "prop2")
  self.propObj1 = self:GetGameObject("prop1Obj")
  self.propObj2 = self:GetGameObject("prop2Obj")
  self.name = self:GetUIComponent("UILocalizationText", "Name")
  self.state = self:GetGameObject("state")
  self._stateRectTransform = self:GetUIComponent("RectTransform", "state")
  self.txtState = self:GetUIComponent("UILocalizationText", "txtState")
  self.imgState1 = self:GetGameObject("imgState1")
  self.imgState2 = self:GetGameObject("imgState2")
  self.bg = self:GetUIComponent("Image", "bg")
  self.petInfoRed = self:GetGameObject("petInfoRed")
  self._lockGO = self:GetGameObject("Lock")
  self._lockCount = self:GetUIComponent("UILocalizationText", "LockCount")
  self._lockText = self:GetUIComponent("UILocalizationText", "LockText")
  self._newFlag = self:GetGameObject("NewFlag")
end

function UITalePetInfoItem:SetData(tmpID, name, callback, offsetX)
  self.ID = tmpID
  self._taleCfg = Cfg.cfg_tale_pet[tmpID]
  self.name:SetText(StringTable.Get(name))
  self._callback = callback
  self._haveRestriction = self.talePetModule:HaveCallRestriction(self.ID)
  self:SetTalePetState()
  self:PetInfoRedController()
  if not self.ID then
    return
  end
  local cfg_pet = Cfg.cfg_pet[self.ID]
  if not cfg_pet then
    return
  end
  self.atlas2 = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  if self._haveRestriction then
    self.bg.sprite = self.atlas:GetSprite("legend_sixiang_btn9")
    self.prop1.sprite = self.atlas2:GetSprite("wu_color")
    self.propObj2:SetActive(true)
    self.prop2.sprite = self.atlas2:GetSprite("wu_color")
    self._newFlag:SetActive(self:IsNew())
  else
    self._newFlag:SetActive(false)
    self.firstElement = cfg_pet.FirstElement
    self.secondElement = cfg_pet.SecondElement
    local cfg_pet_element = Cfg.cfg_pet_element({})
    self.prop1.sprite = self.atlas2:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[self.firstElement].Icon))
    self.propObj1:SetActive(true)
    self.bg.sprite = self.atlas:GetSprite(self.NameBgSpriteName[self.firstElement])
    if self.secondElement > 0 then
      self.propObj2:SetActive(true)
      self.prop2.sprite = self.atlas2:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[self.secondElement].Icon))
    end
  end
  if offsetX then
    self._rectTransform.anchoredPosition = Vector2(offsetX, -350.7)
    self._stateRectTransform.anchoredPosition = Vector2(offsetX, -292.6)
  end
end

function UITalePetInfoItem:IsNew()
  local loginModule = GameGlobal.GetModule(LoginModule)
  local recordValue = LocalDB.GetInt("NewTalePet2" .. loginModule:GetRoleShowID(), 0)
  return recordValue <= 0
end

function UITalePetInfoItem:btnViewOnClick(go)
  if self._callback then
    self._callback(self.ID)
  end
  if self._haveRestriction then
    local isNew = self:IsNew()
    if isNew then
      local loginModule = GameGlobal.GetModule(LoginModule)
      LocalDB.SetInt("NewTalePet2" .. loginModule:GetRoleShowID(), 1)
    end
  end
end

function UITalePetInfoItem:SetTalePetState()
  self.state:SetActive(false)
  self.imgState1:SetActive(true)
  self.imgState2:SetActive(false)
  local info = self.talePetModule:GetPetInfo(self.ID)
  if info == nil then
    self:_SetLockState()
    return
  end
  local selectId = self.talePetModule:SelectPetCfgId()
  if selectId == self.ID then
    self.state:SetActive(true)
    self.imgState2:SetActive(true)
    self._lockGO:SetActive(false)
    self.txtState:SetText(StringTable.Get("str_tale_pet_convening_pet"))
  else
    local state = info.pet_status
    if state == TalePetCallType.TPCT_Done then
      self.state:SetActive(true)
      self.imgState1:SetActive(true)
      self.imgState2:SetActive(true)
      self._lockGO:SetActive(false)
      self.txtState:SetText(StringTable.Get("str_tale_pet_has_get_pet"))
    else
      self:_SetLockState()
    end
  end
end

function UITalePetInfoItem:_SetLockState()
  if self._haveRestriction then
    local restrictionIsUnlock, count = self.talePetModule:RestrictionIsUnlock(self.ID)
    if restrictionIsUnlock then
      self._lockGO:SetActive(false)
      self:_LockTalePet(false)
    else
      self._lockGO:SetActive(true)
      self._lockCount:SetText(count .. "/" .. self._taleCfg.HasPetNum)
      self._lockText:SetText(StringTable.Get("str_tale_pet_lock_text", self._taleCfg.HasPetNum))
      self:_LockTalePet(true)
    end
  else
    self._lockGO:SetActive(false)
    self:_LockTalePet(false)
  end
end

function UITalePetInfoItem:_LockTalePet(lock)
  if self.uiOwner and self.uiOwner.LockTalePet then
    self.uiOwner:LockTalePet(lock)
  end
end

function UITalePetInfoItem:PetInfoRedController()
  if self.ID == self.talePetModule:SelectPetCfgId() then
    return
  end
  local state1 = self.talePetModule:IsCanCallPet(self.ID)
  local state2 = self.talePetModule:IsGetReward(self.ID)
  if state1 or state2 then
    self.petInfoRed:SetActive(true)
  else
    self.petInfoRed:SetActive(false)
  end
end
