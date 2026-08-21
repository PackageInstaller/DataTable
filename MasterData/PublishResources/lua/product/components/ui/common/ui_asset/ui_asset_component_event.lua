_class("UIAssetComponentEvent", UIAssetComponentBase)
UIAssetComponentEvent = UIAssetComponentEvent

function UIAssetComponentEvent:OnInit()
  self._perSecondCout = 2
  self._perNextSecondCout = 5
  self._btnGO = self._gameObject.transform:Find("btn").gameObject
  self._btnImage = self._btnGO:GetComponent("Image")
  self._longTrigger = false
  self._uicustomEventListener = UICustomUIEventListener:New()
end

function UIAssetComponentEvent:GetBtnObject()
  return self._btnGO
end

function UIAssetComponentEvent:SetClickCallBack(callBack, param)
  self._clickCallBack = callBack
  self._param = param
  self._uicustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._btnGO), UIEvent.Click, function(go)
    if self._longTrigger == false and self._clickCallBack then
      self._clickCallBack(go)
    end
  end)
end

function UIAssetComponentEvent:SetLongPressCallBack(longPressCallBack, longPressUpCallBack, pressTime, update)
  self._longPressCallBack = longPressCallBack
  self._longPressUpCallBack = longPressUpCallBack
  self._pressTimeConst = pressTime
  self._pressTime = self._pressTimeConst
  self._update = update
  self:InitLongPress()
end

function UIAssetComponentEvent:InitLongPress()
  self._uicustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._btnGO), UIEvent.Press, function(go)
    if self._timerEvent then
      GameGlobal.Timer():CancelEvent(self._timerEvent)
      self._timerEvent = nil
    end
    self:LongEvent()
  end)
  self._uicustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._btnGO), UIEvent.Unhovered, function(go)
    if self._timerEvent then
      self._startTime = nil
      self._lastTime = nil
      self._addTime = nil
      GameGlobal.Timer():CancelEvent(self._timerEvent)
      self._pressTime = self._pressTimeConst
      self._longTrigger = false
      self._timerEvent = nil
    end
  end)
  self._uicustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._btnGO), UIEvent.Release, function(go)
    if self._timerEvent then
      self._startTime = nil
      self._lastTime = nil
      self._addTime = nil
      GameGlobal.Timer():CancelEvent(self._timerEvent)
      self._pressTime = self._pressTimeConst
      self._longTrigger = false
      if self._longPressUpCallBack then
        self._longPressUpCallBack()
      end
      self._timerEvent = nil
    end
  end)
end

function UIAssetComponentEvent:LongEvent()
  self._timerEvent = GameGlobal.Timer():AddEvent(self._pressTime, function()
    if GuideHelper.IsUIGuideShow() then
      return
    end
    self._longTrigger = true
    if self._longPressCallBack then
      local count = self._longPressCallBack()
      if count then
        self:Calculate(count)
      end
    end
    if self._update then
      self:LongEvent()
    end
  end)
end

function UIAssetComponentEvent:Calculate(count)
  local presse_count = Cfg.cfg_global.pet_up_level_presse_count.IntValue
  local next_presse_count = Cfg.cfg_global.pet_up_level_next_presse_count.IntValue
  local real_presse_count = count
  if presse_count <= real_presse_count then
    self._pressTime = self._pressTimeConst / self._perSecondCout
  end
  if next_presse_count <= real_presse_count then
    self._pressTime = self._pressTimeConst / self._perNextSecondCout
  end
end
