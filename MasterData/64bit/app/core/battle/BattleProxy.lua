local var_0_0 = g.core.config.pet_info
local var_0_1 = g.core.config.succuba_info
local var_0_2 = g.core.config.succuba_show_info
local var_0_3 = g.core.event.enum
local var_0_4 = g.core.event.EventManager
local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_6 = BattleConst.SKIP_TYPE
local var_0_7 = g.core.const.ConstMgr
local var_0_8 = g.core.const.ConstMgr.FUNCTION_TYPE
local DebugCommon = require("app.view.module.debug.common.DebugCommon")
local var_0_10 = g.core.config.split_download_battle_res_info
local var_0_11 = g.core.config.knight_base_info
local BattleProxy = class("BattleProxy")

function BattleProxy:ctor()
	self._battleList = {}
	self._isPlaying = false
	self._isLoading = false
	self._inBattle = false
	self._useOwnNode = false
	self._prefixScene = nil
	self._forceExit = false

	var_0_4:addEventListener(var_0_3.EVENT_CLEAR_BATTLE_RESOURCE, self.clearUILayer, self)

	self._battleType = 1
	self._waitData = nil
	self._taskId = 0
end

function BattleProxy:reset()
	self._battleList = {}
	self._isPlaying = false
	self._inBattle = false
	self._useOwnNode = false
	self._prefixScene = nil
	self._battleType = 1
	self._id = nil
	self._ignoreResult = nil
	self._battleNode = nil
	self._battleLayer = nil
	self._type = nil
	self._typeQuality = nil
	self._record = nil
	self._skipType = var_0_6.HIDE
	self._skipTips = ""
	self._skipWait = 0
	self._forceExit = false
end

function BattleProxy:addReport(arg_3_1)
	self._battleList[arg_3_1.battle_id] = arg_3_1
end

function BattleProxy:removeReport(arg_4_1)
	self._battleList[arg_4_1] = nil
end

function BattleProxy:_getSkipByUnlockType(arg_5_1, arg_5_2)
	if not g.core.common.ModuleUnlock:isModuleShow(arg_5_1) then
		return var_0_6.HIDE
	end

	local var_5_0 = g.core.common.ModuleUnlock:isModuleUnlock(arg_5_1)

	if not (var_5_0 and arg_5_2) then
		if var_5_0 then
			return var_0_6.CANT_SKIP, g.core.lang:get(110045)
		else
			return var_0_6.CANT_SKIP, (g.core.common.ModuleUnlock:getUnlockComment(arg_5_1))
		end
	end

	return var_0_6.ACTIVE
end

function BattleProxy:_getSkipByType(arg_6_1, arg_6_2)
	local var_6_0 = var_0_6.HIDE
	local var_6_1 = ""
	local var_6_2
	local var_6_3 = 0

	if arg_6_1 == BattleConst.TYPE_BIO then
		var_6_2 = var_0_8.BATTLE_SKIP_BIO
	elseif arg_6_1 == BattleConst.TYPE_DAILY then
		var_6_2 = var_0_8.BATTLE_SKIP_DAILY
	elseif arg_6_1 == BattleConst.TYPE_DUNGEON then
		var_6_2 = var_0_8.BATTLE_SKIP_DUNGEON
	elseif arg_6_1 == BattleConst.TYPE_WUSH then
		var_6_2 = var_0_8.BATTLE_SKIP_WUSH
	end

	if var_6_2 then
		var_6_0, var_6_1 = self:_getSkipByUnlockType(var_6_2, arg_6_2)
	end

	if var_6_0 ~= var_0_6.ACTIVE and arg_6_1 == BattleConst.TYPE_DUNGEON and g.core.config.dungeon_stage_info.get(self._id).quality == var_0_7.DungeonConst.STAGE_QUALITY_TYPE.NORMAL then
		if g.core.common.ModuleUnlock:isModuleUnlock(var_0_8.SKIP_DUNGEON) then
			var_6_0 = var_0_6.WAIT
			var_6_3 = 3
		end
	end

	return var_6_0, var_6_1, var_6_3
end

function BattleProxy:getSkip()
	return self._skipType, self._skipTips, self._skipWait
end

function BattleProxy:storeRecord(arg_8_1)
	arg_8_1.noShare = self._noShare
	self._record = arg_8_1
end

function BattleProxy:getRecord()
	return self._record
end

function BattleProxy:getBattleId()
	return self._id
end

function BattleProxy:setDebugStatus(arg_11_1)
	BattleConst.DEBUG = arg_11_1
	BattleConst.SKIP_ENABLE = arg_11_1
end

function BattleProxy:checkSkipBattle(arg_12_1)
	if arg_12_1.isClientSkip then
		return true
	end

	return false
end

function BattleProxy:getEnterBattleParam(arg_13_1)
	local var_13_0 = {}

	if arg_13_1.battle_id and self._battleList[arg_13_1.battle_id] then
		var_13_0.callback = handler(self, self._onBattleFinish)
		var_13_0.report = self._battleList[arg_13_1.battle_id]
		var_13_0.bgId = arg_13_1.bgId
		var_13_0.drop = arg_13_1.drop
		var_13_0.soundType = arg_13_1.soundType
		var_13_0.isVideo = arg_13_1.isVideo
		var_13_0.battleNode = arg_13_1.battleNode
		var_13_0.uiNode = arg_13_1.uiNode
		var_13_0.mapNode = arg_13_1.mapNode
		var_13_0.bgm = arg_13_1.bgm
		var_13_0.type = arg_13_1.type
		var_13_0.mapId = arg_13_1.mapId
		var_13_0.offsetX = arg_13_1.offsetX
		var_13_0.offsetY = arg_13_1.offsetY
		var_13_0.prefixScene = arg_13_1.prefixScene
		var_13_0.bossBaseInfo = arg_13_1.bossBaseInfo
		var_13_0.extraParams = arg_13_1.extraParams

		self:removeReport(arg_13_1.battle_id)
	elseif arg_13_1.report then
		var_13_0.callback = handler(self, self._onBattleFinish)
		var_13_0.report = arg_13_1.report
		var_13_0.command = arg_13_1.command
		var_13_0.bgId = arg_13_1.bgId
		var_13_0.drop = arg_13_1.drop
		var_13_0.guide = arg_13_1.guide
		var_13_0.soundType = arg_13_1.soundType
		var_13_0.isVideo = arg_13_1.isVideo
		var_13_0.battleNode = arg_13_1.battleNode
		var_13_0.uiNode = arg_13_1.uiNode
		var_13_0.mapNode = arg_13_1.mapNode
		var_13_0.bgm = arg_13_1.bgm
		var_13_0.type = arg_13_1.type
		var_13_0.mapId = arg_13_1.mapId
		var_13_0.offsetX = arg_13_1.offsetX
		var_13_0.offsetY = arg_13_1.offsetY
		var_13_0.prefixScene = arg_13_1.prefixScene
		var_13_0.bossBaseInfo = arg_13_1.bossBaseInfo
		var_13_0.extraParams = arg_13_1.extraParams
	end

	return var_13_0
