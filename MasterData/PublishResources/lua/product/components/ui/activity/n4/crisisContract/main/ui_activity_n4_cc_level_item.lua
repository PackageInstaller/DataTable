_class("UIActivityN4CCLevelItem", UICustomWidget)
UIActivityN4CCLevelItem = UIActivityN4CCLevelItem

function UIActivityN4CCLevelItem:OnShow(uiParams)
  self:InitWidget()
end

function UIActivityN4CCLevelItem:OnHide()
  self:CancelTimer()
end

function UIActivityN4CCLevelItem:InitWidget()
  self.imgBoss = self:GetUIComponent("RawImageLoader", "imgBoss")
  self.red = self:GetGameObject("red")
  self.new = self:GetGameObject("new")
  self.red:SetActive(false)
  self.new:SetActive(false)
  self.lock = self:GetGameObject("lock")
  self.unlock = self:GetGameObject("unlock")
  self.rootGo = self:GetGameObject("root")
  self.txtCoundDown = self:GetUIComponent("UILocalizationText", "txtCoundDown")
  local diffcultyPool = self:GetUIComponent("UISelectObjectPath", "diffculty")
  self.diffcultyItems = diffcultyPool:SpawnObjects("UIActivityN4CCLevelItemDiffculty", 3)
  self.diffcultyGo = self:GetGameObject("diffculty")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  local elementPool = self:GetUIComponent("UISelectObjectPath", "element")
  self.element = elementPool:SpawnObject("UIActivityN4CCLevelElement")
  self.animation = self:GetUIComponent("Animation", "animation")
end

function UIActivityN4CCLevelItem:SetData(data, context, clickCb, hideRedAndNew)
  self._clickCb = clickCb
  self._data = data
  self._context = context
  self.hideRedAndNew = hideRedAndNew
  if #self._data ~= 3 then
    Log.error("UIActivityN4CCLevelItem levels should 3 but num is ", #self._data)
    return
  end
  self.easyCfg = self._data[1]
  self.element:SetData(self.easyCfg.ElementIcon1, self.easyCfg.ElementIcon2)
  self._unLockTime = self._context:GetUnlockTime(self.easyCfg)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self:_Refresh()
end

function UIActivityN4CCLevelItem:SetVisible(bVisible)
  self.rootGo:SetActive(bVisible)
end

function UIActivityN4CCLevelItem:PlayEnterAni()
  self.rootGo:SetActive(true)
  self.animation:Play("uianim_UIActivityN4CCLevelItem_in")
end

function UIActivityN4CCLevelItem:PlaySelectAni()
  self.animation:Play("uieff_UIActivityN4CCLevelItem_xuanzhong")
end

function UIActivityN4CCLevelItem:_Refresh()
  self.imgBoss:LoadImage(self.easyCfg.MonsterIcon)
  self.txtName:SetText(StringTable.Get(self.easyCfg.MonsterName))
  local curTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  self._bUnlock = curTime > self._unLockTime
  self.lock:SetActive(not self._bUnlock)
  self.unlock:SetActive(self._bUnlock)
  self.diffcultyGo:SetActive(self._bUnlock)
  if self._bUnlock then
    self:_RefreshUnlock()
  else
    self:_RefreshLock()
  end
  self:_RefreshRedAndNew()
end

function UIActivityN4CCLevelItem:_RefreshRedAndNew()
  if not self.hideRedAndNew then
    local hasNew = self._context:CheckLevelRed(self._data)
    self.new:SetActive(hasNew)
    self.hasNew = hasNew
    local taskRed = not hasNew and self._context:CheckTaskRed(self.easyCfg)
    self.red:SetActive(taskRed)
  else
    self.new:SetActive(false)
    self.red:SetActive(false)
  end
end

function UIActivityN4CCLevelItem:_RefreshUnlock()
  for i = 1, 3 do
    local item = self.diffcultyItems[i]
    local cfg = self._data[i]
    local state = self._context:GetMissionState(cfg)
    item:SetData(state, i)
  end
end

function UIActivityN4CCLevelItem:_RefreshLock()
  self:CancelTimer()
  self:_RefreshLockCountDown()
  self._timerHandler = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:_RefreshLockCountDown()
  end)
end

function UIActivityN4CCLevelItem:_RefreshLockCountDown()
  local curTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  self._bUnlock = curTime > self._unLockTime
  if self._bUnlock then
    self:CancelTimer()
    self:_Refresh()
    return
  end
  local leftTime = self._unLockTime - curTime
  local timeStr = HelperProxy:GetInstance():FormatTime_3(leftTime)
  if self._timeStr ~= TimesRandomCounter then
    self._timeStr = timeStr
    self.txtCoundDown:SetText(timeStr)
  end
end

function UIActivityN4CCLevelItem:CancelTimer()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UIActivityN4CCLevelItem:BtnOnClick(go)
  if self._bUnlock then
    if self._clickCb then
      self._clickCb(self._data, self.hasNew)
    end
  else
    ToastManager.ShowToast(StringTable.Get("str_crisis_contract_level_unlock_tips", self._timeStr))
  end
end
