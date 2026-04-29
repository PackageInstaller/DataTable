_class("UIFeatureAutoBeadInfo", UIController)
UIFeatureAutoBeadInfo = UIFeatureAutoBeadInfo

function UIFeatureAutoBeadInfo:OnShow(uiParams)
  self:InitWidget()
  self:_RefreshContent()
end

function UIFeatureAutoBeadInfo:InitWidget()
  self._TitleText = self:GetUIComponent("UILocalizationText", "TitleText")
  self._PowerFlagText = self:GetUIComponent("UILocalizationText", "PowerFlagText")
  self._PowerDetailText = self:GetUIComponent("UILocalizationText", "PowerDetailText")
  self._BeadList = self:GetUIComponent("UISelectObjectPath", "BeadList")
  self._itemTips = self:GetUIComponent("UISelectObjectPath", "ItemTips")
  self._tips = self._itemTips:SpawnObject("UIInnerAutoBeadTips")
end

function UIFeatureAutoBeadInfo:DotBGOnClick()
  self:CloseDialog()
end

function UIFeatureAutoBeadInfo:_RefreshContent()
  local curPoint, pointToPower = InnerGameHelperRender.GetCurAutoBeadPowerInfo()
  curPoint = math.floor(curPoint)
  pointToPower = math.floor(pointToPower)
  local uiRestPoint = 0
  local uiPower = 0
  local uiPercent = 0
  if pointToPower <= 0 then
    uiPower = 0
    uiRestPoint = curPoint
    uiPercent = 0
  else
    uiPower = math.floor(curPoint / pointToPower)
    uiRestPoint = math.floor(curPoint - uiPower * pointToPower)
    uiPercent = math.floor(uiRestPoint / pointToPower * 100)
  end
  local fmt = "<color=#28ffb0>%s</color>/%s (<color=#28ffb0>%s%%</color>)"
  local str = string.format(fmt, tostring(curPoint), tostring(pointToPower), tostring(uiPercent))
  self._PowerDetailText:SetText(str)
  local flagStr = StringTable.Get("str_season_maze_energy")
  flagStr = flagStr .. ":"
  self._PowerFlagText:SetText(flagStr)
  local beadList = InnerGameHelperRender.GetAutoBeadList()
  if beadList then
    local slotCount = #beadList
    if 0 < slotCount then
      self._BeadList:SpawnObjects("UIWidgetInnerAutoBeadItem", slotCount)
      self._slotWidgets = self._BeadList:GetAllSpawnList()
      for key, value in ipairs(self._slotWidgets) do
        local data = beadList[key]
        value:SetData(key, data, function(uid, id, data, position)
          self:ShowTips(uid, id, data, position)
        end)
      end
    end
  end
end

function UIFeatureAutoBeadInfo:ShowTips(uid, id, data, position)
  self._tips:SetData(uid, id, data, position)
end
