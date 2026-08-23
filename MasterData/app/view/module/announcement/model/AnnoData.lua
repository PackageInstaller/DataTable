local var_0_0 = g.core.const.ConstMgr.AnnoConst
local var_0_1 = g.core.common.Storage
local MultilingualMgr = require("app.core.lang.MultilingualMgr")
local AnnoData = class("AnnoData")

function AnnoData:ctor()
	self:initData()
end

function AnnoData:initData()
	self._webInfoArr = {}

	local var_2_0 = var_0_1:load(var_0_0.JSON_NAME, false) or {}

	var_2_0.readDict = var_2_0.readDict or {}
	self._jsonDict = var_2_0
end

function AnnoData:saveJsonFile()
	var_0_1:save(var_0_0.JSON_NAME, self._jsonDict, false)
end

function AnnoData:setRead(arg_4_1)
	if arg_4_1 then
		self._jsonDict.readDict[tostring(arg_4_1)] = 1
	end
end

function AnnoData:isRead(arg_5_1)
	if arg_5_1 then
		return self._jsonDict.readDict[tostring(arg_5_1)] == 1
	end

	return false
end

function AnnoData:onWebListRequestSuccess(arg_6_1)
	local var_6_0 = json.decode(arg_6_1)

	if not var_6_0 or not var_6_0.outer then
		self._webInfoArr = {}

		return
	end

	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_0.outer) do
		local var_6_2 = {}

		var_6_2.index = iter_6_1.index or 1
		var_6_2.name = iter_6_1.name or ""
		var_6_2.url = iter_6_1.url or ""
		var_6_2.id = iter_6_1.id or 1
		var_6_2.state = var_0_0.TipCtrlIdxConst.SHOWING

		table.insert(var_6_1, var_6_2)
	end

	if #var_6_1 > 1 then
		table.sort(var_6_1, function(arg_7_0, arg_7_1)
			local var_7_0 = self:isRead(arg_7_1.id)

			if self:isRead(arg_7_0.id) == var_7_0 then
				return arg_7_0.index > arg_7_1.index
			else
				return var_7_0
			end
		end)
	end

	self._webInfoArr = var_6_1
end

function AnnoData:onWebListRequestFailed()
	self._webInfoArr = {}
end

function AnnoData:onWebListRequestCancel()
	self._webInfoArr = {}
end

function AnnoData:setWebState(arg_10_1, arg_10_2)
	local var_10_0 = self:getWebInfo(arg_10_1)

	if var_10_0 then
		var_10_0.state = arg_10_2
	end
end

function AnnoData:getWebState(arg_11_1)
	local var_11_0 = self:getWebInfo(arg_11_1)

	if var_11_0 then
		return var_11_0.state
	else
		return var_0_0.TipCtrlIdxConst.FAILED
	end
end

function AnnoData:getWebInfoArr()
	return self._webInfoArr
end

function AnnoData:getWebInfo(arg_13_1)
	return self._webInfoArr[arg_13_1]
end

function AnnoData:getWebInfoWithId(arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(self._webInfoArr) do
		if iter_14_1.id == arg_14_1 then
			return iter_14_1
		end
	end
end

function AnnoData:getWebListUrl()
	local var_15_0 = g.core.platform.PlatformProxy
	local var_15_1 = require("app.core.lang.MultilingualMgr"):getUseLang() or config.DEFAULT_LANG
	local var_15_2

	if config.DEBUG_VERSION then
		var_15_2 = var_0_0.LIST_URL_DEBUG or var_0_0.LIST_URL_RELEASE

		if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.TW then
			var_15_2 = "https://notice-game.gtarcade.com/api/announce/list?gameId=#gameid#&opgameId=#opgameid#&opId=#opid#&time=#time#&lang=#lang#"
		end
	end

	return (g.core.lang:getByString(var_15_2, {
		gameid = var_15_0:getGameId(),
		opgameid = var_15_0:getOpGameId(),
		opid = var_15_0:getOpId(),
		time = g.core.common.ServerTime:getTime(),
		lang = var_15_1
	}))
end

function AnnoData:isSelectedTodayNotShow()
	return self._jsonDict.selectedTodayNotShow == 1
end

function AnnoData:setSelectedTodayNotShow(arg_17_1)
	self._jsonDict.selectedTodayNotShow = arg_17_1 and 1 or nil
end

function AnnoData:_isThereNewAnno()
	for iter_18_0, iter_18_1 in ipairs(self._webInfoArr) do
		if not self:isRead(iter_18_1.id) then
			return true
		end
	end

	return false
end

function AnnoData:_isShowedAnnoToday()
	return self._jsonDict.lastShowedDate == g.core.common.ServerTime:getDate()
end

function AnnoData:setShowedAnnoToday()
	self._jsonDict.lastShowedDate = g.core.common.ServerTime:getDate()
end

function AnnoData:isShowAnnouncement()
	if #self._webInfoArr == 0 then
		return false
	elseif self:isSelectedTodayNotShow() then
		if self:_isShowedAnnoToday() then
			return self:_isThereNewAnno()
		else
			return true
		end
	else
		return true
	end
end

function AnnoData:getWebHtmlFileFullPath(arg_22_1, arg_22_2)
	return cc.FileUtils:getInstance():getWritablePath() .. "/" .. (arg_22_1 .. (MultilingualMgr:getUseLang() or config.DEFAULT_LANG) .. string.sub(arg_22_2, string.find(arg_22_2, "?") + 3)) .. ".html"
end

return AnnoData
