local var_0_0 = g.core.const.ConstMgr.EchoLabConst
local EchoLabTreeTalentData = require("app.view.module.echoLab.model.EchoLabTreeTalentData")
local EchoLabCollectData = require("app.view.module.echoLab.model.EchoLabCollectData")
local var_0_3 = g.core.const.ConstMgr.PARAMETER_CONST
local var_0_4 = g.core.config.parameter_info
local var_0_5 = g.core.config.palace_info
local var_0_6 = g.core.config.palace_compose_info
local EchoLabData = class("EchoLabData")

function EchoLabData:ctor()
	self:initData()
end

function EchoLabData:initData()
	self._treeData = nil
	self._collectData = nil
	self._palaceId = 1
	self._lineUpCardMap = {}
end

function EchoLabData:getTreeData()
	if not self._treeData then
		self._treeData = EchoLabTreeTalentData.new()

		self._treeData:initData()
	end

	return self._treeData
end

function EchoLabData:getCollectData()
	self._collectData = self._collectData or EchoLabCollectData.new()

	return self._collectData
end

function EchoLabData:onS2CPalaceGetInfo(arg_5_1)
	self._palaceId = arg_5_1.id or 1

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.activedAltar or {}) do
		self:getTreeData():setTalentActive(iter_5_1)
	end

	self:getCollectData():checkBuildPutCardList()

	if arg_5_1.build then
		for iter_5_2, iter_5_3 in ipairs(arg_5_1.build) do
			self:getCollectData():updateBuildInfoByNet(iter_5_3)
		end
	end

	if arg_5_1.compose then
		self:getCollectData():updateCardListByNet(arg_5_1.compose)

		if arg_5_1.compose then
			self._lineUpCardMap = {}

			for iter_5_4, iter_5_5 in ipairs(arg_5_1.compose) do
				self:_updateLineUpCardInfo(iter_5_5)
			end
		end
	end
end

function EchoLabData:_updateLineUpCardInfo(arg_6_1)
	if arg_6_1.used_card_id then
		for iter_6_0, iter_6_1 in ipairs(arg_6_1.used_card_id) do
			self._lineUpCardMap[arg_6_1.type] = self._lineUpCardMap[arg_6_1.type] or {}
			self._lineUpCardMap[arg_6_1.type][iter_6_1.num] = self._lineUpCardMap[arg_6_1.type][iter_6_1.num] or {}
			self._lineUpCardMap[arg_6_1.type][iter_6_1.num] = self:getCollectData():getCardStruct(arg_6_1.type, iter_6_1.id)
		end
	end
end

function EchoLabData:onS2CPalaceGetHangupAward(arg_7_1)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		if iter_7_0 ~= "awards" then
			var_7_0[iter_7_0] = iter_7_1
		end
	end

	if arg_7_1.build_type == 0 then
		self:getCollectData():updateAllBuildHangupInfo(var_7_0, true)
	else
		self:getCollectData():updateHangUpInfo(arg_7_1.build_type, var_7_0, true)
	end
end

function EchoLabData:onS2CPalaceActiveCompose(arg_8_1)
	local var_8_0 = self:getCollectData():getCardStructById(arg_8_1.id)

	if not var_8_0 then
		return
	end

	var_8_0:onActive()

	if arg_8_1.daily_active_cnt then
		self:getCollectData():updateOneDailyActiveInfo(var_8_0:getCfg().cards_type, arg_8_1)
	end

	self:getCollectData():updateBuildInfoByNet(arg_8_1, var_8_0:getCfg().compose_belong)
end

function EchoLabData:onS2CPalaceUpgradeCompose(arg_9_1)
	local var_9_0 = self:getCollectData():getCardStructById(arg_9_1.id)

	if not var_9_0 then
		return
	end

	var_9_0:setCurGradeById(arg_9_1.id)

	if arg_9_1.daily_active_cnt then
		self:getCollectData():updateOneDailyActiveInfo(var_9_0:getCfg().cards_type, arg_9_1)
	end

	self:getCollectData():updateBuildInfoByNet(arg_9_1, var_9_0:getCfg().compose_belong)
end

function EchoLabData:onS2CPalaceOneKeyUpgradeCompose(arg_10_1)
	local var_10_0
	local var_10_1 = arg_10_1.ids or {}

	for iter_10_0 = 1, #var_10_1 do
		local var_10_2 = self:getCollectData():getCardStructById(var_10_1[iter_10_0])

		var_10_2:setOneKeyBeforeGrade(var_10_2:getCurGrade())
		var_10_2:setCurGradeById(var_10_1[iter_10_0])

		var_10_0 = var_10_0 or var_10_2:getCfg().compose_belong
	end

	self:getCollectData():updateBuildInfoByNet(arg_10_1, var_10_0)
end

function EchoLabData:onS2CPalaceActiveAltarNode(arg_11_1)
	self:getTreeData():setTalentActive(arg_11_1.id)

	self._palaceId = arg_11_1.palace_id or 1
end

