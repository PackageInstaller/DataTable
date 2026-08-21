_class("UIAssetComponentReduce", UIAssetComponentBase)
UIAssetComponentReduce = UIAssetComponentReduce

function UIAssetComponentReduce:OnInit()
  self._reduceObj = self._gameObject.transform:Find("g_reduce").gameObject
  self._reduceNum = self._gameObject.transform:Find("g_reduce/reduce/reducenum"):GetComponent("UILocalizationText")
  self._reduceNumBtn = self._gameObject.transform:Find("g_reduce/reduce/g_reduce_btn").gameObject
  self._uicustomEventListener = UICustomUIEventListener:New()
end

function UIAssetComponentReduce:SetReduceLongPressCallBack(callback, logPressSec)
  self._reducePressTime = logPressSec
  self._longTrigger = false
  self._uicustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._reduceNumBtn), UIEvent.Click, function(go)
    local clickCallBack = callback
    if clickCallBack then
      clickCallBack()
    end
  end)
  self._uicustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._reduceNumBtn), UIEvent.Press, function(go)
    if GuideHelper.IsUIGuideShow() then
      return
    end
    if not self._reduceTimerEvent then
      self._longTrigger = true
      self._reduceTimerEvent = GameGlobal.Timer():AddEventTimes(self._reducePressTime, TimerTriggerCount.Infinite, function()
        local clickCallBack = callback
        if clickCallBack then
          clickCallBack()
        end
      end)
    end
  end)
  self._uicustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._reduceNumBtn), UIEvent.Unhovered, function(go)
    self._longTrigger = false
    if self._reduceTimerEvent then
      GameGlobal.Timer():CancelEvent(self._reduceTimerEvent)
      self._reduceTimerEvent = nil
    end
  end)
  self._uicustomEventListener:AddUICustomEventListener(UICustomUIEventListener.Get(self._reduceNumBtn), UIEvent.Release, function(go)
    self._longTrigger = false
    if self._reduceTimerEvent then
      GameGlobal.Timer():CancelEvent(self._reduceTimerEvent)
      self._reduceTimerEvent = nil
    end
  end)
end

function UIAssetComponentReduce:SetReduceNum(count, selectCallback)
  if not count or count <= 0 then
    self._reduceObj:SetActive(false)
    if selectCallback then
      selectCallback(false)
    end
    if self._longTrigger then
      self._longTrigger = false
      if self._reduceTimerEvent then
        GameGlobal.Timer():CancelEvent(self._reduceTimerEvent)
        self._reduceTimerEvent = nil
      end
    end
  else
    self._reduceObj:SetActive(true)
    if selectCallback then
      selectCallback(true)
    end
    self._reduceNum:SetText(count)
  end
end
