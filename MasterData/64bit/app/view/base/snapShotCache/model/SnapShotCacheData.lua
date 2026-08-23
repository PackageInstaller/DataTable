local var_0_0 = g.core.const.ConstMgr.SnapShotCacheConst
local SnapShotCacheData = class("SnapShotCacheData")

function SnapShotCacheData:ctor()
	self:initData()
end

function SnapShotCacheData:initData()
	self._cacheData = {
		[var_0_0.SNAP_SHOT_KEY.USER] = {
			nearTime = -1,
			onlyIdKey = "id",
			cnt = 0,
			cacheMap = {}
		},
		[var_0_0.SNAP_SHOT_KEY.GUILD] = {
			nearTime = -1,
			onlyIdKey = "id",
			cnt = 0,
			cacheMap = {}
		},
		[var_0_0.SNAP_SHOT_KEY.ALLIANCE] = {
			nearTime = -1,
			onlyIdKey = "id",
			cnt = 0,
			cacheMap = {}
		}
	}
	self._groupSnapShot = {}
	self._reqGroupSnapShotTime = {}
end

function SnapShotCacheData:clearData()
	self._cacheData = {
		[var_0_0.SNAP_SHOT_KEY.USER] = {
			nearTime = -1,
			onlyIdKey = "id",
			cnt = 0,
			cacheMap = {}
		},
		[var_0_0.SNAP_SHOT_KEY.GUILD] = {
			nearTime = -1,
			onlyIdKey = "id",
			cnt = 0,
			cacheMap = {}
		},
		[var_0_0.SNAP_SHOT_KEY.ALLIANCE] = {
			nearTime = -1,
			onlyIdKey = "id",
			cnt = 0,
			cacheMap = {}
		}
	}
	self._groupSnapShot = {}
	self._reqGroupSnapShotTime = {}
end

function SnapShotCacheData:updateSnapShotCache(arg_4_1, arg_4_2)
	local var_4_0 = g.core.common.ServerTime:getTime() + var_0_0.EXPIRE_TIME

	for iter_4_0, iter_4_1 in ipairs(arg_4_2 or {}) do
		if self._cacheData[arg_4_1].cacheMap[iter_4_1[self._cacheData[arg_4_1].onlyIdKey]] then
			self._cacheData[arg_4_1].cacheMap[iter_4_1[self._cacheData[arg_4_1].onlyIdKey]].data = iter_4_1
			self._cacheData[arg_4_1].cacheMap[iter_4_1[self._cacheData[arg_4_1].onlyIdKey]].expireTime = var_4_0
		else
			self._cacheData[arg_4_1].cacheMap[iter_4_1[self._cacheData[arg_4_1].onlyIdKey]] = {
				data = iter_4_1,
				expireTime = var_4_0
			}
			self._cacheData[arg_4_1].cnt = self._cacheData[arg_4_1].cnt + 1
		end
	end

	if self._cacheData[arg_4_1].nearTime == -1 then
		self._cacheData[arg_4_1].nearTime = var_4_0
	end

	if self._cacheData[arg_4_1].cnt > var_0_0.ONE_CACHE_MAX_NUM then
		self:_removeOutCntData(self._cacheData[arg_4_1])
	end
end

function SnapShotCacheData:checkExpireData()
	local var_5_0 = g.core.common.ServerTime:getTime()

	for iter_5_0, iter_5_1 in pairs(self._cacheData) do
		if var_5_0 >= iter_5_1.nearTime then
			self:_checkAndRemoveExpireData(iter_5_1, var_5_0)
		end
	end
end

function SnapShotCacheData:_checkAndRemoveExpireData(arg_6_1, arg_6_2)
	local var_6_0 = {}
	local var_6_1 = -1
	local var_6_2 = 0

	for iter_6_0, iter_6_1 in pairs(arg_6_1.cacheMap) do
		if arg_6_2 < iter_6_1.expireTime then
			var_6_0[iter_6_0] = iter_6_1

			if var_6_1 < 0 or var_6_1 > iter_6_1.expireTime then
				var_6_1 = iter_6_1.expireTime
			end

			var_6_2 = var_6_2 + 1
		end
	end

	arg_6_1.cacheMap = var_6_0
	arg_6_1.nearTime = var_6_1
	arg_6_1.cnt = var_6_2
end

function SnapShotCacheData:_removeOutCntData(arg_7_1)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_1.cacheMap) do
		local var_7_1 = false

		for iter_7_2 = #var_7_0, 1, -1 do
			if var_7_0[iter_7_2].time > iter_7_1.expireTime then
				table.insert(var_7_0, iter_7_2 + 1, {
					id = iter_7_0,
					time = iter_7_1.expireTime
				})

				var_7_1 = true

				break
			end
		end

		if not var_7_1 then
			table.insert(var_7_0, 1, {
				id = iter_7_0,
				time = iter_7_1.expireTime
			})
		end
	end

	for iter_7_3 = #var_7_0, var_0_0.ONE_CACHE_MAX_NUM + 1, -1 do
		arg_7_1.cacheMap[var_7_0[iter_7_3].id] = nil
	end

	arg_7_1.cnt = var_0_0.ONE_CACHE_MAX_NUM
	arg_7_1.nearTime = var_7_0[var_0_0.ONE_CACHE_MAX_NUM].time
end

