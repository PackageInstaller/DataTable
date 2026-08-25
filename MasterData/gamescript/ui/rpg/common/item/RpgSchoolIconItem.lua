local RpgSchoolIconItem, Super = System.NewComponent("RpgSchoolIconItem")

function RpgSchoolIconItem:ctor(res, data)
  Super.ctor(self)
  self.ui = Item_Team_Career_RpgResource(res)
  self.data = data
  self.selected = Vue.ref(false)
end

function RpgSchoolIconItem:OnBind(binder)
  self.binder = binder
  self:UpdateUI()
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClick))
  binder:BindToVisible(self.ui.Effect_Select, function()
    return self.selected.value
  end)
end

function RpgSchoolIconItem:UpdateUI()
  if not self.data then
    return
  end
  if 0 == self.data.schoolTid then
    self.binder:SetText(self.ui.Text_Career_Name, LT.Text("RoleInterface_Str_Title"))
    self.binder:SetImage(self.ui.Image_Icon, "UIResources/AtlasSource/2_Icon/Career_Icon/UI_Career_Neutral.png")
    self.binder:SetActive(self.ui.Text_Recommend, false)
    return
  end
  local config = DT.SchoolConfig[self.data.schoolTid]
  if not config then
    Logger.Info("找不到职业配置 ==> ", tostring(self.data.schoolTid))
    return
  end
  self.binder:SetText(self.ui.Text_Career_Name, LT.Text(config.Name))
  self.binder:SetImage(self.ui.Image_Icon, config.Icon)
  self.binder:SetActive(self.ui.Text_Recommend, false)
end

function RpgSchoolIconItem:OnClick()
  if not self.data or not self.data.callback then
    return
  end
  self.data.callback(self.data.schoolTid)
end

function RpgSchoolIconItem:ResetData(data)
  self.data = data
  self.selected.value = false
  self:UpdateUI()
end

function RpgSchoolIconItem:SetSelected(selected)
  self.selected.value = selected
end

return RpgSchoolIconItem
