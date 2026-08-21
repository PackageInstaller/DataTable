_class("UIStageWordTips", UIController)
UIStageWordTips = UIStageWordTips

function UIStageWordTips:OnShow(uiParams)
  self._offset = self:GetUIComponent("RectTransform", "offset")
  self._Content = self:GetUIComponent("UISelectObjectPath", "Content")
  local data = uiParams[1]
  local count = #data
  self._Content:SpawnObjects("UIStageWordItem", count)
  local pools = self._Content:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    local tex = data[i]
    item:SetData(tex)
  end
end

function UIStageWordTips:BgOnClick()
  self:CloseDialog()
end
