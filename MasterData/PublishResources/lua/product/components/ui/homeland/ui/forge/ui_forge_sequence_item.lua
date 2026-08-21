_class("UIForgeSequenceItem", UICustomWidget)
UIForgeSequenceItem = UIForgeSequenceItem

function UIForgeSequenceItem:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.data = self.mHomeland:GetForgeData()
end

function UIForgeSequenceItem:OnShow()
  self.unlock = self:GetGameObject("unlock")
  self.forging = self:GetGameObject("forging")
  self.getable = self:GetGameObject("getable")
  self.lock = self:GetGameObject("lock")
  self.idle = self:GetGameObject("idle")
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.txtSize = self:GetUIComponent("UILocalizationText", "txtSize")
  self.txtLiveable = self:GetUIComponent("UILocalizationText", "txtLiveable")
  self.txtOwn = self:GetUIComponent("UILocalizationText", "txtOwn")
  self.txtPlace = self:GetUIComponent("UILocalizationText", "txtPlace")
  self.txtCD = self:GetUIComponent("UILocalizationText", "txtCD")
  self.txtUnlockCondition = self:GetUIComponent("UILocalizationText", "txtUnlockCondition")
  self.forgeCount = self:GetUIComponent("UILocalizationText", "forgeCount")
  self.forgeCountParent = self:GetGameObject("forgeCountParent")
  self._helpCDTime = self:GetUIComponent("UILocalizationText", "helpCDTime")
  self._helpTime = self:GetUIComponent("UILocalizationText", "helpTime")
  self._helpCD = self:GetGameObject("helpCD")
end

function UIForgeSequenceItem:OnHide()
  self.imgIcon:DestoryLastImage()
  self:CancelTimerEvent()
end

function UIForgeSequenceItem:RegisterTimeEvent()
  self:CancelTimerEvent()
  self.te = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:FlushTime()
  end)
end

function UIForgeSequenceItem:CancelTimerEvent()
  if self.te then
    GameGlobal.Timer():CancelEvent(self.te)
    self.te = nil
  end
end

function UIForgeSequenceItem:Flush(index)
  self:CancelTimerEvent()
  self.index = index
  local s = self.data:GetForgeSequenceByIndex(index)
  if s.state == ForgeSequenceState.Locked then
    self.unlock:SetActive(false)
    self.lock:SetActive(true)
    self.idle:SetActive(false)
    self.txtUnlockCondition:SetText(StringTable.Get("str_homeland_skin_islock", s.unlockLevel))
  elseif s.state == ForgeSequenceState.Idle then
    self.unlock:SetActive(false)
    self.lock:SetActive(false)
    self.idle:SetActive(true)
  else
    self.unlock:SetActive(true)
    self.lock:SetActive(false)
    self.idle:SetActive(false)
    local item = self.data:GetForgeInfoItemById(s.forgeItemId)
    self.imgIcon:LoadImage(item.icon)
    self.txtName:SetText(StringTable.Get("str_homeland_forge_detail_name", StringTable.Get("str_homeland_quality_" .. item.quality), item.name))
    self.txtSize:SetText(item.size.x .. "*" .. item.size.y)
    self.txtLiveable:SetText(item.livableValue)
    local curCount, placedCount = UIForgeData.GetOwnPlaceCount(item.id)
    self.txtOwn:SetText(StringTable.Get("str_homeland_forge_detail_own", curCount))
    self.txtPlace:SetText(StringTable.Get("str_homeland_forge_sequence_place", placedCount))
    self.forgeCount:SetText("×" .. item.forgeCount)
    self.forgeCountParent:SetActive(item.forgeCount > 1)
    if s.state == ForgeSequenceState.Forging then
      self.forging:SetActive(true)
      self.getable:SetActive(false)
      self:RegisterTimeEvent()
      self:FlushTime()
      if s.helpRemainTime then
        self._helpTime.gameObject:SetActive(true)
        local hour = math.ceil(s.helpRemainTime / 3600)
        if 0 < hour then
          self._helpTime:SetText(StringTable.Get("str_homeland_visit_help_time", hour))
          self._helpTime.color = Color(0.27450980392156865, 0.6352941176470588, 0.7843137254901961, 1)
        else
          self._helpTime:SetText(StringTable.Get("str_homeland_visit_help_finish"))
          self._helpTime.color = Color(0.6274509803921569, 0.6235294117647059, 0.6235294117647059, 1)
        end
        if 0 < s.helpedTime then
          self._helpCD:SetActive(true)
          local cdHour = math.ceil(s.helpedTime / 3600)
          self._helpCDTime:SetText(StringTable.Get("str_homeland_visit_helped_time", cdHour))
        else
          self._helpCD:SetActive(false)
        end
      else
        self._helpTime.gameObject:SetActive(false)
        self._helpCD:SetActive(false)
      end
    elseif s.state == ForgeSequenceState.Getable then
      self.forging:SetActive(false)
      self.getable:SetActive(true)
    else
      Log.fatal("### invalid state. state=", s.state)
    end
  end