end

function BattleProxy:enterBattle(arg_14_1)
	if self._taskId > 0 then
		return
	end

	self._battleType = arg_14_1.battleType or BattleConst.BATTLE_TYPE.PVE

	if self:checkSkipBattle(arg_14_1) then
		local var_14_0 = require("battle.core.BattleField").new()

		var_14_0:setInitData((self:getEnterBattleParam(arg_14_1) or {}).report)
		var_14_0:executeAll({})
		self:_onBattleFinish((var_14_0:getBattleResultByte()))
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_BATTLE_SKIP_NOTIFY_REFRESH)

		return
	end

	g.core.resource.ResourceManager:clearResource()
	g.core.resource.ResourceManager:luaGCCollect()

	self._record = nil
	self._type = arg_14_1.type or 0
	self._id = arg_14_1.id or 0
	self._ignoreResult = arg_14_1.ignoreResult
	self._inGuideBattle = false
	self._noShare = arg_14_1.noShare
	self._typeQuality = arg_14_1.typeQuality

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_START)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ENTER_BATTLE)

	self._hasGuide = 0

	if self._type == BattleConst.TYPE_DUNGEON and self._id == 10100 then
		self._hasGuide = 1
	end

	local var_14_1 = {}
	local var_14_2 = arg_14_1.battle_id

	if self._isPlaying then
		return false
	end

	if (not var_14_2 or not self._battleList[var_14_2]) and not arg_14_1.report then
		assert(false, "no report battle_id = " .. tostring(var_14_2))

		return false
	end

	self._isPlaying = true
	self._inBattle = true

	self:setForceExit(false)

	local var_14_3 = arg_14_1.skip
	local var_14_4 = arg_14_1.skipTxt
	local var_14_5 = arg_14_1.skipWait or 0

	if not var_14_3 then
		var_14_3, var_14_4, var_14_5 = self:_getSkipByType(self._type, arg_14_1.canSkip or false)
	end

	self._skipType = var_14_3
	self._skipTips = var_14_4
	self._skipWait = var_14_5

	if device.isWindows() and BattleConst.SKIP_ENABLE then
		self._skipType = var_0_6.ACTIVE
		self._skipWait = 0
	end

	local var_14_7

	if var_14_2 then
		var_14_7 = self._battleList[var_14_2] or arg_14_1.report
	end

	local function var_14_8()
		if var_14_2 and self._battleList[var_14_2] then
			var_14_1.callback = handler(self, self._onBattleFinish)
			var_14_1.report = var_14_7
			var_14_1.bgId = arg_14_1.bgId
			var_14_1.drop = arg_14_1.drop
			var_14_1.soundType = arg_14_1.soundType
			var_14_1.isVideo = arg_14_1.isVideo
			var_14_1.battleNode = arg_14_1.battleNode
			var_14_1.uiNode = arg_14_1.uiNode
			var_14_1.mapNode = arg_14_1.mapNode
			var_14_1.bgm = arg_14_1.bgm
			var_14_1.type = arg_14_1.type
			var_14_1.mapId = arg_14_1.mapId
			var_14_1.offsetX = arg_14_1.offsetX
			var_14_1.offsetY = arg_14_1.offsetY
			var_14_1.prefixScene = arg_14_1.prefixScene
			var_14_1.bossBaseInfo = arg_14_1.bossBaseInfo
			var_14_1.extraParams = arg_14_1.extraParams

			self:goBattle(var_14_1)
			self:removeReport(var_14_2)

			return true
		elseif arg_14_1.report then
			var_14_1.callback = handler(self, self._onBattleFinish)
			var_14_1.report = var_14_7
			var_14_1.command = arg_14_1.command
			var_14_1.bgId = arg_14_1.bgId
			var_14_1.drop = arg_14_1.drop
			var_14_1.guide = arg_14_1.guide
			var_14_1.soundType = arg_14_1.soundType
			var_14_1.isVideo = arg_14_1.isVideo
			var_14_1.battleNode = arg_14_1.battleNode
			var_14_1.uiNode = arg_14_1.uiNode
			var_14_1.mapNode = arg_14_1.mapNode
			var_14_1.bgm = arg_14_1.bgm
			var_14_1.type = arg_14_1.type
			var_14_1.mapId = arg_14_1.mapId
			var_14_1.offsetX = arg_14_1.offsetX
			var_14_1.offsetY = arg_14_1.offsetY
			var_14_1.prefixScene = arg_14_1.prefixScene
			var_14_1.bossBaseInfo = arg_14_1.bossBaseInfo
			var_14_1.extraParams = arg_14_1.extraParams

			self:goBattle(var_14_1)

			return true
		else
			assert(false, "no report battle_id = " .. tostring(var_14_2))

			return false
		end
	end

	local var_14_9 = {}

	for iter_14_0, iter_14_1 in ipairs(var_14_7.own_teams) do
		if iter_14_1.combo and iter_14_1.combo.tokens then
			self:_preloadTokens(iter_14_1.combo.tokens)
		end

		local var_14_10 = self:isMonster(iter_14_1, var_14_7.play_id)

		for iter_14_2, iter_14_3 in ipairs(iter_14_1.units) do
			self:_calInfoByBaseId(var_14_10, iter_14_3, iter_14_1.user, var_14_9)
		end

		for iter_14_4, iter_14_5 in ipairs(iter_14_1.pets or {}) do
			local var_14_11 = var_0_0.get(iter_14_5)
			local var_14_12 = var_0_10.fetch(var_14_11.advance_id)

			if var_14_12 then
				self:addResList(var_14_12.res_id, var_14_9)
			end

			g.core.sound.SoundManager:cacheBattleBanks(var_14_11.resource)
			table.insert(var_14_9, {
				resId = var_14_11.resource,
				resType = g.core.common.PackageRes.resType.BATTLE
			})
		end

		for iter_14_6, iter_14_7 in ipairs(iter_14_1.succubas or {}) do
			table.insert(var_14_9, {
				resId = var_0_2.get(var_0_1.get(iter_14_7.id).advance_id).res,
				resType = g.core.common.PackageRes.resType.KNIGHT
			})
		end
	end

	for iter_14_8, iter_14_9 in ipairs(var_14_7.enemy_teams) do
		if iter_14_9.combo and iter_14_9.combo.tokens then
			self:_preloadTokens(iter_14_9.combo.tokens)
		end

		local var_14_13 = self:isMonster(iter_14_9, var_14_7.play_id)

		for iter_14_10, iter_14_11 in ipairs(iter_14_9.units) do
			self:_calInfoByBaseId(var_14_13, iter_14_11, iter_14_9.user, var_14_9)
		end

		for iter_14_12, iter_14_13 in ipairs(iter_14_9.pets or {}) do
			local var_14_14 = var_0_0.get(iter_14_13)

			g.core.sound.SoundManager:cacheBattleBanks(var_14_14.resource)
			table.insert(var_14_9, {
				resId = var_14_14.resource,
				resType = g.core.common.PackageRes.resType.BATTLE
			})
		end

		for iter_14_14, iter_14_15 in ipairs(iter_14_9.succubas or {}) do
			table.insert(var_14_9, {
				resId = var_0_2.get(var_0_1.get(iter_14_15.id).advance_id).res,
				resType = g.core.common.PackageRes.resType.KNIGHT
			})
		end
	end

	local var_14_15, var_14_16 = g.core.common.PackageRes:checkResListIsNeedUpgrade(var_14_9)

	if var_14_15 then
		g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_PACKAGE_LIST_DOWNLOAD_FINISH, handler(self, self._downloadFinish), self)

		self._taskId = var_14_16
		self._waitData = {
			executeBattle = var_14_8,
			params = arg_14_1
		}

		return
	end

	if arg_14_1.cloudLoading == true or arg_14_1.cloudLoading == nil then
		self:showBattleLoading(var_14_8)
	elseif arg_14_1.cloudLoading == false then
		var_14_8()
		self:playBattle()
	end
