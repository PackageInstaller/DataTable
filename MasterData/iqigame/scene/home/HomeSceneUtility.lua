-- chunkname: @IQIGame\\Scene\\Home\\HomeSceneUtility.lua

local HomeActor = require("IQIGame/Scene/Home/Actor/HomeActor")
local UIActor = require("IQIGame/Scene/Home/Actor/UIActor")
local ModelActor = require("IQIGame/Scene/Home/Actor/ModelActor")
local WorkerActor = require("IQIGame/Scene/Home/Actor/WorkerActor")
local ArticleActor = require("IQIGame/Scene/Home/Actor/ArticleActor")
local NpcActor = require("IQIGame/Scene/Home/Actor/NpcActor")
local ActorController = require("IQIGame/Scene/Home/Controller/ActorController")
local WorkerController = require("IQIGame/Scene/Home/Controller/WorkerController")
local ArticleController = require("IQIGame/Scene/Home/Controller/ArticleController")
local TransPortController = require("IQIGame/Scene/Home/Controller/TransportController")
local NpcController = require("IQIGame/Scene/Home/Controller/NpcController")
local UINormalBtnController = require("IQIGame/UI/Home/UIActorController/UINormalBtnController")
local UIChapterBtnController = require("IQIGame/UI/Home/UIActorController/UIChapterBtnController")
local UITaskBtnController = require("IQIGame/UI/Home/UIActorController/UITaskBtnController")
local UIHomeLandDispTaskBtnController = require("IQIGame/UI/Home/UIActorController/UIHomeLandDispTaskBtnController")
local UIHomeLandUpGradeBtnController = require("IQIGame/UI/Home/UIActorController/UIHomeLandUpGradeBtnController")
local UIMainCityBannerController = require("IQIGame/UI/Home/UIActorController/UIMainCityBannerController")
local UISummerActivitiesBtnController = require("IQIGame/UI/Home/UIActorController/UISummerActivitiesBtnController")
local UIPaintingController = require("IQIGame/UI/Home/UIActorController/UIPaintingController")
local HomeSceneUtility = {}

function HomeSceneUtility.CreateHomeRoomPartActor(partCid, parentTrans, readyCall)
	local partCfg = CfgUtil.GetCfgWorldRoomPartDataWithID(partCid)

	if partCfg.Type == Constant.HomePartType.SceneUI then
		return HomeSceneUtility.__OnCreateHomeRoomUIPartActor(partCid, partCfg.SkinCid, parentTrans, readyCall)
	end

	return HomeActor.New(partCid, HomeActor, ActorController, readyCall)
end

function HomeSceneUtility.__OnCreateHomeRoomUIPartActor(partCid, SkinCid, parentTrans, readyCall)
	local skinConfig = CfgHomeRoomPartSkinTable[SkinCid]
	local uiActor

	if skinConfig.ControlType == Constant.HomeUIControlType.UIChapterBtn then
		uiActor = UIActor.New(partCid, UIActor, UIChapterBtnController, readyCall)
	elseif skinConfig.ControlType == Constant.HomeUIControlType.DelayTaskBtn then
		uiActor = UIActor.New(partCid, UIActor, UITaskBtnController, readyCall)
	elseif skinConfig.ControlType == Constant.HomeUIControlType.HomeLandDispTask then
		uiActor = UIActor.New(partCid, UIActor, UIHomeLandDispTaskBtnController, readyCall)
	elseif skinConfig.ControlType == Constant.HomeUIControlType.UpGradeBtn then
		uiActor = UIActor.New(partCid, UIActor, UIHomeLandUpGradeBtnController, readyCall)
	elseif skinConfig.ControlType == Constant.HomeUIControlType.CommonUIBtn then
		uiActor = UIActor.New(partCid, UIActor, UINormalBtnController, readyCall)
	elseif skinConfig.ControlType == Constant.HomeUIControlType.MainCityBanner then
		uiActor = UIActor.New(partCid, UIActor, UIMainCityBannerController, readyCall)
	elseif skinConfig.ControlType == Constant.HomeUIControlType.SummerActivity then
		uiActor = UIActor.New(partCid, UIActor, UISummerActivitiesBtnController, readyCall)
	elseif skinConfig.ControlType == Constant.HomeUIControlType.Painting then
		uiActor = UIActor.New(partCid, UIActor, UIPaintingController, readyCall)
	else
		logError("未定义 家园场景UIPart {0}操作类型 {1}", partCid, SkinCid)

		uiActor = UIActor.New(partCid, UIActor, ActorController, readyCall)
	end

	uiActor:CreateView(skinConfig.PrefabPath, parentTrans)

	return uiActor
end

function HomeSceneUtility.__OnCreateTransactionPartActor(partCid, SkinCid, parentTrans, readyCall)
	local skinConfig = CfgHomeRoomPartSkinTable[SkinCid]
	local actor = ModelActor.New(partCid, ModelActor, ActorController, function(_actor)
		_actor:AddActorComponent(Constant.HomeSceneActorType.TranslateDoorActor)

		if readyCall ~= nil then
			readyCall(_actor)
		end
	end)

	actor:CreateView(skinConfig.PrefabPath, parentTrans)

	return actor
end

function HomeSceneUtility.CreateHomeRoomWorkActor(heroCid, parentTrans, readyCall)
	return WorkerActor.New(heroCid, WorkerActor, WorkerController, function(_actor)
		_actor:Mount(parentTrans)

		if readyCall ~= nil then
			readyCall(_actor)
		end
	end)
end

function HomeSceneUtility.CreateSceneComponent(componentId, parentTrans)
	local cfgComponent = CfgUtil.GetCfgWorldRoomCompDataWithID(componentId)
	local actor

	if cfgComponent.Type == Constant.RoomComponentsType.Article then
		local skinConfig = CfgHomeRoomPartSkinTable[cfgComponent.SkinCid]
		local a = ArticleActor.New(componentId, ArticleActor, ArticleController, nil, componentId)

		a:CreatePrefab(skinConfig.PrefabPath, parentTrans)

		actor = a
	elseif cfgComponent.Type == Constant.RoomComponentsType.Role then
		local npc = NpcActor.New(cfgComponent.SkinCid, NpcActor, NpcController, nil, componentId)

		npc.parentTrans = parentTrans
		actor = npc
	elseif cfgComponent.Type == Constant.RoomComponentsType.Transport then
		local skinConfig = CfgHomeRoomPartSkinTable[cfgComponent.SkinCid]
		local a = ArticleActor.New(componentId, ArticleActor, TransPortController, nil, componentId)

		a:CreatePrefab(skinConfig.PrefabPath, parentTrans)

		actor = a
	end

	return actor
end

return HomeSceneUtility
