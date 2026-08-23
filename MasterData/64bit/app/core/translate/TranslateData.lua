local MailTranslateCache = class("MailTranslateCache")

function MailTranslateCache:ctor(arg_1_1)
	if arg_1_1 then
		self.uniqueKey = arg_1_1.uniqueKey
		self.title = arg_1_1.title
		self.from = arg_1_1.from
		self.content = arg_1_1.content
		self.complete = true
		self.open = arg_1_1.open
	else
		self.uniqueKey = nil
		self.title = nil
		self.from = nil
		self.content = nil
		self.complete = false
		self.open = true
	end
end

function MailTranslateCache:getTitle()
	return self.title
end

function MailTranslateCache:getFrom()
	return self.from
end

function MailTranslateCache:getContent()
	return self.content
end

function MailTranslateCache:setOpen(arg_5_1)
	self.open = arg_5_1
end

function MailTranslateCache:isOpen()
	return self.open
end

function MailTranslateCache:setUniqueKey(arg_7_1)
	self.uniqueKey = arg_7_1
end

function MailTranslateCache:setMailTranslate(arg_8_1, arg_8_2)
	self[arg_8_1] = arg_8_2

	if self.title and self.from and self.content then
		self.complete = true
	end
end

function MailTranslateCache:isComplete()
	if self.complete then
		return self.complete
	end

	if self.title and self.from and self.content and self.uniqueKey then
		self.complete = true
	end

	return self.complete
end

function MailTranslateCache:serialize()
	if self:isComplete() then
		return {
			title = self.title,
			from = self.from,
			content = self.content,
			uniqueKey = self.uniqueKey,
			open = self.open
		}
	end

	return nil
end

function MailTranslateCache:getUniqueKey()
	return self.uniqueKey
end

local TranslateData = class("TranslateData")

function TranslateData:ctor()
	self:initData()
end

function TranslateData:initData()
	self._mailTranslateCache = {}
	self._chatCache = {}
	self._loadedCache = false
	self._numMap = {}

	self:_initNumData()
end

function TranslateData:_initNumData()
	for iter_14_0 = 1, g.core.config.language_package_info.getLength() do
		local var_14_0 = g.core.config.language_package_info.indexOf(iter_14_0)

		if var_14_0.use == 1 then
			local var_14_1 = {
				cfg = var_14_0
			}

			for iter_14_1 = 1, 6 do
				if var_14_0["up_ex" .. iter_14_1] ~= 0 then
					var_14_1.calcElem = var_14_1.calcElem or {}
					var_14_1.calcElem[iter_14_1] = {
						up = var_14_0["up_ex" .. iter_14_1],
						calc = var_14_0["calc_ex" .. iter_14_1],
						tail = var_14_0["tail" .. iter_14_1],
						pointEx = var_14_0["point_ex" .. iter_14_1]
					}
				end
			end

			self._numMap[var_14_0.name] = var_14_1
		end
	end
end

function TranslateData:getTranslateLangNum(arg_15_1)
	return self._numMap[arg_15_1] or self._numMap.defult
end

function TranslateData:isHasMailCache(arg_16_1)
	if self._mailTranslateCache[arg_16_1] then
		return true
	end

	return false
end

function TranslateData:setMailTranslateData(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	if not self._mailTranslateCache[arg_17_1] then
		self._mailTranslateCache[arg_17_1] = MailTranslateCache.new()

		self._mailTranslateCache[arg_17_1]:setUniqueKey(arg_17_1)
	end

	self._mailTranslateCache[arg_17_1]:setMailTranslate(arg_17_2, arg_17_3.data)

	if self._mailTranslateCache[arg_17_1]:isComplete() then
		arg_17_4:setTranslate(true)
		arg_17_4:setTranslateOpen(true)
		self:saveTranslateCache()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TRANSLATE_FINISH_NOTIFY)
	end
end

function TranslateData:getMailTranslateData(arg_18_1)
	return self._mailTranslateCache[arg_18_1]
end

function TranslateData:isMailTranslateOpen(arg_19_1)
	return self._mailTranslateCache[arg_19_1] and self._mailTranslateCache[arg_19_1]:isOpen()
end

function TranslateData:setMailTranslateOpen(arg_20_1, arg_20_2)
	if self._mailTranslateCache[arg_20_1] then
		self._mailTranslateCache[arg_20_1]:setOpen(arg_20_2)
		self:saveTranslateCache()
	end
end

function TranslateData:deleteMail(arg_21_1)
	self._mailTranslateCache[arg_21_1] = nil

	self:saveTranslateCache()
end

function TranslateData:loadTranslateCache()
	if not self._loadedCache then
		for iter_22_0, iter_22_1 in pairs(g.core.common.Storage:load("translateMailCache.json", true) or {}) do
			self._mailTranslateCache[tonumber(iter_22_0)] = MailTranslateCache.new(iter_22_1)
		end

		self._loadedCache = true
	end
