-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/model/ActivityPopupModel.lua

module("logic.extensions.activitypopup.model.ActivityPopupModel", package.seeall)

local DATA_KEY = "ACTIVITYPOPUP_KEY_"
local ActivityPopupModel = class("ActivityPopupModel", BaseModel)

function ActivityPopupModel:ctor()
	return
end

function ActivityPopupModel:onInit()
	self:onReset()
end

function ActivityPopupModel:onReset()
	self._activityList = {}
	self.typePool = {}
end

function ActivityPopupModel:initActivityPopup()
	table.clear(self._activityList)

	local cfgs = ActivityPopupConfig.instance:getCfgs().dataList

	for i, v in ipairs(cfgs) do
		if self:isMatchCondition(v) then
			table.insert(self._activityList, v)
		end
	end

	table.sort(self._activityList, function(a, b)
		return a.priority < b.priority
	end)
end

function ActivityPopupModel:getFirstCommonCfgInTime()
	local resultCfg

	if self._activityList then
		for i, v in ipairs(self._activityList) do
			if v.funcType == 0 then
				resultCfg = v

				break
			end
		end
	end

	return resultCfg
end

function ActivityPopupModel:_isMatchPlatform(cfg)
	return self:checkIsMatchPlatform(cfg.platformTypeLimit) and self:checkIsMatchCochannel(cfg.cochannelLimit)
end

function ActivityPopupModel:checkIsMatchCochannel(cochannelLimit)
	if Framework.OSDef.isEditor then
		return true
	end

	if not string.nilorempty(cochannelLimit) then
		local arr = string.splitToNumber(cochannelLimit, "#")
		local cochannelId = checknumber(LoginModel.instance:getCoChannelId())

		for i, v in ipairs(arr) do
			if v == cochannelId then
				return true
			end
		end

		return false
	end

	return true
end

function ActivityPopupModel:checkIsMatchPlatform(platformTypeLimit)
	if platformTypeLimit ~= nil then
		platformTypeLimit = tostring(platformTypeLimit)
	end

	if not string.nilorempty(platformTypeLimit) then
		if Framework.OSDef.isEditor then
			return true
		end

		local pid = checknumber(LoginModel.instance.platformId)
		local cid = checknumber(BootstrapUtil.getChannelId())
		local platCfg = ActivityPopupConfig.instance:getPlatformCfg(pid, cid)

		if platCfg == nil then
			platCfg = ActivityPopupConfig.instance:getPlatformCfgByPlatformId(pid)
		end

		if platCfg then
			local flag = tostring(platCfg.type)
			local map = {}
			local arr = string.split(flag, "#")

			for i, v in ipairs(arr) do
				map[v] = true
			end

			local isPlatform = false
			local arr = string.split(platformTypeLimit, "#")

			for k, v in pairs(arr) do
				if map[v] then
					isPlatform = true

					break
				end
			end

			if isPlatform == false then
				return false
			end
		else
			return false
		end
	end

	return true
end

function ActivityPopupModel:isMatchCondition(cfg)
	if BootstrapPjaqGameConfigMgr.isReview and checkbool(cfg.hideWithReview) then
		return false
	end

	if not self:_isMatchPlatform(cfg) then
		return false
	end

	if self:checkTypeDone(cfg) then
		return false
	end

	if not ActivityDefineController.instance:isRelateServerBy(cfg.relatedAreaIds) then
		return false
	end

	if cfg.popupType == 1 then
		local openDays = GameUtil.getOpenAreaDaysForFive()
		local startDay = cfg.fromDay
		local endDay = cfg.duration - 1 + cfg.fromDay

		if startDay <= openDays and openDays <= endDay then
			return true
		end
	elseif not string.nilorempty(cfg.openTime) and not string.nilorempty(cfg.endTime) and GameUtil.checkIsInTimePeriod(cfg.openTime, cfg.endTime) then
		return true
	end

	return false
end

function ActivityPopupModel:getHasActView()
	return self._activityList and #self._activityList > 0
end

function ActivityPopupModel:getHasAutoMall(actid)
	if actid == nil then
		actid = 1
	end

	return #self:getAutoMallCfgs(actid) > 0
end

function ActivityPopupModel:getAutoMallCfgs(actid)
	local tab = {}
	local list = ActivityPopupConfig.instance:getPayAutoShowCfg(actid)

	for i, cfg in ipairs(list) do
		-- block empty
	end

	return tab
end

function ActivityPopupModel:getAutoTabMallCfgs()
	local tab = {}
	local map = {}
	local list = ActivityPopupConfig.instance:getPayAutoTabShowCfg()

	for i, cfg in ipairs(list) do
		map[cfg.activityType] = map[cfg.activityType] or {}

		local mibaoCfg = PayShopConfig.instance:getPayShopGoodsCfgById(cfg.shopId)

		if ActivityDefineController.instance:checkIsInTime(mibaoCfg.processType, mibaoCfg.startDay, mibaoCfg.durationDay, mibaoCfg.onlineTime, mibaoCfg.offlineTime) then
			table.insert(map[cfg.activityType], mibaoCfg)

			if table.indexof(tab, cfg.activityType) == false then
				table.insert(tab, cfg.activityType)
			end
		end
	end

	ArraySort.sortOn(tab)

	for k, v in pairs(map) do
		ArraySort.sortOn(v, "id")
	end

	return map, tab
end

function ActivityPopupModel:getNextActivityViewId()
	if #self._activityList == 0 then
		return nil
	end

	local v = table.remove(self._activityList, 1)

	return v.id
end

function ActivityPopupModel:isHaveNextActivityViewId()
	return #self._activityList > 0
end

function ActivityPopupModel:getSignString()
	return "activitypopup"
end

function ActivityPopupModel:checkTypeDone(cfg)
	if cfg then
		local type = cfg.type
		local key = DATA_KEY .. cfg.id

		if type == "once" then
			local value = GameUtil.getUserData(key)

			return checknumber(value) == 1
		elseif type == "each" then
			return checknumber(self.typePool[key]) == 1
		elseif type == "day" then
			local value = GameUtil.getUserDayData(key)

			return checknumber(value) == 1
		elseif type == "week" then
			local value = GameUtil.getUserWeekData(key)

			return checknumber(value) == 1
		elseif type == "forself" then
			local value = GameUtil.getUserData(key)

			return checknumber(value) == 1
		end
	end

	return false
end

function ActivityPopupModel:saveTypeDone(id)
	local cfg = ActivityPopupConfig.instance:getCfgById(id)

	if cfg then
		local type = cfg.type
		local key = DATA_KEY .. cfg.id

		if type == "once" then
			GameUtil.saveUserData(key, 1)
		elseif type == "each" then
			self.typePool[key] = 1
		elseif type == "day" then
			GameUtil.saveUserDayData(key, 1)
		elseif type == "week" then
			GameUtil.saveUserWeekData(key, 1)
		elseif type == "forself" then
			-- block empty
		end
	end
end

ActivityPopupModel.instance = ActivityPopupModel.New()

return ActivityPopupModel
