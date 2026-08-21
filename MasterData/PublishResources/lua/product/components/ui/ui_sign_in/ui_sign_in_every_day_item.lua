_class("UISignInEveryDayItem", UICustomWidget)
UISignInEveryDayItem = UISignInEveryDayItem

function UISignInEveryDayItem:OnShow(uiParam)
  self:GetComponents()
end

function UISignInEveryDayItem:GetComponents()
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._iconImg = self:GetUIComponent("RawImage", "icon")
  self._count = self:GetUIComponent("UILocalizationText", "count")
  self._makeUp = self:GetGameObject("makeUp")
  self._got = self:GetGameObject("got")
  self._dayText = self:GetUIComponent("UILocalizationText", "dayText")
  self._good = self:GetGameObject("good")
  self._select = self:GetGameObject("select")
  self._dataRoot = self:GetGameObject("dataRoot")
  self._bgRoot = self:GetGameObject("bgRoot")
  self._getting = self:GetGameObject("getting")
  self._getting:SetActive(false)
  self._anim = self:GetUIComponent("Animation", "UISignInEveryDayItem")
  self._actBox = self:GetGameObject("actBox")
  self._alpha = self:GetUIComponent("CanvasGroup", "Root")
end

function UISignInEveryDayItem:OnHide()
  self._isActive = false
end

function UISignInEveryDayItem:SetData(data, currentDay, signInCallback, normalCallback, makeUpCallback, checkActBoxCb, yieldTime)
  self._isActive = true
  self._data = data
  self._currentDay = currentDay
  self._normalCallback = normalCallback
  self._makeUpCallback = makeUpCallback
  self._signInCallback = signInCallback
  self._checkActBoxCb = checkActBoxCb
  self:_OnValue()
  self:PlayInAnim(yieldTime)
end

function UISignInEveryDayItem:PlayInAnim(yieldTime)
  if yieldTime then
    self._anim:Stop()
    self._alpha.alpha = 0
    GameGlobal.Timer():AddEvent(yieldTime, function()
      if self._isActive then
        self._anim:Play("uieff_SignIn_EverydayItem_in")
      end
    end)
  else
    self._alpha.alpha = 1
  end
end

function UISignInEveryDayItem:Flush(data)
  self._data = data
  self:_OnValue()
end

function UISignInEveryDayItem:MakeUpAnim()
  self:PlayAnim()
end

function UISignInEveryDayItem:ShowGetting(show)
  self._getting:SetActive(show)
end

function UISignInEveryDayItem:HideMakeUp()
  self._makeUp:SetActive(false)
end

function UISignInEveryDayItem:PlayAnim()
  self._anim:Stop()
  self._alpha.alpha = 1
  self._anim:Play("uieff_SignIn_EverydayItem_Get_new")
end

function UISignInEveryDayItem:_OnValue()
  if self._data == nil then
    return
  end
  self._good:SetActive(self._data.Good)
  self._select:SetActive(self._currentDay == self._data.Day)
  local award = self._data.Items
  local cfg_item = Cfg.cfg_item[award.assetid]
  if not cfg_item then
    Log.fatal("###[UISignInEveryDayItem] cfg_item is nil ! id --> ", award.assetid)
    return
  end
  local icon = cfg_item.Icon
  self._icon:LoadImage(icon)
  self._count:SetText(award.count)
  self._makeUp:SetActive(self._data.CanMakeUp)
  self._got:SetActive(self._data.ItemGot)
  self._dayText:SetText(self._data.Day)
  local alpha = 1
  if self._data.ItemGot then
    alpha = 0.5
  end
  self._iconImg.color = Color(1, 1, 1, alpha)
  if self._currentDay == self._data.Day then
    self._dayText.color = Color(0.9686274509803922, 0.9686274509803922, 0.9686274509803922, 1)
  elseif self._data.ItemGot then
    self._dayText.color = Color(0.1843137254901961, 0.1843137254901961, 0.1843137254901961, 1)
  else
    self._dayText.color = Color(0.5490196078431373, 0.5490196078431373, 0.5490196078431373, 1)
  end
  local startTime, endTime = self._checkActBoxCb(self._data.Day)
  if startTime then
    self._actBox:SetActive(true)
  else
    self._actBox:SetActive(false)
  end
end

function UISignInEveryDayItem:BgOnClick(go)
  local normal = true
  if self._currentDay == self._data.Day then
    if not self._data.ItemGot then
      self._signInCallback(self._data.Day)
      normal = false
    end
  elseif self._currentDay > self._data.Day then
  elseif not self._data.ItemGot and self._data.CanMakeUp and self._makeUpCallback then
    self._makeUpCallback(self._data.Day)
    normal = false
  end
  if normal and self._normalCallback then
    local tr = go.transform
    local pos = tr.position
    local award = self._data.Items
    self._normalCallback(award.assetid, pos)
  end
end
