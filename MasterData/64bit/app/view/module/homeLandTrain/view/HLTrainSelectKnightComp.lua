local HLTrainConst = require("app.view.module.homeLandTrain.const.HLTrainConst")
local var_0_1 = g.core.model.User.hlTrainData
local var_0_2 = g.core.model.User.furnitureData
local BaseConfirmPop = require("app.view.base.pop.BaseConfirmPop")
local var_0_4 = g.core.model.User.knightsData
local HLTrainSelectKnightComp = class("HLTrainSelectKnightComp", require("app.fairyGUI.homeLandTrain.UI_HLTrainSelectKnightComp"))

function HLTrainSelectKnightComp:ctor()
	self._roomStruct = nil
	self._choseDict = {}
	self._ownKnightArr = var_0_4:getSpList(self:_getKnightFilter())
	self._showKnightArr = self._ownKnightArr
	self._dispatchedDict = var_0_1:getDispatchedKnightIdMap()
	self._recommendKnightIdDict = {}

	self.m_knightList:setVirtual()
	self.m_knightList:doFairyBatching(false)
	self.m_knightList:setItemRenderer(handler(self, self._onKnightListRenderer))
	self.m_knightList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickOwnKnightItem))
	self.m_dispatchBtn:addClickListener(handler(self, self._onClickDispatchBtn))
	self.m_clearChoseBtn:addClickListener(handler(self, self._onClickClearChoseBtn))
end

