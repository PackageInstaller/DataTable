local DBGTeamCareerItem, Super = System.NewComponent("DBGTeamCareerItem")

function DBGTeamCareerItem:ctor(res, schoolId, enable, isPvp)
  Super.ctor(self)
  self.ui = UI_Team_Item_TalentResource(res)
  self.schoolId = schoolId
  self.enable = enable
  self.isPvp = isPvp
end

function DBGTeamCareerItem:OnBind(binder)
  self.binder = binder
  self.model = binder:createModel(DBGTeamCareerItemModel, self.schoolId, self.enable)
  local model = self.model
  binder:BindToText(self.ui.Text_Active_Describe, function()
    do return model.GetSchoolContent end
    return model.GetSchoolContent, model
  end, nil, nil, true)
  binder:BindToText(self.ui.Text_Lock_Describe, function()
    do return model.GetSchoolContent end
    return model.GetSchoolContent, model
  end, nil, nil, true)
  binder:BindToText(self.ui.Text_Active_Name, function()
    do return model.GetSchoolTitle, model end
    return model.GetSchoolTitle, model, self.isPvp
  end)
  binder:BindToText(self.ui.Text_Lock_Name, function()
    do return model.GetSchoolTitle, model end
    return model.GetSchoolTitle, model, self.isPvp
  end)
  binder:BindToVisible(self.ui.Group_Activate, function()
    return model.enable
  end)
  binder:BindToVisible(self.ui.Group_Lock, function()
    return not model.enable
  end)
  binder:BindButtonClick(self.ui.Btn_Detail, function()
    self:_OnClickBtnDetail()
  end)
end

function DBGTeamCareerItem:_OnClickBtnDetail()
  UIManager.Instance:Reopen(Urls.AlertToolTipsPanel, {
    title = self.model:GetSchoolTitle(self.isPvp),
    desc = self.model:GetSchoolContentDetail(self.isPvp)
  }, self.ui.Group_Tip)
end

return DBGTeamCareerItem
