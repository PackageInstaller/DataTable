-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\CommentMixin.lua

local CommentInfo = require("UI/Hero/CommentInfo")
local UrlConfig = require("Network/UrlConfig")
local SDKConst = require("SDK/SDKConst")
local SDKCore = require("SDK/SDKCore")
local WebView = require("SDK/Plugin/WebView")
local ResponseCode = SDKConst.ResponseCode
local AttName = SDKConst.AttName
local Base64 = require("Common/Tools/Base64")
local DeviceHelper = require("Helper/DeviceHelper")
local SDKAppUtils = require("SDK/SDKAppUtils")
local HttpUtils = Framework.Network.HttpUtils
local CommentMixin = {}
local REQUEST_TYPE = {
	GET_COMMENT = 1,
	GET_MYRATE = 6,
	POST_RATE = 4,
	GET_RH_COMMENT_NUM = 9,
	FAVOR = 5,
	DELETE_RH_COMMENT = 10,
	GET_RH_COMMENT = 8,
	POST_COMMENT = 2,
	POST_RH_COMMENT = 7,
	GET_RATE = 3
}
local URL_POSTFIX = {
	[REQUEST_TYPE.GET_COMMENT] = "/discuss/comment",
	[REQUEST_TYPE.POST_COMMENT] = "/discuss/comment",
	[REQUEST_TYPE.GET_RATE] = "/discuss/rate",
	[REQUEST_TYPE.POST_RATE] = "/discuss/rate",
	[REQUEST_TYPE.FAVOR] = "/discuss/favor",
	[REQUEST_TYPE.GET_MYRATE] = "/discuss/rate",
	[REQUEST_TYPE.POST_RH_COMMENT] = "/discuss/scomment",
	[REQUEST_TYPE.GET_RH_COMMENT] = "/discuss/scomment",
	[REQUEST_TYPE.GET_RH_COMMENT_NUM] = "/discuss/scommentseq",
	[REQUEST_TYPE.DELETE_RH_COMMENT] = "/discuss/scomment/delete"
}
local URL_TYPE = {
	GET = "Get",
	POST = "Post"
}
local GET_RH_COMMENT_TYPE = {
	Mine = 1,
	Other = 2
}

CommentMixin.REQUEST_CD = 60
CommentMixin.RH_REQUEST_CD = 5

function CommentMixin:initCommentMixin()
	self.allCommentData = {}
	self.rateData = {}
	self.cdRequestTime = 0
	self.myCommentHeroId = nil
	self.myComment = {}
	self.myRate = nil
	self.lastComment = nil
	self.requestBeginTime = os.time() - self.REQUEST_CD
	self.requestRHBeginTime = os.time() - self.RH_REQUEST_CD
end

function CommentMixin:getAllCommentData(id)
	if self.allCommentData then
		return self.allCommentData
	end
end

function CommentMixin:getRateData()
	if self.rateData then
		return self.rateData
	end
end

function CommentMixin:setMyComment(heroId, content)
	self.myComment[heroId] = content
end

function CommentMixin:getMyComment(heroId)
	if self.myComment then
		return self.myComment[heroId]
	end
end

function CommentMixin:setRequestCD(time)
	self.requestBeginTime = time
end

function CommentMixin:getRequestCD()
	if self.requestBeginTime then
		return self.REQUEST_CD - (os.time() - self.requestBeginTime)
	end

	return -1
end

function CommentMixin:setRHRequestCD(time)
	self.requestRHBeginTime = time
end

function CommentMixin:getRHRequestCD()
	if self.requestRHBeginTime then
		return self.RH_REQUEST_CD - (os.time() - self.requestRHBeginTime)
	end

	return -1
end

function CommentMixin:getMyRate()
	if self.myRate then
		return self.myRate
	end
end

