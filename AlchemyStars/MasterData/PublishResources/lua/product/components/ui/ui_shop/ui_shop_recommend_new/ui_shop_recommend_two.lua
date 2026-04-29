_class("UIShopRecommendTwo", UICustomWidget)
UIShopRecommendTwo = UIShopRecommendTwo

function UIShopRecommendTwo:OnShow()
  self._idx2pos = {
    [1] = Vector2(38, 22),
    [2] = Vector2(-200, -33)
  }
  self:GetComponents()
end

function UIShopRecommendTwo:SetData(data)
  self.data = data
  local len = #self.data.list
  if 2 < len then
    len = 2
  end
  self._pool:SpawnObjects("UIShopRecommendTwoItem", len)
  local pools = self._pool:GetAllSpawnList()
  for i = 1, len do
    local item = pools[i]
    local pos = self._idx2pos[i]
    item:SetData(i, self.data, pos, self.callback)
  end
end

function UIShopRecommendTwo:SetCallback(callback)
  self.callback = callback
end

function UIShopRecommendTwo:GetComponents()
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
end
