_class("UISeasonMazeSpecialScoreTaskitem", UICustomWidget)
UISeasonMazeSpecialScoreTaskitem = UISeasonMazeSpecialScoreTaskitem

function UISeasonMazeSpecialScoreTaskitem:InitWidget()
  self.text = self:GetUIComponent("UILocalizationText", "text")
  self.count = self:GetUIComponent("UILocalizationText", "count")
  self.mark = self:GetGameObject("finishMark")
end

function UISeasonMazeSpecialScoreTaskitem:OnShow()
  self:InitWidget()
end

function UISeasonMazeSpecialScoreTaskitem:SetData(data, hard, finish)
  local count = data[1]
  local score = data[2]
  local cfgs = Cfg.cfg_component_season_maze_effect({ID = score})
  if cfgs and 0 < #cfgs then
    local cfg = cfgs[1]
    local score = cfg.EffectList[1][3]
    self.count:SetText(score)
    self.text:SetText(StringTable.Get("str_season_maze_special_score_task_content", hard, count))
  end
  self.mark:SetActive(finish)
end
