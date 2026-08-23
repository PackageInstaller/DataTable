local MailsData = class("MailsData")
local MailsStruct = import(".MailsStruct")
local var_0_2 = {
	SYSTEM_TYPE = 2,
	CHAT_TYPE = 3,
	OTHER_TYPE = 4,
	AWARD_TYPE = 1
}
local var_0_3 = {
	DEL = 1,
	ADD = 0,
	CHANGE = 2
}
local var_0_4 = g.core.config.parameter_info
local var_0_5 = g.core.const.ConstMgr.PARAMETER_CONST

function MailsData:ctor()
	self:initData()
end

function MailsData:initData()
	self._isRewarded = false
	self._isMailRefresh = false
	self._mailMap = {}
	self._mailList = {}
	self._receivedAward = {}
	self._mailNumCanReward = checknumber(var_0_4.get(var_0_5.MAIL_REWARD_LIMIT).parameter)
	self._mailNumBubbleReward = checknumber(var_0_4.get(var_0_5.MAIL_BUBBLE_LEFT).parameter)
end

function MailsData:notifyMailRefresh(arg_3_1)
	self._isMailRefresh = arg_3_1
end

function MailsData:onMailInfoBack(arg_4_1)
	if arg_4_1.mail_type ~= var_0_2.AWARD_TYPE then
		if arg_4_1.mail_type == var_0_2.SYSTEM_TYPE then
			self:_initMailMap(arg_4_1.mail_type, arg_4_1.mails or {})
		end
	end
end

function MailsData:onAwardsMailBack(arg_5_1)
	self:_updateReceivedList(arg_5_1.id, arg_5_1.mail_type)
	self:setReceivedState(true)
end

function MailsData:onDeleteMailBack(arg_6_1)
	local var_6_0 = clone(arg_6_1.mail_type) or {}
	local var_6_1 = clone(arg_6_1.id) or {}

	if var_6_0 then
		local var_6_2 = g.core.common.Storage:load("mail_info.json") or {}

		var_6_2.isRead = var_6_2.isRead or {}

		for iter_6_0 = #var_6_2.isRead, 1, -1 do
			for iter_6_1, iter_6_2 in pairs(var_6_0) do
				if var_6_1[iter_6_1] == var_6_2.isRead[iter_6_0].mailId and iter_6_2 == var_6_2.isRead[iter_6_0].mailType then
					table.remove(var_6_2.isRead, iter_6_0)

					break
				end
			end
		end

		g.core.common.Storage:save("mail_info.json", var_6_2)

		for iter_6_3, iter_6_4 in pairs(var_6_0) do
			if self._mailMap[iter_6_4] then
				for iter_6_5, iter_6_6 in pairs(self._mailMap[iter_6_4]) do
					if iter_6_6:getMailId() == var_6_1[iter_6_3] then
						table.remove(self._mailMap[iter_6_4], iter_6_5)
						self:_modifyMailList(var_0_3.DEL, iter_6_6)

						break
					end
				end
			end
		end
	end
end