end

function UIForgeSequenceItem:FlushTime()
  local s = self.data:GetForgeSequenceByIndex(self.index)
  if UICommonHelper.GetNowTimestamp() >= s.doneTimestamp then
    s.state = ForgeSequenceState.Getable
    self:Flush(self.index)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandForgeUpdateSequence)
  else
    UIForge.FlushCDText(self.txtCD, s.doneTimestamp, self.data.strsWillGetable, true)
  end
end

function UIForgeSequenceItem:BtnGetOnClick(go)
  local s = self.data:GetForgeSequenceByIndex(self.index)
  if s.state == ForgeSequenceState.Getable then
    local itemId = s.forgeItemId
    self._curExp = self.mHomeland:GetHomelandInfo().exp
    self:StartTask(function(TT)
      self:Lock("HomeReqPickupItem")
      local res, forge_list, architecture = self.mHomeland:HandlPickUp(TT, self.index)
      if UIForgeData.CheckCode(res:GetResult()) then
        self.data:InitSequence(forge_list)
        GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandForgeUpdateSequence)
        GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandForgeUpdateList)
        local a = RoleAsset:New()
        a.assetid = itemId
        a.count = s.forgeCount
        self:ShowDialog("UIHomeShowAwards", {a}, nil, false)
        local deltaExp = math.max(0, self.mHomeland:GetHomelandInfo().exp - self._curExp)
        if 0 < deltaExp then
          ToastManager.ShowHomeToast(StringTable.Get("str_homeland_forge_add_exp", deltaExp))
        end
        YIELD(TT, 1000)
        local uiModule = GameGlobal.GetUIModule(HomelandModule)
        uiModule:TryPopLevelUpTip()
        self:UnLock("HomeReqPickupItem")
      else
        self:UnLock("HomeReqPickupItem")
      end
    end, self)
  end
end

function UIForgeSequenceItem:btnCancelOnClick(go)
  local s = self.data:GetForgeSequenceByIndex(self.index)
  local item = self.data:GetForgeInfoItemById(s.forgeItemId)
  self:ShowDialog("UIHomelandMessageBox_Items", StringTable.Get("str_homeland_forge_cancel"), StringTable.Get("str_homeland_forge_cancel_or_not", item.name), item.forgeCosts, function(param)
    self:StartTask(function(TT)
      local key = "CancelForgeTask"
      self:Lock(key)
      local res, forge_list, return_material = self.mHomeland:HandleCancel(TT, s.index)
      if UIForgeData.CheckCode(res:GetResult()) then
        self.data:InitSequence(forge_list)
        GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandForgeUpdateSequence)
        GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandForgeUpdateList)
        ToastManager.ShowHomeToast(StringTable.Get("str_homeland_forge_cancel_success"))
      end
      self:UnLock(key)
    end, self)
  end)
end

function UIForgeSequenceItem:btnSpeedOnClick(go)
  local item = self.data:GetForgeSequenceByIndex(self.index)
  local accItemId, accSeconds = self.data:GetForgeAccItem()
  self:ShowDialog("UIHomelandAccelerate", StringTable.Get("str_homeland_forge_acc_title"), item.doneTimestamp, accItemId, accSeconds, function(id, count)
    self:_UseItem(id, count)
  end)
end

function UIForgeSequenceItem:_UseItem(id, count)
  if count <= 0 then
    return
  end
  self:StartTask(function(TT)
    local accItemId, accSeconds = self.data:GetForgeAccItem()
    local ra = RoleAsset:New()
    ra.assetid = id
    ra.count = count
    local res, forge_list = self.mHomeland:HandleAccelerate(TT, self.index, ra)
    if UIForgeData.CheckCode(res:GetResult()) then
      self.data:InitSequence(forge_list)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandForgeUpdateList)
      local s = self.data:GetForgeSequenceByIndex(self.index)
      if s.state == ForgeSequenceState.Getable then
        ToastManager.ShowHomeToast(StringTable.Get("str_homeland_forge_acc_success_done"))
      else
        local s = UIForge.GetTimestampStr(count * accSeconds, self.data.strsWillGetable)
        ToastManager.ShowHomeToast(StringTable.Get("str_homeland_forge_acc_success", s))
      end
    end
  end, self)
end
