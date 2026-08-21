_class("HomelandFishingConst", Object)
HomelandFishingConst = HomelandFishingConst

function HomelandFishingConst:Constructor()
end

function HomelandFishingConst.GetThrowPowerSpeed()
  local cfg = Cfg.cfg_homeland_fishing.ThrowPowerSpeed
  return cfg.Value / 1000
end

function HomelandFishingConst.GetThrowMinDistance()
  return Cfg.cfg_homeland_fishing.ThrowMinDistance.Value / 1000
end

function HomelandFishingConst.GetThrowMaxDistance()
  return Cfg.cfg_homeland_fishing.ThrowMaxDistance.Value / 1000
end

function HomelandFishingConst.GetCurrentFishRod()
  return HomelandFishRod:New()
end

function HomelandFishingConst.GetBiteFish()
  return HomelandFishingConst.BitFish
end

function HomelandFishingConst.SetBitFishId(fishId)
  HomelandFishingConst.BitFish = HomelandFish:New(fishId)
end

function HomelandFishingConst.GetWishingFishInfo()
  return HomelandFishingConst.WishingFishInfo
end

function HomelandFishingConst.SettWishingFishInfo(info)
  HomelandFishingConst.WishingFishInfo = info
end

function HomelandFishingConst._GetFishingType()
  local fishingtype
  local match = HomelandFishMatchManager:GetInstance():GetCurFishMatch()
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  local homelandClient = homelandModule:GetUIModule():GetClient()
  local character = homelandClient:CharacterManager():MainCharacterController()
  local isMatch = character:GetIsFishMach()
  if match and isMatch then
    local cfg = Cfg.cfg_homeland_fishmatch_main[match:GetMainID()]
    fishingtype = cfg.Type
  else
    fishingtype = FishingEntryType.FET_Normal
  end
  return fishingtype
end

function HomelandFishingConst.GetPlayerPowerNormalSpeed()
  local type = HomelandFishingConst._GetFishingType()
  if type == FishingEntryType.FET_FishingCampaignChallenge then
    return Cfg.cfg_homeland_fishing.CampaignPlayerPowerNormalSpeed.Value / 1000
  elseif type == FishingEntryType.FET_FishingPetChallenge then
    return Cfg.cfg_homeland_fishing.PetPlayerPowerNormalSpeed.Value / 1000
  else
    return Cfg.cfg_homeland_fishing.PlayerPowerNormalSpeed.Value / 1000
  end
end

function HomelandFishingConst.GetPlayerPowerHighSpeed()
  local type = HomelandFishingConst._GetFishingType()
  if type == FishingEntryType.FET_FishingCampaignChallenge then
    return Cfg.cfg_homeland_fishing.CampaignPlayerPowerHighSpeed.Value / 1000
  elseif type == FishingEntryType.FET_FishingPetChallenge then
    return Cfg.cfg_homeland_fishing.PetPlayerPowerHighSpeed.Value / 1000
  else
    return Cfg.cfg_homeland_fishing.PlayerPowerHighSpeed.Value / 1000
  end
end

function HomelandFishingConst.GetFishBiteTime()
  local min, max
  local type = HomelandFishingConst._GetFishingType()
  if type == FishingEntryType.FET_FishingCampaignChallenge then
    min = Cfg.cfg_homeland_fishing.CampaignFishBiteMinTime.Value / 1000
    max = Cfg.cfg_homeland_fishing.CampaignFishBiteMaxTime.Value / 1000
  elseif type == FishingEntryType.FET_FishingPetChallenge then
    min = Cfg.cfg_homeland_fishing.PetFishBiteMinTime.Value / 1000
    max = Cfg.cfg_homeland_fishing.PetFishBiteMaxTime.Value / 1000
  else
    min = Cfg.cfg_homeland_fishing.FishBiteMinTime.Value / 1000
    max = Cfg.cfg_homeland_fishing.FishBiteMaxTime.Value / 1000
  end
  return math.random(min, max)
end

function HomelandFishingConst.GetAnimationCfg(animName)
  if not HomelandFishingConst.Animations then
    HomelandFishingConst.Animations = {}
    local t = {}
    t.name = "FishThrowSuccess"
    t.rodname = "toast_success"
    t.length = 1533
    HomelandFishingConst.Animations[FishgingAnimation.FishThrowSuccess] = t
    t = {}
    t.name = "FishThrowFailure"
    t.rodname = "toss_failure"
    t.length = 1000
    HomelandFishingConst.Animations[FishgingAnimation.FishThrowFailure] = t
    t = {}
    t.name = "CancelFish"
    t.rodname = "collect"
    t.length = 1667
    HomelandFishingConst.Animations[FishgingAnimation.FishCancel] = t
    t = {}
    t.name = "FishBite"
    t.rodname = "fish_bite"
    t.length = 2667
    HomelandFishingConst.Animations[FishgingAnimation.FishPowerChange] = t
    t = {}
    t.name = "FishingPowerGreat"
    t.rodname = "fish_power_greater"
    t.length = 1000
    HomelandFishingConst.Animations[FishgingAnimation.FishPowerGreate] = t
    t = {}
    t.name = "PersonPowerGreat"
    t.rodname = "person_power_greater"
    t.length = 933
    HomelandFishingConst.Animations[FishgingAnimation.PersonPowerGreat] = t
    t = {}
    t.name = "FishSuccess"
    t.rodname = "fish_success"
    t.length = 2600
    HomelandFishingConst.Animations[FishgingAnimation.FishSuccess] = t
    t = {}
    t.name = "DecouplingFishPowerGreat"
    t.rodname = "fish_power_greater_failure"
    t.length = 1133
    HomelandFishingConst.Animations[FishgingAnimation.DecouplingFishPowerGreat] = t
    t = {}
    t.name = "DecouplingPersonPowerGreat"
    t.rodname = "person_power_greater_failure"
    t.length = 1500
    HomelandFishingConst.Animations[FishgingAnimation.DecouplingPersonPowerGreat] = t
    t = {}
    t.name = "FishFailure"
    t.rodname = "fish_failure"
    t.length = 1500
    HomelandFishingConst.Animations[FishgingAnimation.FishFailure] = t
    t = {}
    t.name = "CancelFishing"
    t.rodname = "collect"
    t.length = 0
    HomelandFishingConst.Animations[FishgingAnimation.CancelFishing] = t
  end
  return HomelandFishingConst.Animations[animName]
end

function HomelandFishingConst.GetFishingPositionCfg(positionId)
  local cfg = Cfg.cfg_homeland_fishing_postion[positionId]
  cfg = cfg or Cfg.cfg_homeland_wishingcoin_fishing_postion[positionId]
  cfg = cfg or Cfg.cfg_homeland_rare_fishing_postion[positionId]
  return cfg
end

function HomelandFishingConst.GetDefaultFishingPosition()
  local cfg = Cfg.cfg_homeland_fishing_postion({
    Type = HomelandFishingPointType.River
  })
  for k, v in pairs(cfg) do
    return v.ID
  end
end

function HomelandFishingConst.GetWishingCoinPositionId()
  if not HomelandFishingConst._testId then
    HomelandFishingConst._testId = {}
    HomelandFishingConst._testId[#HomelandFishingConst._testId + 1] = 5609301
  end
  return HomelandFishingConst._testId
end

function HomelandFishingConst.SetWishingCoinPositionId()
  HomelandFishingConst._testId = {}
end
