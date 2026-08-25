local DBGTeamRecommendLevel, Super = System.NewComponent("DBGTeamRecommendLevel")

function DBGTeamRecommendLevel:ctor(res, model)
  Super.ctor(self)
  self.ui = UI_Team_Panel_MainResource(res)
  self.model = model
end

function DBGTeamRecommendLevel:OnBind(binder)
  self.binder = binder
  binder:BindToVisible(self.ui.Group_Recommend_Level, function()
    if not self.model.stageCfg.StageLevel then
      return false
    end
    return self.model.teamType ~= CommonDefine.TeamType.Daily
  end)
  binder:BindToText(self.ui.Text_Battle_Now_Name, function()
    do return LT.Text end
    return LT.Text, "Formation_RecommendLevel"
  end)
  binder:BindToText(self.ui.Text_Battle_Now_Number, function()
    local stageId = self.model.stageId
    if not stageId then
      return
    end
    local boxId = MainCopyDataUtils.GetDymicDifficultyId(stageId) or stageId
    local oriCfg = MainCopyDataUtils.GetStageConfig(stageId)
    local cfg = MainCopyDataUtils.GetStageConfig(boxId)
    return cfg.StageLevel or oriCfg.StageLevel
  end)
  binder:BindToVisible(self.ui.Group_Level_Effect, function()
    return self.model.teamType ~= CommonDefine.TeamType.Daily
  end)
  binder:BindToText(self.ui.Text_Battle_Recommend_Name, function()
    local suppressValue = self.model:GetLevelSuppress()
    local suppressText = string.format("%s%s%%", suppressValue > 0 and "-" or "+", math.floor(suppressValue))
    local text = LT.Textf("LevelSuppression_tips", suppressText)
    if suppressValue > 0 then
      text = string.color(text, "#FF0000")
    end
    return text
  end)
  binder:BindToVisible(self.ui.Text_Battle_Recommend_Name, function()
    local suppressValue = self.model:GetLevelSuppress()
    return suppressValue > 0 and self.model:IsTeamFull()
  end)
  binder:BindToVisible(self.ui.Icon_No_Level_Effect, function()
    local suppressValue = self.model:GetLevelSuppress()
    return 0 == suppressValue and self.model:IsTeamFull()
  end)
  binder:BindToVisible(self.ui.Icon_Level_Effect, function()
    local suppressValue = self.model:GetLevelSuppress()
    return suppressValue > 0 and self.model:IsTeamFull()
  end)
  binder:BindButtonClick(self.ui.Btn_Recommend_Level, System.fn(self, self.OnClickRecommendLevel))
end

function DBGTeamRecommendLevel:OnClickRecommendLevel()
  local title = LT.Text("LevelSuppression_Description_Title")
  local content = LT.Text("LevelSuppression_Description_Detail")
  UIManager.Instance:Reopen(Urls.CommonillustrateView, title, content)
end

return DBGTeamRecommendLevel
