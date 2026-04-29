require("ui_activity_hard_level")
_class("UIActivityCN6N35HardLevel", UIActivityHardLevel)
UIActivityCN6N35HardLevel = UIActivityCN6N35HardLevel

function UIActivityCN6N35HardLevel:GetTimeDownString()
  return "str_cn6&n35_activity_hard_level_remain_time"
end

function UIActivityCN6N35HardLevel:NodePlayAnimationInterval(TT)
end

function UIActivityCN6N35HardLevel:GetLevelNodeName()
  return "UIActivityCN6N35NHardLevelNode"
end
