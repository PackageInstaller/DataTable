_class("UIActivityN29DiffLevel", UIActivityDiffLevel)
UIActivityN29DiffLevel = UIActivityN29DiffLevel

function UIActivityN29DiffLevel:GetTimeDownString()
  return "str_n27_level_remain_time_tips"
end

function UIActivityN29DiffLevel:NodePlayAnimationInterval(TT)
  YIELD(TT, 30)
end

function UIActivityN29DiffLevel:GetIntroName()
  return "UIN29DiffLevelIntro"
end
