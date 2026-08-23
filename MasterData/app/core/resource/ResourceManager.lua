local ResourceLoader = import(".ResourceLoader")
local var_0_1 = cc.FileUtils:getInstance()
local BattlePath = require("app.view.battle.BattlePath")
local var_0_3 = g.core.const.ConstMgr.SpineConst
local ResourceManager = class("ResourceManager")

function ResourceManager:ctor()
	self._knightRes = {}
	self._assistantId = nil
	self._assistantBgId = nil
	self._imageQueue = {}
	self._imageLoading = false
	self._preLoadEffects = {}
	self._preLoadTextures = {}
	self._spineCacheList = {}
	self._initSpineCacheData = {
		cacheTime = 0,
		isCache = false,
		isForever = false
	}
	self._deviceRealQuality = g.core.common.DeviceCheck.getDevicePerformanceLv()

	self:addSpineCache(var_0_3.TYPE.RES_EFFECT, var_0_3.INIT_RES_EFFECT_CACHE, true)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH, self._onFlushChanged, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION, self._onFormationChanged, self)
end

function ResourceManager:reset()
	self:stopLoadImage()

	self._knightRes = {}
	self._assistantId = nil
	self._assistantBgId = nil
	self._imageQueue = {}
	self._imageLoading = false

	self:clearResource()
	self:clearSpineCache()
end

