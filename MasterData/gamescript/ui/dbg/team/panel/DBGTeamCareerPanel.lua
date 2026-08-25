local DBGTeamCareerPanel, Super = System.NewClass("DBGTeamCareerPanel", UIBasePanel)
DBGTeamCareerPanel.uiResCls = UI_Team_Popup_Prop_AwardResource

function DBGTeamCareerPanel:ctor(careerEffectList, isPvp)
  Super.ctor(self)
  self.careerEffectList = careerEffectList
  self.isPvp = isPvp
end

function DBGTeamCareerPanel:OnBind(binder)
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.OnClose))
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.OnClose))
  local CommonPopupFullTipsDataData = {}
  binder:BindComponent(CommonPopupFullTips(self.ui.UI_Common_Popup_Tips_Full, CommonPopupFullTipsDataData))
  binder:BindToText(self.ui.Text_Host_Title, function()
    do return self.GetPanelTitle, self end
    return self.GetPanelTitle, self, self.isPvp
  end)
  binder:BindToText(self.ui.Text_Tips, function()
    do return self.GetPanelTips, self end
    return self.GetPanelTips, self, self.isPvp
  end)
  local careerShowList = {}
  for _, data in pairs(self.careerEffectList) do
    table.insert(careerShowList, data)
  end
  local careerSortWeightMap = {
    [CommonDefine.SchoolType.Chaos] = 1,
    [CommonDefine.SchoolType.Ocean] = 2,
    [CommonDefine.SchoolType.Blood] = 3,
    [CommonDefine.SchoolType.Dimension] = 4
  }
  table.sort(careerShowList, function(a, b)
    local cfgA = DT.SchoolConfig[a.schoolId]
    local cfgB = DT.SchoolConfig[b.schoolId]
    local weightA = careerSortWeightMap[cfgA.NameEn]
    local weightB = careerSortWeightMap[cfgB.NameEn]
    return weightA < weightB
  end)
  for idx, data in pairs(careerShowList) do
    local uiGO = self.ui["UI_Team_Item_Talent" .. idx]
    binder:BindComponent(DBGTeamCareerItem(uiGO, data.schoolId, data.enable, self.isPvp))
  end
end

function DBGTeamCareerPanel:OnClose()
  self:Close()
end

function DBGTeamCareerPanel:GetPanelTitle(isPvp)
  if not isPvp then
    do return LT.Text end
    return LT.Text, "Team_Occupation_Tips"
  end
  do return LT.Text end
  return LT.Text, "PVP_School_Title_String"
end

function DBGTeamCareerPanel:GetPanelTips(isPvp)
  if not isPvp then
    do return LT.Text end
    return LT.Text, "School_Tips_String"
  end
  do return LT.Text end
  return LT.Text, "PVP_School_Tips_String"
end

return DBGTeamCareerPanel
