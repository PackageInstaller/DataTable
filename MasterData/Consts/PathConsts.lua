local cs_PathConsts = CS.PathConsts
local cs_FilePathHelper = CS.FilePathHelper.Instance
local CS_LanguageGlobal = CS.LanguageGlobal
local SkinEnum = require("Game.Skin.SkinEnum")
PathConsts = {
  SpriteAtlasExtension = cs_PathConsts.SpriteAtlasExtension,
  PrefabExtension = cs_PathConsts.PrefabExtension,
  DataExtension = ".dat",
  UnityConfigAssetExtension = ".asset",
  SpriteAtlasPathHead = cs_PathConsts.SpriteAtlasPathHead,
  UIPrefabPathHead = cs_PathConsts.UIPrefabPathHead,
  ModelPrefabPath = cs_PathConsts.ModelPrefabPath,
  OasisBuildingPath = cs_PathConsts.OasisBuildingPrefabPath,
  OasisBuildingEffectPath = "Res/Effect/Prefabs/OasisBuilding/",
  SectorPath = "Res/Model/Sector/",
  PbFilePath = "Res/pb/",
  SkillIconPathHead = "SkillIcons/",
  CharacterPicPathHead = cs_PathConsts.CharacterPicPathHead,
  CharacterBigImgPrefabHead = cs_PathConsts.CharacterBigImgPrefabHead,
  FriendshipDungeonPicHead = "HeroStoryLevel/",
  MaterialDungeonPicHead = "MaterialLevel/Background/",
  OasisBuildingIconPath = "OasisBuilding/",
  AchievementIconPath = "Res/Images/AchievementIcon/",
  AchivLevelIconPath = "AchivLevelIcon/",
  MaterialDungeonBGIconPath = "MaterialLevel/Icon/",
  DormPath = "Res/Model/Dorm/",
  DormRoomPath = "Res/Model/Dorm/Rooms/",
  DormFntPath = "Res/Model/Dorm/Furnitures/",
  AvgImgPath = "Avg/",
  AvgNounImgPath = "Avg/NounDes/",
  FormationPath = "Res/Model/Formation/",
  ShowCharacterSkinPath = "Res/Model/Formation/",
  ShowFairyPath = "Res/Model/Fairy/",
  CampIconPath = "CampIcon/",
  LuckyRafflePath = "Activity/EventLuckyRaffle/",
  SpecWeaponPath = "SpecWeapon/",
  EffectPath = "Res/Effect/Prefabs/",
  PersistentUserDataPath = cs_PathConsts.PersistentDataPath .. "save_data/user_data/",
  PersistentUserChatDataPath = cs_PathConsts.PersistentDataPath .. "save_data/user_chat_data/",
  PersistentDataPath = cs_PathConsts.PersistentDataPath .. "save_data/",
  PersistentDeployDataPath = cs_PathConsts.PersistentDataPath .. "save_data/deploy_data/",
  PersistentBannerCachePath = cs_PathConsts.PersistentDataPath .. "res_cache/banner_img/",
  PersistentNoticeCachePath = cs_PathConsts.PersistentDataPath .. "res_cache/notice_cache/",
  PersistentShareImgPath = cs_PathConsts.PersistentDataPath .. "shareImgTemp.png",
  SectorBackgroundPath = "SectorLevel/",
  BannerPicPath = "HomeAdv/",
  LotteryPicPath = "Lottery/",
  LotteryModelPath = "Res/Model/LotteryShow/",
  SeceneIconPicPath = "SectorIcon/",
  ImagePath = "Res/Images/",
  FactoryPath = "Res/Model/Factory/",
  CampVideoPath = "GetHero/",
  UltSkillVideoPath = "UltSkill/",
  SectorLoadVideoPath = "SectorLoading/",
  SectorCompleteVideoPath = "SectorAnimation/",
  LuaSkillScriptsPath = cs_PathConsts.LuaSkillScriptsPath,
  TreeDCanvasPath = "Res/UIPrefabs/Common/",
  FestivalSignPath = "Res/UIPrefabs/FestivalSignIn/",
  ShopGiftBgPath = "Shop/GiftBag/",
  ShopRecommendPath = "Shop/Recommend/",
  ShopFurnitureThemePath = "Shop/FurnitureTheme/",
  GuideTipsPathHead = "Guide/",
  UserInfoDressUpPathHead = "UserInfoDressUp/",
  TitleBgPath = "TitleIcon",
  FestivalBackgroundPath = "FestivalSign/",
  ActBlackHoleBackgroundPath = "Activity/BlackHole/",
  HeroSkinThemePicPath = "HeroSkinTheme/",
  CharDunStageIconPath = "CharDunMapImage/",
  CharDunPrefabPath = "Res/UIPrefabs/CharacterDungeon/",
  CharDunEntrancePicPath = "Activity/CharDun/",
  CharDunPicPath = "CharDun/",
  MainSceneBgTexturePath = "MainSceneBg/",
  MainSceneDeckPrefabPath = "Res/Effect/Prefabs/MainSceneDeck/",
  WhiteDayPath = "Activity/WhiteDay22/",
  AprilFoolPath = "Activity/AprilFool22/",
  BrotatoCharacterPath = "Res/Model/Fbx/Character/",
  WarChessCharacterPath = "Res/Model/Fbx/Character/",
  WarChessPrefabPath = "Res/WarChess/GridPrefabs/",
  WarChessAreaPrefabPath = "Res/WarChess/AreaPrefab/",
  WarChessUINodePath = "Res/UIPrefabs/WarChess/",
  WarChessEffectPath = "FX/Warchess/ScenesEffect/",
  ActivityOpenVedio = "Activity/",
  ActivityInvitation = "Activity/Invitation/",
  ActivityBattlePass = "BattlePassActivity/",
  ActivityDivergent = "Activity/Divergent/",
  FairyPicPath = "Res/Fairy/",
  FairyPrefabPath = "Res/Fairy/",
  ActivityFlipCard = "Activity/FlipCard/",
  ExplorationBackgroundPath = "Exploration/",
  ActivityLadderGift = "Activity/LadderGift/"
}

