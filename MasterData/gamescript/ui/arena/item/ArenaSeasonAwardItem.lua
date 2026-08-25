local ArenaSeasonAwardItem, Super = System.NewComponent("ArenaSeasonAwardItem")

function ArenaSeasonAwardItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = Item_Season_AwardResource(uiNode)
  self.itemData = data
end

function ArenaSeasonAwardItem:OnBind(binder)
  self.binder = binder
  self:SetLabel()
  binder:BindToCircularListView(self.ui.ScrollView_Award, function()
    return self.itemData.award
  end, function(itemBinder, item, index)
    local itemId = self.itemData.award[index].tid
    local count = self.itemData.award[index].count
    assert(nil ~= itemId, "itemId is nil " .. index)
    assert(nil ~= count, "count is nil " .. index)
    itemBinder:BindComponent(ItemPublicArticle(item, itemId, count, false, false, false, nil))
  end)
end

function ArenaSeasonAwardItem:SetLabel()
  self.binder:SetText(self.ui.Text_Rank, self.itemData.title)
end

return ArenaSeasonAwardItem
