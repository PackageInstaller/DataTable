local GratitudePanel, Super = System.NewClass("GratitudePanel", UIBasePanel)
GratitudePanel.uiResCls = UI_Community_ThanksLetterResource

function GratitudePanel:ctor()
  Super.ctor(self)
end

function GratitudePanel:OnBind(binder)
  binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, System.fn(self, self.Close)))
  local volunteerList = DT.GetOriginalConstant("GratitudePlayerNamesList") or ""
  local nameStr = ""
  local testNameStr = ""
  local maxTextWidth = self.ui.Text_Volunteer.gameObject.transform.sizeDelta.x
  if table.next(volunteerList) ~= nil then
    nameStr = volunteerList[1]
    testNameStr = nameStr
    binder:SetText(self.ui.Text_Volunteer_Cal, nameStr)
  end
  for i = 2, #volunteerList do
    if not string.isempty(volunteerList[i]) then
      local name = volunteerList[i]
      testNameStr = nameStr .. ",<space=0.4em>" .. name
      binder:SetText(self.ui.Text_Volunteer_Cal, testNameStr)
      if maxTextWidth < binder:GetTextPreferredWH(self.ui.Text_Volunteer_Cal) then
        testNameStr = ""
        nameStr = nameStr .. ",\n" .. name
      else
        nameStr = nameStr .. ",<space=0.4em>" .. name
        testNameStr = nameStr .. ",<space=0.4em>" .. name
      end
    end
  end
  binder:SetText(self.ui.Text_Volunteer, nameStr)
  binder:SetActive(self.ui.Text_C_Sincerely, Utils.IsLangEN())
  self:_CalcHeight()
end

function GratitudePanel:_CalTextWidth(binder, nameStr)
  local nameStr = nameStr .. ","
  binder:SetText(self.ui.Text_Volunteer_Cal, nameStr)
  do return binder.GetTextPreferredWH, binder end
  return binder.GetTextPreferredWH, binder, self.ui.Text_Volunteer_Cal, nameStr
end

function GratitudePanel:_CalcHeight()
  local prefixText_Height = StrUtils.SetPreferredHeight(self.ui.Text_Prefix, 22) or 0
  local volunteerText_Height = StrUtils.SetPreferredHeight(self.ui.Text_Volunteer, 40) or 0
  local suffixText_Height = StrUtils.SetPreferredHeight(self.ui.Text_Suffix) or 0
  CS.Framework.TransformUtil.SetAnchoredPos(self.ui.Text_Prefix.gameObject.transform, 0, 0)
  CS.Framework.TransformUtil.SetAnchoredPos(self.ui.Text_Volunteer.gameObject.transform, 0, prefixText_Height * -1)
  CS.Framework.TransformUtil.SetAnchoredPos(self.ui.Text_Suffix.gameObject.transform, 0, (volunteerText_Height + prefixText_Height) * -1)
  local sizeDelta = self.ui.Content.gameObject.transform.sizeDelta
  local Vector2 = CS.UnityEngine.Vector2(0, 0)
  Vector2.x = sizeDelta.x
  Vector2.y = prefixText_Height + volunteerText_Height + suffixText_Height
  self.ui.Content.transform.sizeDelta = Vector2
end

return GratitudePanel