end

function BattleProxy:_preloadTokens(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		g.core.sound.SoundManager:cacheBattleBanks(g.core.config.unite_token_info.get(iter_16_1).res_id)
	end
end

function BattleProxy:_downloadFinish(arg_17_1, arg_17_2, arg_17_3)
	if (arg_17_3.taskId or 0) == self._taskId and self._waitData then
		if self._waitData.params.cloudLoading == true or self._waitData.params.cloudLoading == nil then
			self:showBattleLoading(self._waitData.executeBattle)
		elseif self._waitData.params.cloudLoading == false then
			self._waitData.executeBattle()
			self:playBattle()
		end

		g.core.event.EventManager:removeListenerWithTarget(self)

		self._waitData = nil
		self._taskId = 0
	end
end

function BattleProxy:isMonster(arg_18_1, arg_18_2)
	return arg_18_1.monster_team_id and (not arg_18_1.monster_team_type or arg_18_1.monster_team_type == 0) and arg_18_1.monster_team_id > 0 and arg_18_2 ~= BattleConst.ServerPlayId.EXPLORATION_BOSS
end

function BattleProxy:_calInfoByBaseId(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = ((arg_19_1 or nil) and (g.core.config.monster_info or g.core.config.knight_info)).get(arg_19_2.id)

	self:addResList(var_19_0.res_id, arg_19_4)

	local var_19_1 = var_0_10.fetch(var_19_0.advance_id)

	if var_19_1 then
		self:addResList(var_19_1.res_id, arg_19_4)
		g.core.sound.SoundManager:cacheBattleBanks(var_19_1.res_id)
	end

	g.core.sound.SoundManager:cacheBattleBanks(var_19_0.res_id)

	if not arg_19_1 and var_19_0.type == 1 and arg_19_3 then
		if arg_19_3.dress_id and arg_19_3.dress_id ~= 0 then
			self:addResList(var_19_0.sex == 0 and g.core.config.dress_info.get(arg_19_3.dress_id).woman_res_id or g.core.config.dress_info.get(arg_19_3.dress_id).man_res_id, arg_19_4)
		elseif arg_19_2.skin and arg_19_2.skin > 0 then
			self:addResList(g.core.config.skin_info.get(arg_19_2.skin).res, arg_19_4)
		end
	elseif arg_19_2.skin and arg_19_2.skin > 0 then
		self:addResList(g.core.config.skin_info.get(arg_19_2.skin).res, arg_19_4)
	end
end

function BattleProxy:addResList(arg_20_1, arg_20_2)
	table.insert(arg_20_2, {
		resId = var_0_11.get(arg_20_1).fight_id,
		resType = g.core.common.PackageRes.resType.BATTLE
	})
end

function BattleProxy:showBattleLoading(arg_21_1)
	self._isLoading = true

	local var_21_0 = g.core.layer.LayerManager:getTopLayer()

	var_21_0:setTouchable(true)

	local var_21_1, var_21_2 = g.core.common.GlobalFunc.addCommonLoadingComp()

	g.core.sound.SoundManager:playSound(var_0_7.SoundConst.Sound.BATTLE_CLOUD)
	var_21_2:setHook("start", function()
		var_21_2:setPaused(true)
		g.core.common.Scheduler:newScheduleOnce(function(arg_23_0)
			if not tolua.isnull(var_21_1) and not tolua.isnull(var_21_2) then
				var_21_2:setPaused(false)
			end
		end, 0.5)

		if arg_21_1 then
			arg_21_1()
		end
	end)
	var_21_2:setHook("end", function()
		self:playBattle()
		var_21_0:setTouchable(false)
		var_21_1:removeFromParent()
	end)
	var_21_2:play()
end

function BattleProxy:goBattle(arg_25_1)
	if not arg_25_1.report.is_auto then
		g.core.battle.BattleShowResult:resetData()
	end

	local var_25_0 = require("app.view.battle.BattleLayer").new(arg_25_1)

	if arg_25_1.battleNode then
		self._useOwnNode = true
		self._battleNode = arg_25_1.battleNode
	else
		self._useOwnNode = false
		self._battleNode = g.core.layer.LayerManager:getCocosNode()
	end

	self._prefixScene = arg_25_1.prefixScene

	if arg_25_1.soundType then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_BGM_CHANGE, false, {
			type = arg_25_1.soundType
		})
	end

	self._battleNode:addChild(var_25_0)

	self._battleLayer = var_25_0

	if not self._useOwnNode then
		local var_25_1 = var_25_0:getTokenIds()

		self._battleScene = self._prefixScene and g.core.module.ModuleManager:replaceModule(g.view.entrance.BATTLE, var_25_1) or g.core.module.ModuleManager:pushModule(g.view.entrance.BATTLE, var_25_1)
	end

	self._battleLayer:onBattleGuideStart()

	return true
end

function BattleProxy:isHaveBattleScene()
	return not self._useOwnNode
end

function BattleProxy:playBattle()
	if self._battleLayer then
		self._isLoading = false

		self._battleLayer:play()
	end
end

function BattleProxy:skipBattle()
	if self._battleLayer then
		self._battleLayer:skipPVE()
	end
end

function BattleProxy:isInGuide()
	return self._inGuideBattle
end

function BattleProxy:setInGuide()
	self._inGuideBattle = true
end

function BattleProxy:fastBattle(arg_31_1)
	if not self._battleList[arg_31_1] then
		return
	end

	local var_31_0, var_31_1 = self:fastFight(self._battleList[arg_31_1], 1)

	g.core.network.GameNetProxy:send_C2S_CheckBattleResult({
		result = var_31_1:getBattleResultByte()
	})

	return var_31_0.isWin
end

function BattleProxy:fastBattleWithoutCheck(arg_32_1)
	if not self._battleList[arg_32_1] then
		return
	end

	local var_32_0, var_32_1 = self:fastFight(self._battleList[arg_32_1], 1)

	return var_32_0.is_win
end

function BattleProxy:fastFight(arg_33_1, arg_33_2)
	local var_33_0 = require("battle.core.BattleField").new()
	local var_33_1 = var_33_0:getBattleData()

	var_33_0:setIsTestFight()

	if arg_33_2 then
		function var_33_1.getHighIdentity()
			return arg_33_2
		end
	end

	var_33_0:setInitData(arg_33_1)
	var_33_0:setAuto(true)
	var_33_0:autoExecuteAll()

	local var_33_2 = var_33_0:getBattleResult()

	if var_33_2.is_report ~= 0 and BATTLE_PLATFORM == CLIENT and device.isWindowsDebug() then
		local var_33_3 = io.open("battle_report_error" .. g.core.common.ServerTime:getTime() .. ".txt", "w")

		var_33_3:write(json.encode(arg_33_1))
		var_33_3:close()
	end

	if arg_33_2 then
		var_33_1.getHighIdentity = var_33_1.getHighIdentity
	end

	return var_33_2, var_33_0
end

function BattleProxy:getBattleType()
	return self._battleType
end

function BattleProxy:getType()
	return self._type
end

function BattleProxy:getTypeQuality()
	return self._typeQuality
end

function BattleProxy:getBattleLayer()
	return self._battleLayer
end

function BattleProxy:getBattleSpeed()
	if self._battleLayer then
		return self._battleLayer:getCurSpeed()
	end
end

function BattleProxy:getIsBattleAuto()
	if self._battleLayer then
		return self._battleLayer:getAuto()
	end
end

function BattleProxy:battleFinish()
	self._isPlaying = false
	self._inGuideBattle = false

	self:setUIShow(false)
end

function BattleProxy:isPlaying()
	return self._isPlaying
end

function BattleProxy:isLoading()
	return self._isLoading
end

function BattleProxy:isInBattle()
	return self._inBattle
end

function BattleProxy:resetInBattle()
	self._inBattle = false
end

function BattleProxy:_onBattleFinish(arg_46_1)
	self._isPlaying = false

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_END)

	if self._battleType == BattleConst.BATTLE_TYPE.PVE then
		g.core.network.GameNetProxy:send_C2S_CheckBattleResult({
			result = arg_46_1
		})
	elseif self._ignoreResult then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_FAKE_PVP_BATTLE_RESULT, true, nil)
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_FAKE_PVP_BATTLE_RESULT, true, arg_46_1)
	end
