_class("UIN38_Main_Title", UICustomWidget)
UIN38_Main_Title = UIN38_Main_Title

function UIN38_Main_Title:OnShow(uiParams)
  self:InitWidget()
end

function UIN38_Main_Title:InitWidget()
  self._time = self:GetUIComponent("UILocalizationText", "Time")
  self._subTitle = self:GetGameObject("SubTitle")
end

function UIN38_Main_Title:SetData()
end

function UIN38_Main_Title:SetRemainTime(remainTimeStr)
  self._time:SetText(remainTimeStr)
end
