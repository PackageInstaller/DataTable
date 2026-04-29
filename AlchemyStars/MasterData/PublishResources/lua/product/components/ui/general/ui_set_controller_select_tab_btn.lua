_class("UISetControllerSelectTabBtn", UICustomWidget)
UISetControllerSelectTabBtn = UISetControllerSelectTabBtn

function UISetControllerSelectTabBtn:OnShow()
  self.tgl = self:GetUIComponent("Toggle", "toggle")
  self.toggleBG = self:GetGameObject("toggleBG")
  self.describeText = self:GetUIComponent("UILocalizationText", "describe")
end

function UISetControllerSelectTabBtn:Init(index, describeText, tglGroup, onClickTabBtn, param)
  self.index = index
  self.tgl.group = tglGroup
  self.toggleBG:SetActive(not self.tgl.isOn)
  self.onClickTabBtn = onClickTabBtn
  self.param = param
  self.describeText:SetText(StringTable.Get(describeText .. index))
end

function UISetControllerSelectTabBtn:Select(select)
  self.tgl.isOn = select
  self.toggleBG:SetActive(not select)
end

function UISetControllerSelectTabBtn:toggleOnClick(go)
  self.onClickTabBtn(self.param, self.index)
end
