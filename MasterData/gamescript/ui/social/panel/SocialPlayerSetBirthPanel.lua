local Max_Month = 12
local Max_Day = 31
local SocialPlayerSetBirthPanel, Super = System.NewClass("SocialPlayerSetBirthPanel", UIBasePanel)
SocialPlayerSetBirthPanel.uiResCls = UI_Social_Popup_BirthdayResource

function SocialPlayerSetBirthPanel:ctor(curBirthday, callback)
  Super.ctor(self)
  self:_InitBirthData(curBirthday)
  self.callback = callback
end

function SocialPlayerSetBirthPanel:_InitBirthData(curBirthday)
  self.month = Vue.ref(1)
  self.day = Vue.ref(1)
  self.months = {}
  self.days = {}
  for m = 1, Max_Month do
    table.insert(self.months, m)
  end
  for d = 1, Max_Day do
    table.insert(self.days, d)
  end
  if not curBirthday or "" == curBirthday then
    return
  end
  local infoArr = string.split(curBirthday, "-")
  local month = tonumber(infoArr[1])
  local day = tonumber(infoArr[2])
  self.month.value = month or self.month.value
  self.day.value = day or self.day.value
end

function SocialPlayerSetBirthPanel:OnBind(binder)
  self.binder = binder
  self:_BindPopupComp(binder)
  self:_BindScrollView(binder)
  self:_BindToggles(binder)
  self:_UpdateBirthText()
end

function SocialPlayerSetBirthPanel:_BindPopupComp(binder)
  local confirmBtnTipsData = {
    clickFunc = System.fn(self, self._OnClickConfirm)
  }
  local cancelBtnTipsData = {
    clickFunc = System.fn(self, self.Close)
  }
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.S,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData,
    textTitleCN = "SocialSystemSetBirthday",
    maskClickFunc = function()
    end
  }
  binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_S, commonPopupConfirmTipsData))
end

function SocialPlayerSetBirthPanel:_BindScrollView(binder)
  binder:SetActive(self.ui.ScrollView_Month, false)
  binder:SetActive(self.ui.ScrollView_Day, false)
  binder:BindToCircularListView(self.ui.ScrollView_Month, function()
    return self.months
  end, function(binder, obj, index)
    local month = self.months[index]
    local ui = UI_Social_Dropdown_ItemResource(obj)
    
    local function _OnClick()
      self.month.value = month
      binder:SetZ1Toggle(self.ui.Group_Month, false)
      self:_UpdateMonth()
    end
    
    local function _GetTextColor()
      if month == self.month.value then
        return CommonDefine.ColorType.Light
      end
      return CommonDefine.ColorType.Dark
    end
    
    binder:UpdateLocalizedTextAndResouce(obj)
    binder:SetText(ui.Text_Drop_Item_Tips, month)
    binder:BindToVisible(ui.Group_Nor, function()
      return month ~= self.month.value
    end)
    binder:BindToVisible(ui.Group_Sel, function()
      return month == self.month.value
    end)
    binder:BindToTextColor(ui.Text_Drop_Item_Tips, _GetTextColor)
    binder:BindButtonClick(ui.Btn_Click, _OnClick)
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Day, function()
    return self.days
  end, function(binder, obj, index)
    local day = self.days[index]
    local ui = UI_Social_Dropdown_ItemResource(obj)
    
    local function _OnClick()
      self.day.value = day
      binder:SetZ1Toggle(self.ui.Group_Day, false)
      self:_UpdateDay()
    end
    
    local function _GetTextColor()
      if day == self.day.value then
        return CommonDefine.ColorType.Light
      end
      return CommonDefine.ColorType.Dark
    end
    
    binder:UpdateLocalizedTextAndResouce(obj)
    binder:SetText(ui.Text_Drop_Item_Tips, day)
    binder:BindToVisible(ui.Group_Nor, function()
      return day ~= self.day.value
    end)
    binder:BindToVisible(ui.Group_Sel, function()
      return day == self.day.value
    end)
    binder:BindToTextColor(ui.Text_Drop_Item_Tips, _GetTextColor)
    binder:BindButtonClick(ui.Btn_Click, _OnClick)
  end)
end

function SocialPlayerSetBirthPanel:_BindToggles(binder)
  binder:BindToZ1Toggle(self.ui.Group_Month, nil, function(isOn)
    binder:SetActive(self.ui.ScrollView_Month, isOn)
  end)
  binder:BindToZ1Toggle(self.ui.Group_Day, nil, function(isOn)
    binder:SetActive(self.ui.ScrollView_Day, isOn)
  end)
end

function SocialPlayerSetBirthPanel:_UpdateMonth()
  self.binder:SetText(self.ui.Text_Month_Tips, self.month.value)
end

function SocialPlayerSetBirthPanel:_UpdateDay()
  self.binder:SetText(self.ui.Text_Day_Tips, self.day.value)
end

function SocialPlayerSetBirthPanel:_UpdateBirthText()
  self:_UpdateMonth()
  self:_UpdateDay()
end

function SocialPlayerSetBirthPanel:_OnClickConfirm()
  if not self:_IsDateValid() then
    Alert.Show(10745)
    return
  end
  
  local function _OnReqSuccCallback()
    if self.callback then
      self.callback(self.month.value, self.day.value)
    end
    self:Close()
  end
  
  local function ConfirmCallback()
    SocialDataUtils.ReqSetBirthday(self.month.value, self.day.value, _OnReqSuccCallback)
  end
  
  local tips = ""
  local tipConfig = DT.TipsType[20110]
  if tipConfig then
    tips = LT.Textf(tipConfig.Desc, self.month.value, self.day.value)
  end
  Alert.Show(20110, nil, ConfirmCallback, nil, tips)
end

function SocialPlayerSetBirthPanel:_IsDateValid()
  if not self.month.value or not self.day.value then
    return false
  end
  if type(self.month.value) ~= "number" or type(self.day.value) ~= "number" then
    return false
  end
  local totalDays = os.date("%d", os.time({
    year = 2024,
    month = self.month.value + 1,
    day = 0
  }))
  totalDays = tonumber(totalDays)
  if self.day.value <= 0 or totalDays < self.day.value then
    return false
  end
  local time = os.time({
    year = 2024,
    month = self.month.value,
    day = self.day.value
  })
  return nil ~= time
end

function SocialPlayerSetBirthPanel:Close()
  Super.Close(self)
end

return SocialPlayerSetBirthPanel