function EchoLabData:onS2CPalaceUseCompose(arg_12_1)
	local var_12_0 = var_0_6.get(arg_12_1.id)
	local var_12_1 = self:getCardStructByTypeAndPos(var_12_0.cards_type, arg_12_1.pos)

	if var_12_1 and var_12_1.setPos then
		var_12_1:setPos(-1)
	end

	self._lineUpCardMap[var_12_0.cards_type] = self._lineUpCardMap[var_12_0.cards_type] or {}
	self._lineUpCardMap[var_12_0.cards_type][arg_12_1.pos] = self._lineUpCardMap[var_12_0.cards_type][arg_12_1.pos] or {}

	local var_12_2 = self:getCollectData():getCardStruct(var_12_0.cards_type, var_12_0.advance_id)

	var_12_2:setPos(arg_12_1.pos)

	self._lineUpCardMap[var_12_0.cards_type][arg_12_1.pos] = var_12_2
end

function EchoLabData:onS2CPalaceFirstEnterBuild(arg_13_1)
	self:getCollectData():updateHangUpInfo(arg_13_1.build_type, arg_13_1)
end

function EchoLabData:isUnlockEchoLabTerminal()
	local var_14_0 = ""
	local var_14_1 = self:getTreeData():getTalentById(var_0_4.get(var_0_3.ECHOLAB_TERMINAL_UNLOCK_VALUE).parameter)

	if var_14_1 then
		if var_14_1:isActive() then
			return true
		else
			var_14_0 = g.core.lang:get(408512, {
				str = var_14_1:getInfo().name
			})
		end
	end

	return false, var_14_0
end

function EchoLabData:getPalaceId()
	return self._palaceId
end

function EchoLabData:getCoreMaxLevel()
	return (var_0_5.getLength())
end

function EchoLabData:getAttriButesByCoreLevel(arg_17_1)
	local var_17_0 = var_0_5.get(arg_17_1)
	local var_17_1 = {}

	for iter_17_0, iter_17_1 in ipairs(var_0_0.EMBRYO_SLOT_FIELDS) do
		if var_17_0[iter_17_1.name .. "_slot_num"] ~= 0 then
			table.insert(var_17_1, {
				attrName = iter_17_1.desc,
				attrValue = var_17_0[iter_17_1.name .. "_slot_num"]
			})
		end
	end

	for iter_17_2 = 1, 2 do
		if var_17_0["suppress_affect_type" .. iter_17_2] ~= 0 then
			local var_17_2, var_17_3 = g.core.lang:getAttr(var_17_0["suppress_affect_type" .. iter_17_2], var_17_0["suppress_affect_value" .. iter_17_2], false)

			table.insert(var_17_1, {
				attrName = var_17_2,
				attrValue = var_17_3
			})
		end
	end

	return var_17_1
end

function EchoLabData:getCoreBaseAttrSumData()
	local var_18_0 = {}

	for iter_18_0 = 1, self._palaceId do
		for iter_18_1, iter_18_2, iter_18_3 in var_0_5.get(iter_18_0).gmatch({
			"suppress_affect_type%d+",
			"suppress_affect_value%d+"
		}, true) do
			if iter_18_3[1] > 0 then
				var_18_0[iter_18_3[1]] = var_18_0[iter_18_3[1]] or 0
				var_18_0[iter_18_3[1]] = var_18_0[iter_18_3[1]] + iter_18_3[2]
			end
		end
	end

	return var_18_0
end

function EchoLabData:getCardStructByTypeAndPos(arg_19_1, arg_19_2)
	if not self._lineUpCardMap[arg_19_1] then
		return
	end

	if not self._lineUpCardMap[arg_19_1][arg_19_2] then
		return
	end

	return self._lineUpCardMap[arg_19_1][arg_19_2]
end

function EchoLabData:isLineUpByTypeAndPos(arg_20_1, arg_20_2)
	local var_20_0 = self:getCardStructByTypeAndPos(arg_20_1, arg_20_2)

	if not var_20_0 then
		return false
	end

	return var_20_0:isLineUp()
end

function EchoLabData:getUnlockSlotGrade(arg_21_1, arg_21_2)
	local var_21_0 = var_0_5.match(function(arg_22_0)
		return arg_22_0[arg_21_1] == arg_21_2
	end)

	if var_21_0 and next(var_21_0) then
		return var_21_0[1].palace_grade
	end

	return 0
end

function EchoLabData:getLineUpAttr(arg_23_1)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs((self:getCollectData():getCardStructList(arg_23_1, true))) do
		local var_23_1 = iter_23_1:getLineUpAttrInfo()

		if iter_23_1:isLineUp() then
			var_23_0[var_23_1.type] = var_23_0[var_23_1.type] or 0
			var_23_0[var_23_1.type] = var_23_0[var_23_1.type] + var_23_1.value
		end
	end

	return var_23_0
end

