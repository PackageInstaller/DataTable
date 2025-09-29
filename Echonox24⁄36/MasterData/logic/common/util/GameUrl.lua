-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/GameUrl.lua

module("logic.common.util.GameUrl", package.seeall)

function getSpineUrl(name)
	return false
end

function getStoryModelUrl(name)
	return string.format("character3d/%s/general/%s-story.prefab", name, name)
end

function getTerrainModelUrl(name)
	return string.format("effect3d/prefab/terrain/%s.prefab", name)
end

function getBattlePlotPerformanceUrl(name)
	local rname = string.reverse(name)
	local i = string.find(rname, "_")
	local dir = string.sub(name, 1, string.len(name) - i)

	return string.format("effect3d/prefab/battleplot/%s/%s.prefab", dir, name)
end

function getMeshModelUrl(name)
	return string.format("character3d/%s/general_low/%s_low-battle.prefab", name, name)
end

function getHighMeshModelUrl(name)
	return string.format("character3d/%s/general/%s-battle.prefab", name, name)
end

function getHouseMeshModelUrl(name)
	return string.format("character3d/%s/home/%s-home.prefab", name, name)
end

function getHousePajamaMeshModelUrl(name)
	return string.format("character3d/%s/pajamas/%s-home.prefab", name, name)
end

function getRoguelikeMeshModelUrl(name)
	return string.format("roguelike3d/%s/roguelike/%s-roguelike.prefab", name, name)
end

function getMainSceneMeshModelUrl(name)
	return string.format("character3d/%s/general/%s-main.prefab", name, name)
end

function getMainSceneMeshModelClipUrl(name, clipName)
	return string.format("character3d/%s/general/animations_main/%s.anim", name, clipName)
end

function getMainSceneRoleTimelineUrl(modelCo)
	return ModelCOUtil.getMainTimelinePath(modelCo)
end

function getMainSceneRoleItemUrl(name)
	return string.format("scene/sx_scene-assets/sx-s001_mainscene/prefab/%s.prefab", name)
end

function getMainSceneSeatUrl(name)
	return string.format("scene/sx_scene-assets/sx-s001_mainscene/prefab/%s.prefab", name)
end

function getEquipMeshModelUrl(name)
	return string.format("jiaoshiqi3d/%s/general/%s-battle.prefab", name, name)
end

function getVolumeUrl(name)
	return string.format("volume/%s.prefab", name)
end

function getLightUrl(name)
	return string.format("light/%s.prefab", name)
end

function getEffectUrl(name)
	return string.format("effect/prefab/%s.prefab", name)
end

function get3dEffectUrl(name)
	return string.format("effect3d/prefab/%s.prefab", name)
end

function get3dEffectSceneCommonUrl(name)
	return string.format("effect3d/prefab/scene/comm/%s.prefab", name)
end

function get3dEffectUIUrl(name)
	return string.format("effect3d/prefab/ui/%s.prefab", name)
end

function getSceneUrl(subPath)
	return string.format("scene/sx_scene-assets/%s.unity", subPath)
end

function getFollowConfiner(name)
	return string.format("scene/followconfiner/%s.prefab", name)
end

function getVirtualCamera(name)
	return string.format("virtualcamera/%s.prefab", name)
end

function getPlotBigImageUrl(name)
	return string.format("ui/bigbg/plot/%s", name)
end

function getVideoUrl(name)
	return string.format("movie/%s.usm", name)
end

function getCgBigBgUrl(name)
	return string.format("ui/bigbg/plot/%s.png", name)
end

function getItemQualityUrl(quality)
	return string.format("grid_material_%s", quality)
end

function getEquipQualityUrl(quality)
	return string.format("equip_quality_%s", EquipEnum.QualityName[quality])
end

function getSignInItemQualityUrl(quality)
	return WelfareSigninEnum.QualityName[quality]
end

function getEchoItemQualityUrl(quality)
	return string.format("jscx_tab_%s", EquipEnum.QualityName[quality])
end

function getAuthorityLevelNum(level)
	return string.format("qhd_num_1%s", level)
end

function getEchoItemNumberUrl(quality)
	return string.format("echo_number_%s", EquipEnum.QualityName[quality])
