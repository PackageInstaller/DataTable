-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mail/model/MailMo.lua

module("logic.extensions.mail.model.MailMo", package.seeall)

local MailMo = class("MailMo")

function MailMo:ctor()
	self._id = false
	self._flags = false
	self._receivedTime = false
	self._expiredTime = false
	self._code = 0
	self._title = false
	self._name = false
	self._location = false
	self._content = false
	self._haveAttachment = false
	self._isSecret = false
	self._hasGetReward = false
	self._isRead = false
	self._isSelect = false
	self._isHistory = false
	self._hasUnlock = false
	self._rewardList = false
	self._isSurveyMail = false
	self._surveyRank = false
	self._surveyLinker = false
end

function MailMo:initByAgent(data)
	self._id = data.id
	self._flags = data.flags
	self._receivedTime = tonumber(data.receivedTime)
	self._expiredTime = tonumber(data.expiredTime)
	self._isRead = BitUtils.IsEnableBit(data.flags, 1)
	self._hasUnlock = BitUtils.IsEnableBit(data.flags, 4)
	self._hasGetReward = BitUtils.IsEnableBit(data.flags, 2)
	self._isSurveyMail = BitUtils.IsEnableBit(data.flags, 6)
	self._surveyRank = data.surveyRank > 0 and data.surveyRank or 100000
	self._surveyLinker = data.surveyUrl
	self._code = data.mailCode

	if self._code ~= 0 then
		local config = MailConfig.instance:getMailConfig(self._code)

		if config == nil then
			printWarn(" 在邮件配置表里面找不到 " .. self._code .. "的配置")

			return
		end

		self._title = config.title
		self._name = config.sendName
		self._name = StringUtil.replaceTMPBlackBlock(self._name)
		self._location = config.location
		self._location = StringUtil.replaceTMPBlackBlock(self._location)
		self._content = string.nilorempty(data.content) and config.content or data.content
		self._content = StringUtil.replaceTMPBlackBlock(self._content)

		local rewardCode = config.attachment

		self._haveAttachment = rewardCode > 0
		self._isSecret = BitUtils.IsEnableBit(data.flags, 3)

		local len = #data.attachments

		if len > 0 then
			self._haveAttachment = len > 0
			self._rewardList = {}

			for _, v in ipairs(data.attachments) do
				local itemData = ItemUtil.createItemData(v)

				itemData:setItemMarkType(EventType.ITEM_NORMAL_MARK_TYPE)
				table.insert(self._rewardList, itemData)
			end

			if type(self._rewardList) == "table" then
				table.sort(self._rewardList, ItemUtil.commonSortFunc)
			end

			return
		end

		if self._haveAttachment then
			self._rewardList = {}

			local rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardCode)

			if rewardCO then
				for i, v in ipairs(rewardCO.reward and rewardCO.reward or {}) do
					if v.code ~= GameEnum.CurrencyCodeEnum.EXP then
						table.insert(self._rewardList, v)
					end
				end
			end

			if type(self._rewardList) == "table" then
				table.sort(self._rewardList, ItemUtil.commonSortFunc)
			end
		end
	else
		self._title = data.title
		self._name = data.senderName
		self._name = StringUtil.replaceTMPBlackBlock(self._name)
		self._location = data.senderLocation
		self._location = StringUtil.replaceTMPBlackBlock(self._location)
		self._content = data.content
		self._content = StringUtil.replaceTMPBlackBlock(self._content)
		self._haveAttachment = false
		self._isSecret = BitUtils.IsEnableBit(data.flags, 3)

		if data.attachments then
			local len = #data.attachments

			self._haveAttachment = len > 0
			self._rewardList = {}

			for _, v in ipairs(data.attachments) do
				local itemData = ItemUtil.createItemData(v)

				itemData:setItemMarkType(EventType.ITEM_NORMAL_MARK_TYPE)
				table.insert(self._rewardList, itemData)
			end
		end
	end

	if type(self._rewardList) == "table" then
		table.sort(self._rewardList, ItemUtil.commonSortFunc)
	end
end

function MailMo:getId()
	return self._id
end

function MailMo:setHistory(state)
	self._isHistory = state
end

function MailMo:getHistory()
	return self._isHistory
end

function MailMo:setSelect(select)
	self._isSelect = select
end

function MailMo:isSelect()
	return self._isSelect
end

function MailMo:setUnlock(state)
	self._hasUnlock = state
end

function MailMo:getUnlockState()
	return self._hasUnlock
end

function MailMo:getName()
	return self._name or ""
end

function MailMo:getTitle()
	return self._title or ""
end

function MailMo:getContent()
	return self._content or ""
end

function MailMo:getLocation()
	return self._location or ""
end

function MailMo:hasAttachment()
	return self._haveAttachment
end

function MailMo:getReceivedTimeStr()
	return TimeUtil.instance:stampToDateStr(self._receivedTime)
end

function MailMo:getReceivedTime()
	return self._receivedTime
end

function MailMo:getExpiredTimeStr()
	if self._expiredTime == 0 then
		return lang("tip_perpetual")
	end

	local curTime = ServerTime.now()

	if curTime > self._expiredTime then
		return lang("tip_overdue")
	end

	local offset = self._expiredTime - curTime

	return TextFormatter.formatFullExpireTime(offset)
end

function MailMo:getExpiredTime()
	if self._expiredTime == 0 then
		return false
	end

	local curTime = ServerTime.now()
	local offset = self._expiredTime - curTime

	return offset
end

function MailMo:isExpired()
	if self._expiredTime == nil or self._expiredTime == 0 then
		return false
	end

	local curTime = ServerTime.now()

	if curTime >= self._expiredTime then
		return true
	end

	return false
end

function MailMo:getRewardList()
	return self._rewardList
end

function MailMo:getFirstReward()
	if self._rewardList then
		return self._rewardList[1]
	end

	return false
end

function MailMo:getIsSecret()
	return self._isSecret
end

function MailMo:getIsRead()
	return self._isRead
end

function MailMo:setIsRead()
	self._isRead = true
end

function MailMo:hasGetReward()
	return self._hasGetReward
end

function MailMo:setGetReward()
	self._hasGetReward = true
end

function MailMo:isSurveyMail()
	return self._isSurveyMail
end

function MailMo:getSurveyRank()
	return self._surveyRank
end

function MailMo:getSurveyLinker()
	return self._surveyLinker
end

return MailMo