function MailsData:_initMailMap(arg_7_1, arg_7_2)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_2) do
		local var_7_1 = MailsStruct.new(iter_7_1.base_id)

		var_7_1:setMailType(arg_7_1)
		var_7_1:setMailId(iter_7_1.id)
		var_7_1:setRead(self:_isInLocalReadList(arg_7_1, iter_7_1.id))

		if iter_7_1.awards then
			var_7_1:setRewards(iter_7_1.awards)
		end

		if iter_7_1.got_award then
			var_7_1:setReceived(iter_7_1.got_award)
		end

		if iter_7_1.name and string.len(iter_7_1.name) > 0 then
			var_7_1:setMailSendName(iter_7_1.name)
		end

		if iter_7_1.time then
			var_7_1:setSendTime(iter_7_1.time)
		end

		if iter_7_1.sender_id then
			var_7_1:setSendId(iter_7_1.sender_id)
		end

		if iter_7_1.reason then
			var_7_1:setMailReason(iter_7_1.reason)
		end

		if iter_7_1.expire_time then
			var_7_1:setMailExpireTime(iter_7_1.expire_time)
		end

		if iter_7_1.keys then
			local var_7_2 = {}

			for iter_7_2 = 1, #iter_7_1.keys do
				var_7_2[iter_7_1.keys[iter_7_2]] = iter_7_1.values[iter_7_2]
			end

			var_7_1:setMailKeyValues(var_7_2)
		end

		var_7_1:extraDealValue()

		var_7_0[iter_7_0] = var_7_1
	end

	if not self._mailMap[arg_7_1] then
		self._mailMap[arg_7_1] = var_7_0

		self:_modifyMailListInBatches(var_0_3.ADD, var_7_0)
	else
		for iter_7_3, iter_7_4 in ipairs(var_7_0) do
			local var_7_3 = iter_7_4:getMailId()
			local var_7_4 = var_0_3.ADD

			for iter_7_5, iter_7_6 in pairs(self._mailMap[arg_7_1]) do
				if iter_7_6:getMailId() == var_7_3 then
					var_7_4 = var_0_3.CHANGE
					self._mailMap[arg_7_1][iter_7_5] = iter_7_4

					self:_modifyMailList(var_0_3.CHANGE, iter_7_4)

					break
				end
			end

			if var_7_4 == var_0_3.ADD then
				table.insert(self._mailMap[arg_7_1], 1, iter_7_4)
				self:_modifyMailList(var_0_3.ADD, iter_7_4)
			end
		end
	end
end

function MailsData:_modifyMailList(arg_8_1, arg_8_2)
	if var_0_3.ADD == arg_8_1 then
		local var_8_0 = arg_8_2:getUniqueId()

		if g.core.model.User.translateData:isHasMailCache(var_8_0) then
			arg_8_2:setTranslate(true)

			if g.core.model.User.translateData:isMailTranslateOpen(var_8_0) then
				arg_8_2:setTranslateOpen(true)
			end
		end

		table.insert(self._mailList, 1, arg_8_2)
	elseif var_0_3.DEL == arg_8_1 then
		local var_8_1 = arg_8_2:getMailId()
		local var_8_2 = arg_8_2:getMailType()

		for iter_8_0, iter_8_1 in ipairs(self._mailList) do
			if iter_8_1:getMailType() == var_8_2 and iter_8_1:getMailId() == var_8_1 then
				g.core.model.User.translateData:deleteMail(arg_8_2:getUniqueId())
				table.remove(self._mailList, iter_8_0)

				break
			end
		end
	elseif var_0_3.CHANGE == arg_8_1 then
		local var_8_3 = arg_8_2:getMailId()
		local var_8_4 = arg_8_2:getMailType()

		for iter_8_2, iter_8_3 in ipairs(self._mailList) do
			if iter_8_3:getMailType() == var_8_4 and iter_8_3:getMailId() == var_8_3 then
				self._mailList[iter_8_2] = arg_8_2

				break
			end
		end
	end
end

function MailsData:_modifyMailListInBatches(arg_9_1, arg_9_2)
	for iter_9_0, iter_9_1 in ipairs(arg_9_2) do
		self:_modifyMailList(arg_9_1, iter_9_1)
	end
end

function MailsData:_updateReceivedList(arg_10_1, arg_10_2)
	self._receivedAward = {}

	if arg_10_1 == 0 then
		for iter_10_0, iter_10_1 in pairs(self._mailMap) do
			for iter_10_2, iter_10_3 in pairs(iter_10_1) do
				if iter_10_3:isAwardExsist() and not iter_10_3:isReceived() then
					iter_10_3:setReceived(true)

					for iter_10_4, iter_10_5 in ipairs(iter_10_3:getMailAwards()) do
						table.insert(self._receivedAward, iter_10_5)
					end

					self:_modifyMailList(var_0_3.CHANGE, iter_10_3)
				end
			end
		end
	else
		for iter_10_6, iter_10_7 in pairs(self._mailMap[arg_10_2]) do
			if iter_10_7:getMailId() == arg_10_1 then
				iter_10_7:setReceived(true)

				for iter_10_8, iter_10_9 in ipairs(iter_10_7:getMailAwards()) do
					table.insert(self._receivedAward, iter_10_9)
				end

				self:_modifyMailList(var_0_3.CHANGE, iter_10_7)

				break
			end
		end
	end
end