function PathConsts:GetImagePath(name)
  return self.ImagePath .. name .. ".png"
end

function PathConsts:GetHeroVideoPath(videoName)
  return self.CampVideoPath .. videoName
end

function PathConsts:GetSectorLoadVideoPath(videoName)
  return self.SectorLoadVideoPath .. videoName
end

function PathConsts:GetFullPrefabPath(prefabPath)
  return prefabPath .. self.PrefabExtension
end

function PathConsts:GetModelPrefabPath(prefabName)
  return self.ModelPrefabPath .. prefabName .. self.PrefabExtension
end

function PathConsts:GetUIPrefabPath(resName)
  if string.IsNullOrEmpty(resName) then
    return ""
  else
    return self.UIPrefabPathHead .. resName .. self.PrefabExtension
  end
end

function PathConsts:GetOasisBuildingPrefabPath(resName)
  if string.IsNullOrEmpty(resName) then
    return ""
  else
    return self.OasisBuildingPath .. resName .. self.PrefabExtension
  end
end

function PathConsts:GetOasisBuildingEffetPrefabPath(resName)
  if string.IsNullOrEmpty(resName) then
    return ""
  else
    return self.OasisBuildingEffectPath .. resName .. self.PrefabExtension
  end
end

function PathConsts:GetOasisPrefabPath(resName)
  if string.IsNullOrEmpty(resName) then
    return ""
  else
    return "Res/Model/Oasis/" .. resName .. self.PrefabExtension
  end
end

function PathConsts:GetSectorPrefabPath(resName)
  if string.IsNullOrEmpty(resName) then
    return ""
  else
    return self.SectorPath .. resName .. self.PrefabExtension
  end
end

function PathConsts:GetSkillIconPath(skillIcon)
  return self:GetResImagePath(self.SkillIconPathHead .. skillIcon .. ".png")
end

function PathConsts:GetProfessorModelPath(sexName, resName)
  return self.CharacterPicPathHead .. sexName .. "/" .. resName .. self.PrefabExtension
end

function PathConsts:GetCharacterTexturePath(path)
  return self.CharacterPicPathHead .. path .. ".png"
end

