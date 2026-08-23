local EchoLabConst = require("app.view.module.echoLab.const.EchoLabConst")
local EchoLabCollectCardStruct = require("app/view/module/echoLab/model/struct/EchoLabCollectCardStruct")
local EchoLabCollectBuildStruct = require("app.view.module.echoLab.model.struct.EchoLabCollectBuildStruct")
local EchoLabCollectData = class("EchoLabCollectData")

function EchoLabCollectData:ctor()
	self._buildInfoList = {}
	self._buildInfoIndexDict = {
		buildType = {},
		cardType = {}
	}
	self._cardList = {}
	self._cardIndexDict = {
		advanceId = {},
		cardType = {},
		buildType = {},
		cardId = {}
	}
	self._dirtyTab = {}

	self:_initData()
end

function EchoLabCollectData:_initData()
	print("EchoLabCollectData:_initData")

	self._dailyActiveLeftCount = 0

	local var_2_0 = {
		EchoLabConst.COLLECT_BUILDING_TYPE.COLLECT_CENTER,
		EchoLabConst.COLLECT_BUILDING_TYPE.ANALYSIS_TERMINAL
	}
	local var_2_1 = {
		[EchoLabConst.COLLECT_BUILDING_TYPE.COLLECT_CENTER] = {},
		[EchoLabConst.COLLECT_BUILDING_TYPE.ANALYSIS_TERMINAL] = {}
	}

	for iter_2_0 = 1, g.core.config.palace_build_info.getLength() do
		local var_2_2 = g.core.config.palace_build_info.indexOf(iter_2_0)

		var_2_1[var_2_2.build_type][#var_2_1[var_2_2.build_type] + 1] = var_2_2
	end

	for iter_2_1 = 1, #var_2_0 do
		self._buildInfoList[iter_2_1] = EchoLabCollectBuildStruct.new(var_2_0[iter_2_1], var_2_1[var_2_0[iter_2_1]])
		self._buildInfoIndexDict.buildType[var_2_0[iter_2_1]] = iter_2_1
	end

	print("EchoLabCollectData:_createBuild over")
	self:_initCardList()
end

function EchoLabCollectData:_checkAndSetDictSubValue(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_1[arg_3_2] = arg_3_1[arg_3_2] or {}

	local var_3_0 = arg_3_1[arg_3_2][arg_3_3]

	if not arg_3_1[arg_3_2][arg_3_3] or type(var_3_0) ~= "table" then
		arg_3_1[arg_3_2][arg_3_3] = arg_3_4
	end

	return var_3_0 or arg_3_4
end

function EchoLabCollectData:_initCardList()
	self._cardList = {}

	local var_4_0 = {}

	for iter_4_0 = 1, g.core.config.palace_compose_info.getLength() do
		local var_4_1 = g.core.config.palace_compose_info.indexOf(iter_4_0)
		local var_4_2 = table.concat({
			var_4_1.cards_type,
			var_4_1.advance_id
		}, "_")
		local var_4_3 = var_4_0[var_4_2]

		if not var_4_0[var_4_2] then
			var_4_3 = {}
			var_4_0[var_4_2] = var_4_3
		end

		var_4_3[#var_4_3 + 1] = var_4_1
	end

	for iter_4_1, iter_4_2 in pairs(var_4_0) do
		local var_4_4 = EchoLabCollectCardStruct.new(iter_4_2[1], iter_4_2)

		table.insert(self._cardList, var_4_4)

		for iter_4_3, iter_4_4 in ipairs((var_4_4:getAllIdList())) do
			self._cardIndexDict.cardId[iter_4_4] = #self._cardList
		end

		self:_checkAndSetDictSubValue(self._cardIndexDict.advanceId, iter_4_2[1].advance_id, iter_4_2[1].cards_type, #self._cardList)
		self:_checkAndSetDictSubValue(self._cardIndexDict.cardType, iter_4_2[1].cards_type, iter_4_2[1].advance_id, #self._cardList)

		self:_checkAndSetDictSubValue(self._cardIndexDict.buildType, iter_4_2[1].compose_belong, iter_4_2[1].cards_type, {})[iter_4_2[1].advance_id] = #self._cardList
		self._buildInfoIndexDict.cardType[iter_4_2[1].cards_type] = self._buildInfoIndexDict.buildType[iter_4_2[1].compose_belong]

		if var_4_4:isPut() then
			self._buildInfoList[self._buildInfoIndexDict.buildType[iter_4_2[1].compose_belong]]:addCardToList(var_4_4)
		end
	end

	for iter_4_5, iter_4_6 in ipairs(self._buildInfoList) do
		iter_4_6:sortCardList()
	end
end

function EchoLabCollectData:updateUnputCard(arg_5_1, arg_5_2)
	if not arg_5_1 then
		return
	end

	local var_5_0 = self._buildInfoIndexDict.cardType[arg_5_1]

	if not self._buildInfoIndexDict.cardType[arg_5_1] then
		return
	end

	local var_5_1 = self._buildInfoList[var_5_0]
	local var_5_2 = self._buildInfoList[var_5_0]:getCardStructByCardTypeAndAdvanceId(arg_5_1, arg_5_2)

	if var_5_2 then
		if not var_5_2:isPut() then
			var_5_1:removeCard(arg_5_1, arg_5_2)

			self._dirtyTab[var_5_1] = true
		end
	else
		local var_5_3 = self:getCardStructByIdx(self._cardIndexDict.cardType[arg_5_1][arg_5_2])

		if var_5_3 and var_5_3:isPut() then
			var_5_1:addCardToList(var_5_3)

			self._dirtyTab[var_5_1] = true
		end
	end
end

function EchoLabCollectData:doSortWhenIsDirty()
	for iter_6_0, iter_6_1 in pairs(self._dirtyTab or {}) do
		iter_6_0:sortCardList()
	end

	self._dirtyTab = {}
end

function EchoLabCollectData:checkBuildPutCardList()
	for iter_7_0, iter_7_1 in ipairs(self._buildInfoList) do
		iter_7_1:clearCardList()

		for iter_7_2, iter_7_3 in pairs(self._cardIndexDict.buildType[iter_7_1:getBuildType()]) do
			for iter_7_4, iter_7_5 in pairs(iter_7_3) do
				local var_7_0 = self:getCardStructByIdx(iter_7_5)

				if var_7_0:isPut() then
					iter_7_1:addCardToList(var_7_0)
				end
			end
		end

		iter_7_1:sortCardList()
	end
end

function EchoLabCollectData:getBuildInfo(arg_8_1)
	return (self._buildInfoIndexDict.buildType[arg_8_1] or nil) and self._buildInfoList[self._buildInfoIndexDict.buildType[arg_8_1]]
end

function EchoLabCollectData:getBuildInfoByCardType(arg_9_1)
	return (self._buildInfoIndexDict.cardType[arg_9_1] or nil) and self._buildInfoList[self._buildInfoIndexDict.cardType[arg_9_1]]
end

function EchoLabCollectData:getCardStructByIdx(arg_10_1)
	if arg_10_1 then
		return self._cardList[arg_10_1]
	end

	return nil
end

function EchoLabCollectData:getCardStruct(arg_11_1, arg_11_2)
	return (self._cardIndexDict.cardType[arg_11_1] or nil) and self:getCardStructByIdx(self._cardIndexDict.cardType[arg_11_1][arg_11_2])
end

function EchoLabCollectData:getCardStructById(arg_12_1)
	return (self:getCardStructByIdx(self._cardIndexDict.cardId[arg_12_1]))
end

function EchoLabCollectData:getCardStructList(arg_13_1, arg_13_2)
	local var_13_0 = {}

	if self._cardIndexDict.cardType[arg_13_1] then
		for iter_13_0, iter_13_1 in pairs(self._cardIndexDict.cardType[arg_13_1]) do
			local var_13_1 = self:getCardStructByIdx(iter_13_1)

			if arg_13_2 and var_13_1:isPut() or not arg_13_2 then
				var_13_0[#var_13_0 + 1] = var_13_1
			end
		end
	end

	return var_13_0
end

function EchoLabCollectData:sortOneCardList(arg_14_1)
	local var_14_0 = arg_14_1[1]:getCardType()
	local var_14_1 = g.core.model.User.echoLabData:getCollectData()
	local var_14_2 = var_14_1.activeCount < var_14_1:getBuildInfoByCardType(var_14_0):getDailyActiveInfo(var_14_0).activeMaxCount

	table.sort(arg_14_1, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_15_0:canActive()
		local var_15_1 = arg_15_1:canActive()

		if var_14_2 and var_15_0 ~= var_15_1 then
			return var_15_0
		end

		local var_15_2 = arg_15_0:canUpgrade() and 1 or 0
		local var_15_3 = arg_15_1:canUpgrade() and 1 or 0

		if var_15_2 ~= var_15_3 then
			return var_15_3 < var_15_2
		end

		local var_15_4 = arg_15_0:isActive()

		if var_15_4 ~= arg_15_1:isActive() then
			return var_15_4
		end

		if not var_14_2 and var_15_0 ~= var_15_1 then
			return var_15_0
		end

		local var_15_5 = arg_15_0:getCardQuality()
		local var_15_6 = arg_15_1:getCardQuality()

		if var_15_5 ~= var_15_6 then
			return var_15_6 < var_15_5
		end

		local var_15_7 = arg_15_0:getRealStar()
		local var_15_8 = arg_15_1:getRealStar()

		if var_15_7 ~= var_15_8 then
			return var_15_8 < var_15_7
		end

		return arg_15_0:getCfg().advance_id > arg_15_1:getCfg().advance_id
	end)

	return arg_14_1
end

function EchoLabCollectData:getBuildInfoList()
	return self._buildInfoList
end

function EchoLabCollectData:setDailyLeftActiveCount(arg_17_1)
	self._dailyActiveLeftCount = arg_17_1
end

function EchoLabCollectData:getDailyLeftActiveCount()
	return self._dailyActiveLeftCount
end

function EchoLabCollectData:updateBuildInfoByNet(arg_19_1, arg_19_2)
	arg_19_2 = arg_19_2 or arg_19_1.type

	local var_19_0 = self._buildInfoList[self._buildInfoIndexDict.buildType[arg_19_2]]

	if arg_19_1.build_grade then
		var_19_0:setLevel(arg_19_1.build_grade)
	end

	if arg_19_1.grade then
		var_19_0:setLevel(arg_19_1.grade)
	end

	if arg_19_1.exp then
		var_19_0:setCurExp(arg_19_1.exp)
	end

	if arg_19_1.build_exp then
		var_19_0:setCurExp(arg_19_1.build_exp)
	end

	if arg_19_1.hang_up then
		var_19_0:setHangupInfo(arg_19_1.hang_up)
	end
end

function EchoLabCollectData:updateAllBuildHangupInfo(arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(self._buildInfoList) do
		if iter_20_1:isReceiveNetInfo() then
			iter_20_1:setHangupInfo(arg_20_1)
		end
	end
end

function EchoLabCollectData:updateHangUpInfo(arg_21_1, arg_21_2)
	self:getBuildInfo(arg_21_1):setHangupInfo(arg_21_2)
end

function EchoLabCollectData:getAllHangUpInfo()
	local var_22_0 = {}
	local var_22_1 = {}

	for iter_22_0, iter_22_1 in ipairs(self._buildInfoList) do
		for iter_22_2, iter_22_3 in pairs((iter_22_1:getHangUpInfoDict())) do
			local var_22_2 = iter_22_2:split("_")
			local var_22_3 = tonumber(var_22_2[1])
			local var_22_4 = tonumber(var_22_2[2])

			if var_22_3 > 0 then
				table.insert(var_22_0, {
					type = var_22_3,
					value = var_22_4
				})

				local var_22_5 = iter_22_1:getHangupTimeInfoList()

				if var_22_5[#var_22_5] then
					var_22_5[#var_22_5].ratio = var_22_5[#var_22_5].hangUpTime / g.core.config.parameter_info.get(20213).parameter

					if var_22_5[#var_22_5].ratio > 0 and var_22_5[#var_22_5].ratio <= 1 then
						table.insert(var_22_1, var_22_5[#var_22_5])
					end
				end
			end
		end
	end

	return var_22_0, var_22_1
end

function EchoLabCollectData:updateCardListByNet(arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		self:getBuildInfoByCardType(iter_23_1.type):updateDailyActiveInfoByNet(iter_23_1)

		for iter_23_2, iter_23_3 in ipairs(iter_23_1.compose) do
			local var_23_0 = self:getCardStruct(iter_23_1.type, iter_23_3.id)

			if var_23_0 then
				var_23_0:onActive()
				var_23_0:setCurGradeByCardId(iter_23_3.num)
			end
		end

		for iter_23_4, iter_23_5 in ipairs(iter_23_1.used_card_id or {}) do
			local var_23_1 = self:getCardStruct(iter_23_1.type, iter_23_5.id)

			if var_23_1 then
				var_23_1:setPos(iter_23_5.num)
			end
		end
	end
end

function EchoLabCollectData:updateOneDailyActiveInfo(arg_24_1, arg_24_2)
	self:getBuildInfoByCardType(arg_24_1):updateOneDailyActiveInfo(arg_24_1, arg_24_2)
end

function EchoLabCollectData:isFirstEnterBuild(arg_25_1)
	return self:getBuildInfo(arg_25_1):isReceiveNetInfo()
end

function EchoLabCollectData:_getAttrDesList(arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = {
		name = arg_26_2,
		attrDesList = {}
	}

	for iter_26_0 = 1, #arg_26_1, 2 do
		local var_26_1 = {}
		local var_26_2, var_26_3 = g.core.lang:getAttr(arg_26_1[iter_26_0].type, tonumber(arg_26_1[iter_26_0].value), false)

		var_26_1[1] = {
			title = g.core.lang:get(2071, {
				name = var_26_2
			}),
			value = var_26_3
		}

		if arg_26_1[iter_26_0 + 1] then
			local var_26_4, var_26_5 = g.core.lang:getAttr(arg_26_1[iter_26_0 + 1].type, tonumber(arg_26_1[iter_26_0 + 1].value), false)

			var_26_1[2] = {
				title = g.core.lang:get(2071, {
					name = var_26_4
				}),
				value = var_26_5
			}
		end

		var_26_0.attrDesList[#var_26_0.attrDesList + 1] = var_26_1
	end

	arg_26_3[#arg_26_3 + 1] = var_26_0

	return arg_26_3
end

function EchoLabCollectData:getAllBuildAttrInfoDict()
	local var_27_0 = {
		card = {},
		talent = {},
		all = {}
	}

	for iter_27_0, iter_27_1 in ipairs(self._buildInfoList) do
		iter_27_1:getAllCardAttrDict(var_27_0.card)
		iter_27_1:getAllTalentAttrDict(nil, var_27_0.talent)
		iter_27_1:getAllCardAttrDict(var_27_0.all)
		iter_27_1:getAllTalentAttrDict(nil, var_27_0.all)
	end

	return var_27_0
end

function EchoLabCollectData:getAllBuildAttrInfoDesList()
	local var_28_0 = self:getAllBuildAttrInfoDict()
	local var_28_1 = {}
	local var_28_2 = {}

	for iter_28_0, iter_28_1 in pairs(var_28_0.card) do
		table.insert(var_28_2, {
			type = iter_28_0,
			value = iter_28_1
		})
	end

	if #var_28_2 > 0 then
		self:_getAttrDesList(var_28_2, g.core.lang:get(408545), var_28_1)
	end

	local var_28_3 = {}

	for iter_28_2, iter_28_3 in pairs(var_28_0.talent) do
		table.insert(var_28_3, {
			type = iter_28_2,
			value = iter_28_3
		})
	end

	self:_getAttrDesList(var_28_3, g.core.lang:get(408546), var_28_1)

	return var_28_1
end

function EchoLabCollectData:isCardCanActive(arg_29_1)
	local var_29_0 = false

	if arg_29_1.buildType then
		var_29_0 = self:isBuildHasActiveCard(arg_29_1.buildType)
	elseif arg_29_1.cardType then
		var_29_0 = self:isCardsCanActive(arg_29_1.cardType)
	else
		for iter_29_0, iter_29_1 in ipairs(self._buildInfoList) do
			var_29_0 = self:isBuildHasActiveCard((iter_29_1:getBuildType()))

			if var_29_0 then
				break
			end
		end
	end

	return var_29_0
end

function EchoLabCollectData:isBuildHasActiveCard(arg_30_1)
	local var_30_0 = self:getBuildInfo(arg_30_1)
	local var_30_1 = false

	for iter_30_0, iter_30_1 in pairs((var_30_0:getCardIndexDict())) do
		var_30_1 = self:isOneCardTypeCanActiveOnOneBuild(iter_30_0, var_30_0)

		if var_30_1 then
			break
		end
	end

	return var_30_1
end

function EchoLabCollectData:isCardsCanActive(arg_31_1)
	local var_31_0 = false

	for iter_31_0, iter_31_1 in ipairs(self._buildInfoList) do
		if iter_31_1:getDailyActiveInfo(arg_31_1) then
			var_31_0 = self:isOneCardTypeCanActiveOnOneBuild(arg_31_1, iter_31_1)
		end

		if var_31_0 then
			break
		end
	end

	return var_31_0
end

function EchoLabCollectData:isOneCardTypeCanActiveOnOneBuild(arg_32_1, arg_32_2)
	local var_32_0 = false
	local var_32_1 = arg_32_2:getDailyActiveInfo(arg_32_1)

	if var_32_1 and var_32_1.activeCount < var_32_1.activeMaxCount then
		for iter_32_0, iter_32_1 in ipairs((arg_32_2:getCardListByType(arg_32_1))) do
			var_32_0 = iter_32_1:isPut() and iter_32_1:canActive()

			if var_32_0 then
				break
			end
		end
	end

	return var_32_0
end

function EchoLabCollectData:isCardCanUpgrade(arg_33_1)
	local var_33_0 = false

	if arg_33_1.buildType then
		var_33_0 = self:isBuildHasUpgradeCard(arg_33_1.buildType)
	elseif arg_33_1.cardType then
		var_33_0 = self:isCardsCanUpgrade(arg_33_1.cardType)
	else
		for iter_33_0, iter_33_1 in ipairs(self._buildInfoList) do
			var_33_0 = self:isBuildHasUpgradeCard((iter_33_1:getBuildType()))

			if var_33_0 then
				break
			end
		end
	end

	return var_33_0
end

function EchoLabCollectData:isBuildHasUpgradeCard(arg_34_1)
	local var_34_0 = false

	for iter_34_0, iter_34_1 in ipairs((self:getBuildInfo(arg_34_1):getCardTypeList())) do
		for iter_34_2, iter_34_3 in ipairs(iter_34_1) do
			var_34_0 = iter_34_3:canUpgrade()

			if var_34_0 then
				break
			end
		end

		if var_34_0 then
			break
		end
	end

	return var_34_0
end

function EchoLabCollectData:isCardsCanUpgrade(arg_35_1)
	local var_35_0 = false

	for iter_35_0, iter_35_1 in ipairs((self:getCardStructList(arg_35_1))) do
		var_35_0 = iter_35_1:isPut() and iter_35_1:canUpgrade()

		if var_35_0 then
			break
		end
	end

	return var_35_0
end

function EchoLabCollectData:getCanUpgradeCardIdList(arg_36_1)
	local var_36_0 = {}

	for iter_36_0, iter_36_1 in ipairs((self:getCardStructList(arg_36_1))) do
		if iter_36_1:isPut() and iter_36_1:canUpgrade() then
			table.insert(var_36_0, iter_36_1:getCfg().id)
		end
	end

	return var_36_0
end

function EchoLabCollectData:isReachHangupLimitTime(arg_37_1)
	local var_37_0 = false

	if arg_37_1.buildType then
		var_37_0 = self:isOneBuildReachHangupLimitTime((self:getBuildInfo(arg_37_1.buildType)))
	else
		for iter_37_0, iter_37_1 in ipairs(self._buildInfoList) do
			var_37_0 = self:isOneBuildReachHangupLimitTime(iter_37_1)

			if var_37_0 then
				break
			end
		end
	end

	return var_37_0
end

function EchoLabCollectData:isOneBuildReachHangupLimitTime(arg_38_1)
	local var_38_0 = arg_38_1:getHangupTimeInfoList()

	return (#var_38_0 > 0 or nil) and var_38_0[1].totalTimeTab.time >= g.core.config.parameter_info.get(20213).parameter
end

return EchoLabCollectData
