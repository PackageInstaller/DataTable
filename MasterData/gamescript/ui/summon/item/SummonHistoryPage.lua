local ItemType = CommonDefine.ItemType
local SummonHistoryPage, Super = System.NewComponent("SummonHistoryPage")

function SummonHistoryPage:ctor(uiNode, introModel)
  Super.ctor(self)
  self.ui = UI_Summon_Popup_Detail_TipResource(uiNode)
  self.introModel = introModel
end

function SummonHistoryPage:OnBind(binder)
  local model = binder:createModel(SummonHistoryModel)
  self.model = model
  binder:BindToText(self.ui.Text_Page, function()
    do return LT.Text end
    return LT.Text, model.curPageNum
  end)
  binder:BindToText(self.ui.Text_Mtrl_Type, function()
    do return LT.Text end
    return LT.Text, "SummonTypeText_" .. model.curSummonType, model.curSummonType
  end)
  binder:BindToVisible(self.ui.Icon_Normal_UP, System.fn(self, self.NotReachFirstPage))
  binder:BindToVisible(self.ui.Icon_Disable_UP, System.fn(self, self.ReachFirstPage))
  binder:BindToVisible(self.ui.Icon_Normal_Down, System.fn(self, self.NotReachLastPage))
  binder:BindToVisible(self.ui.Icon_Disable_Down, System.fn(self, self.ReachLastPage))
  binder:BindToVisible(self.ui.Image_Sort, System.fn(self, self.HaveSummonCount))
  binder:BindToVisible(self.ui.ScrollView_Type, function()
    return model.showTypeList
  end)
  binder:BindToVisible(self.ui.Text_C_Not, System.fn(self, self.NotHaveSummonCount))
  binder:BindButtonClick(self.ui.Btn_Click_UP, System.fn(self, self.OnBtnClickUp))
  binder:BindButtonClick(self.ui.Btn_Click_Down, System.fn(self, self.OnBtnClickDown))
  binder:BindButtonClick(self.ui.Btn_Select_Mtrl_Type, System.fn(self, self.OnTypeListClick))
  binder:BindButtonClick(self.ui.Btn_Type_List_Mask, System.fn(self, self.OnCloseTypeList))
  self:OnBindSummonPoolTypeGroup(binder, model)
  self:OnBindSummonHistoryItemGroup(binder, model)
end

function SummonHistoryPage:OnBindSummonPoolTypeGroup(binder, model)
  binder:BindToCircularListView(self.ui.ScrollView_Type, function()
    return model.summonTypeList
  end, function(itemBinder, item, index)
    local summonType = model.summonTypeList[index]
    local itemData = {
      clickCb = function()
        SummonDataUtils.ReqSummonHistory(summonType, 1, function()
          model.SetCurSummonType(summonType)
          model.SetShowTypeList(false)
        end)
      end,
      summonType = summonType
    }
    itemBinder:BindComponent(SummonHistoryTypeItem(item, itemData))
  end)
end

function SummonHistoryPage:OnBindSummonHistoryItemGroup(binder, model)
  binder:BindToRaw(function(itemBinder)
    self.model.SetCurShowItemGroup(SummonDataUtils.GetSummonHistory(self.model.curSummonType, self.model.curPageNum))
    for i = 1, model.onePageShowNum do
      local obj = self.ui["UI_Summon_Item_Ranking_" .. i]
      local showData = model.curShowItemGroup[i]
      if showData then
        local summontype = showData.type
        local itemTid = showData.itemTid
        local itemCfg = DT.Item[itemTid]
        local timeStamp = showData.timestamp
        local itemType = itemCfg.Type == ItemType.AwakerItem and "Awaker" or itemCfg.Type
        local itemData = {
          itemTid = itemTid,
          itemType = LT.Text("ItemType_" .. itemType),
          poolType = LT.Text("SummonTypeText_" .. summontype),
          summonTime = TimeUtils.TimestampToString(timeStamp)
        }
        itemBinder:BindComponent(SummonHistoryContentItem(obj, itemData))
      end
      obj:SetActive(showData)
    end
  end, function()
    return {
      model.curPageNum,
      model.curSummonType,
      self.introModel.currPage
    }
  end)
end

function SummonHistoryPage:OnTypeListClick()
  local boolVal = false
  if not self.model.showTypeList then
    boolVal = true
  end
  self.model.SetShowTypeList(boolVal)
end

function SummonHistoryPage:OnBtnClickUp()
  self.model.SetCurPageNum(self.model.curPageNum - 1)
end

function SummonHistoryPage:OnBtnClickDown()
  if self.model.curPageNum ~= self.model.maxPageNum then
    SummonDataUtils.ReqSummonHistory(self.model.curSummonType, self.model.curPageNum + 1, function()
      self.model.SetCurPageNum(self.model.curPageNum + 1)
    end)
  end
end

function SummonHistoryPage:OnCloseTypeList()
  self.model.SetShowTypeList(false)
end

function SummonHistoryPage:ReachFirstPage()
  return self.model.curPageNum == self.model.minPageNum
end

function SummonHistoryPage:NotReachFirstPage()
  return self.model.curPageNum ~= self.model.minPageNum
end

function SummonHistoryPage:ReachLastPage()
  return self.model.curPageNum == self.model.maxPageNum
end

function SummonHistoryPage:NotReachLastPage()
  return self.model.curPageNum ~= self.model.maxPageNum
end

function SummonHistoryPage:HaveSummonCount()
  return 0 ~= SummonDataUtils.GetSummonHistoryCount(self.model.curSummonType)
end

function SummonHistoryPage:NotHaveSummonCount()
  return 0 == SummonDataUtils.GetSummonHistoryCount(self.model.curSummonType)
end

return SummonHistoryPage
