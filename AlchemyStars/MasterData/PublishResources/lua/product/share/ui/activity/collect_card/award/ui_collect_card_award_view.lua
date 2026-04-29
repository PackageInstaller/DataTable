_class("UICollectCardAwardView", UIController)
UICollectCardAwardView = UICollectCardAwardView

function UICollectCardAwardView:OnShow(uiParam)
  self._cfg = uiParam[1]
  self:GetComponents()
  self:OnValue()
end

function UICollectCardAwardView:GetComponents()
  self._pool = self:GetUIComponent("UISelectObjectPath", "Pool")
  local selectInfo = self:GetUIComponent("UISelectObjectPath", "selectInfo")
  self.tips = selectInfo:SpawnObject("UISelectInfo")
end

function UICollectCardAwardView:OnValue()
  self:SetPool()
end

function UICollectCardAwardView:SetPool()
  local rewards = self._cfg.Rewards
  self._pool:SpawnObjects("UICollectCardAwardViewItem", #rewards)
  local pools = self._pool:GetAllSpawnList()
  for i = 1, #rewards do
    local item = pools[i]
    local id = rewards[i][1]
    local count = rewards[i][2]
    item:SetData(id, count, function(id, pos)
      self:OnItemClick(id, pos)
    end)
  end
end

function UICollectCardAwardView:OnItemClick(id, pos)
  self.tips:SetData(id, pos)
end

function UICollectCardAwardView:BtnOnClick(go)
  self:CloseDialog()
end
