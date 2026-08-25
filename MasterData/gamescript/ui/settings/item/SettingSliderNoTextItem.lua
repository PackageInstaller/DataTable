local SettingItemType = CommonDefine.SettingItemType
local Slider = typeof(CS.UnityEngine.UI.Slider)
local SettingSliderNoTextItem, Super = System.NewComponent("SettingSliderNoTextItem")

function SettingSliderNoTextItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Setting_Content_PerformanceResource(uiNode)
  self.data = data
end

function SettingSliderNoTextItem:OnBind(binder)
  local model = binder:createModel(SettingContentItemModel, self.data)
  self.model = model
  binder:BindToText(self.ui.Text_Title, function()
    do return LT.Text end
    return LT.Text, model.titleText
  end)
  local machineLevel = SettingManager.Instance.machineLevel
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
  binder:BindToText(self.ui.Text_Slider_Tips, function()
    local showText = levelMap[machineLevel]
    if DT.CommonID[showText] then
      showText = DT.CommonID[showText].Desc
    end
    do return LT.Text end
    return LT.Text, showText
  end)
  binder:BindToImage(self.ui.Fill, function()
    return sliderColorMap[machineLevel]
  end)
  binder:SetSliderCurValue(self.ui.Slider_Date, levelSliderMap[machineLevel])
end

return SettingSliderNoTextItem
