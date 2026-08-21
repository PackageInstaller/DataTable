require("ui_activity_hard_level")
_class("UIN39HardLevel", UIActivityHardLevel)
UIN39HardLevel = UIN39HardLevel

function UIN39HardLevel:GetTimeDownString()
  return "str_cn6&n35_activity_hard_level_remain_time"
end

function UIN39HardLevel:NodePlayAnimationInterval(TT)
end

function UIN39HardLevel:GetLevelNodeName()
  return "UIN39HardLevelNode"
end
