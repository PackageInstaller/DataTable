local SummonHistoryContentItem, Super = System.NewComponent("SummonHistoryContentItem")

function SummonHistoryContentItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Summon_Item_RankingResource(uiNode)
  self.itemType = data.itemType
  self.poolType = data.poolType
  self.itemTid = data.itemTid
  self.summonTime = data.summonTime
end

function SummonHistoryContentItem:OnBind(binder)
  binder:BindToText(self.ui.Text_Time, function()
    do return LT.Text end
    return LT.Text, self.summonTime
  end)
  binder:BindToText(self.ui.Text_Name, function()
    local config = ItemDataUtils.GetItemConfig(self.itemTid)
    do return LT.Text end
    return LT.Text, config.Name
  end)
  binder:BindToTextColorOld(self.ui.Text_Name, function()
    local config = ItemDataUtils.GetItemConfig(self.itemTid)
    if config.Quality then
      if config.Quality ~= CommonDefine.CommonQuality.Blue then
        return "#" .. DT.ItemQuality[config.Quality].ItemNameColor
      else
        return CommonDefine.TaskConditionTextColor.NotAchieveColor
      end
    end
    return nil
  end)
  binder:BindToText(self.ui.Text_Role, function()
    do return LT.Text end
    return LT.Text, self.poolType
  end)
  binder:BindToText(self.ui.Text_Type, function()
    do return LT.Text end
    return LT.Text, self.itemType
  end)
end

return SummonHistoryContentItem
