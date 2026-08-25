local CsMaterial = typeof(CS.UnityEngine.Material)
local CsTexture2D = typeof(CS.UnityEngine.Texture2D)
local CommonRes = {}
CommonRes.LogoCn = "UIResources/UIBigImages/UI_Login/UI_Login_Logo_CN.png"
CommonRes.LogoTw = "UIResources/UIBigImages/UI_Login/UI_Login_Logo_TW.png"
CommonRes.LogoEn = "UIResources/UIBigImages/UI_Login/UI_Login_Logo_EN.png"
CommonRes.AllLangFontPathCNBWKS = "LangRes/COM/UI/UI_Font/UI_Text_SYSY_COM_ALL_CN_BWKS.asset"
CommonRes.AllLangFontPathCNXBS = "LangRes/COM/UI/UI_Font/UI_Text_SYSY_COM_ALL_CN_XBS.asset"
CommonRes.AllLangFontPathTWBWKS = "LangRes/COM/UI/UI_Font/UI_Text_SYSY_COM_ALL_TW_BWKS.asset"
CommonRes.AllLangFontPathTWXBS = "LangRes/COM/UI/UI_Font/UI_Text_SYSY_COM_ALL_TW_XBS.asset"
CommonRes.AllLangFontPathJP = "LangRes/COM/UI/UI_Font/UI_Text_SYSY_COM_ALL_JP.asset"
CommonRes.AllLangFontPathKR = "LangRes/COM/UI/UI_Font/UI_Text_SYSY_COM_ALL_KR.asset"
CommonRes.AllLangFontPathTH = "LangRes/COM/UI/UI_Font/UI_Text_SYSY_COM_ALL_TH.asset"
CommonRes.ShaderVariants = "Render/Shader/ShaderVariants.shadervariants"
CommonRes.UILoadingBlockMask = "UI/UI_Common/UI_Common_Prefab/UILoadingBlockMask.prefab"
CommonRes.DbgBattlePanelUrls = "UI/UI_Battle/UI_Battle_Prefab/UI_Battle_Panel_Dbg.prefab"
CommonRes.PvPBattlePanelUrls = "UI/UI_Pvp/UI_Pvp_Prefab/UI_Pvp_Panel_Battle.prefab"
CommonRes.KeeperSkillFilmUrl = "UI/UI_Keeper_Skill/UI_Keeper_Skill_Prefab/UI_Keeper_Panel_Acquire_Film.prefab"
CommonRes.TentacleAppearPrefab = "UI/UI_Battle/UI_Battle_New/UI_Vx_Battle_Tentacle_Open.prefab"
CommonRes.SayeAwakerSelectVxPrefab = "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Battle_B15_02.prefab"
CommonRes.CardChangeDisappearPrefab = "UI/UI_Card/UI_Card_Prefab/UI_Vx_Card_ChangeDisappear.prefab"
CommonRes.CardChangeAppearPrefab = "UI/UI_Card/UI_Card_Prefab/UI_Vx_Card_ChangeAppear.prefab"
CommonRes.CardChangeAppearLoopPrefab = "UI/UI_Card/UI_Card_Prefab/UI_Vx_Card_ChangeLoop.prefab"
CommonRes.AwakerTalentPrefab = "UI/UI_Awaker/UI_Awaker_Prefab/Talent/UI_Awaker_Popup_Talent_Main.prefab"
CommonRes.ChapterItemPrefab = "UI/UI_Chapter/UI_Chapter_Prefab/UI_Chaper_Item_Level_Content.prefab"
CommonRes.ChapterBossPrefab = "UI/UI_Chapter/UI_Chapter_Prefab/UI_Chaper_Item_Boss_Content.prefab"
CommonRes.BossBgPrefab = "MainUIScene/Scene_MainInterface/Prefab/Chaper_Bg_Boss.prefab"
CommonRes.UIMainVxUnlock = "UI/UI_Main/UI_Main_Prefab/UI_Main_VX_Unlock.prefab"
CommonRes.TimelineVideoPath = "GameBasePrefab/TimelineVideo_1.prefab"
CommonRes.TimelineUIVideoPath = "GameBasePrefab/TimelineVideoForUI_Lua.prefab"
CommonRes.CommonBlackTex = "UIResources/UITextures/UI_Common_Black4x4.png"
CommonRes.RedPoint_Dot = "UI/UI_Common/UI_Common_Prefab/RedPoint_Dot.prefab"
CommonRes.RedPoint_Num = "UI/UI_Common/UI_Common_Prefab/RedPoint_Num.prefab"
CommonRes.RedPoint_New = "UI/UI_Common/UI_Common_Prefab/RedPoint_New.prefab"
CommonRes.RedPoint_Gm = "UI/UI_Common/UI_Common_Prefab/RedPoint_Gm.prefab"
CommonRes.BasicAssetList = {
  "Packages/com.unity.render-pipelines.universal/Runtime/Materials/ParticlesUnlit.mat",
  "UIResources/AtlasSource/UI_Common_Image/BlackBackground.png",
  "Icon/TopBarItem/Icon_TopBarItem_1101.png",
  "UI/UI_Common/UI_Common_Prefab/UI_Common_Popup_Tip_3.prefab",
  "UI/UI_Common/UI_Common_Prefab/UI_Common_Popup_Tips_Small.prefab",
  "UI/UI_Common/UI_Common_Prefab/UI_Awaker_Effect_texiao.prefab",
  CommonRes.RedPoint_Dot,
  CommonRes.RedPoint_Num,
  CommonRes.RedPoint_New
}
CommonRes.BattleAssetList = {
  "UI/UI_Battle/UI_Battle_Timeline/Battle_UltiSkill_Painting.prefab",
  "UI/UI_Battle/UI_Battle_Timeline/Battle_UltiSkill_Painting_EX.prefab",
  "TimelineRoot/AwakerPortrait/Battle_UltiSkill_Painting_EX_Common/Battle_UltiSkill_Painting_EX_Common.prefab",
  "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Popup_Battle_Tips_Small.prefab",
  "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Battle_Text_Normal_01.prefab",
  "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Battle_Text_Crit_01.prefab",
  "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Battle_Text_Defense.prefab",
  "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Battle_Text_UltiEnergy.prefab",
  "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Battle_Text_UltiEnergy2.prefab",
  "UI/UI_Battle/UI_Battle_Prefab/Item_Battle_Chaowei_Feature.prefab",
  "UI/UI_Battle/UI_Battle_Prefab/Func_Battle_Blood_Share.prefab",
  "UI/UI_Battle/UI_Battle_Prefab/Func_Battle_Monster_UIRoot_Huge.prefab",
  "UI/UI_Battle/UI_Battle_Prefab/UI_Battle_Item_Intention.prefab",
  "UI/UI_Battle/UI_Battle_Prefab/UI_Battle_Popup_Round_Mine.prefab",
  "UI/UI_Battle/UI_Battle_Prefab/UI_Battle_Popup_Round_Enemy.prefab",
  "UI/UI_Battle/UI_Battle_Prefab/Item_Battle_Card_1.prefab",
  "UI/UI_Battle/UI_Battle_Prefab/UI_Battle_Item_Monster_Bubble.prefab",
  "UI/UI_Battle/UI_Battle_Prefab/UI_Battle_Popup_Elite_Tips.prefab",
  "UI/UI_Battle/UI_Battle_Prefab/UI_Battle_Popup_Open_Tips.prefab",
  CommonRes.SayeAwakerSelectVxPrefab
}
CommonRes.BattleMaterial = {
  Stone = {
    "Render/Material/ActorTemplate/BUnit_Petrifaction_Material.mat",
    CsMaterial
  },
  StoneMaskTex = {
    "Effects/StartUpRes/Noisee_609.png",
    CsTexture2D
  },
  StoneMaskDissolveTex = {
    "Effects/StartUpRes/Noisee_349.png",
    CsTexture2D
  },
  StoneGlowMapTex = {
    "Effects/StartUpRes/Noisee_375.png",
    CsTexture2D
  },
  VajraBody = {
    "Render/Material/ActorTemplate/BUnit_GoldenBody_Material.mat",
    CsMaterial
  },
  VajraBodyTex = {
    "Effects/StartUpRes/E_Co_Flot_23.png",
    CsTexture2D
  },
  IgnoreDamage = {
    "Render/Material/ActorTemplate/BUnit_Perpetual_GoldenBody_Material.mat",
    CsMaterial
  },
  GrayBody = {
    "Render/Material/ActorTemplate/BUnit_Stealth_Material.mat",
    CsMaterial
  }
}
CommonRes.CardBurnMat = "UIResources/VX/Material/UI_Vx_Mat_Common_Burn_002.mat"
CommonRes.CardBorderBurnMat = "UI/UI_Card/UI_Card_Material/UI_Mat_Card_Dissolve.mat"
CommonRes.CardBurnVxPrefab = "UI/UI_Card/UI_Card_Prefab/UI_Vx_Card_Burn.prefab"
CommonRes.BattleCardSPAsset = "UI/SpriteAssets/Battle_Card.asset"
CommonRes.Number2SPAsset = "UI/SpriteAssets/Number2.asset"
CommonRes.AVGScreenEffect = {
  WhiteSmoke = "UI/UI_Story/UI_Story_Prefab/UI_Smoke_White.prefab",
  WhiteSmokeFall = "UI/UI_Story/UI_Story_Prefab/UI_Vx_Avg_Smoke02.prefab",
  WhiteSmokeFallLoop = "UI/UI_Story/UI_Story_Prefab/UI_Vx_Avg_Smoke03.prefab",
  LightRain = "UI/UI_Story/UI_Story_Prefab/UI_Vx_Avg_rain_02.prefab",
  OldFilm = "UI/UI_Story/UI_Story_Prefab/UI_Vx_Avg_Film_01.prefab",
  RedScreen = "UI/UI_Story/UI_Story_Prefab/UI_Vx_Avg_RedScreen_01.prefab",
  RedFlower = "UI/UI_Story/UI_Story_Prefab/UI_Vx_Avg_Flower01.prefab",
  BlackFlower = "UI/UI_Story/UI_Story_Prefab/UI_Vx_Avg_Flower02.prefab",
  BloodSmoke = "UI/UI_Story/UI_Story_Prefab/UI_Story_Bloodsmoke_vx.prefab",
  BlackSmoke = "UI/UI_Story/UI_Story_Prefab/UI_Story_Blacksmoke_vx.prefab",
  RedLoop = "UI/UI_Story/UI_Story_Prefab/UI_Vx_Avg_RedScreen_02.prefab",
  StarLight = "UI/UI_Story/UI_Story_Prefab/UI_Vx_Avg_LightGlow_01.prefab",
  LampLight = "UI/UI_Story/UI_Story_Prefab/UI_Vx_Avg_LightGlow_02.prefab",
  SandStorm = "UI/UI_Story/UI_Story_Prefab/UI_Story_Sandstorm_vx.prefab",
  Erosion = "UI/UI_Story/UI_Story_Prefab/UI_Story_Fading_vx.prefab",
  Smoke = "UI/UI_Story/UI_Story_Prefab/UI_Smoke_Turn.prefab",
  Flame = "UI/UI_Story/UI_Story_Prefab/UI_Vx_Avg_Smoke01.prefab",
  Rain = "UI/UI_Story/UI_Story_Prefab/UI_Vx_Avg_rain_01.prefab",
  Snow = "UI/UI_Story/UI_Story_Prefab/UI_Vx_Avg_snow01.prefab",
  Disturb = "UI/UI_Story/UI_Story_Prefab/UI_Vx_Avg_Disturb.prefab",
  DisturbFx = "UI/UI_Story/UI_Story_Prefab/UI_Vx_Avg_Disturb.prefab",
  SpeedLine = "UI/UI_Story/UI_Story_Prefab/UI_Vx_Avg_SpeedLine_01.prefab",
  KeyWorkEffect = "UI/UI_Story/UI_Story_Prefab/UI_Vx_Avg_Key.prefab"
}
CommonRes.StoryItem = "UI/UI_Story/UI_Story_Prefab/UI_Story_Display_Item.prefab"
CommonRes.AvgNovel = "UI/UI_Story/UI_Story_Prefab/UI_Story_Popup_Novel.prefab"
CommonRes.PVPGlow = {
  Player = "UI/UI_Pvp/UI_Pvp_Prefab/UI_Pvp_VX_Battle_PlayCard_Glow01.prefab",
  Enemy = "UI/UI_Pvp/UI_Pvp_Prefab/UI_Pvp_VX_Battle_PlayCard_Glow02.prefab"
}
CommonRes.StageChapterIcon = {
  [1] = "UIResources/AtlasSource/UI_Dbgcopy_Image/UI_Dbgcopy_StageChapter_01.png",
  [2] = "UIResources/AtlasSource/UI_Dbgcopy_Image/UI_Dbgcopy_StageChapter_02.png"
}
CommonRes.AddtionalAssetList = {
  BlackScreen = "TimelineRoot/InScenes/Res/BlackScreen.prefab"
}
CommonRes.UIPanelAssetList = {
  [Urls.MainPanel] = true,
  [Urls.AwakerBasePanel] = true,
  [Urls.DbgBattlePanel] = true,
  [Urls.BattleExSkillPanel] = true
}
CommonRes.UIPortraitMask = {
  commonMask = "UI/UI_Portrait/UI_Portrait_Material/UI_Portrait_Awaker_Common_Mask.png",
  awakerDetail = "UI/UI_Portrait/UI_Portrait_Material/UI_Portrait_Awaker_Detail_Mask.png",
  awakerPotency = "UI/UI_Portrait/UI_Portrait_Material/UI_Portrait_Awaker_Potency_Mask.png",
  PotencyDetail = "UI/UI_Portrait/UI_Portrait_Material/UI_Portrait_Awaker_Bust_Mask.png",
  summonShowMask = "UI/UI_Portrait/UI_Portrait_Material/UI_Portrait_Summon_Show_Mask.png",
  teamShowMask = "UI/UI_Portrait/UI_Portrait_Material/UI_Portrait_Team_Show_Mask.png",
  UltiSkillMask = "UI/UI_Portrait/UI_Portrait_Material/UI_Portrait_UltiSkill_Mask.png"
}
CommonRes.TimelinePrepared = {
  Common_Enter_Battle = "TimelineRoot/InScenes/MScene/Common/Common_Enter_Battle.prefab",
  Common_Enter_Battle_OneLineCopy = "TimelineRoot/InScenes/MScene/Common/Common_Enter_Battle_OneLineMap.prefab",
  Common_Loading_Battle = "TimelineRoot/InScenes/Loding/Common/Common_Loding_Battle.prefab",
  Common_In_Battle = "TimelineRoot/InScenes/InBScene/Common/Common_In_Battle.prefab",
  Common_Enemy2MyTurn = "TimelineRoot/InScenes/Round/EnemyOur/EnemyOur.prefab",
  Common_My2EnemyTurn = "TimelineRoot/InScenes/Round/OurEnemy/OurEnemy.prefab",
  Common_In_Battle_PvP = "TimelineRoot/InScenes/InBScene/InPVP/Common_In_PVP.prefab"
}
CommonRes.PreloadShaders = {
  "Render/Shader/UI_Shader/UI-Overlaying-Texture.shader"
}
CommonRes.PVPCollectionNameFrame = {
  Weapon = "UIResources/AtlasSource/UI_Pvp_Image/UI_Pvp_PositionColour_7.png",
  KeeperSkill = "UIResources/AtlasSource/UI_Pvp_Image/UI_Pvp_PositionColour_6.png"
}
CommonRes.StageInitialStateBtnFrame = {
  Buff = "UIResources/UIBigImages/UI_Dungeous/UI_Dungeous_Image_Difficulty_Feedback_2.png",
  Debuff = "UIResources/UIBigImages/UI_Dungeous/UI_Dungeous_Image_Difficulty_Feedback_1.png"
}
CommonRes.StageInitialStateBtnIcon = {
  Buff = "UIResources/AtlasSource/UI_Battle_Image/UI_Battle_Icon_Suppress_1.png",
  Debuff = "UIResources/AtlasSource/UI_Battle_Image/UI_Battle_Icon_Suppress_2.png"
}
CommonRes.StageInitialStateTitleFrame = {
  Buff = "UIResources/UIBigImages/UI_Dungeous/UI_Dungeous_Image_Difficulty_Feedback_3.png",
  Debuff = "UIResources/UIBigImages/UI_Dungeous/UI_Dungeous_Image_Difficulty_Feedback_4.png"
}
CommonRes.WupingQualityEffect = {
  Orange = "UI/UI_Common/UI_Common_Prefab/UI_Vx_Item_Goldenglow.prefab",
  Purple = "UI/UI_Common/UI_Common_Prefab/UI_Vx_Item_Purpleglow.prefab",
  Blue = "UI/UI_Common/UI_Common_Prefab/UI_Vx_Item_Blueglow.prefab",
  Green = "UI/UI_Common/UI_Common_Prefab/UI_Vx_Item_Greenglow.prefab"
}
CommonRes.GrayTentacleCd = {
  [3] = "UIResources/AtlasSource/UI_Battle_Image/UI_Battle_TentacleDc_01.png",
  [2] = "UIResources/AtlasSource/UI_Battle_Image/UI_Battle_TentacleDc_02.png",
  [1] = "UIResources/AtlasSource/UI_Battle_Image/UI_Battle_TentacleDc_03.png"
}
CommonRes.RedTentacleCd = {
  [3] = "UIResources/AtlasSource/UI_Battle_Image/UI_Battle_TentacleDc_04.png",
  [2] = "UIResources/AtlasSource/UI_Battle_Image/UI_Battle_TentacleDc_05.png",
  [1] = "UIResources/AtlasSource/UI_Battle_Image/UI_Battle_TentacleDc_06.png"
}
CommonRes.TentacleSlotBg = {
  BattleTentacle = "UIResources/VX/Texture/UI_Battle_Shenhai_Kacao.png",
  BoutTentacle = "UIResources/VX/Texture/UI_Battle_Shenhai_Kacao03.png"
}
CommonRes.SummonSkin = {
  Normal = "Icon/Summon/UI_Summon_D_Icon_AwakerSkin.png",
  Glow = "Icon/Summon/UI_Summon_D_Icon_AwakerSkin.png"
}
CommonRes.SkinIcon = "Icon/Career/Icon_Career_AawakerSkin.png"
CommonRes.PvpHistoryRewardTipsBg = {
  [CareerLevelDefine.CareerLevelType.PvpPreBuilt] = "UIResources/UIBigImages/UI_Large/UI_Large_Pvp/UI_Large_Pvp_Image_TaskReward01.png",
  [CareerLevelDefine.CareerLevelType.PvpDraft] = "UIResources/UIBigImages/UI_Large/UI_Large_Pvp/UI_Large_Pvp_Image_TaskReward02.png",
  [CareerLevelDefine.CareerLevelType.DailyChallenge] = "UIResources/UIBigImages/UI_Large/UI_Large_Pvp/UI_Large_Pvp_Image_TaskReward03.png",
  [CareerLevelDefine.CareerLevelType.RailWay] = "UIResources/UIBigImages/UI_Large/UI_Large_Pvp/UI_Large_Pvp_Image_TaskReward04.png"
}
CommonRes.HourglassIcon = {
  Far = "UIResources/AtlasSource/UI_Common_Image/UI_Common_Countdown_Icon_1.png",
  Middle = "UIResources/AtlasSource/UI_Common_Image/UI_Common_Countdown_Icon_2.png",
  Near = "UIResources/AtlasSource/UI_Common_Image/UI_Common_Countdown_Icon_3.png"
}
CommonRes.FirstTimeLimitedSaleIcon = "UIResources/UIBigImages/UI_Large/UI_Large_Events_Bg/UI_Events_Bg_GiftBag06.png"
CommonRes.MailReadIcon = "UIResources/AtlasSource/UI_Mail_Image/icon_read.png"
CommonRes.MailUnreadIcon = "UIResources/AtlasSource/UI_Mail_Image/icon_unread.png"
CommonRes.FullFavorCardFaceFrame = "UIResources/AtlasSource/2_Icon/UI_Card_Frame_Skill_AwakerFavor.png"
CommonRes.FullFavorExclusiveCardFaceFrame = "UIResources/AtlasSource/2_Icon/UI_Card_Exclusive_Skill_AwakerFavor.png"
CommonRes.TrinketIconMat = "UIResources/VX/Material/UI_Icon_Trinket_Blend.mat"
return CommonRes
