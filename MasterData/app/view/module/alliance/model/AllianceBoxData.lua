local var_0_0 = g.core.const.ConstMgr.AllianceConst
local var_0_1 = g.core.config.guild_alliance_reward_box_info
local var_0_2 = g.core.config.guild_alliance_box_info
local AllianceBoxData = class("AllianceBoxData")

function AllianceBoxData:ctor()
	self._logIndex = 1
	self._insertLogList = {}
	self._showedLogIdDict = {}
	self._myCanOpenBoxDict = {}
	self._myCanSendBoxDict = {}
	self._score = 0
	self._curScoreId = 0

	self:resetData()
end

function AllianceBoxData:resetData()
	self._boxList = {}
	self._curShowBoxList = {}
	self._logList = {}
end

function AllianceBoxData:setCurScoreId(arg_3_1)
	self._curScoreId = arg_3_1 or 0
end

function AllianceBoxData:setCurScore(arg_4_1)
	self._score = arg_4_1 or 0
end

function AllianceBoxData:updateBoxData(arg_5_1)
	self:setCurScore(arg_5_1.box_score)
	self:setCurScoreId(arg_5_1.cur_award_box_id)

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.not_send_boxes or {}) do
		self._myCanSendBoxDict[iter_5_1.id] = iter_5_1.num
	end

	for iter_5_2, iter_5_3 in ipairs(arg_5_1.receive_boxes or {}) do
		self._myCanOpenBoxDict[iter_5_3.id] = iter_5_3.num
	end
end

function AllianceBoxData:onS2CGetBoxInfo(arg_6_1)
	self:resetData()

	local var_6_0 = self:_getStartLogTime()
	local var_6_1 = arg_6_1.box or {}

	table.sort(var_6_1, function(arg_7_0, arg_7_1)
		return arg_7_0.box_time < arg_7_1.box_time
	end)

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		local var_6_2 = iter_6_1.get_num or 0
		local var_6_3 = var_0_2.get(iter_6_1.box_info_id)

		for iter_6_2 = 1, iter_6_1.box_num - var_6_2 do
			table.insert(self._boxList, {
				box_id = iter_6_1.box_id,
				box_info_id = iter_6_1.box_info_id,
				user_name = iter_6_1.user_name,
				user_id = iter_6_1.user_id,
				box_num = iter_6_1.box_num,
				box_time = iter_6_1.box_time,
				boxIndex = iter_6_2,
				boxInfo = var_6_3
			})
		end

		if var_6_0 <= iter_6_1.box_time and var_6_3.quality >= var_0_0.SHOW_LOG_QUALITY then
			table.insert(self._logList, {
				box_id = iter_6_1.box_id,
				box_info_id = iter_6_1.box_info_id,
				user_name = iter_6_1.user_name,
				user_id = iter_6_1.user_id,
				box_num = iter_6_1.box_num,
				box_time = iter_6_1.box_time,
				boxInfo = var_6_3
			})
		end
	end
end

function AllianceBoxData:_getStartLogTime()
	return g.core.common.ServerTime:getNextNDayZeroTime(nil, 0) + g.core.model.User.allianceData:getParams(var_0_0.PARAMETER.BOX_SENDS_START_TIME) * 3600
end

function AllianceBoxData:onS2CBoxGet(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1.boxes or {}) do
		self._myCanOpenBoxDict[iter_9_1.id] = self._myCanOpenBoxDict[iter_9_1.id] or 0
		self._myCanOpenBoxDict[iter_9_1.id] = self._myCanOpenBoxDict[iter_9_1.id] + iter_9_1.num
	end
end

function AllianceBoxData:onS2CBoxOpen(arg_10_1)
	self:setCurScore(arg_10_1.cur_score or 0)

	self._myCanOpenBoxDict[arg_10_1.box_info_id] = self._myCanOpenBoxDict[arg_10_1.box_info_id] - arg_10_1.num
end

function AllianceBoxData:onS2CBoxNotify(arg_11_1)
	self._myCanSendBoxDict[arg_11_1.box_info_id] = self._myCanSendBoxDict[arg_11_1.box_info_id] or 0
	self._myCanSendBoxDict[arg_11_1.box_info_id] = self._myCanSendBoxDict[arg_11_1.box_info_id] + arg_11_1.num
end

function AllianceBoxData:onS2CBoxGrandNotify(arg_12_1)
	local var_12_0 = arg_12_1.box.get_num or 0
	local var_12_1 = var_0_2.get(arg_12_1.box.box_info_id)

	for iter_12_0 = 1, arg_12_1.box.box_num - var_12_0 do
		table.insert(self._boxList, {
			box_id = arg_12_1.box.box_id,
			box_info_id = arg_12_1.box.box_info_id,
			user_name = arg_12_1.box.user_name,
			user_id = arg_12_1.box.user_id,
			box_num = arg_12_1.box.box_num,
			box_time = arg_12_1.box.box_time,
			boxIndex = iter_12_0,
			boxInfo = var_12_1
		})
	end

	table.insert(self._logList, {
		box_id = arg_12_1.box.box_id,
		box_info_id = arg_12_1.box.box_info_id,
		user_name = arg_12_1.box.user_name,
		user_id = arg_12_1.box.user_id,
		box_num = arg_12_1.box.box_num,
		box_time = arg_12_1.box.box_time,
		boxInfo = var_12_1
	})
end