function EchoLabData:getAllAttrSumData()
	local var_24_0 = {
		[911] = 0,
		[910] = 0
	}

	for iter_24_0, iter_24_1 in pairs((self:getCoreBaseAttrSumData())) do
		var_24_0[iter_24_0] = var_24_0[iter_24_0] or 0
		var_24_0[iter_24_0] = var_24_0[iter_24_0] + iter_24_1
	end

	for iter_24_2 = 1, #var_0_0.EchoLabNameArray do
		for iter_24_3, iter_24_4 in pairs((self:getLineUpAttr(var_0_0.EchoLabNameArray[iter_24_2].cardType))) do
			var_24_0[iter_24_3] = var_24_0[iter_24_3] or 0
			var_24_0[iter_24_3] = var_24_0[iter_24_3] + iter_24_4
		end
	end

	return var_24_0
end

function EchoLabData:getAttrSumDataByCardType(arg_25_1)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in pairs((self:getLineUpAttr(arg_25_1))) do
		var_25_0[iter_25_0] = var_25_0[iter_25_0] or 0
		var_25_0[iter_25_0] = var_25_0[iter_25_0] + iter_25_1
	end

	return var_25_0
end

function EchoLabData:getCanLineUpCardListByType(arg_26_1)
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in ipairs((self:getCollectData():getCardStructList(arg_26_1, true))) do
		if iter_26_1:isActive() then
			table.insert(var_26_0, iter_26_1)
		end
	end

	return var_26_0
end

function EchoLabData:getLineUpCountByType(arg_27_1)
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs((self:getCollectData():getCardStructList(arg_27_1, true))) do
		if iter_27_1:isLineUp() then
			table.insert(var_27_0, iter_27_1)
		end
	end

	return #var_27_0
end

function EchoLabData:getCanLineUpCountByType(arg_28_1)
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in ipairs((self:getCollectData():getCardStructList(arg_28_1, true))) do
		if iter_28_1:isActive() and not iter_28_1:isLineUp() then
			table.insert(var_28_0, iter_28_1)
		end
	end

	return #var_28_0
end

function EchoLabData:isHaveCanLineUpCardByType(arg_29_1, arg_29_2)
	local var_29_0 = self:getCanLineUpCountByType(arg_29_2)
	local var_29_1 = var_0_5.get((self:getPalaceId()))[var_0_0.EMBRYO_SLOT_FIELDS[arg_29_1].name .. "_slot_num"] - self:getLineUpCountByType(arg_29_2)

	if var_29_1 > 0 then
		return var_29_1 <= var_29_0
	end

	return false
end

function EchoLabData:isHaveCanLineUpCards(arg_30_1)
	if not self:isUnlockEchoLabTerminal() then
		return false
	end

	if not arg_30_1.ctrlType or not arg_30_1.cardType then
		for iter_30_0 = 1, #var_0_0.EchoLabNameArray do
			if self:_hasHigherValue(iter_30_0, var_0_0.EchoLabNameArray[iter_30_0].cardType) then
				return true
			end
		end

		return false
	elseif arg_30_1.curPos then
		if arg_30_1.curPos > var_0_5.get((self:getPalaceId()))[var_0_0.EMBRYO_SLOT_FIELDS[arg_30_1.ctrlType].name .. "_slot_num"] then
			return false
		end

		local var_30_0 = self:getCardStructByTypeAndPos(arg_30_1.cardType, arg_30_1.curPos)

		if var_30_0 then
			local var_30_1 = self:getNotLineUpCardListByType(arg_30_1.cardType)[1]

			if var_30_1 then
				return var_30_1:getLineUpAttrInfo().value > var_30_0:getLineUpAttrInfo().value
			end
		else
			return true
		end
	elseif self:_hasHigherValue(arg_30_1.ctrlType, arg_30_1.cardType) then
		return true
	end
end

function EchoLabData:_hasHigherValue(arg_31_1, arg_31_2)
	local var_31_0 = self:getNotLineUpCardListByType(arg_31_2)[1]

	if not var_31_0 then
		return false
	end

	for iter_31_0 = 1, var_0_5.get((self:getPalaceId()))[var_0_0.EMBRYO_SLOT_FIELDS[arg_31_1].name .. "_slot_num"] do
		local var_31_1 = self:getCardStructByTypeAndPos(arg_31_2, iter_31_0)

		if not var_31_1 then
			return true
		end

		if var_31_1:getLineUpAttrInfo().value < var_31_0:getLineUpAttrInfo().value then
			return true
		end
	end

	return false
end

function EchoLabData:getNotLineUpCardListByType(arg_32_1)
	local var_32_0 = self:getCanLineUpCardListByType(arg_32_1)
	local var_32_1 = {}

	for iter_32_0 = 1, #var_32_0 do
		if not var_32_0[iter_32_0]:isLineUp() then
			table.insert(var_32_1, var_32_0[iter_32_0])
		end
	end

	table.sort(var_32_1, function(arg_33_0, arg_33_1)
		return arg_33_0:getLineUpAttrInfo().value > arg_33_1:getLineUpAttrInfo().value
	end)

	return var_32_1
end

return EchoLabData
