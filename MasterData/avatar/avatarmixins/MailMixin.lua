-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\MailMixin.lua

local MailMixin = {}

local function sendMailException(mailId)
	if mailId == nil then
		ClientUtils.trySendException("Mail ID is nil ", debug.traceback())

		return
	end

	if string.find(mailId, "\x00") then
		ClientUtils.trySendException("Mail ID starts with \x00 :" .. mailId, debug.traceback())

		return
	end
end

local MailServerData = Class("MailServerData")
local MAIL_ATTACH_EXPIRE_TIME = 2592000

function MailServerData:ctor(mailItem)
	sendMailException(mailItem.mid)

	self.mailId = mailItem.mid
	self.pMailId = mailItem.pmid
	self.mailType = mailItem.type
	self.isRead = mailItem.read ~= 0 and true or false
	self.timeStamp = mailItem.time
	self.hasReceive = mailItem.gotflag ~= 0 and true or false

	local mailData = mailItem.data

	self.senderUid = mailData.suid
	self.sender = mailData.sender
	self.title = mailData.title
	self.content = mailData.content

	local needServerLan = RegionConst.SERVER_LANUAGE_MAP[RegionUtils.curLanguage]

	if needServerLan then
		for _, info in ipairs(mailData.multi_language_content or {}) do
			if info.language == needServerLan then
				self.sender = info.sender
				self.title = info.title
				self.content = info.content
			end
		end
	end

	self.hasAttachments = #mailData.attach > 0
	self.attachments = {}

	if self.hasAttachments then
		for i, itemData in ipairs(mailData.attach) do
			table.insert(self.attachments, itemData)
		end

		self.periodOfValidity = self.timeStamp + MAIL_ATTACH_EXPIRE_TIME
	end

	self.extendData = mailData.extend
	self.templateId = mailData.tmplid or 0
	self.isTemplateType = self.templateId ~= 0

	if self.isTemplateType then
		self.params = {}
		self.paramNeedTranslate = {}

		for _, p in ipairs(mailData.parameter) do
			table.insert(self.params, p.data)
			table.insert(self.paramNeedTranslate, p.need_translate == 1)
		end
	end
end

local MailDataBox = Class("MailDataBox")

function MailDataBox:ctor()
	self.mailItems = {}
	self.sortedMailIdList = {}
	self.unreadCount = 0
end

function MailDataBox:clear()
	self.mailItems = {}
	self.sortedMailIdList = {}
	self.unreadCount = 0
end

function MailDataBox:addMail(serverData)
	self.mailItems[serverData.mailId] = serverData
end

local function _mailListSortFunc(a, b)
	local aNeedFocus = 0
	local bNeedFocus = 0

	if not a.isRead or a.hasAttachments and not a.hasReceive then
		aNeedFocus = 1
	end

	if not b.isRead or b.hasAttachments and not b.hasReceive then
		bNeedFocus = 1
	end

	if aNeedFocus == bNeedFocus then
		return a.timeStamp > b.timeStamp
	else
		return bNeedFocus < aNeedFocus
	end
end

function MailDataBox:postProcess()
	self.unreadCount = 0

	local sortedMailList = {}

	for mid, mailInfo in pairs(self.mailItems) do
		local isRead = mailInfo.isRead

		if not isRead then
			self.unreadCount = self.unreadCount + 1
		end

		table.insert(sortedMailList, mailInfo)
	end

	table.sort(sortedMailList, _mailListSortFunc)

	self.sortedMailIdList = {}

	for i, mailInfo in ipairs(sortedMailList) do
		table.insert(self.sortedMailIdList, mailInfo.mailId)
	end
end

function MailDataBox:readMailByIndex(index)
	local mid = self.sortedMailIdList[index]

	self:readMailById(mid)
end

function MailDataBox:readMail(mailId)
	local mail = self.mailItems[mailId]

	if mail and not mail.isRead then
		mail.isRead = true

		RPC.mailUpdate(mail.mailId, 0)

		self.unreadCount = self.unreadCount - 1

		CurAvatar:checkMailUnreadHint()
	end
end

function MailDataBox:getAttachments(mailId, isAutoGet)
	if self.mailItems[mailId] then
		self.mailItems[mailId].hasReceive = true

		if isAutoGet and self.mailItems[mailId].pMailId ~= "0" then
			-- block empty
		else
			if not self.mailItems[mailId].isRead then
				self.unreadCount = self.unreadCount - 1
			end

			self.mailItems[mailId].isRead = true
		end
	end
end

function MailDataBox:delMailByPmid(pmid)
	for mailId, mailItem in pairs(self.mailItems) do
		if mailItem.pMailId == pmid then
			self.mailItems[mailId] = nil
		end
	end
