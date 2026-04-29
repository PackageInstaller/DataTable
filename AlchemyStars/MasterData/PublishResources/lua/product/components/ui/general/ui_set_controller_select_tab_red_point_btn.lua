_class("UISetControllerSelectTabRedPointBtn", UICustomWidget)
UISetControllerSelectTabRedPointBtn = UISetControllerSelectTabRedPointBtn

function UISetControllerSelectTabRedPointBtn:OnShow()
  self.tgl = self:GetUIComponent("Toggle", "Toggle")
  self.toggleBG = self:GetGameObject("toggleBG")
  self.describeText = self:GetUIComponent("UILocalizationText", "describe")
  self.red = self:GetGameObject("_red")
end

function UISetControllerSelectTabRedPointBtn:Init(index, describeText, tglGroup, onClickTabBtn, param)
  self.index = index
  self.tgl.group = tglGroup
  self.toggleBG:SetActive(not self.tgl.isOn)
  self.onClickTabBtn = onClickTabBtn
  self.param = param
  self.describeText:SetText(StringTable.Get(describeText .. index))
end

function UISetControllerSelectTabRedPointBtn:Select(select)
  self.tgl.isOn = select
  self.toggleBG:SetActive(not select)
end

function UISetControllerSelectTabRedPointBtn:ToggleOnClick(go)
  self.onClickTabBtn(self.param, self.index)
end

function UISetControllerSelectTabRedPointBtn:SetRed(isRed)
  self.red:SetActive(isRed)
end
