L_Const = L_Const or {}
L_Const.defaultResolution = {width = 1920, height = 1080}
L_Const.gameControl = {
  none = 0,
  firstPerspective = 1,
  threePerspective = 2
}
L_Const.settingType = {
  cameraSpeed = 1,
  uiOffset = 2,
  uiLayout = 3,
  softCamera = 4,
  up = 5,
  down = 6,
  left = 7,
  right = 8,
  dodge1 = 9,
  dodge2 = 10,
  jump = 11,
  walkOrRun = 12,
  interaction = 13,
  switchingRole1 = 14,
  switchingRole2 = 15,
  switchingRole3 = 16,
  switchingRole4 = 17,
  curTask = 18,
  openChat = 19,
  openMouse = 20,
  attack = 21,
  skill = 22,
  ultimateSkill = 23,
  petSkill = 24,
  openBag = 25,
  openTeam = 26,
  openMap = 27,
  openHero = 28,
  openMenu = 29,
  openHome = 30,
  openAdventure = 31,
  openTask = 32,
  openPet = 33,
  equipment = 34,
  frame = 35,
  image = 36,
  renderSet = 37,
  renderAccuracy = 38,
  shadow = 39,
  module = 40,
  specialEffects = 41,
  antiAliasing = 42,
  bgm = 43,
  se = 44,
  cv = 45,
  mute = 46,
  physicalPush = 47,
  language = 48,
  CDK = 49,
  userAgreement = 50,
  smallMap = 51,
  resourceSet = 52,
  outStuck = 53,
  logoutCurAccount = 54,
  text = 55,
  resolution = 56,
  openActivity = 57,
  openMail = 58,
  indicatorHud = 59,
  vSync = 60,
  battleCameraAlign = 61,
  ultimateSkillAnim = 62,
  petSkillAnim = 63,
  petSummonCamera = 64,
  breakCamera = 65,
  switchCamera = 66,
  petTogetherSkillCamera = 67,
  mainHomeTechnology = 68,
  privacyAgreement = 69,
  childAgreement = 70,
  userInfo = 71,
  thirdInfo = 72,
  userCenter = 73,
  petCatch = 74,
  openNoviceTask = 75,
  summonPet = 76,
  hideShowPet = 77,
  scanning = 78,
  petCatalog = 79,
  formationPetConfirm = 80,
  closeAccount = 81,
  colorPreview = 82,
  bright = 83,
  saturation = 84,
  contrast = 85,
  dlss = 91,
  dlssLevel = 87,
  windowMode = 88,
  npcDensityLevel = 89,
  damageTextSize = 90,
  textureQuality = 92,
  openAchieve = 93,
  openSocialRoulette = 94,
  superResolution = 86,
  guideLine = 95,
  customerService = 96,
  heroShadowQuality = 98,
  GIQuality = 99,
  AOQuality = 100,
  reflectQuality = 101,
  depthOfField = 102,
  bloom = 103,
  skinAccuracy = 104,
  bossShow = 105,
  AOI = 106,
  openProductQuick = 107,
  graphicsMemory = 108,
  tutorial = 109,
  heroSkillOpacity = 110,
  kiboSkillOpacity = 111,
  allySkillOpacity = 112,
  enemySkillOpacity = 113,
  grassQuality = 114,
  LightShaft = 115,
  Para = 116,
  LensFlare = 117,
  UVDistort = 118,
  gameAct = 119,
  RetileHlod = 120,
  shadowType = 123,
  cameraDirectionAssist = 124,
  openBattlePass = 126,
  multiPlayerNum = 127,
  OpenGacha = 138,
  OpenEntrustTask = 146,
  openFormTeam = 9996,
  openMOD = 99998
}
L_Const.sdkAgreementType = {
  childAgreement = "children_privacy",
  provacyAgreement = "privacy",
  userAgreement = "user_agreement",
  thirdInfo = "privacy_sdk"
}
L_Const.renderSet = {
  [L_Const.settingType.image] = true,
  [L_Const.settingType.renderSet] = true,
  [L_Const.settingType.renderAccuracy] = true,
  [L_Const.settingType.shadow] = true,
  [L_Const.settingType.module] = true,
  [L_Const.settingType.specialEffects] = true,
  [L_Const.settingType.antiAliasing] = true
}
L_Const.settingText = {
  [L_Const.settingType.equipment] = {
    [1] = "ui_systemMessage_32",
    [2] = "ui_systemMessage_33",
    [3] = "ui_systemMessage_34"
  },
  [L_Const.settingType.frame] = {
    [1] = 60
  },
  [L_Const.settingType.image] = {
    [1] = 0,
    [2] = 1,
    [3] = 2,
    [4] = 3
  },
  [L_Const.settingType.antiAliasing] = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0
  },
  [L_Const.settingType.language] = {
    [1] = C_I18NConst.LanguageChs,
    [2] = C_I18NConst.LanguageJp,
    [3] = C_I18NConst.LanguageKr,
    [4] = C_I18NConst.LanguageEn
  },
  [L_Const.settingType.text] = {
    [1] = C_I18NConst.LanguageChs,
    [2] = C_I18NConst.LanguageCht,
    [3] = C_I18NConst.LanguageJp,
    [4] = C_I18NConst.LanguageKr,
    [5] = C_I18NConst.LanguageEn
  },
  [L_Const.settingType.smallMap] = {
    [1] = true,
    [2] = false
  }
}