function MailsData:markAsRead(arg_11_1)
	if self:_isInLocalReadList(arg_11_1:getMailType(), (arg_11_1:getMailId())) then
		return
	end

	local var_11_0 = arg_11_1:getMailType()
	local var_11_1 = arg_11_1:getMailId()
	local var_11_2 = g.core.common.Storage:load("mail_info.json") or {}

	var_11_2.isRead = var_11_2.isRead or {}

	table.insert(var_11_2.isRead, {
		id = var_11_1,
		mailId = var_11_1,
		mailType = var_11_0
	})
	g.core.common.Storage:save("mail_info.json", var_11_2)

	local var_11_3 = self:findMailItem(var_11_0, var_11_1)

	if var_11_3 then
		var_11_3:setRead(true)
		self:_modifyMailList(var_0_3.CHANGE, var_11_3)
	end
end

function MailsData:_isInLocalReadList(arg_12_1, arg_12_2)
	for iter_12_0, iter_12_1 in ipairs((g.core.common.Storage:load("mail_info.json") or {}).isRead or {}) do
		if iter_12_1.mailType == arg_12_1 and iter_12_1.mailId == arg_12_2 then
			return true
		end
	end

	return false
end

function MailsData:findMailItem(arg_13_1, arg_13_2)
	for iter_13_0, iter_13_1 in ipairs(self._mailMap[arg_13_1] or {}) do
		if iter_13_1:getMailId() == arg_13_2 then
			return iter_13_1
		end
	end
end

function MailsData:refreshMailInfo()
	self:_sortList(self._mailList)
end

function MailsData:_sortList(arg_15_1)
	arg_15_1 = arg_15_1 or {}

	if #arg_15_1 < 2 then
		return arg_15_1
	end

	table.sort(arg_15_1, function(arg_16_0, arg_16_1)
		if arg_16_0:isReceived() ~= arg_16_1:isReceived() then
			return arg_16_1:isReceived()
		end

		local var_16_0 = g.core.config.mail_info.get(arg_16_0:getMailBaseId())
		local var_16_1 = g.core.config.mail_info.get(arg_16_1:getMailBaseId())

		if var_16_0.top ~= var_16_1.top then
			return var_16_0.top > var_16_1.top
		end

		if arg_16_0:isRead() ~= arg_16_1:isRead() then
			return arg_16_1:isRead()
		end

		local var_16_2 = arg_16_0:getMailSendTime()
		local var_16_3 = arg_16_1:getMailSendTime()

		if var_16_2 ~= var_16_3 then
			return var_16_3 < var_16_2
		end

		if var_16_0.id == 1017 and var_16_1.id == 1017 then
			return tonumber(arg_16_0:getMailKeyValues().value) > tonumber(arg_16_1:getMailKeyValues().value)
		end

		return var_16_0.id > var_16_1.id
	end)

	return arg_15_1
end

function MailsData:setReceivedState(arg_17_1)
	self._isRewarded = arg_17_1
end

function MailsData:getCurMailList(arg_18_1)
	return self._mailMap[arg_18_1] or {}
end

function MailsData:getUnReadRedPointNum()
	local var_19_0 = self:getUnReadNum()

	if var_19_0 > 0 then
		return var_19_0
	else
		return 0
	end
end

function MailsData:getUnReadNum()
	local var_20_0 = 0

	for iter_20_0, iter_20_1 in pairs(self._mailList or {}) do
		if not iter_20_1:isAwardExsist() and not iter_20_1:isRead() or iter_20_1:isAwardExsist() and not iter_20_1:isReceived() then
			var_20_0 = var_20_0 + 1
		end
	end

	return var_20_0
end

function MailsData:isExistMailCheck()
	local var_21_0 = g.core.common.ServerTime:getTime()

	for iter_21_0, iter_21_1 in pairs(self._mailList or {}) do
		local var_21_2 = iter_21_1:getMailExpireTime()

		if not ((var_21_2 > 0 and var_21_2 < var_21_0 or nil) and true) then
			if iter_21_1:isAwardExsist() then
				if not iter_21_1:isReceived() then
					return true
				end
			elseif not iter_21_1:isRead() then
				return true
			end
		end
	end

	return false