function PathConsts:GetCharacterLive2DPath(resName, fromWhere)
  resName = PlayerDataCenter.skinData:RecitifySkinRes(resName, fromWhere, function(resName)
    return cs_FilePathHelper:GetAssetLangPath(self.CharacterPicPathHead .. resName .. "/L2D/" .. resName, self.PrefabExtension)
  end)
  return cs_FilePathHelper:GetAssetLangPath(self.CharacterPicPathHead .. resName .. "/L2D/" .. resName, self.PrefabExtension)
end

function PathConsts:GetCharacterFaceImgPath(resName, faceId)
  return self.CharacterPicPathHead .. resName .. "/Face/" .. resName .. "_face_" .. faceId .. ".png"
end

function PathConsts:GetCharacterPicPath(resName, fromWhere)
  resName = PlayerDataCenter.skinData:RecitifySkinRes(resName, fromWhere, function(resName)
    return self.CharacterPicPathHead .. resName .. "/npic_" .. resName .. ".png"
  end)
  return self.CharacterPicPathHead .. resName .. "/npic_" .. resName .. ".png"
end

function PathConsts:GetCharacterBigImgPrefabPath(resName, fromWhere)
  resName = PlayerDataCenter.skinData:RecitifySkinRes(resName, fromWhere, function(resName)
    return cs_FilePathHelper:GetAssetLangPath(self.CharacterBigImgPrefabHead .. resName .. "/lpic_" .. resName, self.PrefabExtension)
  end)
  return cs_FilePathHelper:GetAssetLangPath(self.CharacterBigImgPrefabHead .. resName .. "/lpic_" .. resName, self.PrefabExtension)
end

function PathConsts:GetCharacterBigPicPath(resName, fromWhere)
  resName = PlayerDataCenter.skinData:RecitifySkinRes(resName, fromWhere, function(resName)
    return self.CharacterPicPathHead .. resName .. "/lpic_" .. resName .. ".png"
  end)
  return self.CharacterPicPathHead .. resName .. "/lpic_" .. resName .. ".png"
end

function PathConsts:GetCharacterSmallPicPath(resName, fromWhere)
  resName = PlayerDataCenter.skinData:RecitifySkinRes(resName, fromWhere, function(resName)
    return self.CharacterPicPathHead .. resName .. "/spic_" .. resName .. ".png"
  end)
  return self.CharacterPicPathHead .. resName .. "/spic_" .. resName .. ".png"
end

function PathConsts:GetCharacterModelPathEx(prefabName, specSign, perfectLevel)
  specSign = specSign or 0
  perfectLevel = perfectLevel or -1
  return cs_FilePathHelper:GetCharacterModelPathEx(prefabName, specSign, perfectLevel)
end

function PathConsts:GetCharacterActivityLobbyModelPath(prefabName)
  return self.CharacterBigImgPrefabHead .. prefabName .. "/amodel_" .. prefabName .. self.PrefabExtension
end

function PathConsts:GetCharacterDormModelPath(prefabName, specSign)
  specSign = specSign or 0
  if 0 < specSign then
    local modelSignCfg = ConfigData.model_spec_sign[specSign]
    if modelSignCfg ~= nil then
      return self.CharacterBigImgPrefabHead .. prefabName .. "/" .. modelSignCfg.pre_sign .. "dmodel_" .. prefabName .. self.PrefabExtension
    end
  end
  return self.CharacterBigImgPrefabHead .. prefabName .. "/dmodel_" .. prefabName .. self.PrefabExtension
end

function PathConsts:GetCharacterFightModelPath(prefabName, specSign)
  specSign = specSign or 0
  if 0 < specSign then
    local modelSignCfg = ConfigData.model_spec_sign[specSign]
    if modelSignCfg ~= nil then
      return self.CharacterBigImgPrefabHead .. prefabName .. "/" .. modelSignCfg.pre_sign .. "fmodel_" .. prefabName .. self.PrefabExtension
    end
  end
  return self.CharacterBigImgPrefabHead .. prefabName .. "/fmodel_" .. prefabName .. self.PrefabExtension
end

function PathConsts:GetFriendshipDungeonPicPath(resName)
  return self:GetResImagePath(self.FriendshipDungeonPicHead .. "HeroStory" .. resName .. ".png")
end