end

function TranslateData:saveTranslateCache()
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(self._mailTranslateCache) do
		local var_23_1 = iter_23_1:serialize()

		if var_23_1 then
			var_23_0[tostring(iter_23_1:getUniqueKey())] = var_23_1
		end
	end

	g.core.common.Storage:save("translateMailCache.json", var_23_0, true)
end

function TranslateData:getMailCache(arg_24_1)
	return self._mailTranslateCache[arg_24_1]
end

function TranslateData:onTranslateMail(arg_25_1, arg_25_2)
	local var_25_0 = arg_25_1:getUniqueId()

	if g.core.model.User.translateData:isHasMailCache(var_25_0) then
		return true, self:getMailCache(var_25_0)
	end

	local var_25_1 = arg_25_1:getMailKeyValues()
	local var_25_2 = g.core.config.mail_info.get(arg_25_1:getMailBaseId())
	local var_25_3 = g.core.lang:getByString(var_25_2.title, var_25_1)
	local var_25_4 = ""

	var_25_4 = table.nums(arg_25_1:getMailSendName()) > 0 and g.core.lang:getByString(var_25_2.from, arg_25_1:getMailSendName()) or var_25_2.from

	local var_25_5 = g.core.utils.String.dealMailStr(var_25_2.content, var_25_1)

	g.core.translate.TranslateProxy:getNetTranslate(var_25_3, function(arg_26_0)
		if arg_26_0.status ~= 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(2504))

			return
		end

		self:setMailTranslateData(var_25_0, "title", arg_26_0, arg_25_1)

		if arg_25_2 then
			arg_25_2("title", arg_26_0)
		end
	end)
	g.core.translate.TranslateProxy:getNetTranslate(var_25_4, function(arg_27_0)
		if arg_27_0.status ~= 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(2504))

			return
		end

		self:setMailTranslateData(var_25_0, "from", arg_27_0, arg_25_1)

		if arg_25_2 then
			arg_25_2("from", arg_27_0)
		end
	end)
	g.core.translate.TranslateProxy:getNetTranslate(var_25_5, function(arg_28_0)
		if arg_28_0.status ~= 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(2504))

			return
		end

		self:setMailTranslateData(var_25_0, "content", arg_28_0, arg_25_1)

		if arg_25_2 then
			arg_25_2("content", arg_28_0)
		end
	end)

	return false
end

function TranslateData:testSaveTranslateCache(arg_29_1)
	local var_29_0 = arg_29_1:getUniqueId()

	if self:isHasMailCache(var_29_0) then
		return true, self:getMailCache(var_29_0)
	end

	local var_29_1 = arg_29_1:getMailKeyValues()
	local var_29_2 = g.core.config.mail_info.get(arg_29_1:getMailBaseId())
	local var_29_3 = g.core.lang:getByString(var_29_2.title, var_29_1)
	local var_29_4 = ""

	var_29_4 = table.nums(arg_29_1:getMailSendName()) > 0 and g.core.lang:getByString(var_29_2.from, arg_29_1:getMailSendName()) or var_29_2.from

	arg_29_1:setTranslate(true)
	arg_29_1:setTranslateOpen(true)
	self:setMailTranslateData(var_29_0, "title", {
		data = var_29_3 .. "{已翻译}"
	}, arg_29_1)
	self:setMailTranslateData(var_29_0, "from", {
		data = var_29_4 .. "{已翻译}"
	}, arg_29_1)
	self:setMailTranslateData(var_29_0, "content", {
		data = g.core.utils.String.dealMailStr(var_29_2.content, var_29_1) .. "{已翻译}"
	}, arg_29_1)
end

function TranslateData:setChatTranslateCache(arg_30_1, arg_30_2)
	self._chatCache[arg_30_1] = arg_30_2
end

function TranslateData:getChatTranslateUniqueKey(arg_31_1)
	local var_31_0

	if arg_31_1.user then
		var_31_0 = arg_31_1.user.id or "0"
		arg_31_1.time = arg_31_1.time or g.core.common.ServerTime:getTime()
	end

	return arg_31_1.channel .. "_" .. arg_31_1.time .. "_" .. var_31_0
end

function TranslateData:onTranslateChat(arg_32_1, arg_32_2)
	local var_32_0 = self:getChatTranslateUniqueKey(arg_32_1)

	g.core.translate.TranslateProxy:getNetTranslate(arg_32_1.content, function(arg_33_0)
		if arg_33_0.status ~= 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(2504))

			return
		end

		self:setChatTranslateCache(var_32_0, arg_33_0.data)

		if arg_32_2 then
			arg_32_2(arg_33_0)
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TRANSLATE_FINISH_NOTIFY)
	end)
end

function TranslateData:getChatTranslated(arg_34_1)
	return self._chatCache[self:getChatTranslateUniqueKey(arg_34_1)]
end

return TranslateData