function L_Const.settingText:ReadParam(typeKey, index)
  if typeKey == L_Const.settingType.equipment then
    return L_WordsTpl:getValue(self[typeKey][index])
  else
    return self[typeKey][index]
  end
end

function L_Const.settingText:GetParamIdx(typeKey, typeText)
  if L_Const.settingText[typeKey] then
    for i = 1, #L_Const.settingText[typeKey] do
      if L_Const.settingText[typeKey][i] == typeText then
        return i
      end
    end
  end
end

L_Const.settingType_Render_mobile = {
  Render = {
    ["1"] = "0",
    ["2"] = "1",
    ["3"] = "1",
    ["4"] = "2"
  },
  AmalaseaReflection = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "1",
    ["4"] = "2"
  },
  WeatherSkybox = {
    ["1"] = "-1",
    ["2"] = "0",
    ["3"] = "1",
    ["4"] = "2"
  },
  WeatherAO = {
    ["1"] = "-1",
    ["2"] = "-1",
    ["3"] = "-1",
    ["4"] = "-1"
  },
  WeatherFog = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "1",
    ["4"] = "2"
  },
  WeatherRain = {
    ["1"] = "-1",
    ["2"] = "0",
    ["3"] = "1",
    ["4"] = "1"
  },
  WeatherUnderwater = {
    ["1"] = "0",
    ["2"] = "1",
    ["3"] = "1",
    ["4"] = "1"
  },
  WeatherSunShaft = {
    ["1"] = "-1",
    ["2"] = "0",
    ["3"] = "1",
    ["4"] = "1"
  },
  WeatherMoonShaft = {
    ["1"] = "-1",
    ["2"] = "0",
    ["3"] = "1",
    ["4"] = "1"
  },
  WeatherLensFlare = {
    ["1"] = "0",
    ["2"] = "1",
    ["3"] = "1",
    ["4"] = "1"
  },
  WeatherAurora = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "1",
    ["4"] = "1"
  },
  WeatherReflection = {
    ["1"] = "-1",
    ["2"] = "0",
    ["3"] = "1",
    ["4"] = "2"
  },
  WeatherThunder = {
    ["1"] = "-1",
    ["2"] = "0",
    ["3"] = "1",
    ["4"] = "1"
  },
  ProjectQualityLevel = {
    ["1"] = "0",
    ["2"] = "1",
    ["3"] = "2",
    ["4"] = "3"
  },
  ProjectFPS = {
    ["1"] = "30",
    ["2"] = "30",
    ["3"] = "30",
    ["4"] = "30"
  },
  ProjectAnisoLevel = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "0",
    ["4"] = "0"
  },
  BloomDownSample = {
    ["1"] = "4",
    ["2"] = "4",
    ["3"] = "2",
    ["4"] = "2"
  },
  BigworldGrassQuality = {
    ["1"] = "1",
    ["2"] = "1",
    ["3"] = "1",
    ["4"] = "1"
  }
}
L_Const.settingType_Shadow_mobile = {
  MainLightShadow = {
    ["1"] = "0",
    ["2"] = "1",
    ["3"] = "1"
  },
  ShadowQualityFeatureSetting_mainLightSoftShadow = {
    ["1"] = "0",
    ["2"] = "1",
    ["3"] = "1"
  },
  ShadowQualityFeatureSetting_isEightCascade = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "0"
  },
  ShadowQualityFeatureSetting_pcss = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "0"
  },
  ShadowQualityFeatureSetting_mainLightShadowLazyUpdate = {
    ["1"] = "1",
    ["2"] = "1",
    ["3"] = "1"
  },
  ShadowQualityFeatureSetting_mainLightShadowmapResolution = {
    ["1"] = "512",
    ["2"] = "1024",
    ["3"] = "2048"
  },
  ShadowQualityFeatureSetting_shadowDistanceRate = {
    ["1"] = "0",
    ["2"] = "0.15",
    ["3"] = "0.3"
  },
  ShadowQualityFeatureSetting_maxShadowCascadeCount = {
    ["1"] = "0",
    ["2"] = "2",
    ["3"] = "2"
  },
  ShadowQualityFeatureSetting_additionalLightSoftShadow = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "1"
  },
  ShadowQualityFeatureSetting_additionalLightsShadowmapResolution = {
    ["1"] = "512",
    ["2"] = "1024",
    ["3"] = "2048"
  },
  ShadowQualityFeatureSetting_additionalLightsSplitRowNum = {
    ["1"] = "2",
    ["2"] = "2",
    ["3"] = "2"
  },
  ShadowQualityFeatureSetting_isAdditionalShadowDynamicResolution = {
    ["1"] = "1",
    ["2"] = "1",
    ["3"] = "1"
  },
  BigworldShadowLOD = {
    ["1"] = "5",
    ["2"] = "5",
    ["3"] = "5"
  }
}
L_Const.settingType_Model_mobile = {
  BigworldSceneLOD = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "0"
  },
  BigworldCullingDetectLength = {
    ["1"] = "5",
    ["2"] = "8",
    ["3"] = "10"
  },
  CharacterLodBias = {
    ["1"] = "0.5",
    ["2"] = "0.75",
    ["3"] = "1"
  },
  CharacterMaxLodLevel = {
    ["1"] = "2",
    ["2"] = "2",
    ["3"] = "2"
  },
  BigworldColliderLOD = {
    ["1"] = "5",
    ["2"] = "1",
    ["3"] = "0"
  }
}
L_Const.settingType_Effects_mobile = {
  TransparentQualitySetting_shadowTransparentReceive = {
    ["1"] = "0",
    ["2"] = "1",
    ["3"] = "1"
  },
  TransparentQualitySetting_supportCopyTransparent = {
    ["1"] = "0",
    ["2"] = "1",
    ["3"] = "1"
  },
  TransparentQualitySetting_downsampling = {
    ["1"] = "2",
    ["2"] = "1.5",
    ["3"] = "1"
  },
  TransparentQualitySetting_highQualityBloom = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "0"
  },
  TransparentQualitySetting_bloomSkipIters = {
    ["1"] = "1",
    ["2"] = "1",
    ["3"] = "1"
  }
}
L_Const.settingType_Render_pc = {
  Render = {
    ["1"] = "2",
    ["2"] = "2",
    ["3"] = "3",
    ["4"] = "3"
  },
  AmalaseaReflection = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "1",
    ["4"] = "2"
  },
  WeatherSkybox = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "1",
    ["4"] = "2"
  },
  WeatherAO = {
    ["1"] = "2",
    ["2"] = "2",
    ["3"] = "2",
    ["4"] = "2"
  },
  WeatherFog = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "1",
    ["4"] = "2"
  },
  WeatherRain = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "1",
    ["4"] = "1"
  },
  WeatherUnderwater = {
    ["1"] = "1",
    ["2"] = "1",
    ["3"] = "1",
    ["4"] = "1"
  },
  WeatherSunShaft = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "1",
    ["4"] = "1"
  },
  WeatherMoonShaft = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "1",
    ["4"] = "1"
  },
  WeatherLensFlare = {
    ["1"] = "0",
    ["2"] = "1",
    ["3"] = "1",
    ["4"] = "1"
  },
  WeatherAurora = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "1",
    ["4"] = "1"
  },
  WeatherReflection = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "1",
    ["4"] = "2"
  },
  WeatherThunder = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "1",
    ["4"] = "1"
  },
  ProjectQualityLevel = {
    ["1"] = "2",
    ["2"] = "2",
    ["3"] = "3",
    ["4"] = "3"
  },
  ProjectFPS = {
    ["1"] = "2",
    ["2"] = "1",
    ["3"] = "1",
    ["4"] = "1"
  },
  ProjectAnisoLevel = {
    ["1"] = "0",
    ["2"] = "2",
    ["3"] = "4",
    ["4"] = "4"
  },
  BloomDownSample = {
    ["1"] = "2",
    ["2"] = "2",
    ["3"] = "2",
    ["4"] = "1"
  },
  BigworldGrassQuality = {
    ["1"] = "1",
    ["2"] = "1",
    ["3"] = "1",
    ["4"] = "1"
  }
}
L_Const.settingType_Shadow_pc = {
  MainLightShadow = {
    ["1"] = "0",
    ["2"] = "1",
    ["3"] = "1"
  },
  ShadowQualityFeatureSetting_mainLightSoftShadow = {
    ["1"] = "0",
    ["2"] = "1",
    ["3"] = "1"
  },
  ShadowQualityFeatureSetting_isEightCascade = {
    ["1"] = "0",
    ["2"] = "1",
    ["3"] = "1"
  },
  ShadowQualityFeatureSetting_pcss = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "1"
  },
  ShadowQualityFeatureSetting_mainLightShadowLazyUpdate = {
    ["1"] = "1",
    ["2"] = "1",
    ["3"] = "1"
  },
  ShadowQualityFeatureSetting_mainLightShadowmapResolution = {
    ["1"] = "1024",
    ["2"] = "2048",
    ["3"] = "4096"
  },
  ShadowQualityFeatureSetting_shadowDistanceRate = {
    ["1"] = "0.5",
    ["2"] = "0.8",
    ["3"] = "1"
  },
  ShadowQualityFeatureSetting_maxShadowCascadeCount = {
    ["1"] = "4",
    ["2"] = "4",
    ["3"] = "8"
  },
  ShadowQualityFeatureSetting_additionalLightSoftShadow = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "1"
  },
  ShadowQualityFeatureSetting_additionalLightsShadowmapResolution = {
    ["1"] = "1024",
    ["2"] = "2048",
    ["3"] = "4096"
  },
  ShadowQualityFeatureSetting_additionalLightsSplitRowNum = {
    ["1"] = "2",
    ["2"] = "2",
    ["3"] = "2"
  },
  ShadowQualityFeatureSetting_isAdditionalShadowDynamicResolution = {
    ["1"] = "1",
    ["2"] = "1",
    ["3"] = "1"
  },
  BigworldShadowLOD = {
    ["1"] = "5",
    ["2"] = "1",
    ["3"] = "0"
  }
}
L_Const.settingType_RenderScale_mobile = {
  PipelineRenderScale = {
    ["1"] = "0.6",
    ["2"] = "0.8",
    ["3"] = "0.9",
    ["4"] = "1"
  },
  PipelineUIRenderScale = {
    ["1"] = "1",
    ["2"] = "1",
    ["3"] = "1",
    ["4"] = "1"
  },
  PipelineUIHdrRT = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "1",
    ["4"] = "1"
  }
}
L_Const.settingType_RenderScale_pc = {
  PipelineRenderScale = {
    ["1"] = "0.6",
    ["2"] = "0.8",
    ["3"] = "0.9",
    ["4"] = "1"
  },
  PipelineUIRenderScale = {
    ["1"] = "1",
    ["2"] = "1",
    ["3"] = "1",
    ["4"] = "1"
  },
  PipelineUIHdrRT = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "1",
    ["4"] = "1"
  }
}
L_Const.settingType_Model_pc = {
  BigworldSceneLOD = {
    ["1"] = "1",
    ["2"] = "0",
    ["3"] = "0"
  },
  BigworldCullingDetectLength = {
    ["1"] = "10",
    ["2"] = "10",
    ["3"] = "10"
  },
  CharacterLodBias = {
    ["1"] = "0.6",
    ["2"] = "0.8",
    ["3"] = "1"
  },
  CharacterMaxLodLevel = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "0"
  },
  BigworldColliderLOD = {
    ["1"] = "0",
    ["2"] = "0",
    ["3"] = "0"
  }
}
L_Const.settingType_Effects_pc = {
  TransparentQualitySetting_shadowTransparentReceive = {
    ["1"] = "0",
    ["2"] = "1",
    ["3"] = "1"
  },
  TransparentQualitySetting_supportCopyTransparent = {
    ["1"] = "0",
    ["2"] = "1",
    ["3"] = "1"
  },
  TransparentQualitySetting_downsampling = {
    ["1"] = "1.5",
    ["2"] = "1",
    ["3"] = "1"
  }
}
L_Const.settingKey = {
  [L_Const.settingType.up] = {
    "MainMovement",
    1
  },
  [L_Const.settingType.down] = {
    "MainMovement",
    2
  },
  [L_Const.settingType.left] = {
    "MainMovement",
    3
  },
  [L_Const.settingType.right] = {
    "MainMovement",
    4
  },
  [L_Const.settingType.dodge1] = {"MainEvade", 0},
  [L_Const.settingType.dodge2] = {"MainEvade", 1},
  [L_Const.settingType.jump] = {"MainJump", 0},
  [L_Const.settingType.walkOrRun] = {
    "MainSwitchWalkMove",
    0
  },
  [L_Const.settingType.interaction] = {
    "MainInteraction",
    0
  },
  [L_Const.settingType.switchingRole1] = {
    "MainSwitchHero1",
    0
  },
  [L_Const.settingType.switchingRole2] = {
    "MainSwitchHero2",
    0
  },
  [L_Const.settingType.switchingRole3] = {
    "MainSwitchHero3",
    0
  },
  [L_Const.settingType.summonPet] = {
    "MainCallMount",
    0
  },
  [L_Const.settingType.hideShowPet] = {
    "MainHideShowPet",
    0
  },
  [L_Const.settingType.scanning] = {
    "MainScanning",
    0
  },
  [L_Const.settingType.curTask] = {
    "MainTaskToMap",
    0
  },
  [L_Const.settingType.openChat] = {
    "MainTalking",
    0
  },
  [L_Const.settingType.openMouse] = {
    "MainMouseLock",
    0
  },
  [L_Const.settingType.attack] = {"MainAttack", 0},
  [L_Const.settingType.skill] = {"MainSkill", 0},
  [L_Const.settingType.petCatch] = {
    "MainPetCatch",
    0
  },
  [L_Const.settingType.ultimateSkill] = {
    "MainUltimateSkill",
    0
  },
  [L_Const.settingType.petSkill] = {
    "MainPetPuzzleSkill",
    0
  },
  [L_Const.settingType.openTeam] = {
    "MainOpenTeam",
    0
  },
  [L_Const.settingType.openMap] = {
    "MainOpenMap",
    0
  },
  [L_Const.settingType.openHero] = {
    "MainOpenHero",
    0
  },
  [L_Const.settingType.openMenu] = {"MainBack", 0},
  [L_Const.settingType.openHome] = {
    "MainOpenHome",
    0
  },
  [L_Const.settingType.openAdventure] = {
    "MainOpenAdventure",
    0
  },
  [L_Const.settingType.openTask] = {
    "MainOpenTasks",
    0
  },
  [L_Const.settingType.openPet] = {
    "MainOpenPet",
    0
  },
  [L_Const.settingType.openActivity] = {
    "MainOpenActivity",
    0
  },
  [L_Const.settingType.openNoviceTask] = {
    "MainOpenNoviceTask",
    0
  },
  [L_Const.settingType.mainHomeTechnology] = {
    "MainHomeTechnology",
    0
  },
  [L_Const.settingType.openAchieve] = {
    "MainOpenAchieve",
    0
  },
  [L_Const.settingType.openSocialRoulette] = {
    "MainSocialRoulette",
    0
  },
  [L_Const.settingType.openProductQuick] = {
    "MainProductQuick",
    0
  },
  [L_Const.settingType.petCatalog] = {
    "MainPetCatalog",
    0
  },
  [L_Const.settingType.tutorial] = {
    "MainOpenTutorial",
    0
  },
  [L_Const.settingType.gameAct] = {
    "MainOpenGameAct",
    0
  },
  [L_Const.settingType.openBattlePass] = {
    "MainOpenBattlePass",
    0
  }
}
L_Const.inputControl = {
  keyBoard = 1,
  touch = 2,
  gamepad = 3
}
L_Const.equipment = {
  pc = 1,
  mobile = 2,
  gameConsole = 3
}
L_Const.platform = {
  windows = 2,
  editor = 7,
  iPhone = 8,
  android = 11,
  pS4 = 25,
  xbox = 27,
  switch = 32,
  pS5 = 38
}
L_Const.mailLanguage = {
  [C_I18NConst.LanguageChs] = 1,
  [C_I18NConst.LanguageEn] = 2,
  [C_I18NConst.LanguageJp] = 3,
  [C_I18NConst.LanguageKr] = 4,
  [C_I18NConst.LanguageCht] = 5
}
L_Const.prefsKey = {
  lastPlayerId = "lastPlayerId",
  playerAccount = "dev_LocalAccount",
  playerPassword = "playerPassword",
  localInputIp = "dev_LocalInputIP",
  localInputPort = "dev_LocalInputPort",
  serverId = "serverId",
  serverName = "serverName",
  curTraceTask = "curTraceTask",
  firstSetTemp = "firstSet_temp",
  loginChannel = "saveLoginChannel",
  selectInterim = "selectInterim",
  selectIPButton = "selectIPButton",
  lastImageSetting = "lastImageSetting_%s"
}
L_Const.optionFication = {
  control = 1,
  keycode = 2,
  image = 3,
  voice = 4,
  message = 5,
  language = 6,
  account = 7,
  other = 8
}
L_Const.optionType = {
  text = 1,
  slider = 2,
  toggle = 3,
  textInput = 4,
  button = 5,
  multiMenu = 6,
  changeKey = 7,
  dropMenu = 8,
  imageSet = 9,
  fill = 10
}
L_Const.optionTitleType = {
  first = 1,
  second = 2,
  third = 3,
  fourth = 4
}
L_Const.dlssLevel = {
  ["1"] = "0.5",
  ["2"] = "0.7",
  ["3"] = "0.9"
}
L_Const.superResolutionType = {
  close = 1,
  dlss = 2,
  fsr = 3,
  xess = 4
}
L_Const.settingState = {
  none = 1,
  block = 2,
  hide = 3
}
L_Const.settingBlockType = {hardware = 1}
L_Const.blockInfo = {
  [1] = "notice_option_dlss_01"
}
L_Const.textureQualityLevel = {Memory = 16384, GraphicsMemory = 8192}
L_Const.gamepadSpecialButtonName = {
  D_Pad = "D-Pad",
  D_PadAndUpDown = "D-Pad/UpDown",
  D_PadAndLeftRight = "D-Pad/LeftRight"
}
L_Const.gamepadDeviceToSprite = {
  DualSenseGamepadHID = "GamepadSprite_PS5",
  DualShock4GamepadHID = "GamepadSprite_PS4",
  XInputControllerWindows = "GamepadSprite_XBox",
  SwitchProControllerHID = "GamepadSprite_Switch"
}
L_Const.gamepadUseRouletteInputActions = {
  "MainMountRoulette"
}
