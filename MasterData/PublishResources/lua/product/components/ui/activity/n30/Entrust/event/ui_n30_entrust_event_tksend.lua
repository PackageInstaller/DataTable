local e = require("ui_n30_entrust_event")
e:Class("N30EntrustEventTkSend", N30EntrustEvent, EntrustEventType.EntrustEventType_MissionSubmit)

function N30EntrustEventTkSend:Constructor()
end

function N30EntrustEventTkSend:DebugName()
  return "TkSend"
end

function N30EntrustEventTkSend:GetIconName()
  if self._isPass then
    return "n30_wt_ld_icon14"
  else
    return "n30_wt_ld_icon05"
  end
end

function N30EntrustEventTkSend:GetWidgetName()
  return "UIN30EntrustEventTkSend"
end

_class("UIN30EntrustEventTkSend", UIN30EntrustEventWidget)
UIN30EntrustEventTkSend = UIN30EntrustEventTkSend

function UIN30EntrustEventTkSend:Constructor()
  self._finishEvent = false
end

function UIN30EntrustEventTkSend:OnShow(uiParams)
  self._txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self._txtConfirm = self:GetUIComponent("UILocalizationText", "txtConfirm")
  self._btnConfirm = self:GetUIComponent("Button", "btnConfirm")
end

function UIN30EntrustEventTkSend:OnHide()
  if self._event:IsPass() and self._finishEvent then
    self:CallUIMethod("UIN30EntrustLine", "OnEventFinish", {
      self._event:ID()
    })
  end
end

function UIN30EntrustEventTkSend:BtnConfirmOnClick(go)
  if self._event:IsPass() then
    return
  end
  local cfgItem, reward
  cfgItem, reward = self:GetRewardCfg()
  if cfgItem == nil then
    return
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  local haveCount = itemModule:GetItemCount(reward.assetid)
  if haveCount < reward.count then
    local txtPopup = StringTable.Get("str_n30_entrust_event_tk_not_enough")
    ToastManager.ShowToast(txtPopup)
    return
  end
  self:CallUIMethod("UIN30EntrustLine", "CompleteEvent", self._event:ID(), function()
    local txtPopup = StringTable.Get("str_n30_entrust_event_tk_finish")
    ToastManager.ShowToast(txtPopup)
    self._finishEvent = true
    self:RootUIOwner():Refresh()
  end)
end

function UIN30EntrustEventTkSend:GetIcon()
  return self._event:ParamHead()
end

function UIN30EntrustEventTkSend:Refresh()
  local descValue = self._event:ParamDesc()
  if descValue == nil then
    descValue = ""
  else
    descValue = StringTable.Get(descValue)
  end
  self._txtDesc:SetText(descValue)
  local cfgItem, reward
  cfgItem, reward = self:GetRewardCfg()
  if cfgItem == nil then
    self._btnConfirm.gameObject:SetActive(false)
  else
    local itemModule = GameGlobal.GetModule(ItemModule)
    local haveCount = itemModule:GetItemCount(reward.assetid)
    local itemName = StringTable.Get(cfgItem.Name)
    local txtSend = StringTable.Get("str_n30_entrust_event_tk_send_btn", itemName, reward.count)
    local txtHave = StringTable.Get("str_n30_entrust_event_tk_send_btn_have", haveCount)
    self._txtConfirm:SetText(txtSend .. string.format("<color=#A4800F>%s</color>", txtHave))
    self._reward = reward
    self._haveCount = haveCount
  end
  self._btnConfirm.interactable = not self._event:IsPass()
end

function UIN30EntrustEventTkSend:GetRewardCfg()
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
