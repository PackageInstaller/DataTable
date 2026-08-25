local GratitudeView, Super = NewClass("GratitudeView", BaseView)
GratitudeView.uiResCls = UI_Community_ThanksLetterResource

function GratitudeView:OnBuildView()
  self:_RefreshVolunteerNames()
  self.ui.Text_C_Sincerely.gameObject:SetActive(Utils.IsLangEN())
  self:_CalcHeight()
end

function GratitudeView:OnEnterView()
  self:LoadAllLangFont(self.ui.Text_Volunteer)
  self.closeBtn = self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, function()
    self:Close()
    self.closeBtn:PlayCloseAnim()
  end)
end

function GratitudeView:RegisterEvents()
end

function GratitudeView:_RefreshVolunteerNames()
  local volunteerList = DT.GetOriginalConstant("GratitudePlayerNamesList") or ""
  local nameStr = ""
  local maxTextWidth = self.ui.Text_Volunteer.gameObject.transform.sizeDelta.x
  if table.next(volunteerList) ~= nil then
    nameStr = volunteerList[1]
    self:SetText(self.ui.Text_Volunteer_Cal, nameStr)
  end
  for i = 2, #volunteerList do
    if not string.isempty(volunteerList[i]) then
      local name = volunteerList[i]
      local testNameStr = nameStr .. ",<space=0.4em>" .. name
      self:SetText(self.ui.Text_Volunteer_Cal, testNameStr)
      if maxTextWidth < self:_GetTextPreferredWidth(self.ui.Text_Volunteer_Cal) then
        nameStr = nameStr .. ",\n" .. name
      else
        nameStr = nameStr .. ",<space=0.4em>" .. name
      end
    end
  end
  self:SetText(self.ui.Text_Volunteer, nameStr)
end

function GratitudeView:_GetTextPreferredWidth(owner)
  local textComp = self:GetTextComp(owner)
  if not textComp then
    return 0
  end
  return textComp.preferredWidth
end

function GratitudeView:_CalcHeight()
  local prefixTextHeight = StrUtils.SetPreferredHeight(self.ui.Text_Prefix, 22) or 0
  local volunteerTextHeight = StrUtils.SetPreferredHeight(self.ui.Text_Volunteer, 40) or 0
  local suffixTextHeight = StrUtils.SetPreferredHeight(self.ui.Text_Suffix) or 0
  CS.Framework.TransformUtil.SetAnchoredPos(self.ui.Text_Prefix.gameObject.transform, 0, 0)
  CS.Framework.TransformUtil.SetAnchoredPos(self.ui.Text_Volunteer.gameObject.transform, 0, prefixTextHeight * -1)
  CS.Framework.TransformUtil.SetAnchoredPos(self.ui.Text_Suffix.gameObject.transform, 0, (volunteerTextHeight + prefixTextHeight) * -1)
  local sizeDelta = self.ui.Content.gameObject.transform.sizeDelta
  local vec = CS.UnityEngine.Vector2(0, 0)
  vec.x = sizeDelta.x
  vec.y = prefixTextHeight + volunteerTextHeight + suffixTextHeight
  self.ui.Content.transform.sizeDelta = vec
end

return GratitudeView