function SnapShotCacheData:_getMineUserSnapShot()
	local var_8_0 = g.core.model.User:packUser()

	var_8_0.server_name = (g.core.platform.ServerListProxy:getServerById(var_8_0.sid) or {
		name = ""
	}).name

	return var_8_0
end

function SnapShotCacheData:_getMineGuildSnapShot()
	local var_9_0 = g.core.model.User.guildData:getGuildData()

	if next(var_9_0) then
		return var_9_0
	end
end

function SnapShotCacheData:_getCfgByOnlyId(arg_10_1, arg_10_2)
	return arg_10_1.indexOf((math.max(1, arg_10_2 % (arg_10_1.getLength() + 1))))
end

function SnapShotCacheData:_getUserSnapShotTemplate(arg_11_1)
	local var_11_0 = g.core.platform.ServerListProxy:getLoginServer()
	local var_11_1 = self:_getCfgByOnlyId(g.core.config.avatar_frame_info, arg_11_1)
	local var_11_2 = self:_getCfgByOnlyId(g.core.config.avata_info, arg_11_1)

	while var_11_2.put ~= 1 do
		var_11_2 = g.core.config.avata_info.indexOf(1)
	end

	local var_11_4 = arg_11_1 % 2 == 1
	local var_11_5 = self:_getCfgByOnlyId(require("app.core.config.cfg.rand2_surname_info"), arg_11_1)
	local var_11_6 = self:_getCfgByOnlyId(require("app.core.config.cfg.rand3_name_info"), arg_11_1)

	return {
		robot_type = 0,
		vip_level = 1,
		is_robot = true,
		title_id = 0,
		id = arg_11_1,
		sid = var_11_0.sid,
		level = math.floor(math.random(70, 200)),
		base_id = var_11_4 and 210000 or 200000,
		fight_value = tonumber(var_11_0.sid),
		frame_id = var_11_1.id,
		avata_id = var_11_2.id,
		name = var_11_5.surname .. ((arg_11_1 % 2 == 1 or nil) and (var_11_6.name_boy or var_11_6.name_girl)),
		knights = {
			var_11_4 and 210000 or 200000
		}
	}
end

function SnapShotCacheData:_getGuildSnapShotTemplate(arg_12_1)
	return
end

function SnapShotCacheData:_getAllianceSnapShotTemplate(arg_13_1)
	return
end

function SnapShotCacheData:getSnapShot(arg_14_1, arg_14_2, arg_14_3)
	assert(arg_14_1 and arg_14_2, "get SnapShot ERROR,key : " .. tostring(arg_14_1) .. " id :" .. tostring(arg_14_2))

	if arg_14_2 == 0 then
		return
	end

	if var_0_0.SNAP_SHOT_KEY.GUILD == arg_14_1 and arg_14_2 == g.core.model.User:getGuildId() then
		local var_14_0 = self:_getMineGuildSnapShot()

		if var_14_0 then
			return var_14_0
		end
	elseif var_0_0.SNAP_SHOT_KEY.USER == arg_14_1 and arg_14_2 == g.core.model.User:getId() and not arg_14_3 then
		return g.core.model.User:packUser()
	end

	local var_14_1 = self._cacheData[arg_14_1].cacheMap[arg_14_2]

	if not self._cacheData[arg_14_1].cacheMap[arg_14_2] then
		g.core.service.ServiceManager:getServiceByName("SnapShotCacheService"):addWaitSnapShot(arg_14_1, arg_14_2)
	elseif arg_14_3 and var_14_1.expireTime - var_0_0.EXPIRE_TIME + 60 - g.core.common.ServerTime:getTime() < 0 then
		g.core.service.ServiceManager:getServiceByName("SnapShotCacheService"):addWaitSnapShot(arg_14_1, arg_14_2)
	else
		return var_14_1.data
	end
end

function SnapShotCacheData:getDataSnapShotTemplate(arg_15_1, arg_15_2, arg_15_3)
	arg_15_3 = arg_15_3 or 1
	arg_15_2 = arg_15_2 * arg_15_3

	local var_15_0

	if arg_15_1 == var_0_0.SNAP_SHOT_KEY.USER then
		var_15_0 = self:_getUserSnapShotTemplate(arg_15_2)
	elseif arg_15_1 == var_0_0.SNAP_SHOT_KEY.GUILD then
		var_15_0 = self:_getGuildSnapShotTemplate(arg_15_2)
	elseif arg_15_1 == var_0_0.SNAP_SHOT_KEY.ALLIANCE then
		var_15_0 = self:_getAllianceSnapShotTemplate(arg_15_2)
	end

	return var_15_0
end

function SnapShotCacheData:onGroupSnapShotBack(arg_16_1)
	self._groupSnapShot[arg_16_1.tp] = arg_16_1.snapshots
end

function SnapShotCacheData:getSnapShotsByGroup(arg_17_1)
	return self._groupSnapShot[arg_17_1] or {}
end

function SnapShotCacheData:checkSendGroup(arg_18_1)
	local var_18_0 = self._reqGroupSnapShotTime[arg_18_1] or 0
	local var_18_1 = g.core.common.ServerTime:getTime()

	if var_18_1 - var_18_0 > var_0_0.GROUP_REQ_TIME then
		self._reqGroupSnapShotTime[arg_18_1] = var_18_1

		g.core.network.GameNetProxy:send_C2S_Snapshot_OnlineUsers({
			tp = arg_18_1
		})

		return true
	end

	return false
end

return SnapShotCacheData