end

function BattleProxy:clearBattle()
	if self._battleLayer then
		self._battleLayer:cleanup()
		self._battleLayer:removeFromParent(true)

		self._battleLayer = nil
		self._battleScene = nil
	end

	self._inBattle = false
end

function BattleProxy:clearUILayer()
	if self._inBattle then
		self:clearBattle()
	end
end

function BattleProxy:exitBattle()
	local var_49_0 = DebugCommon.getDebugGlobalValueByKey("game_time_scale")

	if var_49_0 and type(var_49_0) == "number" then
		cc.Director:getInstance():getScheduler():setTimeScale(var_49_0)
	else
		cc.Director:getInstance():getScheduler():setTimeScale(1)
	end

	self:battleFinish()
	self:clearBattle()

	if self._useOwnNode then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_BATTLE_EXIT, true, nil)
	elseif self._prefixScene and self._prefixScene.entranceModule then
		g.core.module.ModuleManager:replaceModule(self._prefixScene.entranceModule, self._prefixScene.entranceData)
	else
		g.core.module.ModuleManager:popComponent()
	end

	self._battleScene = nil
	self._prefixScene = nil
end

function BattleProxy:isPaused()
	if self._battleLayer then
		return self._battleLayer:isCurPaused()
	end
end

function BattleProxy:pause()
	if self._battleLayer then
		self._battleLayer:setPause(true)
	end
