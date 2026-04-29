_class("UIHomeDomitoryChartRow", UICustomWidget)
UIHomeDomitoryChartRow = UIHomeDomitoryChartRow

function UIHomeDomitoryChartRow:OnShow(uiParams)
  self:InitWidget()
end

function UIHomeDomitoryChartRow:InitWidget()
  self.bg = self:GetUIComponent("Image", "bg")
  self.text1 = self:GetUIComponent("UILocalizationText", "text1")
  self.text2 = self:GetUIComponent("UILocalizationText", "text2")
end

function UIHomeDomitoryChartRow:SetData(idx, text1, cfg)
  if idx % 2 == 1 then
    self.bg.color = Color.white
  else
    self.bg.color = Color(0.9294117647058824, 0.9215686274509803, 0.9176470588235294)
  end
  self.text1:SetText(text1)
  self.text2:SetText(cfg.SinglePetAddValue)
end
