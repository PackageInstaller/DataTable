_class("UIN0CookBookItem", UICustomWidget)
UIN0CookBookItem = UIN0CookBookItem

function UIN0CookBookItem:Constructor()
  self._foodData = nil
  self._callback = nil
  self._isSelected = false
end

function UIN0CookBookItem:OnShow(uiParams)
  self._atlas = self:GetAsset("CookGame.spriteatlas", LoadType.SpriteAtlas)
  self._lockColor = Color(0.1411764705882353, 0.12156862745098039, 0.11372549019607843)
  self._unLockColor = Color(0.3137254901960784, 0.13333333333333333, 0.06274509803921569)
  self._index = 1
  self:_GetComponents()
end

function UIN0CookBookItem:_GetComponents()
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._selectObj = self:GetGameObject("Selected")
  self._isGetObj = self:GetGameObject("IsGet")
  self._lockObj = self:GetGameObject("lock")
  self._nameBg = self:GetUIComponent("Image", "nameBg")
  self._circleOutline = self:GetUIComponent("H3D.UGUI.CircleOutline", "name")
  self._nameBgRect = self:GetUIComponent("RectTransform", "nameBg")
  self._nameBgSizeFitter = self:GetUIComponent("ContentSizeFitter", "nameBg")
  self._delay = 50
end

function UIN0CookBookItem:SetData(data, status, callback, index)
  self._foodData = data
  self._status = status
  self._callback = callback
  self._index = index
  local delayTime = self._delay * math.floor((index - 1) / 3)
  self:_SetAnimation(delayTime)
  self:_InitData()
end

function UIN0CookBookItem:_InitData()
  self._icon:LoadImage(self._foodData.Icon)
  self._name:SetText(StringTable.Get(self._foodData.Name))
  local isGet = false
  local isLock = false
  if self._status == NewYearDinner_Status.E_NewYearDinner_Status_LOCK then
    isLock = true
    self._nameBg.sprite = self._atlas:GetSprite("n0_food_di03")
    self._circleOutline.effectColor = self._lockColor
  elseif self._status == NewYearDinner_Status.E_NewYearDinner_Status_UN_FINISH then
    self._nameBg.sprite = self._atlas:GetSprite("n0_food_di04")
    self._circleOutline.effectColor = self._unLockColor
  elseif self._status == NewYearDinner_Status.E_NewYearDinner_Status_CAN_RECV then
    self._nameBg.sprite = self._atlas:GetSprite("n0_food_di04")
    self._circleOutline.effectColor = self._unLockColor
    isGet = true
  elseif self._status == NewYearDinner_Status.E_NewYearDinner_Status_RECVED then
    self._nameBg.sprite = self._atlas:GetSprite("n0_food_di04")
    self._circleOutline.effectColor = self._unLockColor
    isGet = true
  end
  self._isGetObj:SetActive(isGet)
  self._lockObj:SetActive(isLock)
  GameGlobal.TaskManager():StartTask(self._SetNameBgSize, self)
end

function UIN0CookBookItem:SetSelect(isSelected)
  self._isSelected = isSelected
  self._selectObj:SetActive(isSelected)
end

function UIN0CookBookItem:_SetAnimation(delay)
  UIWidgetHelper.PlayAnimationInSequence(self, "anim", "anim", "uieff_N0_CookBookItem", delay, 500, nil)
end

function UIN0CookBookItem:GetInfo()
  return self._foodData
end

function UIN0CookBookItem:GetID()
  return self._foodData.ID
end

function UIN0CookBookItem:GetStatus()
  return self._status
end

function UIN0CookBookItem:SetDone()
  self._status = NewYearDinner_Status.E_NewYearDinner_Status_RECVED
  self._nameBg.sprite = self._atlas:GetSprite("n0_food_di04")
  self._circleOutline.effectColor = self._unLockColor
  self._isGetObj:SetActive(true)
end

function UIN0CookBookItem:_SetNameBgSize(TT)
  self:Lock("UIN0CookBookItem")
  YIELD(TT, 10)
  if self._nameBgRect.sizeDelta.x > 208 then
    self._nameBgSizeFitter.enabled = false
    self._nameBgRect.sizeDelta = Vector2(208, 42)
  end
  self:UnLock("UIN0CookBookItem")
end

function UIN0CookBookItem:ItemBtnOnClick()
  self:SetSelect(true)
  if self._callback then
    self._callback(self)
  end
end
