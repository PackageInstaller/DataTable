_class("UIShopSailingAwardsView", UIController)
UIShopSailingAwardsView = UIShopSailingAwardsView

function UIShopSailingAwardsView:Constructor()
end

function UIShopSailingAwardsView:OnShow(uiParams)
  self._awardsNormal = uiParams[1]
  self._awardsAll = uiParams[2]
  self:GetComponents()
  self:OnValue()
end

function UIShopSailingAwardsView:GetComponents()
  self._poolsNormal = self:GetUIComponent("UISelectObjectPath", "poolsNormal")
  self._poolsAll = self:GetUIComponent("UISelectObjectPath", "poolsAll")
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
end

function UIShopSailingAwardsView:OnValue()
  local count = #self._awardsNormal
  self._poolsNormal:SpawnObjects("UIShopSailingPlanItem", count)
  local awardsNormal = self._poolsNormal:GetAllSpawnList()
  for i = 1, count do
    local item = awardsNormal[i]
    local award = self._awardsNormal[i]
    local yieldTime = (i - 1) // 2 * 50
    item:SetData(i, award, function(id, pos)
      self:ItemOnClick(id, pos)
    end, nil, nil, nil, yieldTime, true, false, 0.9)
  end
  local count2 = #self._awardsAll
  self._poolsAll:SpawnObjects("UIShopSailingPlanItem", count2)
  local awardsAll = self._poolsAll:GetAllSpawnList()
  for i = 1, count2 do
    local item = awardsAll[i]
    local yieldTime = (i - 1) // 3 * 50
    local award = self._awardsAll[i]
    item:SetData(i, award, function(id, pos)
      self:ItemOnClick(id, pos)
    end, nil, nil, nil, yieldTime, true, false, 0.9)
  end
end

function UIShopSailingAwardsView:ItemOnClick(id, pos)
  if self._tips then
    self._tips:SetData(id, pos)
  end
end

function UIShopSailingAwardsView:OnHide()
end

function UIShopSailingAwardsView:BgOnClick(go)
  self:CloseDialog()
end