function PathConsts:GetMaterailDungeonPicPath(resName)
  return self:GetResImagePath(self.MaterialDungeonPicHead .. "MatBg" .. resName .. ".png")
end

function PathConsts:GetOasisBuildingIconPath(resName)
  return self:GetResImagePath(self.OasisBuildingIconPath .. resName .. ".png")
end

function PathConsts:GetMaterialDungeonBGIconPath(resName)
  return self:GetResImagePath(self.MaterialDungeonBGIconPath .. resName .. ".png")
end

function PathConsts:GetAchivLevelIconPath(resName)
  return self:GetResImagePath(self.AchivLevelIconPath .. resName .. ".png")
end

function PathConsts:GetDormPath(resName)
  return self.DormPath .. resName .. self.PrefabExtension
end

function PathConsts:GetDormRoomPath(resName)
  return self.DormRoomPath .. resName .. self.PrefabExtension
end

function PathConsts:GetDormFntPath(resName)
  return cs_FilePathHelper:GetAssetLangPath(self.DormFntPath .. resName, self.PrefabExtension)
end

function PathConsts:GetVideoFilePathWitLang(videoPath)
  return cs_FilePathHelper:GetVideoFilePathWitLang(videoPath)
end

function PathConsts:GetDormFntThemeIconPath(resName)
  return self:GetResImagePath("Dorm/FurnitureTheme/" .. resName .. ".png")
end

function PathConsts:GetAvgImgPath(name)
  return self:GetResImagePath(self.AvgImgPath .. name .. ".png")
end

function PathConsts:GetFormationModelPath(prefabName)
  return self.FormationPath .. prefabName .. self.PrefabExtension
end

function PathConsts:GetCampPicPath(resName)
  return self:GetResImagePath(self.CampIconPath .. resName .. ".png")
end

function PathConsts:GetLuckyRafflePicPath(resName)
  return self:GetResImagePath(self.LuckyRafflePath .. resName .. ".png")
end

function PathConsts:GetSpecWeaponPicPath(resName)
  return self:GetResImagePath(self.SpecWeaponPath .. resName .. ".png")
end

function PathConsts:GetAvgNounImgPath(ImgName)
  return self:GetResImagePath(self.AvgNounImgPath .. ImgName .. ".png")
end

function PathConsts:GetAtlasAssetPath(atlasName)
  return self.SpriteAtlasPathHead .. atlasName .. self.SpriteAtlasExtension
end

function PathConsts:GetEffectPath(prefabName)
  return self.EffectPath .. prefabName .. self.PrefabExtension
end

function PathConsts:GetPersistentUserDataPath(strplayerId)
  return self.PersistentUserDataPath .. strplayerId .. self.DataExtension
end

function PathConsts:GetPersistentUserChatDataPath(strplayerId)
  return self.PersistentUserChatDataPath .. strplayerId .. self.DataExtension
end

function PathConsts:GetPersistentSystemDataPath(fileName)
  return self.PersistentDataPath .. fileName .. self.DataExtension
end

function PathConsts:GetPersistentDeployDataPath(strplayerId, fileName)
  return self.PersistentDeployDataPath .. strplayerId .. "/" .. fileName .. self.DataExtension
end

function PathConsts:GetPersistentBannerCachePath(fileName)
  return self.PersistentBannerCachePath .. fileName .. ".png"
end

function PathConsts:GetPersistentNoticeCachePath(fileName)
  return self.PersistentNoticeCachePath .. fileName .. ".png"
end

function PathConsts:GetSectorBackgroundPath(resName)
  return self:GetResImagePath(self.SectorBackgroundPath .. resName .. ".png")
end

function PathConsts:GetSectorStrategyOverviewBgPath(resName)
  return self:GetResImagePath("StrategyOverview/" .. resName .. ".png")
end

function PathConsts:GetBannerPicPath(fileName)
  return self:GetResImagePath(self.BannerPicPath .. fileName .. ".png")
end

function PathConsts:GetLotteryPicPath(fileName)
  return self:GetResImagePath(self.LotteryPicPath .. fileName .. ".png")
end

function PathConsts:GetLotteryModelPath(fileName)
  return self.LotteryModelPath .. fileName .. self.PrefabExtension
end