end

function MailsData:getCanRewardNum()
	local var_22_1 = 0

	for iter_22_0, iter_22_1 in pairs(self._mailList or {}) do
		if iter_22_1:isAwardExsist() and not iter_22_1:isReceived() then
			var_22_1 = var_22_1 + 1
		end
	end

	return var_22_1
end

function MailsData:isShouldShowRewardBubble()
	return self._mailNumCanReward - self:getCanRewardNum() <= self._mailNumBubbleReward
end

function MailsData:isHasAwardMail()
	local var_24_1 = false

	for iter_24_0, iter_24_1 in pairs(self._mailList or {}) do
		if iter_24_1:isAwardExsist() and not iter_24_1:isReceived() then
			var_24_1 = true

			break
		end
	end

	return var_24_1
end

function MailsData:isHasExpireMail()
	local var_25_0 = g.core.common.ServerTime:getTime()
	local var_25_1 = false

	for iter_25_0, iter_25_1 in pairs(self._mailList or {}) do
		local var_25_2 = iter_25_1:getMailExpireTime()

		if var_25_2 > 0 and var_25_2 < var_25_0 then
			var_25_1 = true

			break
		end
	end

	return var_25_1
end

function MailsData:getCanDeledMail(arg_26_1)
	local var_26_0 = g.core.common.Storage:load("mail_info.json") or {}

	var_26_0.isRead = var_26_0.isRead or {}

	local var_26_1 = {}
	local var_26_2 = {}
	local var_26_3 = {}

	if arg_26_1 == 0 then
		var_26_1 = var_26_0.isRead

		for iter_26_0, iter_26_1 in ipairs(self._mailList) do
			if iter_26_1:isAwardExsist() and iter_26_1:isReceived() then
				table.insert(var_26_2, iter_26_1)
			end

			if iter_26_1:isAwardExsist() and not iter_26_1:isReceived() then
				table.insert(var_26_3, iter_26_1)
			end
		end

		for iter_26_2 = #var_26_1, 1, -1 do
			for iter_26_3 = 1, #var_26_3 do
				if var_26_1[iter_26_2] and var_26_3[iter_26_3] and var_26_3[iter_26_3]:getMailId() == var_26_1[iter_26_2].mailId and var_26_3[iter_26_3]:getMailType() == var_26_1[iter_26_2].mailType then
					table.remove(var_26_1, iter_26_2)
				end
			end
		end
	else
		for iter_26_4, iter_26_5 in ipairs(var_26_0.isRead) do
			if iter_26_5.mailType == arg_26_1 then
				table.insert(var_26_1, iter_26_5)
			end
		end

		for iter_26_6, iter_26_7 in ipairs(self._mailList) do
			if iter_26_7:getMailType() == arg_26_1 and iter_26_7:isAwardExsist() and iter_26_7:isReceived() then
				table.insert(var_26_2, iter_26_7)
			end
		end
	end

	return var_26_1, var_26_2
end

function MailsData:isUnReadMail(arg_27_1)
	if not arg_27_1 then
		return false
	end

	local var_27_0 = arg_27_1.id or false
	local var_27_1 = arg_27_1.baseId or false

	for iter_27_0, iter_27_1 in pairs(self._mailList or {}) do
		if iter_27_1:getMailId() == var_27_0 or var_27_1 == iter_27_1:getMailBaseId() then
			if not iter_27_1:isAwardExsist() and not iter_27_1:isRead() then
				return true
			end

			if iter_27_1:isAwardExsist() and not iter_27_1:isReceived() then
				return true
			end
		end
	end

	return false
end

function MailsData:getMailList()
	local var_28_0 = g.core.common.ServerTime:getTime()

	for iter_28_0 = #self._mailList, 1, -1 do
		local var_28_1 = self._mailList[iter_28_0]:getMailExpireTime()

		if var_28_1 > 0 and var_28_1 < var_28_0 then
			table.remove(self._mailList, iter_28_0)
		end
	end

	return self._mailList
end

function MailsData:getReceivedReward()
	return self._receivedAward
end

function MailsData:getReceivedState()
	return self._isRewarded
end

function MailsData:isMailRefresh()
	return self._isMailRefresh
end

return MailsData
