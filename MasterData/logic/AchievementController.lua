-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/achievement/controller/AchievementController.lua

module("logic.extensions.achievement.controller.AchievementController", package.seeall)

local AchievementController = class("AchievementController", BaseController)

function AchievementController:ctor()
	return
end

function AchievementController:sendLoadAllAchievementReq()
	AchievementAgent.instance:sendPM_LoadAllAchievementReq()
end

function AchievementController:sendAchievementGetRankReq()
	AchievementAgent.instance:sendPM_AchievementGetRankReq()
end

function AchievementController:handleAchievementGetRankRes(msg)
	RankModel.instance:setRankData(msg, GameEnum.RankType.AchievementRank, 0)
	GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
end

AchievementController.instance = AchievementController.New()

return AchievementController