function PathConsts:GetSeceneIconPicPath(resName)
  return self:GetResImagePath(self.SeceneIconPicPath .. resName .. ".png")
end

function PathConsts:GetFactoryPath(resName)
  return self.FactoryPath .. resName .. self.PrefabExtension
end

function PathConsts:GetSpriteAtlasPath(resName)
  return self.SpriteAtlasPathHead .. resName .. ".spriteatlas"
end

function PathConsts:GetTreeDCanvasPath(canvasName)
  return self.TreeDCanvasPath .. canvasName .. ".prefab"
end

function PathConsts:GetShopGiftBgPath(resName)
  return self:GetResImagePath(self.ShopGiftBgPath .. resName .. ".png")
end

function PathConsts:GetShopFurnitureThemePath(resName)
  return self:GetResImagePath(self.ShopFurnitureThemePath .. resName .. ".png")
end

function PathConsts:GetShopRecommendPath(resName)
  return self:GetResImagePath(self.ShopRecommendPath .. resName .. ".png")
end

function PathConsts:GetGuideTipsPath(path, resName)
  return self:GetResImagePath(self.GuideTipsPathHead .. path .. "/" .. resName .. ".png")
end

function PathConsts:GetUserDressUpPath(resName)
  return self:GetResImagePath(self.UserInfoDressUpPathHead .. resName .. ".png")
end

function PathConsts:GetUserTitleBgPath(resName)
  return self.SpriteAtlasPathHead .. self.TitleBgPath .. "/" .. resName .. ".png"
end

function PathConsts:GetSectorCompleteVideoPath(sectorId)
  return self.SectorCompleteVideoPath .. "SectorAnimation_" .. sectorId
end

function PathConsts:GetFestivalSignPath(path)
  return self.FestivalSignPath .. path .. ".prefab"
end

function PathConsts:GetFestivalBgPath(path)
  return self:GetResImagePath(self.FestivalBackgroundPath .. path .. ".png")
end

function PathConsts:GetActBlackHoleBgPath(path)
  return self:GetResImagePath(self.ActBlackHoleBackgroundPath .. path .. ".png")
end

function PathConsts:GetExplorationBgPath(path)
  return self:GetResImagePath(self.ExplorationBackgroundPath .. path .. ".png")
end

function PathConsts:GetHeroSkinThemePicPath(path)
  return self:GetResImagePath(self.HeroSkinThemePicPath .. path .. ".png")
end

function PathConsts:GetDynHeadPath(resName)
  return self:GetResImagePath("DynHead/" .. resName .. ".png")
end

function PathConsts:GetDynHeadFramePath(resName)
  return "Res/Effect/Headframe/" .. resName .. ".prefab"
end

function PathConsts:GetShowCharacterSkinPrefabPath(prefabName)
  return self.ShowCharacterSkinPath .. prefabName .. self.PrefabExtension
end

function PathConsts:GetShowCharacterSkinPrefabPath(prefabName)
  return self.ShowCharacterSkinPath .. prefabName .. self.PrefabExtension
end

function PathConsts:GetShowFairyPrefabPath(prefabName)
  return self.ShowFairyPath .. prefabName .. self.PrefabExtension
end

function PathConsts:GetCharDunStageIconPath(resName)
  return self:GetResImagePath(self.CharDunStageIconPath .. resName .. ".png")
end

function PathConsts:GetCharDunEntrancePicPath(resName)
  return self:GetResImagePath(self.CharDunEntrancePicPath .. resName .. ".png")
end

function PathConsts:GetCharDunPrefabPath(resName)
  return self.CharDunPrefabPath .. resName .. ".prefab"
end

function PathConsts:GetCharDunPath(resName)
  return self:GetResImagePath(self.CharDunPicPath .. resName .. ".png")
end

function PathConsts:GetCharDunVideoPath(heroID)
  return "CharDun/" .. "CharDun_" .. heroID
end

function PathConsts:GetCharDunVideoFullPath(heroID)
  return "Res/media/videos/CharDun/" .. "CharDun_" .. heroID .. ".usm"
end

function PathConsts:GetStaffVideoFullPath()
  return "Staff/staff"
end

function PathConsts:GetAvgVideoPath(pathName)
  return "avg/" .. pathName
end

