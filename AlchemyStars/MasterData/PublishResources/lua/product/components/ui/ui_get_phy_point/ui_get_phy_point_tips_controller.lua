_class("UIGetPhyPointTipsController", UIController)
UIGetPhyPointTipsController = UIGetPhyPointTipsController

function UIGetPhyPointTipsController:OnShow(uiParams)
  self._right_data = uiParams[1]
  local rightList = {}
  for index, value in ipairs(self._right_data.begin_end) do
    local _values = string.split(value, "|")
    local _times_01 = tonumber(_values[1])
    local _times_02 = tonumber(_values[2])
    local _cost = tonumber(_values[3])
    local times = {}
    times[1] = _times_01
    times[2] = _times_02
    times[3] = _cost
    table.insert(rightList, times)
  end
  self._pools = self:GetUIComponent("UISelectObjectPath", "rect")
  self._tipsContent = self:GetUIComponent("UILocalizationText", "txt")
  local maxCount = self._right_data.max_times
  self._tipsContent:SetText(StringTable.Get("str_get_phy_point_bug_tips_content", maxCount))
  local count = table.count(rightList)
  self._pools:SpawnObjects("UIGetPhyPointTipsItem", count)
  local items = self._pools:GetAllSpawnList()
  for i = 1, #items do
    local item = items[i]
    local costID = self._right_data.cost_id
    local cfg_item = Cfg.cfg_item[costID]
    local times = rightList[i]
    local cost = self._right_data.cost_count
    local icon = cfg_item.Icon
    item:SetData(times, cost, icon)
  end
end

function UIGetPhyPointTipsController:bgOnClick()
  self:CloseDialog()
end
