UIBgmHelper = {}
local MainDefault = 2
local AircraftDefault = 4

function UIBgmHelper.GetDefaultBgm(type)
  if type == EnumBgmType.E_Bgm_Main then
    return MainDefault
  elseif type == EnumBgmType.E_Bgm_AirCraft then
    return AircraftDefault
  end
end

function UIBgmHelper.PlayMainBgm()
  local module = GameGlobal.GetModule(RoleModule)
  local id = module:UI_GetMusic(EnumBgmType.E_Bgm_Main)
  if id == 0 then
    id = MainDefault
  end
  if not Cfg.cfg_role_music[id] then
    Log.fatal("找不到主界面bgm配置，播默认bgm:", id)
    id = MainDefault
  end
  AudioHelperController.PlayBGM(Cfg.cfg_role_music[id].AudioID)
end

function UIBgmHelper.PlyAircraftBgm()
  local module = GameGlobal.GetModule(RoleModule)
  local id = module:UI_GetMusic(EnumBgmType.E_Bgm_AirCraft)
  if id == 0 then
    id = AircraftDefault
  end
  if not Cfg.cfg_role_music[id] then
    Log.fatal("找不到风船bgm配置，播默认bgm:", id)
    id = AircraftDefault
  end
  AudioHelperController.PlayBGM(Cfg.cfg_role_music[id].AudioID)
end

function UIBgmHelper.FormatTime(s)
  local minute = math.floor(s / 60)
  local second = s % 60
  return string.format("%02d:%02d", minute, second)
end

function UIBgmHelper.PlayDrawcardBgm()
  AudioHelperController.PlayBGM(CriAudioIDConst.BGMDrawcard, 0)
end
