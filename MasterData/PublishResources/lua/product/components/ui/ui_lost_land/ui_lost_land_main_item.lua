_class("UILostLandMainItem", UICustomWidget)
UILostLandMainItem = UILostLandMainItem

function UILostLandMainItem:OnShow(uiParams)
  self:GetComponents()
end

function UILostLandMainItem:SetData(idx, data, callback)
  self._idx = idx
  self._data = data
  self._callback = callback
  self:OnValue()
end

function UILostLandMainItem:FlushData(data)
  self._data = data
  self:OnValue()
end

function UILostLandMainItem:GetComponents()
  self._cg = self:GetUIComponent("RawImageLoader", "cg")
  self._lvTexLeft = self:GetGameObject("lvTexGo")
  self._lvTex = self:GetUIComponent("UILocalizationText", "lvTex")
  self._gradeTex = self:GetUIComponent("UILocalizationText", "gradeTex")
  self._nameTex = self:GetUIComponent("UILocalizationText", "nameTex")
  self._lockMask = self:GetGameObject("lockMask")
  self._lock = self:GetGameObject("lock")
  self._lockTex = self:GetUIComponent("UILocalizationText", "lockTex")
  self._lockImg = self:GetUIComponent("Image", "lockImg")
  self._nameBg = self:GetUIComponent("Image", "nameBg")
end

function UILostLandMainItem:awardViewBtnOnClick(go)
  self:ShowDialog("UILostLandAwardViewController", self._data)
end

function UILostLandMainItem:OnValue()
  local cg = self._data:GetCg()
  local recommendGrade = self._data:GetRecommendGrade()
  local recommendLv = self._data:GetRecommendLv()
  local recommendG = false
  local recommendL = false
  if recommendGrade and 0 < recommendGrade then
    self._gradeTex.gameObject:SetActive(true)
    self._gradeTex:SetText(recommendGrade)
    recommendG = true
  else
    self._gradeTex.gameObject:SetActive(false)
  end
  if recommendLv and 0 < recommendLv then
    self._lvTex.gameObject:SetActive(true)
    self._lvTex:SetText(recommendLv)
    recommendL = true
  else
    self._lvTex.gameObject:SetActive(false)
  end
  local nameTex = self._data:GetName()
  local lockState = self._data:GetLockState()
  self._cg:LoadImage(cg)
  if recommendG or recommendL then
    self._lvTexLeft:SetActive(true)
  else
    self._lvTexLeft:SetActive(false)
  end
  self._nameTex:SetText(StringTable.Get(nameTex))
  self._lockMask:SetActive(lockState == UILostLandEnterLockType.LOCK or lockState == UILostLandEnterLockType.CANUNLOCK)
  self._lock:SetActive(lockState == UILostLandEnterLockType.LOCK or lockState == UILostLandEnterLockType.CANUNLOCK)
  local lockTex
  if lockState == UILostLandEnterLockType.LOCK then
    local conditionStr = self._data:GetCondition()
    lockTex = StringTable.Get("str_lost_land_enter_unlock_condition", table.unpack(conditionStr))
  elseif lockState == UILostLandEnterLockType.CANUNLOCK then
    lockTex = StringTable.Get("str_lost_land_enter_click_unlock")
  end
  self._lockTex:SetText(lockTex)
end

function UILostLandMainItem:bgOnClick(go)
  if self._callback then
    self._callback(self._idx)
  end
end
