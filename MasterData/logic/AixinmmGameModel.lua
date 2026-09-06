-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmmgame/model/AixinmmGameModel.lua

module("logic.extensions.aixinmmgame.model.AixinmmGameModel", package.seeall)

local AixinmmGameModel = class("AixinmmGameModel", BaseModel)

function AixinmmGameModel:onInit()
	self:onReset()
end

function AixinmmGameModel:onReset()
	self._activityId = 281003
	self._useGameTime = 0
	self._hasGainGamePrizeIds = nil
	self.CiList = nil
end

function AixinmmGameModel:getUseGameTimes()
	return self._useGameTime
end

function AixinmmGameModel:getMaxGameTimes(activityId)
	local data = AixinmmGameConfig.instance:getActCfg(activityId)

	return (data or nil) and (data.dailyTimes or 0)
end

function AixinmmGameModel:getLeftGameTimes(activityId)
	local cur = self:getUseGameTimes()
	local max = self:getMaxGameTimes(activityId)

	return Mathf.Max(max - cur, 0)
end

function AixinmmGameModel:isPlayerGameRewardGeted(prizeId)
	self._hasGainGamePrizeIds = self._hasGainGamePrizeIds or {}

	return TableUtil.isHad(self._hasGainGamePrizeIds, prizeId)
end

function AixinmmGameModel:prepareGameDatas(activityId)
	local testList = {}
	local actCfg = AixinmmGameConfig.instance:getActCfg(activityId)
	local planId = actCfg.gamePlanId
	local pcfgs = AixinmmGameConfig.instance:getGamePlanCfgs(planId)
	local dataList = {
		{},
		{},
		{}
	}

	for stageId, list in ipairs(pcfgs) do
		local totalWeight = 0
		local newList = {}

		for _, v in pairs(list) do
			totalWeight = totalWeight + v.weight

			table.insert(newList, v)
		end

		local randomNum = math.random(1, totalWeight)
		local currNum = 0
		local templateId = 0

		table.sort(newList, function(a, b)
			return a.weight < b.weight
		end)

		for i, v in ipairs(newList) do
			currNum = currNum + v.weight

			if randomNum <= currNum then
				templateId = v.templateId

				break
			end
		end

		if templateId > 0 then
			table.insert(testList, templateId)

			local tcfgs = AixinmmGameConfig.instance:getGameTemplateCfgs(templateId)

			if not tcfgs then
				printError("没有模板id配置！！！", templateId)

				tcfgs = {}
			end

			for i, v in ipairs(tcfgs) do
				if v.isPetCol <= 0 then
					table.insert(dataList[1], v.line1)
					table.insert(dataList[2], v.line2)
					table.insert(dataList[3], v.line3)
				else
					local ptcfgs = AixinmmGameConfig.instance:getPetTemplateCfgs(stageId)
					local tempList = {}
					local totalWeightTemp = 0

					for k, v in pairs(ptcfgs) do
						totalWeightTemp = totalWeightTemp + v.weight

						table.insert(tempList, v)
					end

					table.sort(tempList, function(a, b)
						return a.weight < b.weight
					end)

					local currNum = 0

					for i = 1, 3 do
						currNum = 0

						local randomNumTemp = math.random(1, totalWeightTemp)

						for index, v0 in ipairs(tempList) do
							currNum = currNum + v0.weight

							if randomNumTemp <= currNum then
								table.insert(dataList[i], v0.slotId)
								table.remove(tempList, index)

								totalWeightTemp = totalWeightTemp - v0.weight

								break
							end
						end
					end
				end
			end
		end
	end

	print("=======测试  各阶段id")

	for i, v in ipairs(testList) do
		print("===阶段:", i, "id:", v)
	end

	return dataList
end

function AixinmmGameModel:onGetInfo(msg)
	self._useGameTime = checkint(msg.gameCount)
	self._hasGainGamePrizeIds = msg.gainedPrizeIds or {}
end

function AixinmmGameModel:onGetGamePrize(msg)
	self._hasGainGamePrizeIds = msg.gainedPrizeIds
end

function AixinmmGameModel:onStartGame(msg)
	return
end

function AixinmmGameModel:onSettleGame(msg)
	self._useGameTime = self._useGameTime - 1
	self.CiList = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
end

function AixinmmGameModel:ShowCI()
	MaterialController.instance:showChangeSetInTemp(checknumber(self.CiList))

	self.CiList = nil
end

function AixinmmGameModel:getDailyOpen(dataKey)
	return checkint(GameUtil.getUserDayData(dataKey)) <= 0
end

function AixinmmGameModel:setDailyOpen(dataKey)
	GameUtil.saveUserDayData(dataKey, 1)
end

AixinmmGameModel.instance = AixinmmGameModel.New()

return AixinmmGameModel
