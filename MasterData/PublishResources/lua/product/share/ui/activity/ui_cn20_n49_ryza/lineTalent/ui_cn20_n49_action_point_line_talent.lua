_class("UICN20N49ActionPointLineTalent", UICustomWidget)
UICN20N49ActionPointLineTalent = UICN20N49ActionPointLineTalent

function UICN20N49ActionPointLineTalent:OnShow()
  self._isOpen = true
end

function UICN20N49ActionPointLineTalent:OnHide()
  self._isOpen = false
end

function UICN20N49ActionPointLineTalent:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UICN20N49ActionPointLineTalent:SetData(campaign, componentId, detailDialog, showTime, posControllerName)
  self._campaign = campaign
  self._componentId = componentId
  self._detailDialog = detailDialog
  self._showTime = showTime
  self._endTime_ActionPoint = nil
  self._posControllerName = posControllerName
  self:_SetActionPoint()
end

function UICN20N49ActionPointLineTalent:AttachEvents()
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UICN20N49ActionPointLineTalent:_SetActionPoint()
  local componentId = self._componentId
  local component = self._campaign:GetComponent(componentId)
  local icon = component:GetItemIcon()
  if icon then
    self:_SetIcon("_iconActionPoint", icon)
  end
  local n1, n2 = component:GetItemCount()
  self:_SetText("_txtActionPoint", n1 .. "/" .. n2)
  if self._showTime then
    local state_time = self:GetGameObject("state_time")
    local state_max = self:GetGameObject("state_max")
    state_time:SetActive(n1 < n2)
    state_max:SetActive(n2 <= n1)
    local endTime = component:GetRegainEndTime()
    if self._endTime_ActionPoint == endTime then
      Log.info("UICN20N49ActionPointLineTalent:_SetActionPoint() Same endTime")
    elseif n2 <= n1 then
      Log.info("UICN20N49ActionPointLineTalent:_SetActionPoint() n1 >= n2")
    else
      self._endTime_ActionPoint = endTime
      self:_SetRemainingTime_Action("_actionPointPool", "str_activity_common_next_action_point", endTime, nil, function()
        self:_ReloadAndRefreshActionPoint()
      end)
    end
  end
end

function UICN20N49ActionPointLineTalent:_ReloadAndRefreshActionPoint()
  Log.info("UICN20N49ActionPointLineTalent:_ReloadAndRefreshActionPoint()")
  self:StartTask(function(TT)
    YIELD(1)
    local res = AsyncRequestRes:New()
    self._campaign:ReLoadCampaignInfo_Force(TT, res)
    self:_SetActionPoint()
  end, self)
end

function UICN20N49ActionPointLineTalent:OnUIGetItemCloseInQuest(type)
  if self._isOpen then
    local res = AsyncRequestRes:New()
    self:StartTask(function(TT)
      self._campaign:ReLoadCampaignInfo_Force(TT, res)
      if res and res:GetSucc(true) then
        self:_Refresh()
      end
    end, self)
  end
end

function UICN20N49ActionPointLineTalent:_SetRemainingTime_Action(widgetName, descId, endTime, tickCallback, stopCallback)
  local obj = self:_SpawnObject(widgetName, "UIActivityCommonRemainingTime")
  obj:SetCustomTimeStr_Common_1()
  obj:SetExtraRollingText()
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, tickCallback, stopCallback)
end

function UICN20N49ActionPointLineTalent:_Refresh()
  self._endTime_ActionPoint = nil
  self:_SetActionPoint()
end

function UICN20N49ActionPointLineTalent:_SetIcon(widgetName, icon)
  widgetName = widgetName or "icon"
  local obj = self:GetUIComponent("Image", widgetName)
  obj.sprite = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas):GetSprite(icon)
end

function UICN20N49ActionPointLineTalent:_SetText(widgetName, str)
  widgetName = widgetName or "text"
  local obj = self:GetUIComponent("UILocalizationText", widgetName)
  obj:SetText(str)
end

function UICN20N49ActionPointLineTalent:ActionPointBtnOnClick(go)
  local componentId = self._componentId
  local component = self._campaign:GetComponent(componentId)
  self:ShowDialog(self._detailDialog, component, go.transform.anchoredPosition, nil, go, self._posControllerName)
end
