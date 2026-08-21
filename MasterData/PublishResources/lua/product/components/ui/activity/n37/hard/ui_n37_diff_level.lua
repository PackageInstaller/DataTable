require("ui_activity_diff_level")
_class("UIN37DiffLevel", UIActivityDiffLevel)
UIN37DiffLevel = UIN37DiffLevel

function UIN37DiffLevel:GetTimeDownString()
  return "str_cn6&n35_activity_hard_level_remain_time"
end

function UIN37DiffLevel:NodePlayAnimationInterval(TT)
end

function UIN37DiffLevel:GetIntroName()
  return "UIN37HardIntro"
end

function UIN37DiffLevel:GetLevelNodeName()
  return "UIN37DiffLevelNode"
end
