local var_0_0 = g.core.const.ConstMgr.SuccubaConst
local SuccubaStruct = require("app.view.module.succuba.model.SuccubaStruct")
local SuccubaData = class("SuccubaData")

function SuccubaData:ctor()
	self:initData()
end

function SuccubaData:initData()
	self._succubaList = {}
	self._indexMap = {
		sid = {},
		advanceId = {},
		lineUp = {},
		room = {}
	}
	self._advMap = {}
	self._advNum = 0
	self._aiData = require("app.view.module.succuba.model.AIData").new()
	self._actionTimes = 0
	self._requestInfo = false
	var_0_0.FORMAT_SUCCUBA_NUM_MAX = g.core.config.succuba_parameter_info.get(var_0_0.PARAMETER_ID.FORMATION_MAX_ID).parameter

	for iter_2_0 = 1, g.core.config.succuba_info.getLength() do
		local var_2_0 = g.core.config.succuba_info.indexOf(iter_2_0)

		if not self._advMap[var_2_0.advance_id] then
			self._advMap[var_2_0.advance_id] = var_2_0.id
			self._advNum = self._advNum + 1
		end
	end
end

function SuccubaData:getSuccubaBySid(arg_3_1)
	return self._indexMap.sid[arg_3_1]
end

function SuccubaData:getSuccubaByAdvanceId(arg_4_1, arg_4_2)
	return (not self._indexMap.advanceId[arg_4_1] and arg_4_2 or nil) and self:_createSuccubaStruct(self._advMap[arg_4_1], nil, true)
end

