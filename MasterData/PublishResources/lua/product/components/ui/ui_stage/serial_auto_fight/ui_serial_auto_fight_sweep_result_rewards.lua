_class("UISerialAutoFightSweepResultRewards", UICustomWidget)
UISerialAutoFightSweepResultRewards = UISerialAutoFightSweepResultRewards

function UISerialAutoFightSweepResultRewards:OnShow()
  self._listData = {}
  self._curProgress = 0
end

function UISerialAutoFightSweepResultRewards:OnHide()
end

function UISerialAutoFightSweepResultRewards:SetStyleUI(styleName)
  self._styleName = styleName
  UISerialAutoFightStyleHelper.FitStyle_Widget(self._styleName, "line01", self, "_line")
  UISerialAutoFightStyleHelper.FitStyle_Widget(self._styleName, "titleColor", self, "_txtTitle")
  UISerialAutoFightStyleHelper.FitStyle_Widget(self._styleName, "titleColor", self, "_txtProgress")
end

function UISerialAutoFightSweepResultRewards:SetData(maxProgress, tipsCallback)
  self._tipsCallback = tipsCallback
  self._listData = {}
  self._curProgress = 0
  self._maxProgress = maxProgress
  self:_SetProgress(self._curProgress, self._maxProgress)
end

function UISerialAutoFightSweepResultRewards:Refresh(curProgress, matchRes)
  if curProgress ~= #self._listData + 1 then
    Log.error("UISerialAutoFightSweepResultRewards:Refresh() curProgress wrong")
    return
  end
  self._curProgress = curProgress
  self:_SetProgress(self._curProgress, self._maxProgress)
  table.insert(self._listData, matchRes)
  self:_SetDynamicList()
  self:_DynamicListPlayAnimation()
end

function UISerialAutoFightSweepResultRewards:_SetProgress(curProgress, maxProgress)
  local str = StringTable.Get("str_battle_auto_fight_sweep_progress", curProgress, maxProgress)
  UIWidgetHelper.SetLocalizationText(self, "_txtProgress", str)
end

function UISerialAutoFightSweepResultRewards:_GetRewards(matchRes)
  local allRewards = {}
  self:_AppendRewards(allRewards, "m_activity_rewards", matchRes.m_activity_rewards)
  self:_AppendRewards(allRewards, "m_back_rewards", matchRes.m_back_rewards)
  self:_AppendRewards(allRewards, "m_vecAwardNormal", matchRes.m_vecAwardNormal)
  self:_AppendRewards(allRewards, "m_vecAwardPerfect", matchRes.m_vecAwardPerfect)
  self:_AppendRewards(allRewards, "m_vecExtAward", matchRes.m_vecExtAward)
  self:_AppendRewards(allRewards, "m_vecDoubleExtAward", matchRes.m_vecDoubleExtAward)
  self:_AppendRewards(allRewards, "m_vecFirstPassAward", matchRes.m_vecFirstPassAward)
  self:_AppendRewards(allRewards, "m_coin_ext_rewards", matchRes.m_coin_ext_rewards)
  return allRewards
end

function UISerialAutoFightSweepResultRewards:_AppendRewards(tb, type, rewards)
  rewards = rewards or {}
  self:_RemoveExp(rewards)
  local itemModule = GameGlobal.GetModule(ItemModule)
  itemModule:BattleResultSortAsset(rewards)
  for i, roleAsset in ipairs(rewards) do
    table.insert(tb, {type = type, roleAsset = roleAsset})
  end
end

function UISerialAutoFightSweepResultRewards:_RemoveExp(rewards)
  local eraseIDList = {}
  for i, roleAsset in ipairs(rewards) do
    if roleAsset.assetid == RoleAssetID.RoleAssetExp then
      table.insert(eraseIDList, roleAsset)
    end
  end
  for i, v in ipairs(eraseIDList) do
    table.removev(rewards, v)
  end
end

function UISerialAutoFightSweepResultRewards:_SetDynamicList(matchRes)
  local svRect = self:GetUIComponent("ScrollRect", "DynamicList")
  if not self._dynamicListHelper then
    self._dynamicList = self:GetUIComponent("UIDynamicScrollView", "DynamicList")
    self._dynamicListHelper = UIActivityDynamicListHelper:New(self, self._dynamicList, "UISerialAutoFightSweepResultItem", function(listItem, itemIndex)
      listItem:SetStyleUI(self._styleName)
      local rewards = self:_GetRewards(self._listData[itemIndex])
      listItem:SetData(#self._listData, itemIndex, rewards, svRect, self._tipsCallback)
    end)
  end
  local itemCount = #self._listData
  local itemCountPerRow = 1
  self._dynamicListHelper:Refresh(itemCount, itemCountPerRow)
  self._dynamicList:MovePanelToItemIndex(itemCount, 0)
end

function UISerialAutoFightSweepResultRewards:_DynamicListPlayAnimation()
  local tb = self._dynamicListHelper:GetVisibleItem()
  for _, v in ipairs(tb) do
    v.item:PlayAnimationIn(v.index)
  end
end