function ResourceManager:_transSpinePath(arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_1 or not arg_3_2 then
		return {}
	end

	local var_3_0
	local var_3_2 = arg_3_3 or {}

	if arg_3_1 == var_0_3.TYPE.BATTLE_KNIGHT then
		var_3_0 = BattlePath.getSpineKnightPath(arg_3_2)
	elseif arg_3_1 == var_0_3.TYPE.BATTLE_EFFECT then
		var_3_0 = BattlePath.getSpineEffectPath(arg_3_2)
	elseif arg_3_1 == var_0_3.TYPE.RES_KNIGHT then
		var_3_0 = g.core.common.Path:getSpineKnightPath(arg_3_2)
	elseif arg_3_1 == var_0_3.TYPE.RES_KNIGHT_BG then
		if cc.FileUtils:getInstance():isFileExist(arg_3_2 .. "_bg.skel") then
			var_3_0 = g.core.common.Path:getSpineKnightBgPath(arg_3_2)
		end
	elseif arg_3_1 == var_0_3.TYPE.RES_EFFECT then
		var_3_0 = g.core.common.Path:getEffSpine(arg_3_2)
	elseif arg_3_1 == var_0_3.TYPE.BATTLE_ATTR then
		var_3_0 = BattlePath.getSpineAttrPath(arg_3_2)
	elseif arg_3_1 == var_0_3.TYPE.BATTLE_BUFF then
		var_3_0 = BattlePath.getSpineBuffPath(arg_3_2)
	elseif arg_3_1 == var_0_3.TYPE.BATTLE_TWEEN then
		var_3_0 = BattlePath.getSpineTweenPath(arg_3_2)
	elseif arg_3_1 == var_0_3.TYPE.MAIN_ROLE_BACK then
		var_3_0 = g.core.common.Path:getMainRoleBackSpinePath(arg_3_2)
	end

	if var_3_0 then
		table.insert(var_3_2, {
			path = var_3_0,
			name = string.gsub(var_3_0, "/", "_")
		})
	end

	return var_3_2
end

function ResourceManager:addSpineCache(arg_4_1, arg_4_2, arg_4_3)
	if self._deviceRealQuality <= 0 or g.core.model.User.splitDownloadData:isShowDownloadListPop() then
		return
	end

	arg_4_3 = not not arg_4_3

	local var_4_0 = {}

	if type(arg_4_2) == "string" or type(arg_4_2) == "number" then
		var_4_0 = self:_transSpinePath(arg_4_1, arg_4_2)
	elseif type(arg_4_2) == "table" then
		for iter_4_0, iter_4_1 in pairs(arg_4_2) do
			if type(iter_4_0) == "string" and iter_4_1 then
				var_4_0 = self:_transSpinePath(arg_4_1, iter_4_0, var_4_0)
			elseif type(iter_4_0) == "number" then
				var_4_0 = self:_transSpinePath(arg_4_1, iter_4_1, var_4_0)
			end
		end
	else
		dump("error name type")

		return
	end

	for iter_4_2 = 1, #var_4_0 do
		local var_4_1 = self._spineCacheList[var_4_0[iter_4_2].name]

		if self._spineCacheList[var_4_0[iter_4_2].name] and var_4_1.isCache then
			-- block empty
		else
			local var_4_2, var_4_3 = BattlePath.getSpineResPath(var_4_0[iter_4_2].path)

			if sp.SkeletonAnimation:addSkeletonDataCache(var_4_2, var_4_3) then
				var_4_1 = var_4_1 or clone(self._initSpineCacheData)
				var_4_1.path = var_4_0[iter_4_2].path
				var_4_1.isCache = true
				var_4_1.cacheTime = var_4_1.cacheTime + 1
				var_4_1.isForever = var_4_1.isForever or arg_4_3
				self._spineCacheList[var_4_0[iter_4_2].name] = var_4_1
			else
				dump("add spine cache " .. var_4_0[iter_4_2].name .. " fail")
			end
		end
	end

	self:getSpineCacheNum()
end

function ResourceManager:removeSpineCache(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = {}

	if type(arg_5_2) == "string" or type(arg_5_2) == "number" then
		var_5_0 = self:_transSpinePath(arg_5_1, arg_5_2)
	elseif type(arg_5_2) == "table" then
		for iter_5_0, iter_5_1 in pairs(arg_5_2) do
			if type(iter_5_0) == "string" and iter_5_1 then
				var_5_0 = self:_transSpinePath(arg_5_1, iter_5_0, var_5_0)
			elseif type(iter_5_0) == "number" then
				var_5_0 = self:_transSpinePath(arg_5_1, iter_5_1, var_5_0)
			end
		end
	else
		dump("error name type")

		return
	end

	self:_removeSpineCacheByList(var_5_0, arg_5_3)
end

function ResourceManager:_removeSpineCacheByList(arg_6_1, arg_6_2)
	if self._deviceRealQuality <= 0 then
		return
	end

	arg_6_2 = not not arg_6_2

	for iter_6_0 = 1, #arg_6_1 do
		if not self._spineCacheList[arg_6_1[iter_6_0].name] then
			-- block empty
		elseif not arg_6_2 and self._spineCacheList[arg_6_1[iter_6_0].name].isForever then
			-- block empty
		else
			local var_6_0, var_6_1 = BattlePath.getSpineResPath(arg_6_1[iter_6_0].path)

			if sp.SkeletonAnimation:removeSkeletonDataCache(var_6_0) then
				self._spineCacheList[arg_6_1[iter_6_0].name].isCache = false
				self._spineCacheList[arg_6_1[iter_6_0].name].isForever = false
			else
				dump("remove spine cache " .. arg_6_1[iter_6_0].name .. " fail")
			end
		end
	end

	self:getSpineCacheNum()
end

function ResourceManager:getSpineCacheNum()
	return (sp.SkeletonAnimation:getSkeletonDataCacheNum())
end

function ResourceManager:dumpSpineCacheList()
	dump(self._spineCacheList)
end

function ResourceManager:isSpineCached(arg_9_1)
	local var_9_0 = string.gsub(arg_9_1, "/", "_")

	return self._spineCacheList[var_9_0] and self._spineCacheList[var_9_0].isCache
end

function ResourceManager:clearSpineCache()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(self._spineCacheList) do
		if iter_10_1.isCache then
			table.insert(var_10_0, {
				name = iter_10_0,
				path = iter_10_1.path
			})
		end
	end

	self:_removeSpineCacheByList(var_10_0, true)
end

function ResourceManager:getDeviceRealQuality()
	return self._deviceRealQuality
end

function ResourceManager:initPreloadKnightCache()
	if not self._initFlush then
		if g.core.common.PackageRes:isPackageEnable() then
			g.core.common.Scheduler:newScheduleOnce(handler(self, self.refreshKnightCache), 0)
		else
			self:refreshKnightCache()
		end

		self._initFlush = true
	end
end

function ResourceManager:_onFlushChanged(arg_13_1, arg_13_2, arg_13_3)
	return
end

function ResourceManager:_onFormationChanged(arg_14_1, arg_14_2, arg_14_3)
	if arg_14_3.tp == 1 then
		self:refreshKnightCache()
	end
end

function ResourceManager:refreshAssistaneCache()
	local var_15_0 = g.core.model.User:getAssistantResInfo()
	local var_15_1 = var_15_0.painted_id

	if var_15_0.painted_bg_id > 0 then
		var_15_1 = var_15_0.painted_bg_id
	end

	if self._assistantId ~= var_15_0.painted_id then
		if self._assistantId then
			self:removeSpineCache(var_0_3.TYPE.RES_KNIGHT, self._assistantId, true)
		end

		self._assistantId = var_15_0.painted_id

		self:addSpineCache(var_0_3.TYPE.RES_KNIGHT, self._assistantId, true)
	end

	if self._assistantBgId ~= var_15_1 then
		if self._assistantBgId then
			self:removeSpineCache(var_0_3.TYPE.RES_KNIGHT_BG, self._assistantBgId, true)
		end

		self._assistantBgId = var_15_1

		self:addSpineCache(var_0_3.TYPE.RES_KNIGHT_BG, self._assistantBgId, true)
	end
end

function ResourceManager:refreshKnightCache()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs((g.core.model.User.knightsData:getLineUpList())) do
		var_16_0[tostring(iter_16_1:getResInfo().fight_id)] = true
	end

	local var_16_1 = {}

	for iter_16_2, iter_16_3 in pairs(var_16_0) do
		if not self._knightRes[iter_16_2] then
			var_16_1[iter_16_2] = true
		end
	end

	for iter_16_4, iter_16_5 in pairs(self._knightRes) do
		if not var_16_0[iter_16_4] then
			var_16_1[iter_16_4] = false
		end
	end

	self:_refreshLoader(var_16_1)
end

function ResourceManager:_refreshLoader(arg_17_1)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in pairs(arg_17_1) do
		local var_17_1 = tonumber(iter_17_0)

		var_17_0[iter_17_0] = iter_17_1

		if not iter_17_1 then
			self:removeSpineCache(var_0_3.TYPE.BATTLE_KNIGHT, var_17_1, true)
		else
			self:addSpineCache(var_0_3.TYPE.BATTLE_KNIGHT, var_17_1, true)
		end
	end

	local var_17_2 = {}

	for iter_17_2, iter_17_3 in pairs(self._knightRes) do
		table.insert(var_17_2, iter_17_2)
	end

	for iter_17_4, iter_17_5 in pairs(var_17_0) do
		table.insert(var_17_2, iter_17_4)
	end

	local var_17_3 = {}

	for iter_17_6, iter_17_7 in ipairs(var_17_2) do
		if var_17_0[iter_17_7] ~= false then
			var_17_3[iter_17_7] = true
		end
	end

	self._knightRes = var_17_3
end

function ResourceManager:clearResource()
	fgui.UIPackage:removeAllUnusedItemAltas()
	cc.SpriteFrameCache:getInstance():removeUnusedSpriteFrames()
	cc.Director:getInstance():getTextureCache():removeUnusedTextures()
end

function ResourceManager:luaGCCollect()
	g.core.service.ServiceManager:getServiceByName("LuaGcService"):resetFullGCTime()
end

function ResourceManager:_pushAsyncImage(arg_20_1)
	local var_20_0 = arg_20_1.nextFrame or false

	if type(arg_20_1.file) == "string" then
		if var_0_1:isFileExist(arg_20_1.file) then
			table.insert(self._imageQueue, {
				file = arg_20_1.file,
				callback = arg_20_1.callback,
				key = arg_20_1.key,
				nextFrame = var_20_0
			})
		end
	elseif type(arg_20_1.file) == "table" then
		local var_20_1 = {}

		for iter_20_0, iter_20_1 in ipairs(arg_20_1.file) do
			if var_0_1:isFileExist(iter_20_1) then
				table.insert(var_20_1, iter_20_1)
			end
		end

		table.insert(self._imageQueue, {
			file = var_20_1,
			callback = arg_20_1.callback,
			key = arg_20_1.key,
			nextFrame = var_20_0
		})
	end
end

function ResourceManager:loadImageAsync(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		local var_21_1 = ResourceLoader:getPlatformResourceURL(iter_21_1)

		if not var_21_0[var_21_1] then
			var_21_0[iter_21_1] = {
				name = var_21_1,
				index = iter_21_0
			}
		end
	end

	local var_21_2 = {}

	for iter_21_2, iter_21_3 in ipairs(arg_21_1) do
		local var_21_3 = var_21_0[iter_21_3] or {}
		local var_21_4 = {}

		var_21_4.index = var_21_3.index or iter_21_2
		var_21_4.name = var_21_3.name or iter_21_3
		var_21_2[#var_21_2 + 1] = var_21_4
	end

	table.sort(var_21_2, function(arg_22_0, arg_22_1)
		return arg_22_0.index < arg_22_1.index
	end)

	for iter_21_4, iter_21_5 in ipairs(var_21_2) do
		self:_pushAsyncImage({
			file = iter_21_5.name,
			callback = arg_21_2,
			key = arg_21_3
		})
	end

	self:_doLoadImage()
end

function ResourceManager:loadImageAsyncOnce(arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		var_23_0[ResourceLoader:getPlatformResourceURL(iter_23_1)] = 1
	end

	arg_23_1 = {}

	for iter_23_2, iter_23_3 in pairs(var_23_0) do
		arg_23_1[#arg_23_1 + 1] = iter_23_2
	end

	self:_pushAsyncImage({
		file = arg_23_1,
		callback = arg_23_2,
		key = arg_23_3
	})
	self:_doLoadImage()
end

function ResourceManager:stopLoadImage()
	self._stopLoad = true
end

function ResourceManager:loadKnightSpineAsync(arg_25_1, arg_25_2, arg_25_3)
	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		self:_pushAsyncImage({
			file = "battle/knight_spine/" .. iter_25_1 .. "/" .. iter_25_1 .. ".png",
			callback = arg_25_2,
			key = arg_25_3
		})
	end

	self:_doLoadImage()
end

function ResourceManager:loadKnightSpinePngAsync(arg_26_1, arg_26_2, arg_26_3)
	for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
		self:_pushAsyncImage({
			file = "pic/knight_spine/" .. iter_26_1 .. ".png",
			callback = arg_26_2,
			key = arg_26_3
		})
	end

	self:_doLoadImage()
end

function ResourceManager:loadEffectsAsync(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
		var_27_1(iter_27_1)
	end

	if arg_27_4 then
		self:_pushAsyncImage({
			nextFrame = true,
			file = var_27_0,
			callback = arg_27_2,
			key = arg_27_3
		})
	else
		local var_27_3 = #var_27_0

		for iter_27_2, iter_27_3 in ipairs(var_27_0) do
			self:_pushAsyncImage({
				nextFrame = true,
				file = iter_27_3,
				callback = arg_27_2,
				key = iter_27_2 == var_27_3 and arg_27_3 or ""
			})
		end
	end

	self:_doLoadImage()
end

function ResourceManager:loadSpineEffectAsync(arg_29_1, arg_29_2, arg_29_3)
	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		self:_pushAsyncImage({
			nextFrame = true,
			file = "effect_spine/" .. iter_29_1 .. "/" .. iter_29_1 .. ".png",
			callback = arg_29_2,
			key = arg_29_3
		})
	end

	self:_doLoadImage()
end

function ResourceManager:_doLoadImage()
	if not self._imageLoading and #self._imageQueue > 0 then
		self._stopLoad = false
		self._imageLoading = true

		if type(self._imageQueue[1].file) == "string" then
			cc.Director:getInstance():getTextureCache():addImageAsync(self._imageQueue[1].file, handler({
				image = self._imageQueue[1],
				manager = self
			}, self._loadImageCallback))
		elseif type(self._imageQueue[1].file) == "table" then
			if #self._imageQueue[1].file <= 0 then
				self._imageLoading = false

				table.remove(self._imageQueue, 1)
			else
				for iter_30_0, iter_30_1 in ipairs(self._imageQueue[1].file) do
					cc.Director:getInstance():getTextureCache():addImageAsync(iter_30_1, handler({
						file = iter_30_1,
						image = self._imageQueue[1],
						manager = self
					}, self._loadImageOnceCallback))
				end
			end
		end
	end
end

function ResourceManager:_doLoadNextImage()
	local var_31_0 = #self._imageQueue > 0 and self._imageQueue[1]

	if not (#self._imageQueue > 0 and self._imageQueue[1]) then
		return
	end

	if var_31_0.nextFrame then
		self._imageLoading = true

		g.core.common.Scheduler:newScheduleOnce(function(arg_32_0)
			self._imageLoading = false

			self:_doLoadImage()
		end, 0)
	else
		self:_doLoadImage()
	end
end

function ResourceManager:_loadImageCallback(arg_33_1)
	local var_33_0 = self

	self = self.manager

	if self._stopLoad then
		self._imageLoading = false
		self._imageQueue = {}

		return
	end

	if not arg_33_1 then
		g.core.log:info("Load Image Failed: " .. tostring(var_33_0.image.file))
	end

	if var_33_0.image.callback then
		var_33_0.image.callback(arg_33_1, var_33_0.image.key)
	end

	self._imageLoading = false

	table.remove(self._imageQueue, 1)
	self:_doLoadNextImage()
end

function ResourceManager:_loadImageOnceCallback(arg_34_1)
	local var_34_0 = self

	self = self.manager

	if self._stopLoad then
		self._imageLoading = false
		self._imageQueue = {}

		return
	end

	if not arg_34_1 then
		g.core.log:info("Load Image Failed: " .. tostring(var_34_0.file))
	end

	if var_34_0.file == var_34_0.image.file[#var_34_0.image.file] then
		if var_34_0.image.callback then
			var_34_0.image.callback(arg_34_1, var_34_0.image.key)
		end

		self._imageLoading = false

		table.remove(self._imageQueue, 1)
		self:_doLoadNextImage()
	end
end

function ResourceManager:storeEffects(arg_35_1)
	local var_35_0 = arg_35_1

	cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_37_0)
		if #var_35_0 > 0 then
			var_35_1(var_35_0[1])
			table.remove(var_35_0, 1)
		end

		self:_doLoadImage()
	end, 0, false)
end

return ResourceManager