end

function BattleProxy:resume()
	if self._battleLayer then
		self._battleLayer:setPause(false)
	end
end

function BattleProxy:fightPause()
	if self._battleLayer then
		self._battleLayer:setFightingPause(true)
	end
end

function BattleProxy:fightResume()
	if self._battleLayer then
		self._battleLayer:setFightingPause(false)
	end
end

function BattleProxy:setSkillShow(arg_55_1, arg_55_2)
	if self._battleLayer then
		self._battleLayer:setSkillShow(arg_55_1, arg_55_2)

		if arg_55_2 then
			self:setSkillUIShow(arg_55_2)
		end
	end
end

function BattleProxy:setSkillUIShow(arg_56_1)
	if self._battleLayer then
		self._battleLayer:setSkillUIShow(arg_56_1)
	end
end

function BattleProxy:setUIShow(arg_57_1)
	if self._battleLayer then
		self._battleLayer:showUI(arg_57_1)
	end
end

function BattleProxy:getUILayerSubComp(arg_58_1)
	return self._battleLayer:getUILayerSubComp(arg_58_1)
end

function BattleProxy:dispatchEvent(arg_59_1, arg_59_2, arg_59_3)
	local var_59_0 = {
		self._type,
		self._id,
		arg_59_2
	}
	local var_59_1 = arg_59_2
	local var_59_2

	if arg_59_1 == g.core.event.enum.EVENT_BATTLE_ROUND_END then
		var_59_0 = {
			self._type,
			self._id,
			unpack(arg_59_2)
		}
		var_59_1 = arg_59_2[1]
		var_59_2 = arg_59_3 or false
	end

	g.core.event.EventManager:dispatchEvent(arg_59_1, var_59_2, {
		story = var_59_0,
		value = var_59_1
	})

	if arg_59_1 == g.core.event.enum.EVENT_BATTLE_NEW_ANGER and self._hasGuide == 1 then
		if arg_59_2.id == 200000 or arg_59_2.id == 210000 then
			self:showGuide(1, arg_59_2.rect)
		end
	elseif arg_59_1 == g.core.event.enum.EVENT_BATTLE_NEW_SKILL and self._hasGuide == 2 then
		self:showGuide(3, arg_59_2.rect)
	end
end

function BattleProxy:touchSkill(arg_60_1, arg_60_2)
	if self._battleLayer then
		self._battleLayer:touchSkill(arg_60_1, arg_60_2)
	end
end

function BattleProxy:clickSkill(arg_61_1)
	if self._battleLayer then
		self._battleLayer:clickSkill(arg_61_1)
	end
end

function BattleProxy:playVidio(arg_62_1)
	g.core.network.GameNetProxy:send_C2S_GetBattleVideo({
		battle_id = arg_62_1
	})
end

function BattleProxy:playVidioBattle(arg_63_1)
	if not arg_63_1 then
		return
	end

	local var_63_0 = arg_63_1.battle_report
	local var_63_1 = 106
	local var_63_2 = BattleConst.TYPE_ARENA

	if arg_63_1.battle_report.play_id == BattleConst.ServerPlayId.PEAK_ARENA then
		var_63_1 = var_0_7.PeakArenaConst.BATTLE_BG_ID
		var_63_2 = BattleConst.TYPE_PEAK_ARENA_PVP
	end

	self:enterBattle({
		isVideo = true,
		cloudLoading = true,
		battleType = BattleConst.BATTLE_TYPE.VIDEO,
		type = var_63_2,
		report = var_63_0,
		command = arg_63_1.player_command,
		skip = var_0_6.ACTIVE,
		bgId = var_63_1
	})
end

function BattleProxy:showBattleErrorTips(arg_64_1, arg_64_2, arg_64_3)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_FIGHT_SERVER_BACK_ERROR)

	if arg_64_2 == 244 then
		return
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new({
		type = 1,
		text = arg_64_1,
		text_cancel = g.core.lang:get(110044),
		handler_cancel = function()
			self:exitBattle()
		end
	}), {
		system = true
	})

	local var_64_0, var_64_1 = g.core.platform.PlatformProxy:getVersion()

	if arg_64_2 == 29 and arg_64_3 then
		local var_64_2 = self:getDungeonBattleTimeStamp()

		if not var_64_2[1] then
			-- block empty
		end

		if not var_64_2[2] then
			-- block empty
		end

		if not g.core.platform.ServerListProxy:getSelectedServer().id then
			-- block empty
		end
	elseif arg_64_2 and arg_64_3 then
		g.core.platform.BuglyProxy:error(string.format("Error! ret: %s(%s) msgId: %s battleType:%s localVersion %s packageVersion%s", tostring(arg_64_2), g.core.lang:getRet(arg_64_2), tostring(arg_64_3), tostring(self:getType() or 0), tostring(var_64_0), tostring(var_64_1)))
	end
end

function BattleProxy:testBattle(arg_66_1, arg_66_2, arg_66_3, arg_66_4)
	local var_66_0
	local var_66_1
	local var_66_2 = BattleConst.TYPE_DUNGEON

	if arg_66_4 then
		var_66_0 = require("app.core.network.ProtoBuilder"):decodeByMsgName("BattleReport", (from_base64((require("app.view.battle.test.base64Data")))))
	else
		var_66_0 = arg_66_3 and require("app.view.battle.test." .. arg_66_3) or require("app.view.battle.test.testData_Jgame2")

		if arg_66_3 == "testData_boss1" then
			var_66_1 = 6
			var_66_2 = BattleConst.TYPE_REBEL
		elseif arg_66_3 == "testData_boss2" then
			var_66_1 = 5
			var_66_2 = BattleConst.TYPE_REBEL
		elseif arg_66_3 == "testData_boss3" then
			var_66_1 = 7
			var_66_2 = BattleConst.TYPE_REBEL
		end
	end

	self:enterBattle({
		skip = 2,
		battleType = 2,
		ignoreResult = true,
		cloudLoading = false,
		report = var_66_0,
		type = var_66_2,
		battleNode = arg_66_1,
		uiNode = arg_66_2,
		bgId = var_66_1
	})