end

function getEchoItemQuality1Url(quality)
	return string.format("echo_quality_%s1", EquipEnum.QualityName[quality])
end

function getRoguePropItemQualityUrl(quality)
	return string.format("rungroup_prop_quality_%s", EquipEnum.QualityName[quality])
end

function getTeachExploreQualityUrl(quality)
	return string.format("jxb_line_%s", EquipEnum.QualityName[quality])
end

function getHeroBreakLvImage(level)
	return string.format("smrtp_text_0001_%s", level)
end

function getImageGuideUrl(name)
	return string.format("ui/bigbg/guide/%s.png", name)
end

function getBigBgUrlByPrefix(prefix, name)
	return string.format("ui/bigbg/%s/%s.png", prefix, name)
end

function getBgPrefab(name)
	return string.format("effect/prefab/test_prefabe.prefab")
end

function getSpineReplaceFood(name)
	return string.format("ui/dynicon/food/%s.png", name)
end

function getSpineReplaceFace(name)
	return string.format("ui/dynicon/face/%s.png", name)
end

function getTeamCampUrl(name)
	return string.format("scene/sx_scene-assets/sx-s510_baindui/textures/%s.png", name)
end

function getCharacterBg(name)
	return string.format("ui/bigbg/charactersystem/background/%s.png", name)
end

function getCharacterQuality2DiBg(quality)
	return string.format("ui/bigbg/charactersystem/characterdetail/%s.png", CommEnum.CharacterQuality2DetailImg[quality])
end

function getCharacterHeroAnchorBg(name)
	if string.match(name, "%.") then
		return string.format("ui/bigbg/charactersystem/heartanchor/%s", name)
	end

	return string.format("ui/bigbg/charactersystem/heartanchor/%s.png", name)
end

function getScenePrefabUrl(name)
	return string.format("scene/common-elems/%s.prefab", name)
end

function getSceneRoomBillboardIcon(rootName, protomerId, billBoadId)
	return string.format("scene/sx_scene-assets/%s/textures/room_billboard2/%s_%02d.png", rootName, protomerId, billBoadId)
end

function getSceneRunUrl(folderName, sceneName)
	return string.format("scene/sx_scene-assets/%s/scene_run/%s_run.unity", folderName, sceneName)
end

function getStoreBigIcon(name)
	return string.format("ui/bigbg/store/%s.png", name)
end

function getStoreDynamicIcon(name)
	return string.format("ui/dynicon/store/%s.png", name)
end

function getAudioFileUrl(name)
	return string.format("audio/%s", name)
end

function getSummoncardCardBg(name)
	return string.format("ui/bigbg/summoncard/card_entry/%s.png", name)
end

function getSummoncardMaterialPath(materialName)
	return string.format("materials/other/summoncard/%s.mat", materialName)
end

function getHouseMaterialPath(name)
	return string.format("scene/common-elems/common-myhome/wallpaper_materials/%s.mat", name)
end

function getLotteryPrefabPath(lotteryPrefabName)
	return string.format("ui/views/summoncard/summoncardpane/%s.prefab", lotteryPrefabName)
end

function getChoukaQualityPath(quaLotteryBg)
	return string.format("shared/effect3d/prefab/ui/chouka_quality_%s.prefab", quaLotteryBg)
end

function getGuideType3Path(name)
	return string.format("ui/views/guide/type3_panel/%s.prefab", name)
end

function getGuideType4Path(name)
	return string.format("ui/views/guide/type4_panel/%s.prefab", name)
end

function getGuideType5Path(name)
	return string.format("ui/views/guide/type5_panel/%s.prefab", name)
end

function getGuideImgPath(name)
	return string.format("language/zh/ui/bigbg/guide/%s.png", name)
end

function get3DAnimPrefab(name)
	return string.format("effect3d/prefab/cutscene/storyboard/%s.prefab", name)
end

function getEquipTimingDiceAnimPrefab(index)
	return string.format("jiaoshiqi3d/dice%s/general/dice%s-default.prefab", index, index)
end

function getSubCgPrefab(name)
	return string.format("ui/views/story/%s.prefab", name)