end

function MailDataBox:mailExist(mailId)
	return self.mailItems[mailId] ~= nil
end

function MailDataBox:getSortedMailList()
	return self.sortedMailIdList
end

function MailDataBox:getMailInfoByIndex(index)
	local mid = self.sortedMailIdList[index]

	return self:getMailInfo(mid)
end

function MailDataBox:getMailInfo(mailId)
	local mail = self.mailItems[mailId]

	if mail then
		return mail
	end
end

function MailDataBox:getMailCount()
	return #self.sortedMailIdList
end

function MailDataBox:getNextUnread()
	if self.unreadCount <= 0 then
		return
	else
		for i, mailId in ipairs(self.sortedMailIdList) do
			local mailData = self.mailItems[mailId]

			if mailData then
				local unreceive = mailData.hasAttachments and not mailData.hasReceive
				local unread = not mailData.isRead

				if unread or unreceive then
					return mailId
				end
			end
		end

		return
	end
end

function MailDataBox:getAttachmentInfo(mailId)
	if self.mailItems[mailId] then
		return self.mailItems[mailId].attachments
	end
end

function MailDataBox:hasAttachments()
	for mailId, mailData in pairs(self.mailItems) do
		if mailData.hasAttachments and not mailData.hasReceive then
			return true
		end
	end

	return false
end

function MailDataBox:hasAttachMailList()
	local hasAttach = {}

	for i, mailId in ipairs(self.sortedMailIdList) do
		local mailData = self.mailItems[mailId]

		if mailData and mailData.hasAttachments and not mailData.hasReceive then
			table.insert(hasAttach, mailId)
		end
	end

	return hasAttach
end

function MailDataBox:_getIndexByMid(mid)
	for index, mailId in ipairs(self.sortedMailIdList) do
		if mailId == mid then
			return index
		end
	end
end

function MailMixin:initMailMixin(baseData, syncData)
	self.mainMailBox = MailDataBox()
end

function MailMixin:postinitMailMixin(baseData, syncData)
	return
end

function MailMixin:onMailNotify(mail)
	for i, mailItem in ipairs(mail) do
		local mailSvrData = MailServerData(mailItem)

		self.mainMailBox:addMail(mailSvrData)

		if mailItem.attach == 1 then
			self:onMailBonus(mailItem.data.reason, mailItem.data.attach)
		end
	end

	self.mainMailBox:postProcess()
	self:refreshMailBox()
	self:checkMailUnreadHint()
end

function MailMixin:onMailRecallNotify(pmid)
	self.mainMailBox:delMailByPmid(pmid)
	self.mainMailBox:postProcess()
	self:refreshMailBox()
	self:checkMailUnreadHint()
end

function MailMixin:onMailUpdateResp()
	return
end

function MailMixin:onMailGetAttachResp(mailId, code)
	if self.requestingBatchAttach then
		local receiveEnd = false

		if code == 0 then
			receiveEnd = true
		else
			self.mainMailBox:getAttachments(mailId, true)
			self:refreshMailBox()

			if not self:_getNextMail() then
				receiveEnd = true
			end
		end

		if receiveEnd then
			self.requestingBatchAttach = nil

			local unreceiveCount = self.waitToShowMailCount - #self.waitToReceiveMails

			if unreceiveCount ~= 0 then
				self.waitToShowMailCount = math.max(1, unreceiveCount)
			else
				self:showMailResults()
			end
		end
	else
		if code == 0 then
			MsgManager.notice(Lang.get(1867))

			return
		end

		self.mainMailBox:getAttachments(mailId, false)

		local nextUnreadMailId = self.mainMailBox:getNextUnread()

		if nextUnreadMailId then
			self:mailBoxSelectMail(nextUnreadMailId)
		else
			self:refreshMailBox()
		end
	end

	self:checkMailUnreadHint()
end

function MailMixin:onMailReportResp()
	return
end

function MailMixin:mailSystemBagFull()
	if self.requestingBatchAttach then
		self.requestingBatchAttach = nil
	end

	if self.waitToShowMailCount and self.waitToShowMailCount > 0 then
		self:showMailResults()
	end
end

function MailMixin:getAttach(mailId)
	if not self.requestingBatchAttach and self.waitToShowMailCount and self.waitToShowMailCount > 0 then
		MsgManager.notice(Lang.get(1868))

		return false
	end

	if not self:_checkBagFull(mailId) then
		return false
	end

	self.waitToShowMailCount = 1
	self.waitToShowMailItemList = {}

	sendMailException(mailId)
	RPC.mailGetAttach(mailId)

	return true
end