function HLTrainSelectKnightComp:initComp(arg_2_1)
	self._roomStruct = arg_2_1
	self._dispatchedDict = var_0_1:getDispatchedKnightIdMap()
	self._choseDict = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.knightIdArr) do
		self._choseDict[iter_2_1] = true
	end

	if #self._ownKnightArr > 1 then
		table.sort(self._ownKnightArr, self:_getSortRule())
	end

	self._recommendKnightIdDict = self:_getRecommendKnightIdDict()

	self.m_knightList:setNumItems(#self._showKnightArr)
	self.m_knightList:scrollToView(0)
	self:_updateTotalIncreasedPercentage()
end

function HLTrainSelectKnightComp:getChoseKnightIdArr()
	return table.keys(self._choseDict)
end

function HLTrainSelectKnightComp:updateKnightsMobility()
	for iter_4_0 = 0, self.m_knightList:numChildren() - 1 do
		self.m_knightList:getChildAt(iter_4_0):updateMobility()
	end
end

function HLTrainSelectKnightComp:_onClickOwnKnightItem(arg_5_1)
	local var_5_0 = arg_5_1:getDataValue()
	local var_5_1 = self._showKnightArr[var_5_0 + 1]:getServerId()

	if self._choseDict[var_5_1] then
		self:_changeChoseState(var_5_0, var_5_1)

		return
	end

	if table.nums(self._choseDict) >= math.min(HLTrainConst.ROOM_MAX_DISPATCH_NUM, self._roomStruct.refCfgInfo.limit_dispatch) then
		g.core.module.ModuleManager:tip(g.core.lang:get(111047))

		return
	end

	if self:_isDispatchedOtherRoom(var_5_1) then
		g.core.module.ModuleManager:pushPopup(BaseConfirmPop.new({
			title = g.core.lang:get(111026),
			desc = g.core.lang:get(111046),
			onConfirm = handler(self, function()
				self:_changeChoseState(var_5_0, var_5_1)
			end)
		}))
	elseif var_0_2:isKnightCheckIn(var_5_1) then
		g.core.module.ModuleManager:pushPopup(BaseConfirmPop.new({
			title = g.core.lang:get(111026),
			desc = g.core.lang:get(111044),
			onConfirm = handler(self, function()
				self:_changeChoseState(var_5_0, var_5_1)
			end)
		}))
	else
		self:_changeChoseState(var_5_0, var_5_1)
	end
end

function HLTrainSelectKnightComp:_onClickDispatchBtn()
	self:dispatchCompEvent("event_click_dispatch_btn")
end

function HLTrainSelectKnightComp:_onClickClearChoseBtn()
	self:clearChoseKnights()
	self:dispatchCompEvent("event_click_clear_chose_btn")
end

function HLTrainSelectKnightComp:clearChoseKnights()
	self._choseDict = {}

	self.m_knightList:setNumItems(#self._showKnightArr)
	self.m_knightList:scrollToView(0)
	self:_updateTotalIncreasedPercentage()
end

function HLTrainSelectKnightComp:resetChoseKnights()
	self._choseDict = {}

	for iter_11_0, iter_11_1 in ipairs(self._roomStruct.knightIdArr) do
		self._choseDict[iter_11_1] = true
	end

	self.m_knightList:setNumItems(#self._showKnightArr)
	self.m_knightList:scrollToView(0)
	self:_updateTotalIncreasedPercentage()
end

function HLTrainSelectKnightComp:_onKnightListRenderer(arg_12_1, arg_12_2)
	local var_12_0 = self._showKnightArr[arg_12_1 + 1]:getServerId()

	arg_12_2:updateCell(self._showKnightArr[arg_12_1 + 1], self:_isChose(var_12_0), self:_isRecommend(var_12_0), (self:_isDispatchedOtherRoom(var_12_0) or nil) and var_0_1:getRoomStruct(self._dispatchedDict[var_12_0]).refCfgBaseInfo.name)
end

function HLTrainSelectKnightComp:_getKnightFilter()
	return function(arg_14_0)
		return arg_14_0:isCanBeDispatched()
	end
end

function HLTrainSelectKnightComp:_getSortRule()
	return function(arg_16_0, arg_16_1)
		local var_16_0 = arg_16_0:getServerId()
		local var_16_1 = arg_16_1:getServerId()

		if self._choseDict[var_16_0] ~= self._choseDict[var_16_1] then
			return checkbool(self._choseDict[var_16_0])
		end

		local var_16_2 = arg_16_0:getMobilityVal()
		local var_16_3 = arg_16_1:getMobilityVal()
		local var_16_4

		if var_16_2 == 0 ~= (var_16_3 == 0) then
			do return var_16_3 == 0 end

			var_16_4 = var_0_1:isKnightDispatched(var_16_1)
		end

		local var_16_5

		if var_0_1:isKnightDispatched(var_16_0) ~= var_16_4 then
			do return var_16_4 end

			var_16_5 = var_0_2:isKnightCheckIn(var_16_1)
		end

		if var_0_2:isKnightCheckIn(var_16_0) ~= var_16_5 then
			return var_16_5
		end

		local var_16_6 = arg_16_0:getHomeLandTalent()
		local var_16_7 = arg_16_1:getHomeLandTalent()

		if var_16_6 ~= var_16_7 then
			return var_16_7 < var_16_6
		end

		if var_16_2 ~= var_16_3 then
			return var_16_3 < var_16_2
		end

		local var_16_8 = arg_16_0:getQuality()
		local var_16_9 = arg_16_1:getQuality()

		if var_16_8 ~= var_16_9 then
			return var_16_9 < var_16_8
		end

		local var_16_10 = arg_16_0:getStarLv()
		local var_16_11 = arg_16_1:getStarLv()

		if var_16_10 == var_16_11 then
			return var_16_1 < var_16_0
		else
			return var_16_11 < var_16_10
		end
	end
end

function HLTrainSelectKnightComp:_changeChoseState(arg_17_1, arg_17_2)
	local var_17_0 = not self:_isChose(arg_17_2)

	self._choseDict[arg_17_2] = var_17_0 and true or nil

	local var_17_1 = self.m_knightList:itemIndexToChildIndex(arg_17_1)

	if var_17_1 >= 0 and var_17_1 < self.m_knightList:numChildren() then
		self.m_knightList:getChildAt(var_17_1):setChose(var_17_0)
	end

	self:_updateTotalIncreasedPercentage()
	self:dispatchCompEvent("event_change_chose_knight")
end

function HLTrainSelectKnightComp:_isDispatchedOtherRoom(arg_18_1)
	if self._dispatchedDict[arg_18_1] then
		return self._dispatchedDict[arg_18_1] ~= self._roomStruct.advanceId
	end

	return false
end

function HLTrainSelectKnightComp:_getDeltaMobility(arg_19_1)
	local var_19_0 = 0

	if self._checkInMap[arg_19_1] then
		var_19_0 = var_0_2:getMobilityRecoverBaseSpeedWithKnightId(arg_19_1) / 3600 * self._passedTime
	elseif var_0_1:isKnightDispatched(arg_19_1) then
		var_19_0 = -var_0_1:getMobilityBaseCostPerHourWithKnightId(arg_19_1) / 3600 * self._passedTime
	end

	return var_19_0
end

function HLTrainSelectKnightComp:_getRecommendKnightIdDict()
	local var_20_0 = 0

	for iter_20_0, iter_20_1 in ipairs(self._roomStruct.knightIdArr) do
		if var_0_4:getKnightById(iter_20_1):getMobilityVal() > 0 then
			var_20_0 = var_20_0 + 1
		end
	end

	local var_20_1 = math.min(HLTrainConst.ROOM_MAX_DISPATCH_NUM, self._roomStruct.refCfgInfo.limit_dispatch) - var_20_0

	if var_20_1 < 1 then
		return {}
	end

	local var_20_2 = {}

	for iter_20_2, iter_20_3 in ipairs(self._ownKnightArr) do
		local var_20_3 = iter_20_3:getServerId()

		if not var_0_2:isKnightCheckIn(var_20_3) and not var_0_1:isKnightDispatched(var_20_3) and iter_20_3:getMobilityVal() > iter_20_3:getMaxMobility() * 0.35 then
			table.insert(var_20_2, iter_20_3)
		end
	end

	local var_20_4 = {}

	if var_20_1 < #var_20_2 then
		for iter_20_4 = 1, var_20_1 do
			var_20_4[var_20_2[iter_20_4]:getServerId()] = true
		end
	else
		for iter_20_5, iter_20_6 in ipairs(var_20_2) do
			var_20_4[iter_20_6:getServerId()] = true
		end
	end

	return var_20_4
end

function HLTrainSelectKnightComp:_isRecommend(arg_21_1)
	return checkbool(self._recommendKnightIdDict[arg_21_1])
end

function HLTrainSelectKnightComp:_updateTotalIncreasedPercentage()
	local var_22_0 = 0

	for iter_22_0, iter_22_1 in pairs(self._choseDict) do
		if iter_22_1 then
			var_22_0 = var_22_0 + var_0_4:getKnightById(iter_22_0):getHomeLandTalent()
		end
	end

	self.m_increasedNumTxt:setText((g.core.lang:get(111052, {
		num = var_22_0 / 10
	})))
end

function HLTrainSelectKnightComp:uncheckKnight(arg_23_1)
	if not self:_isChose(arg_23_1) then
		return
	end

	for iter_23_0, iter_23_1 in ipairs(self._showKnightArr) do
		if iter_23_1:getServerId() == arg_23_1 then
			self:_changeChoseState(iter_23_0 - 1, arg_23_1)

			break
		end
	end
end

function HLTrainSelectKnightComp:_isChose(arg_24_1)
	if arg_24_1 and arg_24_1 > 0 then
		return checkbool(self._choseDict[arg_24_1])
	end

	return false
end

return HLTrainSelectKnightComp