function CommentMixin:GetCommentHandler(entry_id, current_uid, limit, offset, page, orderby, created, commentId, uid, callback)
	if not entry_id then
		return
	end

	local jsonData = self:_getCommentUserInfo()

	jsonData.entry_id = entry_id

	if current_uid then
		jsonData.current_uid = current_uid
	end

	if limit then
		jsonData.limit = limit
	end

	if offset then
		jsonData.offset = offset
	end

	if page then
		jsonData.page = page
	end

	if orderby then
		jsonData.orderby = orderby
	end

	if created then
		jsonData.created = created
	end

	if commentId then
		jsonData.id = commentId
	end

	if uid then
		jsonData.uid = uid
	end

	local url = self:_getCommentUrl(REQUEST_TYPE.GET_COMMENT, URL_TYPE.GET, jsonData)
	local requestCallback = Functor(self._onCommentRequestFinish_Get, self, REQUEST_TYPE.GET_COMMENT, callback)

	self:_requestCommentGet(url, requestCallback)
end

function CommentMixin:GetRearHouseCommentHandler(entry_id, current_uid, limit, offset, page, orderby, created, commentId, uid, callback)
	if entry_id and entry_id == self.uid then
		self.cacheGetCommentType = GET_RH_COMMENT_TYPE.Other
	elseif uid and uid == self.uid then
		self.cacheGetCommentType = GET_RH_COMMENT_TYPE.Mine
	end

	local jsonData = self:_getCommentUserInfo()

	jsonData.entry_id = entry_id

	if current_uid then
		jsonData.current_uid = current_uid
	end

	if limit then
		jsonData.limit = limit
	end

	if offset then
		jsonData.offset = offset
	end

	if page then
		jsonData.page = page
	end

	if orderby then
		jsonData.orderby = orderby
	end

	if created then
		jsonData.created = created
	end

	if commentId then
		jsonData.id = commentId
	end

	if uid then
		jsonData.uid = uid
	end

	local url = self:_getCommentUrl(REQUEST_TYPE.GET_RH_COMMENT, URL_TYPE.GET, jsonData)
	local requestCallback = Functor(self._onCommentRequestFinish_Get, self, REQUEST_TYPE.GET_RH_COMMENT, callback)

	self:_requestCommentGet(url, requestCallback)
end

function CommentMixin:GetRearHouseCommentNumHandler(current_uid, callback)
	if not current_uid then
		return
	end

	local jsonData = self:_getCommentUserInfo()

	jsonData.current_uid = current_uid

	local url = self:_getCommentUrl(REQUEST_TYPE.GET_RH_COMMENT_NUM, URL_TYPE.GET, jsonData)
	local requestCallback = Functor(self._onCommentRequestFinish_Get, self, REQUEST_TYPE.GET_RH_COMMENT_NUM, callback)

	self:_requestCommentGet(url, requestCallback)
end

function CommentMixin:DeleteRearHouseCommentHandler(commentId, uid, entry_id, current_uid, callback)
	local jsonData = self:_getCommentUserInfo()

	jsonData.uid = uid
	jsonData.entry_id = entry_id
	jsonData.current_uid = current_uid
	jsonData.id = commentId

	local url = self:_getCommentUrl(REQUEST_TYPE.DELETE_RH_COMMENT, URL_TYPE.POST, jsonData)
	local requestCallback = Functor(self._onCommentRequestFinish_Post, self, REQUEST_TYPE.DELETE_RH_COMMENT, callback)

	self:_requestCommentPost(url, jsonData, requestCallback)
end

function CommentMixin:PostCommentHandler(entry_id, uid, content, name, callback)
	self.myCommentHeroId = entry_id

	if not uid then
		return
	end

	local jsonData = self:_getCommentUserInfo()

	jsonData.uid = uid
	jsonData.entry_id = entry_id
	jsonData.content = content
	jsonData.name = name

	local url = self:_getCommentUrl(REQUEST_TYPE.POST_COMMENT, URL_TYPE.POST, jsonData)
	local requestCallback = Functor(self._onCommentRequestFinish_Post, self, REQUEST_TYPE.POST_COMMENT, callback)

	self:_requestCommentPost(url, jsonData, requestCallback)
end

