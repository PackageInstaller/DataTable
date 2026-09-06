-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/athenabless/controller/AthenaBlessController.lua

module("logic.extensions.athenabless.controller.AthenaBlessController", package.seeall)

local AthenaBlessController = class("AthenaBlessController", BaseController)

AthenaBlessController.RedPointStr = "AthenaBlessRedPoint"

function AthenaBlessController:ctor()
	return
end

function AthenaBlessController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.AthenaBlessGetInfo, self._onGetInfo, self)
end

function AthenaBlessController:onReset()
	return
end

function AthenaBlessController:_onGetInfo()
	return
end

function AthenaBlessController:getTaskList()
	local list = {}
	local activityId = AthenaBlessModel.instance:getActivityId()
	local cfg = AthenaBlessConfig.instance:getActivityCfg(activityId)

	if not cfg then
		return list
	end

	local cfgTasks = AthenaBlessConfig.instance:getTaskCfgList(cfg.taskPlanId)

	if not cfgTasks or #cfgTasks == 0 then
		return list
	end

	for i, v in ipairs(cfgTasks) do
		local element = {}

		element.cfg = v
		element.curScore = AthenaBlessModel.instance:getScore(v.taskId)
		element.maxScore = v.scoreDailyLimit
		element.isMaxScore = element.curScore >= element.maxScore

		table.insert(list, element)
	end

	table.sort(list, function(a, b)
		if a.isMaxScore and not b.isMaxScore then
			return false
		elseif not a.isMaxScore and b.isMaxScore then
			return true
		else
			return a.cfg.taskId < b.cfg.taskId
		end
	end)

	return list
end

function AthenaBlessController:getCurLevel()
	local curScore = AthenaBlessModel.instance:getCurScore()
	local activityId = AthenaBlessModel.instance:getActivityId()
	local cfg = AthenaBlessConfig.instance:getActivityCfg(activityId)

	if not cfg then
		return 1
	end

	local list = AthenaBlessConfig.instance:getLevelCfgList(cfg.scoreLvPlanId)
	local level = 1

	for i, v in ipairs(list) do
		if curScore >= v.score then
			level = i
		else
			break
		end
	end

	return level
end

function AthenaBlessController:curLevelIconPath()
	local curScore = AthenaBlessModel.instance:getCurScore()
	local activityId = AthenaBlessModel.instance:getActivityId()
	local cfg = AthenaBlessConfig.instance:getActivityCfg(activityId)

	if not cfg then
		return "", ""
	end

	local list = AthenaBlessConfig.instance:getLevelCfgList(cfg.scoreLvPlanId)
	local path = ""
	local effectPath = ""

	for i, v in ipairs(list) do
		if curScore >= v.score then
			path = v.icon

			if not string.nilorempty(v.effResPath) then
				effectPath = string.format("20211126/yadiannadezhufu/%s.prefab", v.effResPath)
			end
		else
			break
		end
	end

	return path, effectPath
end

function AthenaBlessController:getLevelCfg(activityId, level)
	local cfg = AthenaBlessConfig.instance:getActivityCfg(activityId)

	if not cfg then
		return nil
	end

	return AthenaBlessConfig.instance:getLevelCfg(cfg.scoreLvPlanId, level)
end

function AthenaBlessController:getTargetLevelIconPath(activityId, level)
	local cfg = self:getLevelCfg(activityId, level)

	if cfg then
		local iconPath = cfg.icon

		return iconPath, (not string.nilorempty(cfg.effResPath) or nil) and string.format("20211126/yadiannadezhufu/%s.prefab", cfg.effResPath)
	else
		return "", ""
	end
end

function AthenaBlessController:sendGetInfo()
	local cfgActivityDefine = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.AthenaBless)

	if cfgActivityDefine then
		AthenaBlessAgent.instance:sendPM_AnthenaBlessGetInfoReq(cfgActivityDefine.activityId)
	end
end

function AthenaBlessController:isActiveRedPoint()
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.AthenaBless)

	if not cfg then
		return false
	end

	local key = AthenaBlessController.RedPointStr .. cfg.activityId
	local isMarked = GameUtil.getUserData(key)

	return not isMarked
end

function AthenaBlessController:markRedPoint(activityId)
	local key = AthenaBlessController.RedPointStr .. activityId

	if not GameUtil.getUserData(key) then
		GameUtil.saveUserData(key, true)
	end
end

AthenaBlessController.instance = AthenaBlessController.New()

return AthenaBlessController