function SuccubaData:getSuccubaByCfgId(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(self._succubaList) do
		if iter_5_1:getCurCfg().id == arg_5_1 then
			return iter_5_1
		end
	end
end

function SuccubaData:getLineUpSuccuba(arg_6_1)
	return self._indexMap.lineUp[arg_6_1]
end

function SuccubaData:getSuccubaList()
	return self._succubaList
end

function SuccubaData:getTotalCharm()
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs((self:getSuccubaList())) do
		var_8_0 = var_8_0 + iter_8_1:getCharm()
	end

	return var_8_0
end

function SuccubaData:getAllSuccubaList()
	local var_9_0 = {}

	if #self._succubaList < self._advNum then
		for iter_9_0, iter_9_1 in pairs(self._advMap) do
			local var_9_1 = not g.core.model.User.homeData:checkItemIsInUnputList("succuba_info", iter_9_0)

			if not self._indexMap.advanceId[iter_9_0] then
				if var_9_1 then
					var_9_0[#var_9_0 + 1] = self:_createSuccubaStruct(iter_9_1, nil, true)
				end
			elseif var_9_1 or self._indexMap.advanceId[iter_9_0]:isOwn() then
				var_9_0[#var_9_0 + 1] = self._indexMap.advanceId[iter_9_0]
			end
		end

		table.sort(var_9_0, function(arg_10_0, arg_10_1)
			local var_10_0 = arg_10_0:isOwn()
			local var_10_1 = arg_10_0:isCanCompose()

			if var_10_1 ~= arg_10_1:isCanCompose() then
				return var_10_1
			end

			if var_10_0 ~= arg_10_1:isOwn() then
				return var_10_0
			end

			return arg_10_0:getCurCfg().id < arg_10_1:getCurCfg().id
		end)
	else
		for iter_9_2, iter_9_3 in ipairs(self._succubaList) do
			if iter_9_3:isPut() or iter_9_3:isOwn() then
				var_9_0[#var_9_0 + 1] = iter_9_3
			end
		end
	end

	return var_9_0
end

function SuccubaData:getLineUpSuccubaList()
	return self._indexMap.lineUp
end

function SuccubaData:getRoomListByCheckInit()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(self._succubaList) do
		if iter_12_1:getRoomId() == 0 then
			var_12_0[#var_12_0 + 1] = iter_12_1
		end
	end

	if #var_12_0 > 0 then
		for iter_12_2 = 1, g.core.const.ConstMgr.SuccubaConst.ROOM_MAX_NUM do
			if not self._indexMap.room[iter_12_2] and #var_12_0 > 0 then
				self:checkInRoom(table.remove(var_12_0, (math.random(1, #var_12_0))):getSid(), iter_12_2)
			end
		end
	end

	return self._indexMap.room
end

function SuccubaData:getRoomList()
	return self._indexMap.room
end

function SuccubaData:getSuccubaByRoom(arg_14_1)
	return self._indexMap.room[arg_14_1]
end

function SuccubaData:getRandomAlongSuccubaList()
	local var_15_0 = {}
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(self._succubaList) do
		if iter_15_1:getRoomId() == 0 then
			var_15_0[#var_15_0 + 1] = iter_15_1
		else
			var_15_1[#var_15_1 + 1] = iter_15_1
		end
	end

	local var_15_2 = var_15_0

	if #var_15_0 > 3 then
		var_15_2 = {}

		for iter_15_2 = 1, 3 do
			local var_15_3 = math.random(1, #var_15_0)

			var_15_2[iter_15_2] = var_15_0[var_15_3]

			table.remove(var_15_0, var_15_3)
		end
	elseif #var_15_1 > 0 then
		for iter_15_3 = 1, math.min(#var_15_1, 3 - #var_15_2) do
			local var_15_4 = math.random(1, #var_15_1)

			var_15_2[#var_15_2 + 1] = var_15_1[var_15_4]

			table.remove(var_15_1, var_15_4)
		end
	end

	return var_15_2
end

function SuccubaData:getAIData()
	return self._aiData
end

function SuccubaData:_createSuccubaStruct(arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = SuccubaStruct.new({
		id = arg_17_1
	})

	if not arg_17_3 then
		self._succubaList[#self._succubaList + 1] = var_17_0
		self._indexMap.advanceId[var_17_0:getAdvanceId()] = var_17_0
		self._indexMap.sid[arg_17_2] = var_17_0
	end

	return var_17_0
end

function SuccubaData:checkNeedRequest()
	return g.core.common.ModuleUnlock:isFunctionUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.SUCCUBA) and not self._requestInfo
end

function SuccubaData:updateSuccubaSvrInfo(arg_19_1)
	local var_19_0 = self:getSuccubaBySid(arg_19_1.id) or self:_createSuccubaStruct(arg_19_1.base_id, arg_19_1.id)

	if arg_19_1.position then
		self:_changeFormation(var_19_0, arg_19_1.position)
	end

	var_19_0:updateSvrInfo(arg_19_1)
end

function SuccubaData:updateInteractionInfo(arg_20_1)
	(self:getSuccubaBySid(arg_20_1.id) or self:_createSuccubaStruct(arg_20_1.base_id, arg_20_1.id)):updateInteractionInfo(arg_20_1)
end

function SuccubaData:removeSuccubaBySid(arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(self._succubaList) do
		if iter_21_1:getSid() == arg_21_1 then
			table.remove(self._succubaList, iter_21_0)

			self._indexMap.sid[arg_21_1] = nil
			self._indexMap.advanceId[iter_21_1:getAdvanceId()] = nil

			local var_21_0 = iter_21_1:getPosition()

			if var_21_0 then
				self._indexMap.lineUp[var_21_0] = nil
			end

			break
		end
	end
end

function SuccubaData:checkInRoom(arg_22_1, arg_22_2)
	local var_22_0 = self:getSuccubaBySid(arg_22_1)

	if self._indexMap.room[arg_22_2] then
		self._indexMap.room[arg_22_2]:setRoomId(0)
	end

	local var_22_1 = var_22_0:getRoomId()

	if var_22_1 ~= 0 then
		self._indexMap.room[var_22_1] = nil
	end

	self._indexMap.room[arg_22_2] = var_22_0

	var_22_0:setRoomId(arg_22_2)
end

function SuccubaData:getInteractionActionTimes()
	return self._actionTimes
end

function SuccubaData:setMainShowSuccuba(arg_24_1)
	self._indexMap.main = self:getSuccubaBySid(arg_24_1)
end

function SuccubaData:getMainShowSuccuba()
	return self._indexMap.main
end

function SuccubaData:getAllCanSellFrag()
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in ipairs((self:getSuccubaList())) do
		local var_26_1 = iter_26_1:getCurCfg()
		local var_26_2 = g.core.model.User.fragmentsData:getFragmentNumById(var_26_1.fragment)

		if var_26_2 > 0 then
			local var_26_3 = g.core.config.fragment_info.get(var_26_1.fragment)

			table.insert(var_26_0, {
				type = g.core.common.Goods.TYPE_FRAGMENT,
				value = var_26_1.fragment,
				size = var_26_2,
				priceType = var_26_3.price_type,
				priceValue = var_26_3.price_value,
				priceSize = var_26_3.price_size,
				quality = var_26_3.quality
			})
		end
	end

	return var_26_0
end

function SuccubaData:getCanSellFrag()
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs((self:getSuccubaList())) do
		local var_27_1 = iter_27_1:getCurCfg()
		local var_27_2 = g.core.model.User.fragmentsData:getFragmentNumById(var_27_1.fragment)

		if iter_27_1:isMaxStar() and var_27_2 > 0 then
			local var_27_3 = g.core.config.fragment_info.get(var_27_1.fragment)

			table.insert(var_27_0, {
				type = g.core.common.Goods.TYPE_FRAGMENT,
				value = var_27_1.fragment,
				size = var_27_2,
				priceType = var_27_3.price_type,
				priceValue = var_27_3.price_value,
				priceSize = var_27_3.price_size,
				quality = var_27_3.quality
			})
		end
	end

	return var_27_0
end

function SuccubaData:_changeFormation(arg_28_1, arg_28_2)
	local var_28_0 = arg_28_1:getPosition()

	if arg_28_2 > 0 then
		local var_28_1 = self:getLineUpSuccuba(arg_28_2)

		if var_28_1 then
			var_28_1:updateSvrInfo({
				position = var_28_0
			})
		end

		self._indexMap.lineUp[var_28_0] = var_28_1
	end

	arg_28_1:updateSvrInfo({
		position = arg_28_2
	})

	if arg_28_2 ~= 0 then
		self._indexMap.lineUp[arg_28_2] = arg_28_1
	else
		self._indexMap.lineUp[var_28_0] = nil
	end
end

function SuccubaData:onS2CSuccubaGetInfo(arg_29_1)
	self._requestInfo = true

	for iter_29_0, iter_29_1 in ipairs(arg_29_1.succubas or {}) do
		self:updateSuccubaSvrInfo(iter_29_1)
	end

	for iter_29_2, iter_29_3 in ipairs(arg_29_1.inter_actions or {}) do
		self:updateInteractionInfo(iter_29_3)
	end

	self._actionTimes = arg_29_1.action_times or 0

	if arg_29_1.main_succuba_id then
		self:setMainShowSuccuba(arg_29_1.main_succuba_id)
	end
end

function SuccubaData:onS2CSuccubaLevelUp(arg_30_1)
	return
end

function SuccubaData:onS2CSuccubaStarUp(arg_31_1)
	return
end

function SuccubaData:onS2CSuccubaSetMainSuccuba(arg_32_1)
	self:setMainShowSuccuba(arg_32_1.id)
end

function SuccubaData:onS2CSuccubaInterActiveGet(arg_33_1)
	self:getSuccubaBySid(arg_33_1.id):setEventId(arg_33_1.event_id)

	self._actionTimes = self._actionTimes + 1
end

function SuccubaData:onSuccubaInterActiveSave(arg_34_1)
	self:updateInteractionInfo({
		id = arg_34_1.id,
		event_id = arg_34_1.event_id,
		progress = arg_34_1.progress
	})
end

function SuccubaData:onSuccubaInterActiveFinish(arg_35_1)
	local var_35_0 = self:getSuccubaBySid(arg_35_1.id)

	if arg_35_1.tp == 1 then
		self:updateInteractionInfo({
			event_id = 0,
			progress = 0,
			id = arg_35_1.id
		})

		if arg_35_1.event_id then
			var_35_0:onActiveEvent(arg_35_1.event_id)
		end

		var_35_0:updateInteractionInfo(arg_35_1.data)
	elseif arg_35_1.tp == 2 then
		var_35_0:updateInteractionInfo(arg_35_1.data)
		var_35_0:costAIExpTimes()
	end
end

function SuccubaData:onSuccubaInterActiveActivation(arg_36_1)
	return
end

function SuccubaData:onSuccubaFlush(arg_37_1)
	for iter_37_0, iter_37_1 in ipairs(arg_37_1.succubas or {}) do
		self:updateSuccubaSvrInfo(iter_37_1)
	end

	for iter_37_2, iter_37_3 in ipairs(arg_37_1.inter_actions or {}) do
		self:updateInteractionInfo(iter_37_3)
	end

	self._actionTimes = arg_37_1.action_times or 0
end

function SuccubaData:onSuccubaStageUp(arg_38_1)
	local var_38_0 = self:getSuccubaBySid(arg_38_1.id)

	var_38_0:setStage(arg_38_1.next_stage)
	var_38_0:setNode(arg_38_1.next_node)
	var_38_0:refreshAdvanceStageInfo()
end

function SuccubaData:onS2CSuccubaOpObject(arg_39_1)
	if arg_39_1.insert then
		for iter_39_0, iter_39_1 in ipairs(arg_39_1.insert) do
			self:updateSuccubaSvrInfo(iter_39_1)
		end
	end

	if arg_39_1.update then
		for iter_39_2, iter_39_3 in ipairs(arg_39_1.update) do
			self:updateSuccubaSvrInfo(iter_39_3)
		end
	end

	if arg_39_1.del then
		for iter_39_4, iter_39_5 in ipairs(arg_39_1.del) do
			self:removeSuccubaBySid(iter_39_5)
		end
	end
end

function SuccubaData:onS2CFormationChangeFormation(arg_40_1)
	self:_changeFormation(self:getSuccubaBySid(arg_40_1.id), arg_40_1.pos)
end

function SuccubaData:getLeftInteractionTimes()
	return g.core.config.succuba_parameter_info.get(var_0_0.PARAMETER_ID.INTERACTION_TIMES_ID).parameter - self:getInteractionActionTimes()
end

function SuccubaData:hasLeftInteractionTimes(arg_42_1)
	if arg_42_1.sid == 0 then
		return false
	end

	return #self._succubaList > 0 and self:getLeftInteractionTimes() > 0
end

function SuccubaData:hasLeftAITimes(arg_43_1)
	if #self._succubaList == 0 then
		return false
	end

	local var_43_0 = false

	if arg_43_1.sid then
		var_43_0 = self:succubaHasLeftAIExpTimes(arg_43_1.sid)
	else
		for iter_43_0, iter_43_1 in ipairs(self._succubaList) do
			if self:succubaHasLeftAIExpTimes(iter_43_1:getSid()) then
				var_43_0 = true

				break
			end
		end
	end

	return var_43_0
end

function SuccubaData:succubaHasLeftAIExpTimes(arg_44_1, arg_44_2)
	local var_44_0 = g.core.model.User.succubaData:getSuccubaBySid(arg_44_1)

	if not var_44_0 then
		return false
	end

	local var_44_1 = g.core.config.succuba_parameter_info.get(g.core.const.ConstMgr.SuccubaConst.PARAMETER_ID.CHAT_AI_EXP_TIMES).parameter

	if arg_44_2 then
		return var_44_1 >= var_44_0:getInteractionAIExpTimes()
	end

	return var_44_1 > var_44_0:getInteractionAIExpTimes()
end

function SuccubaData:hasSuccubaCanLevelUp(arg_45_1)
	if #self._succubaList == 0 then
		return false
	end

	local var_45_0 = false

	if arg_45_1.sid then
		local var_45_1 = self:getSuccubaBySid(arg_45_1.sid)

		if var_45_1 then
			var_45_0 = var_45_1:isLvUpAvailable()
		end
	else
		for iter_45_0, iter_45_1 in ipairs(self._succubaList) do
			if iter_45_1:isLvUpAvailable() then
				var_45_0 = true

				break
			end
		end
	end

	return var_45_0
end

function SuccubaData:hasSuccubaCanStarUp(arg_46_1)
	if #self._succubaList == 0 then
		return false
	end

	local var_46_0 = false

	if arg_46_1.sid then
		local var_46_1 = self:getSuccubaBySid(arg_46_1.sid)

		if var_46_1 then
			var_46_0 = var_46_1:isStarUpAvailable()
		end
	else
		for iter_46_0, iter_46_1 in ipairs(self._succubaList) do
			if iter_46_1:isStarUpAvailable() then
				var_46_0 = true

				break
			end
		end
	end

	return var_46_0
end

function SuccubaData:canLineUpSuccuba(arg_47_1)
	if #self._succubaList <= table.nums(self._indexMap.lineUp) then
		return false
	end

	if arg_47_1.pos then
		return self._indexMap.lineUp[arg_47_1.pos] == nil
	else
		local var_47_0 = false

		for iter_47_0 = 1, var_0_0.FORMAT_SUCCUBA_NUM_MAX do
			if not self._indexMap.lineUp[iter_47_0] then
				var_47_0 = true

				break
			end
		end

		return var_47_0
	end
end

function SuccubaData:canAdvUpSuccuba(arg_48_1)
	if #self._succubaList == 0 then
		return false
	end

	local var_48_0 = false

	if arg_48_1.sid then
		local var_48_1 = self:getSuccubaBySid(arg_48_1.sid)

		if var_48_1 then
			var_48_0 = var_48_1:isAdvUpAvailable()
		end
	else
		for iter_48_0, iter_48_1 in ipairs(self._succubaList) do
			if iter_48_1:isAdvUpAvailable() then
				var_48_0 = true

				break
			end
		end
	end

	return var_48_0
end

return SuccubaData