function CommentMixin:PostRearHouseCommentHandler(entry_id, uid, content, name, callback)
	if not uid then
		return
	end

	local jsonData = self:_getCommentUserInfo()

	jsonData.uid = uid
	jsonData.entry_id = entry_id
	jsonData.content = content
	jsonData.name = name

	local url = self:_getCommentUrl(REQUEST_TYPE.POST_RH_COMMENT, URL_TYPE.POST, jsonData)
	local requestCallback = Functor(self._onCommentRequestFinish_Post, self, REQUEST_TYPE.POST_RH_COMMENT, callback)

	self:_requestCommentPost(url, jsonData, requestCallback)
end

function CommentMixin:GetRateHandler(id, current_uid, callback)
	if not id then
		return
	end

	local jsonData = self:_getCommentUserInfo()

	if id then
		jsonData.id = id
	end

	if current_uid then
		jsonData.current_uid = current_uid
	end

	local url = self:_getCommentUrl(REQUEST_TYPE.GET_RATE, URL_TYPE.GET, jsonData)
	local requestCallback = Functor(self._onCommentRequestFinish_Get, self, REQUEST_TYPE.GET_RATE, callback)

	self:_requestCommentGet(url, requestCallback)
end

function CommentMixin:PostRateHandler(uid, entry_id, score, callback)
	local jsonData = self:_getCommentUserInfo()

	jsonData.uid = uid
	jsonData.entry_id = entry_id
	jsonData.score = score

	local url = self:_getCommentUrl(REQUEST_TYPE.POST_RATE, URL_TYPE.POST, jsonData)
	local requestCallback = Functor(self._onCommentRequestFinish_Post, self, REQUEST_TYPE.POST_RATE, callback)

	self:_requestCommentPost(url, jsonData, requestCallback)
end

function CommentMixin:FavorHandler(uid, comment_id, isDelete, callback)
	local jsonData = self:_getCommentUserInfo()

	jsonData.uid = uid
	jsonData.comment_id = comment_id

	if isDelete then
		jsonData.delete = isDelete
	end

	local url = self:_getCommentUrl(REQUEST_TYPE.FAVOR, URL_TYPE.POST, jsonData)
	local requestCallback = Functor(self._onCommentRequestFinish_Post, self, REQUEST_TYPE.FAVOR, callback)

	self:_requestCommentPost(url, jsonData, requestCallback)
end

function CommentMixin:GetMyRateHandler(id, current_uid, callback)
	if not id then
		return
	end

	local jsonData = self:_getCommentUserInfo()

	if id then
		jsonData.id = id
	end

	if current_uid then
		jsonData.current_uid = current_uid
	end

	local url = self:_getCommentUrl(REQUEST_TYPE.GET_MYRATE, URL_TYPE.GET, jsonData)
	local requestCallback = Functor(self._onCommentRequestFinish_Get, self, REQUEST_TYPE.GET_MYRATE, callback)

	self:_requestCommentGet(url, requestCallback)
end

function CommentMixin:couldRequest()
	if os.time() - REQUEST_CD[self.cdRequestTime] > self.LastRequestTime then
		self.LastRequestTime = os.time()
		self.cdRequestTime = self.cdRequestTime + 1

		return true
	else
		return false
	end
end

function CommentMixin:_requestCommentGet(url, callback)
	HttpHelper.get(url, callback, 3)
end

function CommentMixin:_requestCommentPost(url, jsonData, callback)
	HttpHelper.post(url, ClientUtils.table2String(jsonData), callback, 3)
end

