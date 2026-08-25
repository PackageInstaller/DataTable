local SettingSliderNoTextItem, Super = NewViewComponent("SettingSliderNoTextItem")
local levelMap = {
  [1] = "High",
  [2] = "Middle",
  [3] = "Low"
}
local levelSliderMap = {
  [1] = 1.0,
  [2] = 0.6666666666666666,
  [3] = 0.3333333333333333
}
local sliderColorMap = {
  [1] = "UIResources/AtlasSource/UI_Setting_Image/Image_Setting_Content_Slider1_Fill_Red.png",
  [2] = "UIResources/AtlasSource/UI_Setting_Image/Image_Setting_Content_Slider1_Fill_Yellow.png",
  [3] = "UIResources/AtlasSource/UI_Setting_Image/Image_Setting_Content_Slider1_Fill_Green.png"
}

function SettingSliderNoTextItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Setting_Content_PerformanceResource(uiNode)
  self.data = data
end

function SettingSliderNoTextItem:OnEnterComponent()
  self:SetText(self.ui.Text_Title, LT.Text(self.data.titleText))
  local machineLevel = SettingManager.Instance.machineLevel
  local showText = levelMap[machineLevel]
  if DT.CommonID[showText] then
    showText = DT.CommonID[showText].Desc
  end
  self:SetText(self.ui.Text_Slider_Tips, LT.Text(showText))
  self:SetImage(self.ui.Fill, sliderColorMap[machineLevel])
  self:SetSliderValue(self.ui.Slider_Date, levelSliderMap[machineLevel])
end

return SettingSliderNoTextItem
