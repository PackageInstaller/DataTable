-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/armorhero/model/ArmorHeroModel.lua

module("logic.extensions.armorhero.model.ArmorHeroModel", package.seeall)

local ArmorHeroModel = class("ArmorHeroModel", BaseModel)

function ArmorHeroModel:onInit()
	self:onReset()
end

function ArmorHeroModel:onReset()
	self._infoMap = {}
end

function ArmorHeroModel:getInfo(activityId)
	local info = self._infoMap[activityId]

	if not info then
		print(string.format("铠甲勇士预热数据未初始化：%s", activityId))
	end

	return info
end

function ArmorHeroModel:handlePM_ArmorHeroInfoRes(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	self._infoMap[activityId] = info
end

function ArmorHeroModel:handlePM_ArmorHeroSummonRes(msg)
	local activityId = msg.activityId
	local info = self._infoMap[activityId]

	if info then
		info.hasSummonId = info.hasSummonId or {}

		table.insert(info.hasSummonId, msg.summonId)
	end
end

function ArmorHeroModel:handlePM_ArmorHeroGainTaskPrizeRes(msg)
	local activityId = msg.activityId
	local info = self._infoMap[activityId]

	if info then
		info.hasGainTaskPrize = true
	end
end

function ArmorHeroModel:handlePM_ArmorHeroGainBookPrizeRes(msg)
	local activityId = msg.activityId
	local info = self._infoMap[activityId]

	if info then
		info.hasGainBookPrize = true
	end
end

function ArmorHeroModel:handlePM_ArmorHeroGainSharePrizeRes(msg)
	local activityId = msg.activityId
	local info = self._infoMap[activityId]

	if info then
		info.hasGainSharePrize = true
	end
end

function ArmorHeroModel:handlePM_ArmorHeroGainProgressPrizeRes(msg)
	local activityId = msg.activityId
	local info = self._infoMap[activityId]

	if info then
		info.stageInfos = info.stageInfos

		for _, stageInfo in ipairs(info.stageInfos) do
			if stageInfo.stageId == msg.stageId then
				stageInfo.hasGainProgressPrizeId = stageInfo.hasGainProgressPrizeId or {}

				table.insert(stageInfo.hasGainProgressPrizeId, msg.progressId)

				break
			end
		end
	end
end

function ArmorHeroModel:handlePM_ArmorHeroNotifyClgFinish(msg)
	local activityId = msg.activityId
	local info = self._infoMap[activityId]

	if info then
		local stageId = msg.stageId
		local addDamage = checknumber(msg.damage)
		local matchInfo

		if not info.stageInfos then
			for _, stageInfo in ipairs(info.stageInfos) do
				if stageInfo.stageId == stageId then
					matchInfo = stageInfo

					break
				end
			end

			if matchInfo then
				matchInfo.totalDamage = (matchInfo.totalDamage or 0) + addDamage
			else
				matchInfo = {
					stageId = stageId,
					totalDamage = addDamage
				}

				table.insert(info.stageInfos, matchInfo)

				info.stageInfos = info.stageInfos
			end
		end
	end
end

function ArmorHeroModel:getBossDamage(activityId, stageId)
	local info = self._infoMap[activityId]

	if info then
		if not info.stageInfos then
			for _, stageInfo in ipairs(info.stageInfos) do
				if stageInfo.stageId == stageId then
					return stageInfo.totalDamage or 0
				end
			end
		end
	end

	return 0
end

local TaskType = {
	Book = "IsBook",
	Share = "IsShare",
	LoginDays = "LoginDays"
}

function ArmorHeroModel:isfinishTask(activityId, taskType)
	local info = self._infoMap[activityId]

	if info then
		if taskType == TaskType.Book then
			return info.hasGainBookPrize or false
		elseif taskType == TaskType.Share then
			return info.hasGainSharePrize or false
		elseif taskType == TaskType.LoginDays then
			if not info.loginDays then
				local loginDays = 0
				local actCfg = ArmorHeroConfig.instance:getActivityCfgByActId(activityId)

				if actCfg then
					if not actCfg.loginDays then
						local requiredDays = 0

						return requiredDays <= loginDays
					end
				end
			end
		end
	end

	return false
end

ArmorHeroModel.instance = ArmorHeroModel.New()

return ArmorHeroModel
