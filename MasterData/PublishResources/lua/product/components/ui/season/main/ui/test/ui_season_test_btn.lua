_class("UISeasonTestBtn", UICustomWidget)
UISeasonTestBtn = UISeasonTestBtn

function UISeasonTestBtn:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonTestBtn:InitWidget()
  self.txt = self:GetUIComponent("UILocalizationText", "txt")
end

function UISeasonTestBtn:SetData(title, cb)
  self.txt:SetText(title)
  self._cb = cb
end

function UISeasonTestBtn:UISeasonTestBtnOnClick(go)
  if self._cb then
    self._cb()
  end
end
