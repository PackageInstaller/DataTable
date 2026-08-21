_class("UIActivityN29HardLevel", UIActivityHardLevel)
UIActivityN29HardLevel = UIActivityN29HardLevel

function UIActivityN29HardLevel:GetTimeDownString()
  return "str_n27_level_remain_time_tips"
end

function UIActivityN29HardLevel:NodePlayAnimationInterval(TT)
  YIELD(TT, 30)
end
