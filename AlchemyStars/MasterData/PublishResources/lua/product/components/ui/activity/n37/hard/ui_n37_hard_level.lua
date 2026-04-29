require("ui_activity_hard_level")
_class("UIN37HardLevel", UIActivityHardLevel)
UIN37HardLevel = UIN37HardLevel

function UIN37HardLevel:GetTimeDownString()
  return "str_cn6&n35_activity_hard_level_remain_time"
end

function UIN37HardLevel:NodePlayAnimationInterval(TT)
end

function UIN37HardLevel:GetLevelNodeName()
  return "UIN37HardLevelNode"
end
