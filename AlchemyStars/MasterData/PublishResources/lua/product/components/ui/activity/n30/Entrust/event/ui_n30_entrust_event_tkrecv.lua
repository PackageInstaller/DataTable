local e = require("ui_n30_entrust_event")
e:Class("N30EntrustEventTkRecv", N30EntrustEvent, EntrustEventType.EntrustEventType_MissionOccupy)

function N30EntrustEventTkRecv:Constructor()
end

function N30EntrustEventTkRecv:DebugName()
  return "TkRecv"
end

function N30EntrustEventTkRecv:GetIconName()
  if self._isPass then
    return "n30_wt_ld_icon14"
  else
    return "n30_wt_ld_icon05"
  end
end

function N30EntrustEventTkRecv:GetWidgetName()
  return "UIN30EntrustEventTkRecv"
end

_class("UIN30EntrustEventTkRecv", UIN30EntrustEventWidget)
UIN30EntrustEventTkRecv = UIN30EntrustEventTkRecv

function UIN30EntrustEventTkRecv:Constructor()
  self._finishEvent = false
end

function UIN30EntrustEventTkRecv:OnShow(uiParams)
  self._txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self._txtConfirm = self:GetUIComponent("UILocalizationText", "txtConfirm")
  self._btnConfirm = self:GetUIComponent("Button", "btnConfirm")
end

function UIN30EntrustEventTkRecv:OnHide()
  if self._event:IsPass() and self._finishEvent then
    self:CallUIMethod("UIN30EntrustLine", "OnEventFinish", {
      self._event:ID()
    })
  end
end

function UIN30EntrustEventTkRecv:BtnConfirmOnClick(go)
  if self._event:IsPass() then
    return
  end
  self:CallUIMethod("UIN30EntrustLine", "CompleteEvent", self._event:ID(), function()
    local itemName
    local cfgItem = self:GetRewardCfg()
    if cfgItem == nil then
      itemName = ""
    else
      itemName = StringTable.Get(cfgItem.Name)
    end
    local txtPopup = StringTable.Get("str_n30_entrust_event_tk_recv_popup", itemName)
    ToastManager.ShowToast(txtPopup)
    self._finishEvent = true
    self:RootUIOwner():Refresh()
  end)
end

function UIN30EntrustEventTkRecv:GetIcon()
  return self._event:ParamHead()
end

function UIN30EntrustEventTkRecv:Refresh()
  local descValue = self._event:ParamDesc()
  if descValue == nil then
    descValue = ""
  else
    descValue = StringTable.Get(descValue)
  end
  self._txtDesc:SetText(descValue)
  local cfgItem = self:GetRewardCfg()
  if cfgItem == nil then
    self._btnConfirm.gameObject:SetActive(false)
  else
    local itemName = StringTable.Get(cfgItem.Name)
    local txtValue = StringTable.Get("str_n30_entrust_event_tk_recv_btn", itemName)
    self._txtConfirm:SetText(txtValue)
  end
  self._btnConfirm.interactable = not self._event:IsPass()
end

function UIN30EntrustEventTkRecv:GetRewardCfg()
  local cfg = self._event:Cfg()
  local entrustData = self._event:EntrustData()
  local reward
  local rewardFinish = entrustData:EventRewardList(cfg)
  for k, v in pairs(rewardFinish) do
    reward = v
    break
  end
  local cfgItem
  if reward ~= nil then
    cfgItem = Cfg.cfg_item[reward.assetid]
    return cfgItem, reward
  else
    return cfgItem
  end
end
