local key = {
  name = 1,
  SeasonID = 2,
  startRadius = 3,
  endRadius = 4,
  highVolume = 5,
  lowVolume = 6,
  isAnimationAudio = 7,
  audioID = 8,
  AnimAudioID = 9
}
local config = {
  ["SceneRoot/Layer3/zone1/S1_pfb_ketouji"] = {
    "SceneRoot/Layer3/zone1/S1_pfb_ketouji",
    8001,
    5,
    1,
    0.5,
    0.1,
    false,
    1804
  },
  ["SceneRoot/Layer2/zone1/S1_pfb_fengxiangbiao"] = {
    "SceneRoot/Layer2/zone1/S1_pfb_fengxiangbiao",
    8001,
    3,
    1,
    0.25,
    0.1,
    false,
    1805
  },
  ["SceneRoot/Layer3/zone1/S1_pfb_leida"] = {
    "SceneRoot/Layer3/zone1/S1_pfb_leida",
    8001,
    5,
    1,
    0.4,
    0.1,
    false,
    1806
  },
  ["SceneRoot/Layer1/eff_Scene_water/water"] = {
    "SceneRoot/Layer1/eff_Scene_water/water",
    8001,
    5,
    1,
    0.4,
    0.1,
    false,
    1802
  },
  ["SceneRoot/Layer7/2/eff_Scene_yanjiang/root"] = {
    "SceneRoot/Layer7/2/eff_Scene_yanjiang/root",
    8001,
    4,
    1,
    0.5,
    0.1,
    false,
    1801
  },
  ["SceneRoot/Layer2/zone2/daxiyi_posion"] = {
    "SceneRoot/Layer2/zone2/daxiyi_posion",
    8001,
    5,
    1,
    0.5,
    0.1,
    true,
    nil,
    {
      idle = -1,
      shou = -1,
      haqi = 1803
    }
  },
  ["SceneRoot/Layer3/zone1/S1_pfb_fengche_test"] = {
    "SceneRoot/Layer3/zone1/S1_pfb_fengche_test",
    8001,
    5,
    1,
    0.5,
    0.1,
    false,
    1807
  }
}
return config, "name", key