function PathConsts:GetGuideVideoPath(path, name)
  return "Guide/" .. path .. "/" .. name
end

function PathConsts:GetMainSceneBgPath(resName)
  return self:GetResImagePath(self.MainSceneBgTexturePath .. resName .. ".png")
end

function PathConsts:GetMainSceneDeckPath(resName)
  return self.MainSceneDeckPrefabPath .. resName .. ".prefab"
end

function PathConsts:GetMainSceneMatPath(resName)
  return "Res/Materials/HomeMainBg/" .. resName .. ".mat"
end

function PathConsts:GetWhiteDayPhotoPath(resName)
  return self:GetResImagePath(self.WhiteDayPath .. resName .. ".png")
end

function PathConsts:GetWhiteDayLinePath(resName)
  return self:GetResImagePath(self.WhiteDayPath .. resName .. ".png")
end

function PathConsts:GetMainBgThumbnail(resName)
  return self:GetResImagePath("MainSceneBgThumbnail/" .. resName .. ".png")
end

function PathConsts:GetResImagePath(relPath)
  return cs_FilePathHelper:GetResImagePath(relPath)
end

function PathConsts:GetAprilFoolLevelPath(resName)
  return self:GetResImagePath(self.AprilFoolPath .. resName .. ".png")
end

function PathConsts:GetActivityComebackPrefab(resName)
  return "Res/UIPrefabs/EventComeback/" .. resName .. ".prefab"
end

function PathConsts:GetActivityInvatationPath(resName)
  return self:GetResImagePath(self.ActivityInvitation .. resName .. ".png")
end

function PathConsts:GetActivityBattlePassPath(resName)
  return self:GetResImagePath(self.ActivityBattlePass .. resName .. ".png")
end

function PathConsts:GetActivityDivergentPath(resName)
  return self:GetResImagePath(self.ActivityDivergent .. resName .. ".png")
end

function PathConsts:GetActivityFlipCardPath(resName)
  return self:GetResImagePath(self.ActivityFlipCard .. resName .. ".png")
end

function PathConsts:GetActivityLadderGiftPath(resName)
  return self:GetResImagePath(self.ActivityLadderGift .. resName .. ".png")
end

function PathConsts:GetActivityLobbyUIPrefab(resName)
  return "Res/UIPrefabs/ActivityLobby/" .. resName .. ".prefab"
end

function PathConsts:GetActivityInteractUIPrefab(resName)
  return "Res/UIPrefabs/ActivityInteract/" .. resName .. ".prefab"
end

function PathConsts:GetActivityLobbyMainUIPrefab(resName)
  return "Res/UIPrefabs/ActivityLobbyMain/" .. resName .. ".prefab"
end

function PathConsts:GetRoundRewardPoolPic(resName)
  return self:GetResImagePath("RewardPool/" .. resName .. ".png")
end

function PathConsts:GetCharacterAvatarMainPrefabPath()
  return "Res/Avatar/AvatarMain.prefab"
end

function PathConsts:GetCharacterAvatarPartPrefabPath(avatarName, prefabName)
  return "Res/Avatar/" .. avatarName .. "/" .. prefabName .. ".prefab"
end

function PathConsts:GetCharacterPrefab(resName)
  return "Res/Character/" .. resName .. ".prefab"
end

function PathConsts:GetCarnivalPic(resName)
  return self:GetResImagePath("Activity/Carnival22/" .. resName .. ".png")
end

function PathConsts:GetMiniGameItemPic(resName)
  return self:GetResImagePath("Activity/MiniGame/" .. resName .. ".png")
end

function PathConsts:GetActLimitTaskPic(resName)
  return self.ImagePath .. "Activity/LimitTask/" .. resName .. ".png"
end

function PathConsts:GetHandbookItemPic(resName)
  return self:GetResImagePath("Handbook/" .. resName .. ".png")
end

function PathConsts:GetActivityKeyExertionPath(resName)
  return self:GetResImagePath("Activity/LuckyBag/" .. resName .. ".png")
end

function PathConsts:GetActivityPath(resName)
  return self:GetResImagePath("Activity/" .. resName .. ".png")
end

function PathConsts:GetBrotatoCharCtrlPath(charName)
  return PathConsts.BrotatoCharacterPath .. charName .. "/" .. charName .. "_brotato_animator.controller"
