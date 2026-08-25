local SummonIntroUpPageItem, Super = System.NewComponent("SummonIntroUpPageItem")

function SummonIntroUpPageItem:ctor(uiNode, info)
  Super.ctor(self)
  self.ui = UI_Summon_Item_Awaker_NewResource(uiNode)
  self.info = info
end

function SummonIntroUpPageItem:OnBind(binder)
  binder:SetText(self.ui.Text_Title, self.info.title)
  binder:BindToCircularListView(self.ui.ScrollView, function()
    return self.info.tidList
  end, function(itemBinder, uiNode, index)
    local tid = self.info.tidList[index]
    local config = ItemDataUtils.GetItemConfig(tid)
    local itemUI = UI_Summon_Item_InfoResource(uiNode)
    itemBinder:SetText(itemUI.Text_Name, LT.Text(config.Name))
    local itemData = {
      itemTid = tid,
      clickFunc = function()
        if ItemDataUtils.GetItemType(tid) == CommonDefine.ItemType.AwakerItem then
          local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(tid)
          AwakerDataUtils.JumpToSingleAwakerPanel(CommonDefine.AwakerPage.Detail, awakerTid)
          return
        end
        ItemDataUtils.ShowItemDetailTips(binder, itemUI.uiNode, nil, tid)
      end
    }
    binder:BindComponent(CommonIconItemType2(itemUI.UI_Common_Item_WuPin_Type2, itemData))
  end)
end

return SummonIntroUpPageItem
