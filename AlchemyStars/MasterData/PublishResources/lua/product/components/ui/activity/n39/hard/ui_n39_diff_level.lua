require("ui_activity_diff_level")
_class("UIN39DiffLevel", UIActivityDiffLevel)
UIN39DiffLevel = UIN39DiffLevel

function UIN39DiffLevel:GetTimeDownString()
  return "str_cn6&n35_activity_hard_level_remain_time"
end

function UIN39DiffLevel:NodePlayAnimationInterval(TT)
end

function UIN39DiffLevel:GetIntroName()
  return "UIN39HardIntro"
end

function UIN39DiffLevel:GetLevelNodeName()
  return "UIN39DiffLevelNode"
end
