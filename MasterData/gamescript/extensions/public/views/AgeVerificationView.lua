local YEAR_VERIFICATION_RAGE = 100
local DEFAULT_YEAR = 1990
local DEFAULT_MONTH = 1
local SCROLL_DEFAULT_POS_X = -133
local SCROLL_DEFAULT_POS_Y = -24
local AgeVerificationView, Super = NewClass("AgeVerificationView", BaseView)
AgeVerificationView.uiResCls = UI_Recharge_BirthRegistrationResource

function AgeVerificationView:ctor(callback)
  Super.ctor(self)
  self.callback = callback
  self:InitViewData()
end

function AgeVerificationView:OnEnterView()
  local limitInfoList = ConstantCfgUtils.GetMonthlySpendingLimitsInfo()
  local limitInfo1, limitInfo2 = limitInfoList[1], limitInfoList[2]
  self:SetText(self.ui.Text_AgeRang_1, LT.Textf("VerificationAgeFormat1", limitInfo1.maxAge))
  self:SetText(self.ui.Text_AgeRang_2, LT.Textf("VerificationAgeFormat2", limitInfo2.minAge, limitInfo2.maxAge))
  self:SetText(self.ui.Text_AgeInfo_1, LT.Textf("VerificationAgeLimit", limitInfo1.limitNum))
  self:SetText(self.ui.Text_AgeInfo_2, LT.Textf("VerificationAgeLimit", limitInfo2.limitNum))
  self:RefreshView()
end

function AgeVerificationView:RegisterEvents()
  self:_CreateTableView()
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self.OnClickConfirm))
  self:AddZ1ToggleValueChangedListener(self.ui.Group_Year, System.fn(self, self._OnToggleGroupYear))
  self:AddZ1ToggleValueChangedListener(self.ui.Group_Month, System.fn(self, self._OnToggleMonthYear))
end

function AgeVerificationView:OnClickConfirm()
  Alert.Show(20162, nil, function()
    if self.callback then
      local birthDayStr = string.format("%d%02d%02d", self.year, self.month, 1)
      self.callback(birthDayStr)
      self.callback = nil
    end
    PlayerDataUtils.ReqOnSetAge(self.year, self.month, function()
      Super.Close(self)
    end)
  end)
end

function AgeVerificationView:Close()
  Super.Close(self)
  Alert.Show(20164)
  UIManager.Instance:Reopen(Urls.AgeVerificationView)
end

function AgeVerificationView:_OnToggleGroupYear(isOn)
  self:_SetScrollViewAcitve(self.ui.ScrollView_Year.transform, isOn)
  self:YearListJump()
end

function AgeVerificationView:_OnToggleMonthYear(isOn)
  self:_SetScrollViewAcitve(self.ui.ScrollView_Month.transform, isOn)
  self:MonthListJump()
end

function AgeVerificationView:_CreateTableView()
  local cellTrans = self.ui.UI_Social_Dropdown_Item.transform
  local width, height = cellTrans.sizeDelta.x, cellTrans.sizeDelta.y
  self.yearListView = self:CreateTableview(self.ui.ScrollView_Year, function()
    return #self.yearList
  end, function(view, index)
    do return self._YearCellAtIndex, self, view end
    return self._YearCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
  self.yearListView:ReloadData()
  self.monthListView = self:CreateTableview(self.ui.ScrollView_Month, function()
    return #self.monthList
  end, function(view, index)
    do return self._MonthCellAtIndex, self, view end
    return self._MonthCellAtIndex, self, view, index
  end, function()
    return width, height
  end)
  self.monthListView:ReloadData()
end

function AgeVerificationView:_YearCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Social_Dropdown_Item)
  local year = self.yearList[index]
  local ui = UI_Social_Dropdown_ItemResource(cell.gameObject)
  local textColor = year == self.year and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark
  self:SetText(ui.Text_Drop_Item_Tips, year)
  self:SetTextColorType(ui.Text_Drop_Item_Tips, textColor)
  self:SetActive(ui.Group_Nor, year ~= self.year)
  self:SetActive(ui.Group_Sel, year == self.year)
  self:AddButtonClickListener(ui.Btn_Click, function()
    self:SetYear(year)
  end)
  return cell
end

function AgeVerificationView:_MonthCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Social_Dropdown_Item)
  local month = self.monthList[index]
  local ui = UI_Social_Dropdown_ItemResource(cell.gameObject)
  local textColor = month == self.month and CommonDefine.ColorType.Light or CommonDefine.ColorType.Dark
  self:SetText(ui.Text_Drop_Item_Tips, month)
  self:SetTextColorType(ui.Text_Drop_Item_Tips, textColor)
  self:SetActive(ui.Group_Nor, month ~= self.month)
  self:SetActive(ui.Group_Sel, month == self.month)
  self:AddButtonClickListener(ui.Btn_Click, function()
    self:SetMonth(month)
  end)
  return cell
end

function AgeVerificationView:InitViewData()
  self.year = DEFAULT_YEAR
  self.month = DEFAULT_MONTH
  self.yearList = {}
  self.monthList = {}
  local date = TimeUtils.GetServerDate(TimeUtils.GetServerTime())
  local maxYear = date.year
  local minYear = maxYear - YEAR_VERIFICATION_RAGE
  for i = minYear, maxYear do
    table.insert(self.yearList, i)
  end
  for i = 1, 12 do
    table.insert(self.monthList, i)
  end
end

function AgeVerificationView:SetYear(numVal)
  self.year = numVal
  self:RefreshView()
  self.yearListView:ReloadData()
  self:SetZ1Toggle(self.ui.Group_Year, false)
end

function AgeVerificationView:SetMonth(numVal)
  self.month = numVal
  self:RefreshView()
  self.monthListView:ReloadData()
  self:SetZ1Toggle(self.ui.Group_Month, false)
end

function AgeVerificationView:_SetScrollViewAcitve(scroll, isActive)
  if isActive then
    CS.Framework.TransformUtil.SetLocalPos(scroll, SCROLL_DEFAULT_POS_X, SCROLL_DEFAULT_POS_Y, 0)
  else
    CS.Framework.TransformUtil.SetLocalPos(scroll, 9999, 9999, 0)
  end
end

function AgeVerificationView:RefreshView()
  self:SetText(self.ui.Text_Year_Tips, self.year)
  self:SetText(self.ui.Text_Month_Tips, self.month)
end

function AgeVerificationView:YearListJump()
  self:_ListJump(self.yearList, self.year, self.yearListView)
end

function AgeVerificationView:MonthListJump()
  self:_ListJump(self.monthList, self.month, self.monthListView)
end

function AgeVerificationView:_ListJump(list, targetVal, listView)
  local jumpIdx = 1
  for idx, val in ipairs(list) do
    if val == targetVal then
      jumpIdx = idx
      break
    end
  end
  local offset = listView:GetOffsetByIndex(jumpIdx - 1)
  listView:SetOffset(offset, false)
  if listView.isReady then
    listView:SetOffset(offset, false)
  else
    function listView.reloadFinishCallback()
      listView.reloadFinishCallback = nil
      
      listView:SetOffset(offset, false)
    end
  end
end

return AgeVerificationView
