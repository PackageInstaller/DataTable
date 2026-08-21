_class("UITestFuncServerTime", UICustomWidget)
UITestFuncServerTime = UITestFuncServerTime

function UITestFuncServerTime:OnShow(uiParams)
  self._root = self:GetGameObject("_root")
  self._adjust = self:GetUIComponent("UILocalizationText", "_adjust")
  self._text = self:GetUIComponent("UILocalizationText", "_text")
  self._btns = UITestFuncBtnManager:New(self, "Content", nil)
  self:_SetContent(self._btns)
  self._btns:SpawnBtns()
end

function UITestFuncServerTime:OnHide()
end

function UITestFuncServerTime:_SetContent(manager)
  self:_AddBtn_Sample(manager, "S4", 8004, "BeginTime")
  self:_AddBtn_Sample(manager, "N40", 1136, "BeginTime")
  self:_AddBtn_Component(manager, "N40 掉落", 113602102, "CloseTime")
  self:_AddBtn_Sample(manager, "N40", 1136, "EndTime")
end

function UITestFuncServerTime:_AddBtn_TimeText(manager, title, text)
  manager:AddBtn_Default(title, function()
    self._text:SetText(text)
  end)
end

function UITestFuncServerTime:_AddBtn_Sample(manager, title, campaignId, key)
  title = string.format("%s %d %s", title, campaignId, key)
  manager:AddBtn_Default(title, function()
    local text = self:_GetSampleInfo(campaignId, key)
    self._text:SetText(text)
  end)
end

function UITestFuncServerTime:_AddBtn_Component(manager, title, cmptCfgId, key)
  title = string.format("%s %s", title, key)
  manager:AddBtn_Default(title, function()
    local text = self:_GetCmptInfo(cmptCfgId, key)
    self._text:SetText(text)
  end)
end

function UITestFuncServerTime:_GetSampleInfo(campaignId, key)
  local cfg = Cfg.cfg_campaign[campaignId]
  if cfg then
    return cfg[key]
  end
  return ""
end

function UITestFuncServerTime:_GetCmptInfo(cmptCfgId, key)
  local tb = {
    [113602102] = {
      UnlockTime = "2024-01-10 05:00:00",
      CloseTime = "2024-01-29 09:00:00"
    }
  }
  local cfg = tb[cmptCfgId]
  if cfg then
    return cfg[key]
  end
  return ""
end

function UITestFuncServerTime:GoToTime()
  local text = self._text.text
  if string.isnullorempty(text) then
    return
  end
  local adjust = self._adjust.text
  if string.isnullorempty(text) then
    adjust = 0
  end
  local loginModule = GameGlobal.GetModule(LoginModule)
  local target = loginModule:GetTimeStampByTimeStr(text, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local t = target + tonumber(adjust)
  UIGMHelper.GotoTime(t)
end

function UITestFuncServerTime:ExitBtnOnClick()
  self._root:SetActive(false)
end

function UITestFuncServerTime:AdjustBtnOnClick()
  local tb = {
    0,
    -15,
    -30,
    -60,
    -180
  }
  self._index = self._index or 0
  self._index = (self._index + 1) % #tb
  local index = self._index + 1
  self._adjust:SetText(tb[index])
end

function UITestFuncServerTime:GoToBtnOnClick()
  self:GoToTime()
end
