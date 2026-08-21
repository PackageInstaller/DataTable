_class("SmokeTestTeamBuildSeatInfo", Object)
SmokeTestTeamBuildSeatInfo = SmokeTestTeamBuildSeatInfo

function SmokeTestTeamBuildSeatInfo:Constructor(conf, index)
  self.testTeamBuildID = conf.ID
  self.seatIndex = index
  self.enabled = conf.Enabled
  self.level = conf.Level
  self.awakening = conf.Awakening
  self.grade = conf.Grade
  self.intimacy = conf.Intimacy
  self.equip = conf.Equip
  self.refine = conf.EquipRefine
end

function SmokeTestTeamBuildSeatInfo.__tostring(t)
  return table.concat({
    "config ID:",
    tostring(t.testTeamBuildID),
    " seat index:",
    tostring(t.seatIndex),
    "; ",
    " enabled:",
    tostring(t.enabled),
    " level:",
    tostring(t.level),
    " awakening:",
    tostring(t.awakening),
    " grade:",
    tostring(t.grade),
    " intimacy:",
    tostring(t.intimacy),
    " equip:",
    tostring(t.equip)
  })
end

function SmokeTestTeamBuildSeatInfo.ExplainSeat(confID, index, mute)
  local conf = Cfg.cfg_level_test_team_build[confID]
  conf = conf or Cfg.cfg_level_test_team_build[-1]
  return SmokeTestTeamBuildSeatInfo:New(conf, index)
end