function AllianceBoxData:onS2CBoxSendBox(arg_13_1)
	self._myCanSendBoxDict[arg_13_1.box.box_info_id] = self._myCanSendBoxDict[arg_13_1.box.box_info_id] - arg_13_1.box.box_num

	self:insertLog(arg_13_1.box)
end

function AllianceBoxData:onS2CBoxExchangeBoxAward(arg_14_1)
	self:setCurScore(arg_14_1.left_score)
	self:setCurScoreId(arg_14_1.new_id)

	self._myCanOpenBoxDict[arg_14_1.box_info_id] = self._myCanOpenBoxDict[arg_14_1.box_info_id] or 0
	self._myCanOpenBoxDict[arg_14_1.box_info_id] = self._myCanOpenBoxDict[arg_14_1.box_info_id] + 1
end

function AllianceBoxData:getShowBoxList()
	if #self._curShowBoxList == 0 then
		for iter_15_0 = 1, g.core.model.User.allianceData:getParams(var_0_0.PARAMETER.SHOW_BOX_MAX) do
			if self._boxList[iter_15_0] then
				table.insert(self._curShowBoxList, self._boxList[iter_15_0])
			else
				break
			end
		end
	end

	return self._curShowBoxList
end

function AllianceBoxData:getOpenBoxCount(arg_16_1)
	return self._myCanOpenBoxDict[arg_16_1] or 0
end

function AllianceBoxData:getSendBoxCount(arg_17_1)
	return self._myCanSendBoxDict[arg_17_1] or 0
end

function AllianceBoxData:insertLog(arg_18_1)
	local var_18_0 = var_0_2.get(arg_18_1.box_info_id)

	if var_18_0.quality >= var_0_0.SHOW_LOG_QUALITY then
		table.insert(self._insertLogList, {
			box_id = arg_18_1.box_id,
			box_info_id = arg_18_1.box_info_id,
			user_name = arg_18_1.user_name,
			user_id = arg_18_1.user_id,
			box_num = arg_18_1.box_num,
			box_time = arg_18_1.box_time,
			boxInfo = var_18_0
		})
	end
end

function AllianceBoxData:getLog()
	if #self._insertLogList > 0 then
		local var_19_0 = table.remove(self._insertLogList, 1)

		self._showedLogIdDict[var_19_0.box_id] = true

		return var_19_0
	end

	local var_19_1 = #self._logList

	if #self._logList == 0 then
		return nil
	end

	if var_19_1 < self._logIndex then
		self._logIndex = 1
		self._showedLogIdDict = {}
	end

	local var_19_2 = self._logList[self._logIndex]

	if self._showedLogIdDict[self._logList[self._logIndex].box_id] then
		self._logIndex = self._logIndex + 1

		return self:getLog()
	end

	self._showedLogIdDict[var_19_2.box_id] = true

	return var_19_2
end

function AllianceBoxData:getCurScore()
	return self._score
end

function AllianceBoxData:getCurInfo()
	if self._curScoreId > 0 then
		return var_0_1.get(self._curScoreId)
	else
		return nil
	end
end

function AllianceBoxData:updateBoxTime()
	local var_22_0 = g.core.model.User.allianceData:getParams(var_0_0.PARAMETER.BOX_TIME_MAX) - 5
	local var_22_1 = g.core.common.ServerTime:getTime()
	local var_22_2 = false

	while self._boxList[1] do
		if var_22_1 > self._boxList[1].box_time + var_22_0 then
			var_22_2 = true

			table.remove(self._boxList, 1)
		else
			break
		end
	end

	if var_22_2 then
		self._curShowBoxList = {}
	end

	if self._logList[1] then
		if (self._logList[1].box_time or 0) < self:_getStartLogTime() then
			self._logList = {}
		end
	end

	return var_22_2
end

function AllianceBoxData:boxIsExpired(arg_23_1)
	return g.core.common.ServerTime:getTime() >= arg_23_1 + g.core.model.User.allianceData:getParams(var_0_0.PARAMETER.BOX_TIME_MAX)
end

function AllianceBoxData:hasRedSendBox(arg_24_1)
	if arg_24_1 then
		local var_24_0 = arg_24_1.boxId or 0

		if var_24_0 > 0 then
			do return self._myCanSendBoxDict[var_24_0] and self._myCanSendBoxDict[var_24_0] > 0 end

			goto label_24_0
		end
	end

	for iter_24_0, iter_24_1 in pairs(self._myCanSendBoxDict) do
		if iter_24_1 > 0 then
			return true
		end
	end

	::label_24_0::

	return false
end

function AllianceBoxData:hasRedOpenBox(arg_25_1)
	if arg_25_1 then
		local var_25_0 = arg_25_1.boxId or 0

		if var_25_0 > 0 then
			do return self._myCanOpenBoxDict[var_25_0] and self._myCanOpenBoxDict[var_25_0] > 0 end

			goto label_25_0
		end
	end

	for iter_25_0, iter_25_1 in pairs(self._myCanOpenBoxDict) do
		if iter_25_1 > 0 then
			return true
		end
	end

	::label_25_0::

	return false
end

function AllianceBoxData:hasRedBoxScoreAward(arg_26_1)
	local var_26_0 = self:getCurInfo()

	if not var_26_0 then
		return false
	end

	return self._score >= var_26_0.need
end

function AllianceBoxData:hasRedGetBox(arg_27_1)
	return #self:getShowBoxList() > 0
end

return AllianceBoxData
