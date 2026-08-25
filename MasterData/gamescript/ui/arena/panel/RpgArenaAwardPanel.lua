local RpgArenaAwardPanel, Super = System.NewClass("RpgArenaAwardPanel", UIBasePanel)
RpgArenaAwardPanel.uiResCls = Popup_Award_DetailResource

function RpgArenaAwardPanel:ctor()
  Super.ctor(self)
  self:InitData()
end

function RpgArenaAwardPanel:InitData()
end

function RpgArenaAwardPanel:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Confirm, System.fn(self, self.BtnConfirmClick))
  self:BindToggle()
  self:BindScrollView()
  binder:SetZ1Toggle(self.ui.Btn_Day_Award, true)
end

function RpgArenaAwardPanel:BindToggle()
  local binder = self.binder
  binder:BindToZ1Toggle(self.ui.Btn_Day_Award, self.ui.ScrollView_Day_Award, function(isOn)
    if isOn then
      binder:ListViewJumpToIndex(self.ui.ScrollView_Day_Award, 1)
    end
  end)
  binder:BindToZ1Toggle(self.ui.Btn_Season_Award, self.ui.ScrollView_Season_Award, function(isOn)
    if isOn then
      binder:ListViewJumpToIndex(self.ui.ScrollView_Season_Award, 1)
    end
  end)
  binder:BindToZ1Toggle(self.ui.Btn_All_Award, self.ui.ScrollView_All_Award, function(isOn)
    if isOn then
      binder:ListViewJumpToIndex(self.ui.ScrollView_All_Award, 1)
    end
  end)
end

local function GetTitleStr(data)
  if data.title then
    return data.title
  else
    local low = data.UpperLimit
    local high = data.LowerLimit
    if low == high then
      do return string.format, (LT.Text("RPGJJC_Str_Ranking")) end
      return string.format, LT.Text("RPGJJC_Str_Ranking"), low, nil
    else
      local str = string.format("%d~%d", low, high)
      do return string.format, (LT.Text("RPGJJC_Str_Ranking")) end
      return string.format, LT.Text("RPGJJC_Str_Ranking"), str
    end
  end
end

function RpgArenaAwardPanel:BindScrollView()
  local binder = self.binder
  binder:BindNormalListView(self.ui.ScrollView_Day_Award, function()
    return self.dayAward
  end, function(index)
    local data = self.dayAward[index]
    return data.prefab or "Item_Season_Award"
  end, function(itemBinder, item, index)
    local data = self.dayAward[index]
    local prefabName = data.prefab or "Item_Season_Award"
    if "Item_Season_Award" == prefabName then
      local itemData = {}
      itemData.title = data.title or GetTitleStr(data)
      itemData.award = {
        {
          tid = data.ItemID,
          count = data.ItemNum
        }
      }
      itemBinder:BindComponent(ArenaSeasonAwardItem(item, itemData))
    else
      itemBinder:BindComponent(ArenaDayAwardItem(item, data))
    end
  end)
  binder:BindNormalListView(self.ui.ScrollView_Season_Award, function()
    return self.seasonAward
  end, function(index)
    local data = self.seasonAward[index]
    return data.prefab or "Item_Season_Award"
  end, function(itemBinder, item, index)
    local data = self.seasonAward[index]
    local prefabName = data.prefab or "Item_Season_Award"
    if "Item_Season_Award" == prefabName then
      local itemData = {}
      itemData.title = data.title or GetTitleStr(data)
      itemData.award = {
        {
          tid = data.ItemID,
          count = data.ItemNum
        }
      }
      itemBinder:BindComponent(ArenaSeasonAwardItem(item, itemData))
    else
      itemBinder:SetText(item, data.desc)
    end
  end)
  binder:BindNormalListView(self.ui.ScrollView_All_Award, function()
    return self.allAward
  end, function(index)
    local data = self.allAward[index]
    local prefabName = data.prefab or "Item_Season_Award"
    return prefabName
  end, function(itemBinder, item, index)
    local data = self.allAward[index]
    local prefabName = data.prefab or "Item_Season_Award"
    if "Item_Season_Award" == prefabName then
      local itemData = {}
      itemData.title = data.title or GetTitleStr(data)
      itemData.award = {
        {
          tid = data.ItemID,
          count = data.ItemNum
        }
      }
      itemBinder:BindComponent(ArenaSeasonAwardItem(item, itemData))
    else
      itemBinder:SetText(item, data.desc)
    end
  end)
end

function RpgArenaAwardPanel:BtnConfirmClick()
  self:Close()
end

return RpgArenaAwardPanel
