_class("UIN25IdolAchieveTitle", UICustomWidget)
UIN25IdolAchieveTitle = UIN25IdolAchieveTitle

function UIN25IdolAchieveTitle:Constructor()
  self._parent = nil
  self._cfg = nil
  self._urlIcon = {
    [4] = "n25_ych_di26",
    [5] = "n25_ych_di27",
    [6] = "n25_ych_di25"
  }
  self._nameColor = self:GetNameColor()
end

function UIN25IdolAchieveTitle:OnShow(uiParams)
  self._imgBg = self:GetUIComponent("Image", "imgBg")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
end

function UIN25IdolAchieveTitle:OnHide()
end

function UIN25IdolAchieveTitle:GetNameColor()
  return {
    [0] = Color(0.34901960784313724, 0.34901960784313724, 0.34901960784313724, 1),
    [4] = Color(1.0, 0.5529411764705883, 0.25882352941176473, 1),
    [5] = Color(0.4980392156862745, 0.3411764705882353, 0.9215686274509803, 1),
    [6] = Color(0.9568627450980393, 0.48627450980392156, 0.5843137254901961, 1)
  }
end

function UIN25IdolAchieveTitle:SetData(parent, cfg)
  self._parent = parent
  self._cfg = cfg
  local url = self._urlIcon[cfg.StateIcon]
  if url ~= nil then
    self._imgBg.enabled = true
    self._imgBg.sprite = self._parent:GetAtlas():GetSprite(url)
    self._txtName.color = self._nameColor[cfg.StateIcon]
  else
    self._imgBg.enabled = false
  end
  self._txtName:SetText(StringTable.Get(self._cfg.Name))
end
