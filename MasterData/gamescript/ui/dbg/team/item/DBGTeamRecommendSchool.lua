local DBGTeamRecommendSchool, Super = System.NewComponent("DBGTeamRecommendSchool")

function DBGTeamRecommendSchool:ctor(res, model)
  Super.ctor(self)
  self.ui = UI_Team_Panel_MainResource(res)
  self.model = model
end

function DBGTeamRecommendSchool:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Recommend_School, System.fn(self, self.OnClickRecommendSchool))
  binder:BindButtonClick(self.ui.Button_Addition, function()
    self.ui.Button_Addition:SetActive(false)
  end)
  self:OnBindRecommondSchool(binder)
end

function DBGTeamRecommendSchool:OnBindRecommondSchool(binder)
  binder:BindToVisible(self.ui.Image_Grade, function()
    do return table.next end
    return table.next, self.model.stageCfg
  end)
  binder:BindToVisible(self.ui.Group_Recommend_School, function()
    return DataCenter.dbgTeamData.recommendedSchoolID > 0 or self.model.stageCfg and self.model.stageCfg.RecClass ~= nil
  end)
  binder:BindToRaw(function(_, recClass)
    for i = 1, 4 do
      local schoolId = recClass[i]
      local icon = self.ui["Icon_Recommend_" .. i]
      icon:SetActive(nil ~= schoolId)
      local cfg = DT.SchoolConfig[schoolId]
      if cfg and cfg.Icon then
        binder:SetImage(icon, cfg.Icon)
      end
    end
  end, function()
    local recommendedSchoolID = DataCenter.dbgTeamData.recommendedSchoolID
    if recommendedSchoolID > 0 then
      return {recommendedSchoolID}
    end
    return self.model.stageCfg.RecClass or {}
  end)
  binder:BindToRaw(function(_, isRecommend)
    self.ui.Group_Addition:SetActive(true)
    local addPercent = self.model.stageCfg.RecommendedSchoolBonus or 0
    local content = LT.Textf("RecClass_tips", string.format("+%s%%", addPercent))
    binder:SetText(self.ui.Text_Addition_On, content)
    binder:SetText(self.ui.Text_Addition_Off, content)
    self.ui.Text_Addition_On:SetActive(isRecommend)
    self.ui.Text_Addition_Off:SetActive(not isRecommend)
  end, function()
    do return self.model.IsRecommendSchool end
    return self.model.IsRecommendSchool, self.model
  end)
end

function DBGTeamRecommendSchool:OnClickRecommendSchool()
  self.ui.Button_Addition:SetActive(true)
end

return DBGTeamRecommendSchool
