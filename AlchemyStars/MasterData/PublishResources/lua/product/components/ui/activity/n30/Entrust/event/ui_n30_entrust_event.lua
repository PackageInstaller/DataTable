_class("N30EntrustEvent", Object)
N30EntrustEvent = N30EntrustEvent

function N30EntrustEvent:Constructor(node, cfg)
  self._parent = node
  self._cfg = cfg
  self._isVisible = false
  self._isLocked = false
  self._isPass = false
end

function N30EntrustEvent:DebugName()
  return "Base"
end

function N30EntrustEvent:CreateEvent(node, cfg)
  local eventType = cfg.EventType
  local c = self._dic[eventType]
  if c ~= nil then
    return c:New(node, cfg, eventType)
  end
end

function N30EntrustEvent:Class(child, base, eventType)
  if self._dic == nil then
    self._dic = {}
  end
  _class(child, base)
  self._dic[eventType] = _G[child]
end

function N30EntrustEvent:Node()
  return self._parent
end

function N30EntrustEvent:ID()
  return self._cfg.EventID
end

function N30EntrustEvent:Cfg()
  return self._cfg
end

function N30EntrustEvent:EventType()
  return self._cfg.EventType
end

function N30EntrustEvent:ParamTeamID()
  if self._cfg.Params == nil then
    return nil
  end
  return self._cfg.Params[1].TeamID
end

function N30EntrustEvent:ParamBannerID()
  if self._cfg.Params == nil then
    return nil
  end
  return self._cfg.Params[1].BannerID
end

function N30EntrustEvent:ParamBannerType()
  if self._cfg.Params == nil then
    return nil
  end
  return self._cfg.Params[1].BannerType
end

function N30EntrustEvent:ParamStoryID()
  if self._cfg.Params == nil then
    return nil
  end
  return self._cfg.Params[1].StoryID
end

function N30EntrustEvent:ParamHard()
  if self._cfg.Params == nil then
    return false
  end
  return self._cfg.Params[1].Type == 1
end

function N30EntrustEvent:ParamHead()
  if self._cfg.Params == nil then
    return nil
  end
  return self._cfg.Params[1].Head
end

function N30EntrustEvent:ParamShowNumber()
  if self._cfg.Params == nil then
    return false
  end
  return self._cfg.Params[1].ShowNumber == 1
end

function N30EntrustEvent:ParamDesc()
  if self._cfg.Params == nil then
    return nil
  end
  return self._cfg.Params[1].Desc
end

function N30EntrustEvent:EntrustData()
  return self._parent:EntrustData()
end

function N30EntrustEvent:IsVisible()
  return self._isVisible
end

function N30EntrustEvent:IsLocked()
  return self._isLocked
end

function N30EntrustEvent:IsPass()
  return self._isPass
end

function N30EntrustEvent:GetIconBgName()
  return nil
end

function N30EntrustEvent:GetIconName()
  if self._isPass then
    return "n30_wt_ld_icon14"
  else
    return "n30_wt_ld_icon05"
  end
end

function N30EntrustEvent:GetWidgetName()
  return nil
end

function N30EntrustEvent:OnArrived(ui)
  ui:ShowDialog("UIN30EntrustEvent", self)
end

_class("N30EntrustLine", Object)
N30EntrustLine = N30EntrustLine

function N30EntrustLine:Constructor(node, cfg)
  self._parent = node
  self._cfg = cfg
  self._isVisible = false
end

function N30EntrustLine:CreateLine(node, cfg)
  return self:New(node, cfg)
end

function N30EntrustLine:Node()
  return self._parent
end

function N30EntrustLine:ID()
  return self.cfg.ID
end

function N30EntrustLine:Cfg()
  return self._cfg
end

function N30EntrustLine:EntrustData()
  return self._parent:EntrustData()
end

function N30EntrustLine:IsVisible()
  return self._isVisible
end

_class("UIN30EntrustEventWidget", UICustomWidget)
UIN30EntrustEventWidget = UIN30EntrustEventWidget

function UIN30EntrustEventWidget:ShowClose()
  return true
end

function UIN30EntrustEventWidget:GetTitle()
  local cfg = self._event:Cfg()
  if cfg.PointName ~= nil then
    return StringTable.Get(cfg.PointName)
  else
    return nil
  end
end

function UIN30EntrustEventWidget:GetIcon()
  return nil
end

function UIN30EntrustEventWidget:SetEvent(event)
  self._event = event
end

function UIN30EntrustEventWidget:Refresh()
end

_class("UIN30EntrustEvent", UIController)
UIN30EntrustEvent = UIN30EntrustEvent

function UIN30EntrustEvent:Constructor()
end

function UIN30EntrustEvent:LoadDataOnEnter(TT, res, uiParams)
  self._event = uiParams[1]
end

function UIN30EntrustEvent:OnShow(uiParams)
  self._btnClose = self:GetUIComponent("RectTransform", "btnClose")
  self._uiTitle = self:GetUIComponent("RectTransform", "uiTitle")
  self._txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self._uiFinish = self:GetUIComponent("RectTransform", "uiFinish")
  self._uiIcon = self:GetUIComponent("RawImageLoader", "uiIcon")
  self._uiEvent = self:GetUIComponent("UISelectObjectPath", "uiEvent")
  self._widgetEvent = nil
  self._safeArea = self:GetUIComponent("Animation", "safeArea")
  self._animation = self:GetUIComponent("Animation", "animation")
  self:Refresh()
end

function UIN30EntrustEvent:OnHide()
end

function UIN30EntrustEvent:BtnCloseOnClick(go)
  self:CloseDialogAnimation()
end

function UIN30EntrustEvent:Refresh()
  local isShowClose = true
  local eventTitle, iconUrl
  local widgetName = self._event:GetWidgetName()
  self._uiEvent:Engine().gameObject:SetActive(widgetName ~= nil)
  if widgetName ~= nil then
    self._uiEvent:Engine():SetObjectName(widgetName .. ".prefab")
    self._widgetEvent = self._uiEvent:SpawnObject(widgetName)
    self._widgetEvent:SetEvent(self._event)
    self._widgetEvent:Refresh()
    isShowClose = self._widgetEvent:ShowClose()
    eventTitle = self._widgetEvent:GetTitle()
    iconUrl = self._widgetEvent:GetIcon()
  end
  self._btnClose.gameObject:SetActive(isShowClose)
  self._uiFinish.gameObject:SetActive(self._event:IsPass())
  self._uiTitle.gameObject:SetActive(eventTitle ~= nil)
  if eventTitle ~= nil then
    self._txtTitle:SetText(eventTitle)
  end
  self._uiIcon.gameObject:SetActive(iconUrl ~= nil)
  if iconUrl ~= nil then
    self._uiIcon:LoadImage(iconUrl)
  end
end

function UIN30EntrustEvent:RewardItemInfo(reward, go)
  local deltaPosition = go.transform.position - self._safeArea.transform.position
  self:ShowDialog("UIN30EntrustItemInfo", reward, deltaPosition)
end

function UIN30EntrustEvent:CloseDialogAnimation(cbFinish)
  local lockName = "UIN30EntrustEvent:CloseDialogAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("uieff_N30_EntrustEvent_out")
    YIELD(TT, 200)
    self:UnLock(lockName)
    self:CloseDialog()
    if cbFinish then
      cbFinish()
    end
  end)
end

return N30EntrustEvent, N30EntrustLine