function CommentMixin:_onCommentRequestFinish_Get(requestType, callback, responseCode, dataString)
	local succ = false

	if responseCode == ResponseCode.SUCC and dataString then
		local AllData = ClientUtils.string2Table(dataString)

		if AllData then
			if requestType == REQUEST_TYPE.GET_COMMENT then
				self.allCommentData = AllData
			elseif requestType == REQUEST_TYPE.GET_RATE then
				local id = AllData.id

				if id then
					succ = true

					if not self.rateData[id] then
						self.rateData[id] = {}
					end

					CommentInfo.RateData(self.rateData[id], AllData)
				end
			elseif requestType == REQUEST_TYPE.GET_MYRATE then
				self.myRate = AllData
			elseif requestType == REQUEST_TYPE.GET_RH_COMMENT then
				if self.cacheGetCommentType then
					if self.cacheGetCommentType == GET_RH_COMMENT_TYPE.Other then
						if self.rearHouseCommentInfo == nil then
							self.rearHouseCommentInfo = {}
						end

						self.rearHouseCommentInfo.tick = Time.time
						self.rearHouseCommentInfo.commentData = AllData.data or {}

						table.sort(self.rearHouseCommentInfo.commentData, function(a, b)
							return a.created > b.created
						end)
					elseif self.cacheGetCommentType == GET_RH_COMMENT_TYPE.Mine then
						if self.rearHouseMyCommentInfo == nil then
							self.rearHouseMyCommentInfo = {}
						end

						self.rearHouseMyCommentInfo.tick = Time.time
						self.rearHouseMyCommentInfo.commentData = AllData.data
					end
				end
			elseif requestType == REQUEST_TYPE.GET_RH_COMMENT_NUM then
				self.rearHouseMyCommentNum = AllData.seq
			end
		end
	end

	if not succ then
		self:_onCommentHttpError()
	end

	if callback then
		callback(responseCode)
	end
end

function CommentMixin:_onCommentRequestFinish_Post(requestType, callback, responseCode, dataString)
	if responseCode == ResponseCode.SUCC then
		if requestType == REQUEST_TYPE.POST_COMMENT then
			MsgManager.notice(Lang.get(1828))

			local data = ClientUtils.string2Table(dataString)

			if data and data.filtered then
				local commentDlg = UIManager.tryGetUI("commentDlg")

				if commentDlg then
					commentDlg.btnE:newCommentCallback(data.filtered)
				end
			end
		elseif requestType == REQUEST_TYPE.POST_RATE then
			MsgManager.notice(Lang.get(1829))
		elseif requestType == REQUEST_TYPE.FAVOR then
			-- block empty
		elseif requestType == REQUEST_TYPE.POST_RH_COMMENT then
			local data = ClientUtils.string2Table(dataString)

			if data and data.code == 0 then
				if not self.rearHouseFavorInfo.favorToday or not (utils.getTableElemCount(self.rearHouseFavorInfo.favorToday) >= Const.REARHOUSE_FAVOR_LIMIT) then
					if self:isFavoredToday(self.cachedRearHouseCommentUid) then
						MsgManager.notice(Lang.get(96098))
					else
						self.cachedRearHouseFavorUid = self.cachedRearHouseCommentUid

						RPC.houseFavor(self.cachedRearHouseFavorUid)
					end
				end

				if self.rearHouseMyCommentNum then
					self.rearHouseMyCommentNum = self.rearHouseMyCommentNum + 1
				end

				if self.rearHouseMyCommentInfo == nil then
					self.rearHouseMyCommentInfo = {}
				end

				self.rearHouseMyCommentInfo.tick = Time.time

				local data = {
					uid = self.uid,
					entry_id = self.cachedRearHouseCommentUid,
					created = ClientUtils.getServerTime()
				}

				self.rearHouseMyCommentInfo.commentData = self.rearHouseMyCommentInfo.commentData or {}

				table.insert(self.rearHouseMyCommentInfo.commentData, 1, data)
			elseif data and data.code == 102 then
				MsgManager.notice(Lang.get(96099))
			elseif data and data.code == 103 then
				MsgManager.notice(Lang.get(96100))
			else
				local codeNum = data.code or data.error.code

				if codeNum then
					-- block empty
				end
			end
		elseif requestType == REQUEST_TYPE.DELETE_RH_COMMENT then
			MsgManager.notice(Lang.get(96101))
			self:deleteRearHouseComment()
		end

		if callback then
			callback(responseCode)
		end
	end
end

function CommentMixin:_getCommentUserInfo()
	local curToken = AccountManager.getToken()
	local data = {
		token = curToken
	}

	return data
end