function MailMixin:getAllAttachs()
	if self.requestingBatchAttach then
		MsgManager.notice(Lang.get(1868))

		return false
	end

	self.waitToReceiveMails = self.mainMailBox:hasAttachMailList()

	local totalMailCount = #self.waitToReceiveMails

	if totalMailCount <= 0 then
		return false
	end

	if self:_getNextMail() then
		self.requestingBatchAttach = true
		self.waitToShowMailCount = totalMailCount
		self.waitToShowMailItemList = {}
	end
end

function MailMixin:_getNextMail()
	if self.waitToReceiveMails and #self.waitToReceiveMails > 0 then
		local mailId = self.waitToReceiveMails[1]

		if not self:_checkBagFull(mailId) then
			return false
		end

		table.remove(self.waitToReceiveMails, 1)
		sendMailException(mailId)
		RPC.mailGetAttach(mailId)

		return true
	else
		return false
	end
end

function MailMixin:_checkBagFull(mailId)
	return true
end

function MailMixin:receiveAttachments(attrs, items, heros, equips, artifacts)
	if not self.waitToShowMailCount or self.waitToShowMailCount <= 0 then
		return
	end

	self.waitToShowMailCount = self.waitToShowMailCount - 1

	for i, attr in ipairs(attrs) do
		local id = Const.MONEY_TYPE2ID[attr.type]

		if id then
			local num = attr.value

			self:_addItemIDNum(id, num)
		end
	end

	for i, item in ipairs(items) do
		local id = item.id
		local num = item.num

		self:_addItemIDNum(id, num)
	end

	for i, equip in ipairs(equips) do
		self:_addItemInfo(Const.ITEM_TYPE_EQUIP, equip)
	end

	for i, artifact in ipairs(artifacts) do
		self:_addItemInfo(Const.ITEM_TYPE_ARTIFACT, artifact)
	end

	if self.waitToShowMailCount == 0 then
		self:showMailResults()
	end
end

function MailMixin:_addItemIDNum(itemId, itemNum)
	local hasSame = false

	for i, item in ipairs(self.waitToShowMailItemList) do
		if item.type == Const.ITEM_TYPE_ITEM and item.info.id == itemId then
			item.info.num = item.info.num + itemNum
			hasSame = true

			break
		end
	end

	if not hasSame then
		table.insert(self.waitToShowMailItemList, {
			info = {
				id = itemId,
				num = itemNum
			},
			type = Const.ITEM_TYPE_ITEM
		})
	end
end

function MailMixin:_addItemInfo(itemType, itemInfo)
	table.insert(self.waitToShowMailItemList, {
		type = itemType,
		info = itemInfo
	})
end

function MailMixin:sortMailList(...)
	self.mainMailBox:postProcess()
end

function MailMixin:tryOpenMailBox()
	if self.mainMailBox:getMailCount() <= 0 then
		MsgManager.notice(Lang.get(1869))

		return
	end

	UIManager.getUI("mailBoxDlg", true)
end

function MailMixin:mailBoxSelectMail(mailId)
	local dlg = UIManager.getUI("mailBoxDlg", nil, false)

	if dlg then
		dlg:selectMailById(mailId, true)
	end
end

function MailMixin:refreshMailBox()
	local dlg = UIManager.getUI("mailBoxDlg", nil, false)

	if dlg then
		dlg:refreshMailBox()
	end
end

function MailMixin:showMailResults()
	if #self.waitToShowMailItemList > 0 then
		local fakeItemList = {}
		local equipInfoList = {}
		local artifactInfoList = {}

		for i, item in ipairs(self.waitToShowMailItemList) do
			if item.type == Const.ITEM_TYPE_ITEM then
				table.insert(fakeItemList, item.info)
			elseif item.type == Const.ITEM_TYPE_EQUIP then
				table.insert(equipInfoList, item.info)
			elseif item.type == Const.ITEM_TYPE_ARTIFACT then
				table.insert(artifactInfoList, item.info)
			end
		end

		local dlg = UIManager.getUI("mailResultDlg", true)

		dlg:setMailAwards(fakeItemList, equipInfoList, artifactInfoList)
	end

	self.waitToShowMailCount = 0
	self.waitToShowMailItemList = {}
end

function MailMixin:checkMailUnreadHint()
	RedDotManager.setKeyState(UIConst.RD_HINT_MAIL_UNREAD, self.mainMailBox.unreadCount > 0)
end

function MailMixin:isItemInMailbox(itemId)
	if self.mainMailBox then
		local mailList = self.mainMailBox:hasAttachMailList()
		local attachs

		for _, mailId in ipairs(mailList) do
			attachs = self.mainMailBox:getAttachmentInfo(mailId)

			for _, attach in ipairs(attachs) do
				if attach.id == itemId then
					return true
				end
			end
		end
	end

	return false
end

return MailMixin
