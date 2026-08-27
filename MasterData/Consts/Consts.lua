require("Consts.PathConsts")
require("Consts.LayerMask")
require("Consts.TagConsts")
require("Consts.AreaConst")
require("Consts.UIAtlasConsts")
require("Consts.GameDefine")
require("Consts.ItemConsts")
require("Consts.LanguageConst")
require("Consts.HeroConsts")
require("Consts.TipConsts")
require("Consts.TipTagConsts")
require("Consts.ResConsts")
require("Consts.AnimationConst")
require("Consts.PicTipsConsts")
require("Consts.GameSettingConsts")
local cs_MicaSDKManager = CS.MicaSDKManager
Consts = {}
Consts.SceneName = {
  Main = "003_Oasis_001",
  Sector = "002_Sector_001",
  Dorm = "004_Interior_001",
  Factory = "008_Factory_001",
  Empty = "Empty",
  Fight = "009_Fight_001",
  ShowCharacter = "006_Show_006",
  SnakeGame = "007_Arena_002",
  FairyLobbyMain = "011_Fairy_001",
  Empty4AB = "Empty4AB"
}
Consts.GameChannelType = {
  Official = 0,
  Bilibili = 1,
  QATest = 2,
  BilibiliQATest = 3,
  BilibiliKol = 4,
  Kol = 5,
  Gray = 6,
  BilibiliGray = 7,
  InlandMax = 99,
  En = 100,
  EnQATest = 101,
  EnKol = 102,
  EnMax = 199,
  Jp = 200,
  JpQATest = 201,
  JpMax = 299,
  Kr = 300,
  KrQATest = 301,
  KrMax = 399,
  Tw = 400,
  TwQATest = 401,
  TwMax = 499
}

function Consts.GameChannelType.IsBilibili(channelType)
  if channelType == nil then
    channelType = cs_MicaSDKManager.Instance.channelId
  end
  if channelType == Consts.GameChannelType.Bilibili or channelType == Consts.GameChannelType.BilibiliQATest or channelType == Consts.GameChannelType.BilibiliKol or channelType == Consts.GameChannelType.BilibiliGray then
    return true
  end
  return false
end

function Consts.GameChannelType.IsPnSdk(channelType)
  if channelType == nil then
    channelType = cs_MicaSDKManager.Instance.channelId
  end
  if channelType == Consts.GameChannelType.Kr or channelType == Consts.GameChannelType.KrQATest or channelType == Consts.GameChannelType.Tw or channelType == Consts.GameChannelType.TwQATest then
    return true
  end
  return false
end

function Consts.GameChannelType.IsOversea(channelType)
  if channelType == nil then
    channelType = cs_MicaSDKManager.Instance.channelId
  end
  if channelType == Consts.GameChannelType.En or channelType == Consts.GameChannelType.EnQATest or channelType == Consts.GameChannelType.Jp or channelType == Consts.GameChannelType.JpQATest then
    return true
  end
  return false
end

function Consts.GameChannelType.IsInland(channelType)
  if channelType == nil then
    channelType = cs_MicaSDKManager.Instance.channelId
  end
  if channelType < Consts.GameChannelType.InlandMax and channelType >= Consts.GameChannelType.Official then
    return true
  end
  return false
end

function Consts.GameChannelType.IsJp(channelType)
  if channelType == nil then
    channelType = cs_MicaSDKManager.Instance.channelId
  end
  if channelType < Consts.GameChannelType.JpMax and channelType >= Consts.GameChannelType.Jp then
    return true
  end
  return false
end

function Consts.GameChannelType.IsEn(channelType)
  if channelType == nil then
    channelType = cs_MicaSDKManager.Instance.channelId
  end
  if channelType < Consts.GameChannelType.EnMax and channelType >= Consts.GameChannelType.En then
    return true
  end
  return false
end

function Consts.GameChannelType.IsTw(channelType)
  if channelType == nil then
    channelType = cs_MicaSDKManager.Instance.channelId
  end
  if channelType < Consts.GameChannelType.TwMax and channelType >= Consts.GameChannelType.Tw then
    return true
  end
  return false
end

function Consts.GameChannelType.IsKr(channelType)
  if channelType == nil then
    channelType = cs_MicaSDKManager.Instance.channelId
  end
  if channelType < Consts.GameChannelType.KrMax and channelType >= Consts.GameChannelType.Kr then
    return true
  end
  return false
end
