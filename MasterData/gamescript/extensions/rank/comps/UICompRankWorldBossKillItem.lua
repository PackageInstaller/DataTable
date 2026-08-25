local UICompRankWorldBossKillItem, Super = NewViewComponent("UICompRankWorldBossKillItem", UICompRankBaseItem)

function UICompRankWorldBossKillItem:ctor(uiNode, view, rankMO)
  Super.ctor(self, uiNode, view, rankMO)
  self.ui = UI_Events_Item_KillRankResource(uiNode)
end

function UICompRankWorldBossKillItem:_GetNameTextNode()
  return self.ui.Text_Name
end

function UICompRankWorldBossKillItem:_GetUidTextNode()
  return self.ui.Text_Uid
end

function UICompRankWorldBossKillItem:_GetScoreTextNode()
  return self.ui.Text_KillCount
end

function UICompRankWorldBossKillItem:_GetRankIdxTextNode()
  return self.ui.Text_Ranking
end

return UICompRankWorldBossKillItem
