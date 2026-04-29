_class("UIForgeSpeed", UIController)
UIForgeSpeed = UIForgeSpeed

function UIForgeSpeed:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.data = self.mHomeland:GetForgeData()
  self.mRole = self:GetModule(RoleModule)
end

function UIForgeSpeed:OnShow(uiParams)
  self.txtLeftTimeL = self:GetUIComponent("UILocalizationText", "txtLeftTimeL")
  self.txtLeftTimeR = self:GetUIComponent("UILocalizationText", "txtLeftTimeR")
  self.txtCostL = self:GetUIComponent("UILocalizationText", "txtCostL")
  self.txtCostR = self:GetUIComponent("UILocalizationText", "txtCostR")
  self.sldCount = self:GetUIComponent("Slider", "sldCount")
  self.costIcon = self:GetUIComponent("Image", "costIcon")
  
  function self.OnSldCountValueChange(value)
    self:ClampCurCount(value)
    self:Flush()
  end
  
  self.sldCount.onValueChanged:AddListener(self.OnSldCountValueChange)
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.index = uiParams[1]
  self.curCount = 1
  self:Flush()
  self:RegisterTimeEvent()
end

function UIForgeSpeed:OnHide()
  self.sldCount.onValueChanged:RemoveListener(self.OnSldCountValueChange)
  self:CancelTimerEvent()
end

function UIForgeSpeed:RegisterTimeEvent()
  self:CancelTimerEvent()
  self.te = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:Flush()
  end)
end

function UIForgeSpeed:CancelTimerEvent()
  if self.te then
    GameGlobal.Timer():CancelEvent(self.te)
  end
end

function UIForgeSpeed:Flush()
  local s = self.data:GetForgeSequenceByIndex(self.index)
  local tsNow = UICommonHelper.GetNowTimestamp()
  local tsDelta = s.doneTimestamp - tsNow
  if tsDelta <= 0 then
    self:CloseDialog()
  else
    local accItemId, accSeconds = self.data:GetForgeAccItem()
    local cost = math.ceil(tsDelta / accSeconds)
    local countItem = self.mRole:GetAssetCount(accItemId) or 0
    local max = math.min(cost, countItem)
    local min = math.min(1, max)
    self.sldCount.minValue = min
    self.sldCount.maxValue = max
    self:ClampCurCount(self.curCount)
    self.sldCount.value = self.curCount
    UIForge.FlushCDText(self.txtLeftTimeL, s.doneTimestamp, self.data.strsWillGetable, true)
    UIForge.FlushCDText(self.txtLeftTimeR, s.doneTimestamp - self.curCount * accSeconds, self.data.strsWillGetable, true)
    self.txtCostL:SetText(countItem)
    self.txtCostR:SetText(countItem - self.curCount)
    self.txtCount:SetText(self.curCount)
    local topCfg = Cfg.cfg_top_tips[accItemId]
    if not topCfg then
      Log.exception("cfg_top_tips中缺少配置:", accItemId)
    end
    local atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
    self.costIcon.sprite = atlas:GetSprite(topCfg.Icon)
  end
end

function UIForgeSpeed:ClampCurCount(curCount)
  curCount = math.min(self.sldCount.maxValue, curCount)
  curCount = math.max(self.sldCount.minValue, curCount)
  self.curCount, _ = math.modf(curCount)
end

function UIForgeSpeed:bgOnClick(go)
  self:CloseDialog()
end

function UIForgeSpeed:btnCloseOnClick(go)
  self:CloseDialog()
end

function UIForgeSpeed:btnLowerOnClick(go)
  if self.curCount > 0 then
    self:ClampCurCount(self.curCount - 1)
    self:Flush()
  end
end

function UIForgeSpeed:btnUpperOnClick(go)
  if self.curCount < self.sldCount.maxValue then
    self:ClampCurCount(self.curCount + 1)
    self:Flush()
  end
end

function UIForgeSpeed:btnConfirmOnClick(go)
  if self.curCount <= 0 then
    self:CloseDialog()
    return
  end
  self:StartTask(function(TT)
    local accItemId, accSeconds = self.data:GetForgeAccItem()
    local ra = RoleAsset:New()
    ra.assetid = accItemId
    ra.count = self.curCount
    local res, forge_list = self.mHomeland:HandleAccelerate(TT, self.index, ra)
    if UIForgeData.CheckCode(res:GetResult()) then
      self.data:InitSequence(forge_list)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandForgeUpdateSequence)
      local s = self.data:GetForgeSequenceByIndex(self.index)
      if s.state == ForgeSequenceState.Getable then
        ToastManager.ShowHomeToast(StringTable.Get("str_homeland_forge_acc_success_done"))
      else
        local s = UIForge.GetTimestampStr(self.curCount * accSeconds, self.data.strsWillGetable)
        ToastManager.ShowHomeToast(StringTable.Get("str_homeland_forge_acc_success", s))
      end
      self:CloseDialog()
    end
  end, self)
end
