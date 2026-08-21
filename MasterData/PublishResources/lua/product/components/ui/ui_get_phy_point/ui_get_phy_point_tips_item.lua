_class("UIGetPhyPointTipsItem", UICustomWidget)
UIGetPhyPointTipsItem = UIGetPhyPointTipsItem

function UIGetPhyPointTipsItem:SetData(times, cost, icon)
  local iconRaw = self:GetUIComponent("RawImageLoader", "icon")
  local timesTex = self:GetUIComponent("UILocalizationText", "times")
  local costTex = self:GetUIComponent("UILocalizationText", "cost")
  iconRaw:LoadImage(icon)
  local timesStr
  if table.count(times) > 1 then
    local times1 = times[1]
    local times2 = times[2]
    if times1 < times2 - 0.1 then
      timesStr = times1 .. "~" .. times2
    else
      timesStr = times1
    end
  else
    timesStr = times[1]
  end
  timesTex:SetText(StringTable.Get("str_get_phy_point_times", timesStr))
  if times[3] then
    costTex:SetText(times[3])
  end
end
