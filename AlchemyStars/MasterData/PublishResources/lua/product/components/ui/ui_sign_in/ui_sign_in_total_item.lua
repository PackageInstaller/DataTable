_class("UISignInTotalItem", UICustomWidget)
UISignInTotalItem = UISignInTotalItem

function UISignInTotalItem:OnShow(uiParam)
  self:GetComponents()
  self:AttachEvent(GameEventType.OnTotalAwardGot, self.OnGetTotalAward)
end

function UISignInTotalItem:SetData(data, currentTotalDay, normalCallback, getAwardCallback, yieldTime)
  self._isActive = true
  self._data = data
  self._currentTotalDay = currentTotalDay
  self._normalCallback = normalCallback
  self._getAwardCallback = getAwardCallback
  self:_OnValue()
  self:PlayInAnim(yieldTime)
end

function UISignInTotalItem:OnHide()
  self._isActive = false
end

function UISignInTotalItem:PlayInAnim(yieldTime)
  if yieldTime then
    self._alpha.alpha = 0
    GameGlobal.Timer():AddEvent(yieldTime, function()
      if self._isActive then
        self._anim.enabled = false
        self._anim.enabled = true
        self._anim:Stop()
        self._anim:Play("uieff_SignIn_UISignInTotalItem_in")
      end
    end)
  else
    self._alpha.alpha = 1
  end
end

function UISignInTotalItem:OnGetTotalAward(days, data)
  if self._data.DayCount == days then
    self._data = data
    self:_OnValue()
    self:PlayGetAnim()
  end
end

function UISignInTotalItem:PlayGetAnim()
  self._anim.enabled = false
  self._anim.enabled = true
  self._anim:Stop()
  self._anim:Play("uieff_SignIn_UISignInTotalItem_Get")
end

function UISignInTotalItem:GetComponents()
  self._awardPool = self:GetUIComponent("UISelectObjectPath", "awardPool")
  self._dayCount = self:GetUIComponent("UILocalizationText", "dayCount")
  self._got = self:GetGameObject("got")
  self._get = self:GetGameObject("get")
  self._not_finish = self:GetGameObject("not_finish")
  self._anim = self:GetUIComponent("Animation", "UISignInTotalItem")
  self._alpha = self:GetUIComponent("CanvasGroup", "Root")
end

function UISignInTotalItem:_OnValue()
  local dayCount = self._data.DayCount
  self._dayCount:SetText(dayCount)
  local getState = 0
  if self._data.Got then
    getState = 3
  elseif self._currentTotalDay < self._data.DayCount then
    getState = 1
  else
    getState = 2
  end
  self._got:SetActive(getState == 3)
  self._get:SetActive(getState == 2)
  self._not_finish:SetActive(getState == 1)
  local awards = self._data.Items
  self._awardPool:SpawnObjects("UISignInTotalAwardsItem", #awards)
  local items = self._awardPool:GetAllSpawnList()
  for i = 1, #items do
    items[i]:SetData(i, awards[i], function(matid, pos)
      self._normalCallback(matid, pos)
    end, false)
  end
end

function UISignInTotalItem:getOnClick(go)
  if self._getAwardCallback then
    self._getAwardCallback(self._data.DayCount)
  end
end