end

function getMonumentMaterial(name)
	return string.format("ui/views/playerinfo/materials/materials_dynamic/%s.mat", name)
end

function GetCharacterFaceAnimPath(characterName, clipName)
	return string.format("character3d/%s/general/animations_show_face/%s.anim", characterName, clipName)
end

function GetMouthAnimationClipPath(storyId, clipName)
	return string.format("story/stories/%s/mouthclip/%s.anim", storyId, clipName)
end

function GetIdelAnimClipPath(clipName)
	return string.format("character3d/comm/animations_show/%s.anim", clipName)
end

function GetBlushPath()
	return string.format("effect3d/prefab/story/common_blush.prefab")
end

function GetXinMaoPath(characterName, heroName)
	return string.format("effect3d/xinmao/%s/%s_comm_xm.prefab", characterName, heroName)
end

function getShafaTouchTimelinePath(resName, id)
	local name = string.format("%s_shafa_touch_%s", resName, id)

	return string.format("effect3d/prefab/main/%s/%s_p.prefab", name, name)
end

function GetGuideDataPath(configName)
	return string.format("guide_config/%s.data", configName)
end

function getBigBgUrlNewBieTaskQuality(quality)
	return string.format("ui/bigbg/task/%s.png", CommEnum.Quality2NewbieTaskIcon[quality])
end

function getRoguelikeBigDynamic(imgName)
	return string.format("ui/bigbg/rungroup/rungroup_dynamic/%s.png", imgName)
end

function getQualityUrl(quality)
	return string.format("jscx_tab_%s", CommEnum.Quality2Char[quality])
end

function getBigBgUrlSpecialTraining(name)
	return string.format("ui/bigbg/special_training/%s.png", name)
end

function getBigBgUrlWelfare(subPath)
	return string.format("ui/bigbg/wekfare/%s.png", subPath)
end

function getBigBgUrlMainBanner(imageName)
	return string.format("language/zh/ui/bigbg/main/main_dynamic/%s.png", imageName)
end

function getMianjuUrl(name)
	return string.format("zhuguanmianju3d/%s.prefab", name)
end

function getEchoEffect(icon)
	return string.format("ui/views/charactersystem/carryitem/echo_effect/%s.prefab", icon)
end

function getNormalChapterUrl(chapterId)
	return string.format("ui/views/instance/instance_normal_chapter_%d.prefab", chapterId)
end

function getHardChapterUrl(chapterId)
	return string.format("ui/views/instance/instance_hard_chapter_%d.prefab", chapterId)
end

function getSumonCardCamp(campId)
	return string.format("ui/views/summoncard/summongcard_camp/%s.prefab", campId)
end

function getRetriveBannerIcon(name)
	return string.format("ui/dynicon/retrieve/%s.png", name)
end

function getRetrieveSceneBgMat(name)
	return string.format("scene/sx_scene-assets/sx-s410_drawcard/materials/bg/%s.mat", name)
end

function getRetrieveQualityBg(name)
	return string.format("ui/bigbg/retrieve/retrieve_dynamic/%s.png", name)
end

function getRetrieveSceneRes(name)
	return string.format("ui/bigbg/retrieve/scene/%s.png", name)
end

function getRetrieveImageTitle(name)
	return string.format("ui/bigbg/retrieve/%s.png", name)
end

function getRetrieveBigDynamic(name)
	return string.format("ui/bigbg/retrieve/retrieve_dynamic/%s.png", name)
end

function getEchoCardPackDynamic(itemId)
	return string.format("ui/bigbg/echocard_package/echo_pack3d_dynamic/echo_pack3d_%s.png", itemId)
end

function getStoryBinddataUrl(storyId)
	return string.format("story/stories/%s/binddata.asset", storyId)
end

function getStoryCfgdataUrl(storyId)
	return string.format("story/stories/%s/cfgdata.json", storyId)
end

function getStoryAnimcfgUrl(storyId)
	return string.format("story/stories/%s/animcfg.asset", storyId)
end

function getChoukaAppearVfx(quality)
	return string.format("ui/views/retrieve/chouka_vfx_%s.prefab", quality)
end