function CommentMixin:_getCommentUrl(reuqestType, UrlType, data)
	local url = SvrListManager.getRaidersSvr()

	if UrlType == URL_TYPE.GET then
		local append = URL_POSTFIX[reuqestType] .. "?" .. ClientUtils.composeGetParams(data)

		url:SetUrlAppend(append)
	elseif UrlType == URL_TYPE.POST then
		local append = URL_POSTFIX[reuqestType] .. "?uuid=" .. self:encryption(data)

		url:SetUrlAppend(append)
	end

	return url
end

function CommentMixin:_onCommentHttpError()
	local url = SvrListManager.getRaidersSvr()

	url:Next()
end

function CommentMixin:encryption(jsonData)
	local timestamp = string.format("%x", os.time())

	if string.len(timestamp) < 11 then
		for i = 1, 11 - string.len(timestamp) do
			timestamp = "0" .. timestamp
		end
	end

	math.randomseed(tostring(os.time()):reverse():sub(1, 7))

	local nonce = string.format("%x", math.random(1, 65535))

	if string.len(nonce) < 16 then
		for i = 1, 16 - string.len(nonce) do
			nonce = "0" .. nonce
		end
	end

	local key = string.format("%x", AccountManager.getOpenID())
	local concat = ""
	local jsonDataKeys = {}

	for i, v in pairs(jsonData) do
		table.insert(jsonDataKeys, i)
	end

	table.sort(jsonDataKeys)

	for i, v in pairs(jsonDataKeys) do
		concat = concat .. v .. jsonData[v]
	end

	concat = Framework.Tools.LuaToolkit.md5(concat)

	local md = Framework.Tools.LuaToolkit.md5(timestamp .. nonce .. key .. concat)
	local uuid = md .. nonce .. timestamp

	return uuid
end

function CommentMixin:openSwitchAccount()
	local sdkUid = SDKCore.getUserValue(AttName.USER_ID)
	local authKey = SDKCore.getUserValue(AttName.USER_TOKEN)
	local base64ed = Base64.enc(authKey)
	local platformData = SDKCore.getPlatformData()
	local authAppId = platformData.app_id
	local deviceID = SDKAppUtils.getNativeDeviceID()
	local packageId = SDKAppUtils.getPackageName()
	local spMark = UrlConfig.getSpMark()
	local base_url = "https://webpage-global.flowgame.com/migrate/index.html"
	local ts = os.time()
	local nonce = self:getNonce()
	local params = {
		game_id = "1001",
		ts = ts,
		nonce = nonce,
		spmark = spMark,
		auth_app_id = authAppId or "",
		auth_key = base64ed,
		dev_id = deviceID,
		device_os = DeviceHelper.runtimePlatform,
		old_sdk_uid = sdkUid,
		package_id = packageId,
		region = RegionUtils.region
	}
	local appkey = "752xcWEvbxzsed13"
	local signed_url = self:generateSignedUrl(base_url, params, appkey) .. "&language=" .. RegionUtils.curLanguage

	WebView.unityOpenUrl(signed_url)
end

function CommentMixin:generateMd5Sign(params, appkey)
	local keys = {}

	for k in pairs(params) do
		table.insert(keys, k)
	end

	table.sort(keys)

	local parts = {}

	for _, k in ipairs(keys) do
		table.insert(parts, k .. "=" .. params[k])
	end

	local signBaseStr = table.concat(parts, "&") .. "&" .. appkey
	local hexdigest = Framework.Tools.LuaToolkit.md5(signBaseStr)

	return hexdigest
end

function CommentMixin:generateSignedUrl(base_url, params, appkey)
	local sign = self:generateMd5Sign(params, appkey)
	local query_string_parts = {}

	for k, v in pairs(params) do
		table.insert(query_string_parts, k .. "=" .. v)
	end

	local query_string = table.concat(query_string_parts, "&")

	return base_url .. "?" .. query_string .. "&sign=" .. sign
end

function CommentMixin:getNonce()
	math.randomseed(os.clock())

	local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	local length = 8
	local randomString = ""

	for i = 1, length do
		local rand = math.random(#chars)

		randomString = randomString .. string.sub(chars, rand, rand)
	end

	return randomString
end

return CommentMixin
