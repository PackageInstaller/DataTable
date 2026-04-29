_class("UICollectCardOpen", UIController)
UICollectCardOpen = UICollectCardOpen

function UICollectCardOpen:OnShow(uiParam)
  self._cardMap = uiParam[1]
  self:SortCards()
  self:GetComponents()
  self:OnValue()
end

function UICollectCardOpen:SortCards()
  self._cards = {}
  for key, value in pairs(self._cardMap) do
    for i = 1, value do
      local cardid = key
      table.insert(self._cards, cardid)
    end
  end
  table.sort(self._cards, function(a, b)
    local cfg_a = Cfg.cfg_component_collect_card[a]
    local cfg_b = Cfg.cfg_component_collect_card[b]
    if cfg_a.Type == cfg_b.Type then
      return a < b
    else
      return cfg_a.Type == 2
    end
  end)
end

function UICollectCardOpen:GetComponents()
  self._pool = self:GetUIComponent("UISelectObjectPath", "Pool")
  self._ScrollRect = self:GetUIComponent("Transform", "Pool").parent.parent.gameObject:GetComponent("ScrollRect")
end

function UICollectCardOpen:OnValue()
  self:SetPool()
end

function UICollectCardOpen:SetPool()
  self._pool:SpawnObjects("UICollectCardOpenItem", #self._cards)
  local pools = self._pool:GetAllSpawnList()
  for i = 1, #self._cards do
    local item = pools[i]
    local id = self._cards[i]
    item:SetData(i, id)
  end
  self._ScrollRect.enabled = #self._cards > 15
end

function UICollectCardOpen:BtnOnClick(go)
  self:CloseDialog()
end