end

function PathConsts:GetWarChessCharCtrlPath(charName)
  return PathConsts.WarChessCharacterPath .. charName .. "/" .. charName .. "_warchess_animator.controller"
end

function PathConsts:GetWarChessPrefabPath(resName)
  return PathConsts.WarChessPrefabPath .. resName .. self.PrefabExtension
end

function PathConsts:GetWarChessAreaPrefabPath(resName)
  return PathConsts.WarChessAreaPrefabPath .. resName .. self.PrefabExtension
end

function PathConsts:GetWarChessUINodePrefabPath(resName)
  return self.WarChessUINodePath .. resName .. ".prefab"
end

function PathConsts:GetWarChessEffectPrefabPath(name)
  return PathConsts.WarChessEffectPath .. name .. self.PrefabExtension
end

function PathConsts:GetSpecWeaponVideoPath(name)
  return "SpecWeapon/" .. name
end

function PathConsts:GetGiftPopBg(resName)
  return PathConsts.ImagePath .. "GiftPopBg/" .. resName .. ".png"
end

function PathConsts:GetTinyGamePrefabPath(name)
  return "Res/Model/TinyGame/Prefabs/" .. name .. self.PrefabExtension
end

function PathConsts:GetVowPrefabPath(name)
  return "Res/Model/VowSystem/" .. name .. self.PrefabExtension
end

function PathConsts:GetWarChessSeasonPic(resName)
  return self.ImagePath .. "WarChessSeason/" .. resName .. ".png"
end

function PathConsts:GetCharDunVer2Bg(name)
  return PathConsts.ImagePath .. "CharDun/Ver2/" .. name .. ".png"
end

function PathConsts:GetStrategyOverviewItem(name)
  return "Res/UIPrefabs/StrategyOverViewItem/" .. name .. ".prefab"
end

function PathConsts:GetSectorEntrancTex(name)
  return self:GetResImagePath("SectorEntrance/" .. name .. ".png")
end

function PathConsts:GetActivityOpenVedio(name)
  return PathConsts.ActivityOpenVedio .. name
end

function PathConsts:GetActivitySaveMoney(name)
  return self:GetResImagePath("Activity/Savemoney/" .. name .. ".png")
end

function PathConsts:GetSkyboxMat(resName)
  return "Res/Materials/Skybox/" .. resName .. ".mat"
end

function PathConsts:GetShareRoutePic(name)
  return self:GetResImagePath("Activity/" .. name)
end

function PathConsts:GetDeliverySimulatorPic(name)
  return self:GetResImagePath("Delivery/Sector/" .. name .. ".png")
end

function PathConsts:GetActDeliverySimulatorPic(name)
  return self:GetResImagePath("DeliverySimulator/" .. name .. ".png")
end

function PathConsts:GetFairyPicPath(resName)
  return PathConsts.FairyPicPath .. resName .. ".png"
end

function PathConsts:GetFairyPrefabPath(resName)
  return PathConsts.FairyPrefabPath .. resName .. self.PrefabExtension
end

function PathConsts:GetExplorationBGEffect(resName)
  return "FX/UI_effct/UI_Exploration/" .. resName .. self.PrefabExtension
end

function PathConsts:GetExplorationWormholeGoEffect()
  return "FX/UI_effct/UI_Exploration/" .. "FXP_Transition_hd_go" .. self.PrefabExtension
end

function PathConsts:GetExplorationWormholeInEffect()
  return "FX/UI_effct/UI_Exploration/" .. "FXP_Transition_hd_in" .. self.PrefabExtension
end

function PathConsts:GetEventComebackPicPath(resName)
  return self:GetResImagePath("EventComeback/" .. resName .. ".png")
end

function PathConsts:GetReinforceCardBgPath(resName)
  return self:GetResImagePath("ReinforcePlay/" .. resName .. ".png")
end

function PathConsts:GetReinforceLevelBgPath(resName)
  return self:GetResImagePath("ReinforcePlay/SectorPreview/" .. resName .. ".png")
end

function PathConsts:GetMidiPath(resName)
  return "Res/Midi/" .. resName .. ".mid.bytes"
end
