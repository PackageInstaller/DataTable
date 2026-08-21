_class("UIDrawCardAwardConversionOneItem", UICustomWidget)
UIDrawCardAwardConversionOneItem = UIDrawCardAwardConversionOneItem

function UIDrawCardAwardConversionOneItem:OnShow()
  self._drawCardAwardConversionRefMap = {
    [1] = "one",
    [2] = "two",
    [3] = "three",
    [4] = "four",
    [5] = "five"
  }
  self.detail = self:GetUIComponent("UISelectObjectPath", "detail")
  self.detailLayout = self:GetUIComponent("GridLayoutGroup", "detail")
  self.topText = self:GetGameObject("topText")
end

function UIDrawCardAwardConversionOneItem:SetData(data, index, callback)
  local conversecfg = Cfg.cfg_drawcard_conversion_data
  local key = self._drawCardAwardConversionRefMap[index]
  local itemdata = data[key]
  local count = #itemdata
  self.detail:SpawnObjects("UIDrawCardAwardConversionOneDetailItem", count)
  if count == 2 then
    self.topText:SetActive(false)
    self.detailLayout.padding.top = 0
  else
    self.topText:SetActive(true)
  end
  local items = self.detail:GetAllSpawnList()
  for index, value in ipairs(items) do
    value:SetData(itemdata[index])
  end
end

function UIDrawCardAwardConversionOneItem:OnHide()
end