end

function BattleProxy:playTest()
	local var_67_0 = math.random(os.time())

	math.randomseed(var_67_0)

	self.testSeed = var_67_0

	local var_67_1 = {
		battle_id = math.random(100000000)
	}

	var_67_1.atk_type = 2
	var_67_1.is_auto = true

	local var_67_2 = {}
	local var_67_3 = {}

	var_67_2[1] = self:randomTeam()
	var_67_3[1] = self:randomTeam()

	while math.random(10) > 8 do
		var_67_2[#var_67_2 + 1] = self:randomTeam()
	end

	while math.random(10) > 5 do
		var_67_3[#var_67_3 + 1] = self:randomTeam()
	end

	var_67_1.own_teams = var_67_2
	var_67_1.enemy_teams = var_67_3

	if math.random(10) > 6 then
		local var_67_4 = g.core.config.battle_rating_info.indexOf((math.random(g.core.config.battle_rating_info.getLength()))).id

		if var_67_4 > 1100 then
			var_67_1.win_condition = var_67_4
		end
	end

	local var_67_5 = {}

	for iter_67_0 = 1, 50 do
		var_67_5[iter_67_0] = math.random(1000) - 1
	end

	var_67_1.random_seeds = var_67_5
	var_67_1.random_seed = math.random(100)

	local var_67_6 = require("battle.core.proto.ProtoBuilder"):encodeByMsgName("BattleReport", var_67_1)
	local var_67_7 = require("battle.core.BattleField").new()

	var_67_7:setInitDataBytes(var_67_6)

	local var_67_9

	::label_67_0::

	if 0 == 0 then
		repeat
			local var_67_8 = var_67_7:execute()

			goto label_67_0
		until true

		var_67_9 = {
			report = var_67_6
		}
	end

	var_67_9.result = var_67_7:getBattleResultByte()

	g.core.network.GameNetProxy:send_C2S_ClientTestBattle(var_67_9)
end

function BattleProxy:randomTeam()
	local var_68_0 = {}
	local var_68_1 = {}

	for iter_68_0 = 1, 6 do
		local var_68_2 = self:randomKnight()

		var_68_2.pos = iter_68_0
		var_68_1[iter_68_0] = var_68_2
	end

	var_68_0.units = var_68_1

	local var_68_3 = {}
	local var_68_4 = {}
	local var_68_5 = {}

	for iter_68_1 = 1, 4 do
		var_68_4[iter_68_1] = g.core.config.unite_token_info.indexOf((math.random(g.core.config.unite_token_info.getLength()))).id
		var_68_5[iter_68_1] = math.random(10) - 1
	end

	var_68_3.tokens = var_68_4
	var_68_3.level = var_68_5

	local var_68_6 = {
		{
			type = 601,
			value = math.random(200)
		},
		{
			type = 602,
			value = 200
		},
		{
			type = 603,
			value = math.random(10)
		},
		{
			type = 604,
			value = math.random(10)
		},
		{
			type = 605,
			value = math.random(20)
		}
	}

	for iter_68_2 = 6, 11 do
		var_68_6[iter_68_2] = {
			type = 600 + iter_68_2,
			value = math.random(1000)
		}
	end

	var_68_3.attrs = var_68_6
	var_68_0.combo = var_68_3
	var_68_0.fight_value = math.random(100000)

	return var_68_0
end

function BattleProxy:randomKnight()
	local var_69_0 = {
		id = g.core.config.knight_info.indexOf((math.random(g.core.config.knight_info.getLength()))).id,
		skill_level1 = math.random(10) - 1,
		skill_level2 = math.random(10) - 1
	}
	local var_69_1 = {}
	local var_69_2 = math.random(100000)

	var_69_1[1] = {
		type = 1,
		value = var_69_2
	}
	var_69_1[2] = {
		type = 2,
		value = math.random(1000)
	}
	var_69_1[3] = {
		type = 3,
		value = math.random(500)
	}
	var_69_1[4] = {
		type = 3,
		value = math.random(500)
	}
	var_69_1[5] = {
		type = 401,
		value = math.random(5) - 1
	}
	var_69_1[6] = {
		type = 402,
		value = math.random(4)
	}
	var_69_1[7] = {
		type = 701,
		value = var_69_2
	}

	for iter_69_0, iter_69_1 in pairs((require("battle.const.BattleAttr"))) do
		if iter_69_1 > 100 and iter_69_1 < 400 or iter_69_1 > 500 and iter_69_1 < 600 then
			var_69_1[#var_69_1 + 1] = {
				type = iter_69_1,
				value = math.random(1000) - 1
			}
		end
	end

	var_69_0.attrs = var_69_1

	return var_69_0
end

function BattleProxy:playTestTeamBattle(arg_70_1, arg_70_2, arg_70_3, arg_70_4, arg_70_5, arg_70_6)
	local var_70_0 = {}

	var_70_0.battle_id = 10001
	var_70_0.atk_type = 1
	var_70_0.is_auto = false

	local var_70_1 = {}
	local var_70_2 = {}

	var_70_1[1] = self:getTestTeam(arg_70_1, 1)
	var_70_1[2] = self:getTestTeam(arg_70_1, 2)
	var_70_2[1] = self:getTestTeam(arg_70_2, 1)
	var_70_2[2] = self:getTestTeam(arg_70_2, 2)
	var_70_0.own_teams = var_70_1
	var_70_0.enemy_teams = var_70_2
	var_70_0.random_seeds = {
		500
	}

	self:enterBattle({
		guide = true,
		skip = 0,
		battleType = 2,
		report = var_70_0,
		ignoreResult = arg_70_3,
		bgId = arg_70_4,
		type = BattleConst.TYPE_GAME_START,
		id = arg_70_5,
		cloudLoading = arg_70_6,
		soundType = (arg_70_2 == 110040 or nil) and 3
	})
end

function BattleProxy:getTestTeam(arg_71_1, arg_71_2)
	arg_71_2 = arg_71_2 or 1

	local var_71_0 = g.core.config.monster_team_info.get(arg_71_1, arg_71_2)
	local var_71_1 = {}
	local var_71_2 = {}

	var_71_1.units = var_71_2
	var_71_1.fight_value = 0

	local var_71_3 = {}

	var_71_1.combo = var_71_3
	var_71_1.monster_team_id = arg_71_1

	for iter_71_0 = 1, 6 do
		local var_71_4 = var_71_0[table.concat({
			"monster_",
			iter_71_0
		})]

		if var_71_4 > 0 then
			local var_71_5 = g.core.config.guide_monster_info.fetch(var_71_4) or g.core.config.monster_info_ex.get(var_71_4)
			local var_71_6 = {
				pos = iter_71_0,
				id = var_71_4
			}

			var_71_6.star = 0

			local var_71_7 = {}

			var_71_6.attrs = var_71_7
			var_71_7[#var_71_7 + 1] = {
				type = 1,
				value = var_71_5.initial_hp
			}
			var_71_7[#var_71_7 + 1] = {
				type = 701,
				value = var_71_5.initial_hp
			}
			var_71_7[#var_71_7 + 1] = {
				type = 2,
				value = var_71_5.attack
			}
			var_71_7[#var_71_7 + 1] = {
				type = 3,
				value = var_71_5.phy_defence
			}
			var_71_7[#var_71_7 + 1] = {
				type = 4,
				value = var_71_5.mag_defence
			}
			var_71_7[#var_71_7 + 1] = {
				type = 101,
				value = var_71_5.accuracy_rate
			}
			var_71_7[#var_71_7 + 1] = {
				type = 102,
				value = var_71_5.dodge_rate
			}
			var_71_7[#var_71_7 + 1] = {
				type = 103,
				value = var_71_5.crit_rate
			}
			var_71_7[#var_71_7 + 1] = {
				type = 104,
				value = var_71_5.harden_rate
			}
			var_71_7[#var_71_7 + 1] = {
				type = 105,
				value = var_71_5.block_rate
			}
			var_71_7[#var_71_7 + 1] = {
				type = 106,
				value = var_71_5.pierce_rate
			}
			var_71_7[#var_71_7 + 1] = {
				type = 207,
				value = var_71_5.damage_add
			}
			var_71_7[#var_71_7 + 1] = {
				type = 208,
				value = var_71_5.damage_dec
			}
			var_71_7[#var_71_7 + 1] = {
				type = 203,
				value = var_71_5.crit_damage_add
			}
			var_71_7[#var_71_7 + 1] = {
				type = 201,
				value = var_71_5.block_damage_dec
			}
			var_71_7[#var_71_7 + 1] = {
				type = 401,
				value = var_71_5.initial_anger
			}
			var_71_7[#var_71_7 + 1] = {
				type = 402,
				value = var_71_5.anger_recover
			}
			var_71_7[#var_71_7 + 1] = {
				type = 518,
				value = var_71_5.anti_reduce_anger
			}
			var_71_7[#var_71_7 + 1] = {
				type = 520,
				value = var_71_5.anti_faint
			}
			var_71_7[#var_71_7 + 1] = {
				type = 901,
				value = var_71_5.monster_knight_damage_add
			}
			var_71_7[#var_71_7 + 1] = {
				type = 902,
				value = var_71_5.monster_knight_damage_dec
			}
			var_71_7[#var_71_7 + 1] = {
				type = 903,
				value = var_71_5.monster_combo_damage_add
			}
			var_71_7[#var_71_7 + 1] = {
				type = 904,
				value = var_71_5.monster_combo_damage_dec
			}

			if var_71_5.advance_id == 210000 or var_71_5.advance_id == 200000 then
				local var_71_8 = g.core.model.User:getName()

				if var_71_8 ~= 0 then
					var_71_6.name = var_71_8
				end
			end

			var_71_2[#var_71_2 + 1] = var_71_6
		end
	end

	var_71_3.tokens = {}

	for iter_71_1 = 1, 4 do
		local var_71_9 = var_71_0[table.concat({
			"unite_token_",
			iter_71_1
		})]

		if var_71_9 > 0 then
			var_71_3.tokens[#var_71_3.tokens + 1] = var_71_9
		end
	end

	local var_71_10 = {}

	var_71_3.attrs = var_71_10
	var_71_10[#var_71_10 + 1] = {
		type = 601,
		value = var_71_0.initial_combo
	}
	var_71_10[#var_71_10 + 1] = {
		type = 602,
		value = var_71_0.maximum_combo
	}
	var_71_10[#var_71_10 + 1] = {
		type = 603,
		value = var_71_0.combo_recover_action
	}
	var_71_10[#var_71_10 + 1] = {
		type = 605,
		value = var_71_0.combo_recover_round
	}
	var_71_10[#var_71_10 + 1] = {
		type = 610,
		value = var_71_0.combo_damage_add
	}
	var_71_10[#var_71_10 + 1] = {
		type = 611,
		value = var_71_0.combo_damage_dec
	}

	return var_71_1
end

function BattleProxy:showGuide(arg_72_1, arg_72_2)
	do return end

	local var_72_0 = g.core.common.Storage:load("battle.json") or {}

	if arg_72_1 <= (var_72_0.guide or 0) then
		return
	else
		var_72_0.guide = arg_72_1

		g.core.common.Storage:save("battle.json", var_72_0)
	end

	local var_72_1 = g.core.layer:LayerManager()
	local var_72_2 = fgui.UIPackage:createObject("base", "BasePlaceHolderComp2")

	var_72_2:setSize(display.width * 2, display.height * 2)
	var_72_2:setPivot(0.5, 0.5, true)
	var_72_2:setPosition(display.width, display.height)
	var_72_1:addChild(var_72_2)
	var_72_2:addClickListener(function()
		return
	end)
	fgui.UIPackage:addPackage("ui/guide/guide")
	self:fightPause()

	local var_72_3 = {
		{
			y = -140,
			x = 20
		},
		{
			y = -140,
			x = 20
		},
		{
			y = 100,
			x = 0
		}
	}

	if not self._renderTexture then
		self._renderTexture = cc.RenderTexture:create(display.width, display.height)

		var_72_1:addNode(self._renderTexture, -1)
		self._renderTexture:setPosition(display.width, display.height)

		local var_72_4 = cc.LayerColor:create(cc.c4b(255, 255, 255, 0), arg_72_2.width, arg_72_2.height)

		var_72_4:setBlendFunc({
			src = GL_ONE,
			dst = GL_ZERO
		})
		var_72_1:addNode(var_72_4)
		var_72_4:setVisible(false)
		var_72_4:setPosition(arg_72_2.x, arg_72_2.y)
		self._renderTexture:setVisible(true)
		var_72_4:setVisible(true)
		self._renderTexture:beginWithClear(0, 0, 0, 0.7)
		var_72_4:visit()
		self._renderTexture:endToLua()
		var_72_4:setVisible(false)
	else
		self._renderTexture:setVisible(true)
	end

	local var_72_5 = fgui.UIPackage:createObject("guide", "GuideDialogComp")

	var_72_1:addChild(var_72_5)
	var_72_5:setTouchable(false)
	var_72_5:setTitle((g.core.lang:getRealRichTxt(g.core.lang:get(110050 + arg_72_1))))
	var_72_5:setPosition(display.width + var_72_3[arg_72_1].x, display.height + var_72_3[arg_72_1].y)
	var_72_2:addClickListener(function()
		var_72_5:removeFromParent()
		var_72_2:removeFromParent()
		self._renderTexture:setVisible(false)

		self._hasGuide = 0

		self:fightResume()
	end)

	if arg_72_1 == 1 then
		g.core.sound.SoundManager:playSound(g.core.common.Path:getVoice("Vo_Chapter2_Guide_07"))
	end
end

function BattleProxy:setForceExit(arg_75_1)
	self._forceExit = arg_75_1
end

function BattleProxy:getForceExit()
	return self._forceExit
end

function BattleProxy:getGuildFightReport(arg_77_1)
	return self._battleList[arg_77_1]
end

function BattleProxy:getBioTeamResults(arg_78_1)
	if not self._battleList[arg_78_1] then
		return
	end

	local var_78_0 = require("battle.core.BattleField").new()

	var_78_0:setInitData(self._battleList[arg_78_1])
	var_78_0:setAuto(true)

	local function var_78_1()
		local var_79_0 = var_78_0:getBattleData()
		local var_79_1 = {
			isWin = var_78_0:getWinner() == 1
		}

		var_79_1.hps1, var_79_1.knights1 = var_79_0:packKnightData(1)
		var_79_1.hps2, var_79_1.knights2 = var_79_0:packKnightData(2)

		return var_79_1
	end

	local var_78_2 = {}

	repeat
		local var_78_4 = var_78_0:execute(true)
		local var_78_5

		if (var_78_0:getAttackIndex(1) or 1) > 1 and not false then
			var_78_5 = true

			table.insert(var_78_2, (var_78_1()))
		end
	until var_78_4 ~= var_78_0.BATTLE_FIGHTING

	table.insert(var_78_2, (var_78_1()))

	return var_78_2, clone(self._battleList[arg_78_1])
end

function BattleProxy:testBattleResult()
	dump(require("app.core.network.ProtoBuilder"):decodeByMsgName("BattleResult", (from_base64((require("app.view.battle.test.base64Result"))))), "GM战斗的结果")
end

function BattleProxy:battleAndCheckResult()
	local var_81_0 = require("battle.core.BattleField").new()

	var_81_0:setInitData((require("app.core.network.ProtoBuilder"):decodeByMsgName("BattleReport", (from_base64((require("app.view.battle.test.base64Data")))))))
	var_81_0:setAuto(false)
	var_81_0:checkResult((require("app.core.network.ProtoBuilder"):decodeByMsgName("BattleResult", (from_base64((require("app.view.battle.test.base64Result")))))))
	dump(var_81_0:getBattleResult(), "战斗结果")
end

function BattleProxy:checkResult()
	local var_82_0 = require("battle.core.BattleField").new()

	var_82_0:setInitDataBytes((from_base64((require("app.view.battle.test.base64Data")))))

	local BattleEditorData = require("app.view.module.debug.model.BattleEditorData")
	local var_82_2 = os.time()

	BattleEditorData:saveToReport(table.concat({
		"check_result",
		var_82_2
	}), (var_82_0:checkResult((require("app.core.network.ProtoBuilder"):decodeByMsgName("BattleResult", (from_base64((require("app.view.battle.test.base64Result")))))))))
	BattleEditorData:saveToReport(table.concat({
		"just_run_result",
		var_82_2
	}), (var_82_0:getBattleResult()))
end

function BattleProxy:printResult()
	require("app.view.module.debug.model.BattleEditorData"):saveToReport(table.concat({
		"battleResult",
		(os.time())
	}), (require("app.core.network.ProtoBuilder"):decodeByMsgName("BattleResult", (from_base64((require("app.view.battle.test.base64Result")))))))
end

function BattleProxy:playBattleReport()
	self:enterBattle({
		cloudLoading = false,
		skip = 2,
		type = 1,
		bgId = 101,
		battleType = 2,
		ignoreResult = true,
		report = require("app.core.network.ProtoBuilder"):decodeByMsgName("BattleReport", (from_base64((require("app.view.battle.test.base64Data")))))
	})
end

function BattleProxy:printReport()
	require("app.view.module.debug.model.BattleEditorData"):saveToReport(table.concat({
		"battleReport",
		(os.time())
	}), (require("app.core.network.ProtoBuilder"):decodeByMsgName("BattleReport", (from_base64((require("app.view.battle.test.base64Data")))))))
end

local var_0_13 = {}

function BattleProxy:addDungeonBattleTimeStamp()
	if #var_0_13 >= 2 then
		table.remove(var_0_13, 1)
	end

	table.insert(var_0_13, os.time())
end

function BattleProxy:getDungeonBattleTimeStamp()
	return var_0_13
end

return BattleProxy
