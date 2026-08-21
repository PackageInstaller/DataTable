_class("UISeasonMazeTeamRecommend", UICustomWidget)
UISeasonMazeTeamRecommend = UISeasonMazeTeamRecommend

function UISeasonMazeTeamRecommend:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMazeTeamRecommend:InitWidget()
  self._iconListGen = self:GetUIComponent("UISelectObjectPath", "IconList")
  self._baseGo = self:GetGameObject("Bg")
end

function UISeasonMazeTeamRecommend:SetData(seasonMissionID)
  self._baseGo:SetActive(false)
  local cfg_mission = Cfg.cfg_season_maze_mission[seasonMissionID]
  if cfg_mission then
    local recommendTb = cfg_mission.Recommend
    if recommendTb then
      local iconData = recommendTb.Icons
      if iconData then
        self._baseGo:SetActive(true)
        local count = #iconData
        self._iconListGen:SpawnObjects("UISeasonMazeTeamRecommendIcon", count)
        self._iconList = self._iconListGen:GetAllSpawnList()
        for i = 1, count do
          self._iconList[i]:SetData(iconData[i].type, iconData[i].param)
        end
      end
    end
  end
end
