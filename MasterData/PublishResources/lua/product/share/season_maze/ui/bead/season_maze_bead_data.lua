_class("SeasonMazeBeadData", Object)
SeasonMazeBeadData = SeasonMazeBeadData

function SeasonMazeBeadData:Constructor(index, data)
  self.index = index
  self.data = data
  if self.data then
    local cfg = Cfg.cfg_component_season_maze_autobead[data.bead_info.cfg_id]
    if cfg then
      self.level = cfg.Lv
      self.type = cfg.Type
      self.quality = cfg.Quality
      self.kind = cfg.KindID
      self.tag = cfg.Tag
    end
  end
end

function SeasonMazeBeadData:IsMax()
  return self.level and self.level == 4
end

_class("SeasonMazeBeadPair", Object)
SeasonMazeBeadPair = SeasonMazeBeadPair

function SeasonMazeBeadPair:Constructor(uid1, uid2, beadData1, beadData2)
  self.uid1 = uid1
  self.uid2 = uid2
  self.beadData = {beadData1, beadData2}
  self.choice = true
end
