local var_0_0 = g.core.const.ConstMgr.outpostConst
local var_0_1 = g.core.model.User.outpostData
local OutpostEvent = require("app.view.module.outpost.const.OutpostEvent")
local OutpostCommon = require("app.view.module.outpost.const.OutpostCommon")
local var_0_4 = g.core.config.outpost_tips_info
local OutpostVirtualWorld = require("app.view.module.outpost.simulationWorld.OutpostVirtualWorld")
local OutpostGameStage = class("OutpostGameStage", require("app.fairyGUI.outpost.UI_OutpostGameStage"), function()
	return fgui.GComponent:create({
		resName = "OutpostGameStage",
		pkgPath = "ui/outpost/outpost",
		isFullScreen = true,
		pkgName = "outpost"
	}, ...)
end)

function OutpostGameStage:ctor(arg_2_1)
	self._param = arg_2_1
	self._isFirstEnter = true

	self:initVirtualWorld()

	self._tipsData = {}
	self._tipIds = {}

	self.m_mapComp:setStage(self)
	self.m_touchGraph:addClickListener(handler(self, self.onCloseKnight))
	self.m_KnightBtn:addClickListener(handler(self, self.onClickKnightBtn))
	self.m_bossBtn:addClickListener(handler(self, self.onClickBossBtn))
	self.m_HomeBtn:addClickListener(handler(self, self.onClickHomeBtn))
	self.m_speedBtn:addClickListener(handler(self, self.onClickSpeedBtn))
	self.m_HomeBtn:setVisible(g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HOME_LAND_MAIN))
	self.m_topBarComp:setHomeCallBack(handler(self, self._onTopHomeClick))
	self.m_topBarComp:setReturnCallBack(handler(self, self._onTopReturnClick))
	self.m_shopBtn:addClickListener(handler(self, self._onShopClick))
	self.m_shopBtn:setVisible(g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PLAY_SHOP))
	self.m_bagBtn:addClickListener(handler(self, self._onBagClick))

	self._eventManager = var_0_1:getEventManager()

	self._virtualWorld:setMapSize(self.m_mapComp:getMapWorld():getMapGround():getGroundSize())
	self.m_topBarComp:setResInfoById(379)

	if device.isWindows() and config.SHOW_DEBUG_BTN then
		local var_2_0 = fgui.UIPackage:createObject("outpost", "OutpostDebugComp")

		var_2_0:setVirtualWorld(self._virtualWorld)
		var_2_0:setPosition(1300, 110)
		self:addChild(var_2_0)
	end

	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.OUTPOST)
	self.m_speedBtn:setVisible(var_0_1:isSpeedBtnActive())

	if var_0_1:isSpeedOn() then
		cc.Director:getInstance():getScheduler():setTimeScale(var_0_1:getSpeed())
	else
		cc.Director:getInstance():getScheduler():setTimeScale(1)
	end
end

function OutpostGameStage:initVirtualWorld()
	self._virtualWorld = OutpostVirtualWorld.new()

	local var_3_0 = cc.Node:create()

	self:addNode(var_3_0)
	var_3_0:scheduleUpdate(handler(self._virtualWorld, self._virtualWorld.tickUpdate))
end

function OutpostGameStage:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_GETINFO, handler(self, self.onOutpostGetInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_KNIGHT_ENTRANCE, handler(self, self._onS2CKnightEntrance), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_KNIGHT_EXIT, handler(self, self._onS2CKnightExit), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_CALLBOSS, handler(self, self._onS2CBuildCallBoss), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_ORDERPROCESS, handler(self, self._onS2CBuildOrderProcess), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BATTLEFINISH, handler(self, self._onS2CBattleFinish), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_OUTPOST_CALL_KNIGHT_TO_BUILD, handler(self, self.onKnightCallBuild), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_MAP_UNLOCK, handler(self, self.onMapTpUnlock), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_MAP_CLICKDROP, handler(self, self.onClickDrop), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_OUTPOST_JUMP_TO_POS, handler(self, self.onJumpToPos), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_OUTPOST_JUMP_TO_BUILD, handler(self, self.onJumpToBuild), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_OUTPOST_GOTO_EQUIP, handler(self, self.onJumpToBattleBuild), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_UNLOCK, handler(self, self.updateUnlockState), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_USE, handler(self, self._onS2CBuildUse), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_OUTPOST_OPEN_KNIGHT_COMP, handler(self, self.onClickKnightBtn), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_GETTASKAWARD, handler(self, self.checkTopBarBtnShow), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_SYNCTASK, handler(self, self.checkTopBarBtnShow), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_OUTPOST_TIPS_ITEM, handler(self, self.tipsDropItem), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_OUTPOST_PUSH_LIMIT_TASK, handler(self, self.onGuidePushLimitTask), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_ONEKEYCLICKDROP, handler(self, self.onClickAllDrop), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BOSS_SWEEP, handler(self, self._onSweepBoss), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_GETBOSSBOX, handler(self, self.onClickBossBox), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_OUTPOST_BOSS_BOX_EXPIRE, handler(self, self.onTipsChangeBossUpdate), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_DELBOSS, handler(self, self._onBossCancel), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_OUTPOST_BUILD_LEVEL_CHANGED, handler(self, self.onBuildLevelUp), self)

	if self._isFirstEnter then
		self._isFirstEnter = false

		local var_4_0 = cc.p(25, 25)

		if self._param and type(self._param) == "table" then
			if self._param.pos then
				var_4_0 = self._param.pos
			elseif self._param.buildType then
				var_4_0 = nil

				self:_jumpToBuild(self._param.buildType)
			end
		end

		if var_4_0 then
			self.m_mapComp:moveToPoint(var_4_0.x, var_4_0.y)
		end
	end

	self:updateTipShow()
	self:updateUnlockState()
	self:checkTopBarBtnShow()
	self:onTipsChangeBossUpdate()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_limitTaskBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_KnightBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_bossBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_shopBtn
	})
	self:newSchedule(handler(self, self._tickUpdateSec), 1)
	self.m_enterTransition:play(handler(self, self._onAfterAnimFinish))

	if self:getVirtualWorld():getVirtualMap():hasBoss() then
		g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_Battle_Common)
	else
		g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_SimManage)
	end
end

function OutpostGameStage:onOutpostGetInfo()
	self:onTipsChangeBossUpdate()
end

function OutpostGameStage:checkTopBarBtnShow()
	local var_6_0 = var_0_1:isCanOutOutpost()

	self.m_topBarComp:setBackHomeBtnShowState(var_6_0, var_6_0, var_6_0)
end

function OutpostGameStage:_onAfterAnimFinish()
	self:checkGuide()
end

function OutpostGameStage:checkGuide()
	if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.OUTPOST_WEAK_TICK_GUIDE) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
			tickType = 6,
			enum = g.core.const.ConstMgr.GuideConst.ENUM_TICK.OUTPOST_WEAK_TICK_GUIDE
		})
		g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.OUTPOST_WEAK_TICK_GUIDE)
		g.core.model.User.guideData:setGuideTickedFinish(48)
	end
end

function OutpostGameStage:_onCrossDayUpdate()
	g.core.network.GameNetProxy:send_C2S_Outpost_GetInfo({})
end

function OutpostGameStage:_onSweepBoss(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if arg_10_4.box then
		self._virtualWorld:getVirtualMap():addBossBox(arg_10_4.box)
	end

	self:onTipsChangeBossUpdate()
end

function OutpostGameStage:onClickDrop(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	self:getVirtualWorld():getVirtualMap():removeDrop((table.concat({
		arg_11_4.map_tp,
		arg_11_4.target_x,
		arg_11_4.target_y,
		arg_11_4.seq
	}, "_")))
end

function OutpostGameStage:onClickBossBox(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	self:getVirtualWorld():getVirtualMap():removeBossBox(arg_12_4.box_id)

	if arg_12_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_12_4.awards, true)
	end

	self:onTipsChangeBossUpdate()
end

function OutpostGameStage:_onBossCancel(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	self:getVirtualWorld():getVirtualMap():removeBoss(arg_13_4.boss_id)
end

function OutpostGameStage:onBuildLevelUp(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	self.m_speedBtn:setVisible(var_0_1:isSpeedBtnActive())
end

function OutpostGameStage:onClickAllDrop(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	self:getVirtualWorld():getVirtualMap():removeAllDrop()
end

function OutpostGameStage:updateUnlockState()
	local var_16_0 = not var_0_1:getBuildData():getBuild({
		type = var_0_0.BuildType.Boss
	}):isLockBuild()

	self.m_bossBtn:setVisible(var_16_0)

	local var_16_1 = self.m_KnightBtn

	if var_16_0 then
		self.m_bossBtn:setX(self.m_KnightBtn:getX() + 216)
		self.m_shopBtn:setX(self.m_bossBtn:getX() + 216)

		var_16_1 = self.m_bossBtn
	elseif g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.HOT_SELLING) then
		self.m_shopBtn:setX(self.m_KnightBtn:getX() + 216)
	end

	self.m_bagBtn:setX(((self.m_shopBtn:isVisible() or nil) and self.m_shopBtn):getX() + 216)
end

function OutpostGameStage:_onS2CKnightEntrance(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	for iter_17_0, iter_17_1 in ipairs(arg_17_4.knights) do
		local var_17_0 = var_0_1:getKnightsData()

		self:getVirtualWorld().getVirtualMap(var_17_0):addKnight((var_17_0:getKnightByAdvId(iter_17_1.advance_id)))
	end
end

function OutpostGameStage:_onS2CKnightExit(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	for iter_18_0, iter_18_1 in ipairs(arg_18_4.knights) do
		self:getVirtualWorld():getVirtualMap():removeKnight(iter_18_1.knight_id)
	end
end

function OutpostGameStage:_onS2CBuildCallBoss(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	self:getVirtualWorld():getVirtualMap():addBoss(arg_19_4.boss)
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_Battle_Common)
end

function OutpostGameStage:_onS2CBuildOrderProcess(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	if arg_20_4.order_tp == var_0_0.EXCHANGE_TYPE.SELL then
		if arg_20_4.build_tp == var_0_0.BuildType.WeaponShop or arg_20_4.build_tp == var_0_0.BuildType.ArmorShop then
			if arg_20_4.knight then
				local var_20_0 = self._virtualWorld:getVirtualMap():getKnightById(arg_20_4.knight.knight_id)

				if var_20_0 then
					var_20_0:checkAttrChange(true)
				end
			end
		end
	end

	if arg_20_4.build_tp == var_0_0.BuildType.Exchange and var_0_0.BuildType.Exchange == arg_20_4.build_tp and arg_20_4.order_tp == var_0_0.EXCHANGE_TYPE.SELL then
		local var_20_1 = self._virtualWorld:getVirtualMap()
		local var_20_2 = cc.p(var_20_1:getBuildByType(arg_20_4.build_tp):getPos())

		var_20_2.y = var_20_1.y - 100
		var_20_2.x = var_20_2.x + 10

		self.m_mapComp:playItemFlyEff({
			itemInfo = {
				type = var_0_0.EXCHANGE_ITEM_TYPE,
				value = g.core.config.outpost_exchange_item_info.get(arg_20_4.target_id).item_value,
				size = arg_20_4.target_num
			},
			buildPos = var_20_2
		})
	end

	self:updateTipRefreshShow()
end

function OutpostGameStage:_onS2CBuildUse(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	local var_21_0 = self:getVirtualWorld():getVirtualMap():getKnightById(arg_21_4.knight_id)

	if arg_21_4.build_tp == var_0_0.BuildType.Hospital then
		var_21_0:refreshCurHp()
	elseif arg_21_4.build_tp == var_0_0.BuildType.Restaurant then
		var_21_0:refreshHunger()
	elseif arg_21_4.build_tp == var_0_0.BuildType.Tavern then
		var_21_0:refreshMood()
	elseif arg_21_4.build_tp == var_0_0.BuildType.Hotel then
		var_21_0:refreshFatigue()
	end

	self:updateTipRefreshShow()
end

function OutpostGameStage:_onS2CBattleFinish(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0 = arg_22_4.drops or {}
	local var_22_1 = arg_22_4.boss_boxes or {}
	local var_22_2 = arg_22_4.new_monster
	local var_22_3 = arg_22_4.knights or {}
	local var_22_4 = self._virtualWorld:getVirtualMap()

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		var_22_4:addDrop(table.concat({
			arg_22_4.map_tp,
			iter_22_1.pos_x,
			iter_22_1.pos_y,
			iter_22_1.seq
		}, "_"), arg_22_4.map_tp, iter_22_1)
	end

	if #var_22_1 > 0 then
		for iter_22_2, iter_22_3 in ipairs(var_22_1) do
			var_22_4:addBossBox(iter_22_3)
		end

		if self:getVirtualWorld():getVirtualMap():hasBoss() then
			g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_Battle_Common)
		else
			g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_SimManage)
		end
	end

	if var_22_2 then
		var_22_4:addMonster(var_22_2)
	end

	for iter_22_4, iter_22_5 in ipairs(var_22_3) do
		local var_22_5 = var_22_4:getKnightById(iter_22_5.knight_id)

		var_22_5:checkAttrChange()
		self.m_mapComp:showKnightExp(var_22_5)
	end

	for iter_22_6, iter_22_7 in ipairs(arg_22_4.dropToKnights or {}) do
		self.m_mapComp:showKnightDrop(var_22_4:getKnightById(iter_22_7.knight_id), (not iter_22_7.drops or nil) and {}, arg_22_4.x, arg_22_4.y)
	end

	self:onTipsChangeBossUpdate()
end

function OutpostGameStage:onMapTpUnlock(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = self._virtualWorld:getVirtualMap()

	for iter_23_0, iter_23_1 in ipairs(arg_23_4.map.drops or {}) do
		var_23_0:addDrop(table.concat({
			arg_23_4.map.map_type,
			iter_23_1.pos_x,
			iter_23_1.pos_y,
			iter_23_1.seq
		}, "_"), arg_23_4.map.map_type, iter_23_1)
	end

	for iter_23_2, iter_23_3 in ipairs(arg_23_4.map.monsters or {}) do
		var_23_0:addMonster(iter_23_3)
	end

	self:getVirtualWorld():getVirtualMap():clearOnArenaUnlock(arg_23_4.map_tp)
end

function OutpostGameStage:onUpdateBuildTip()
	local var_24_0 = self._virtualWorld:getTopBuild()

	self._tipIds[var_0_0.TIPS_TYPE.BUILD] = {}

	for iter_24_0, iter_24_1 in pairs({
		[var_0_0.BuildType.Hospital] = var_0_0.TIPS_ENUM.HOSPITAL_LACK,
		[var_0_0.BuildType.Hotel] = var_0_0.TIPS_ENUM.HOTEL_LACK,
		[var_0_0.BuildType.Restaurant] = var_0_0.TIPS_ENUM.RESTAURANT_LACK,
		[var_0_0.BuildType.Tavern] = var_0_0.TIPS_ENUM.TAVERN_LACK
	}) do
		local var_24_1 = var_0_1:getBuildData():getBuild({
			type = iter_24_0
		})

		if not var_24_1:isLockBuild() and not var_24_1:isHasConsumptionItem() then
			local var_24_2 = var_0_4.get(iter_24_1)

			self._tipIds[var_24_2.type] = self._tipIds[var_24_2.type] or {}

			table.insert(self._tipIds[var_24_2.type], {
				id = iter_24_1,
				buildType = iter_24_0
			})
		end
	end

	if var_24_0 then
		table.sort(self._tipIds[var_0_0.TIPS_TYPE.BUILD], function(arg_25_0, arg_25_1)
			if arg_25_0.buildType == var_24_0 or arg_25_1.buildType == var_24_0 then
				return arg_25_0.buildType == var_24_0
			end

			return arg_25_0.id < arg_25_1.id
		end)
	end
end

function OutpostGameStage:_tickUpdateSec()
	if self._virtualWorld:isNeedUpdateTip() then
		self:updateTipRefreshShow()
	end

	var_0_1:saveBossHp()
end

function OutpostGameStage:updateTipRefreshShow()
	self:onUpdateBuildTip()
	self:onTipsChangeUpdate(self._virtualWorld:getCheckTipKnight())
	self:updateTipShow()
end

function OutpostGameStage:onTipsChangeBossUpdate()
	self._tipIds[var_0_0.TIPS_TYPE.BOSS_BOX] = {}

	local var_28_0 = var_0_1:getBossBoxDict()

	if next(var_28_0) then
		local var_28_1 = {}

		for iter_28_0, iter_28_1 in pairs(var_28_0) do
			table.insert(var_28_1, iter_28_1)
		end

		local var_28_2 = g.core.common.ServerTime:getTime()

		for iter_28_2 = #var_28_1, 1, -1 do
			if var_28_1[iter_28_2].expire_time ~= 0 and var_28_2 > var_28_1[iter_28_2].expire_time then
				table.remove(var_28_1, iter_28_2)
			end
		end

		table.sort(var_28_1, function(arg_29_0, arg_29_1)
			if arg_29_0.expire_time ~= 0 and arg_29_1.expire_time ~= 0 then
				if arg_29_0.expire_time ~= arg_29_1.expire_time then
					return arg_29_0.expire_time < arg_29_1.expire_time
				end
			elseif arg_29_0.expire_time ~= 0 or arg_29_1.expire_time ~= 0 then
				return arg_29_1.expire_time ~= 0
			end

			return arg_29_0.boss_id > arg_29_1.boss_id
		end)

		if var_28_1 and var_28_1[1] then
			local var_28_3 = self:getVirtualWorld():getVirtualMap():getBossBoxEntity(var_28_1[1].id)

			if var_28_3 then
				local var_28_4, var_28_5 = var_28_3:getPos()

				table.insert(self._tipIds[var_0_0.TIPS_TYPE.BOSS_BOX], {
					id = var_0_0.TIPS_ENUM.BOSS_BOX,
					box = var_28_1[1],
					pos = cc.p(OutpostCommon.pixelToCoord(var_28_4, var_28_5))
				})
			end
		end
	end

	self:updateTipShow()
end

function OutpostGameStage:onTipsChangeUpdate(arg_30_1)
	self._tipIds[var_0_0.TIPS_TYPE.KNIGHT] = {}

	local var_30_0 = {
		[var_0_0.BuildType.WeaponShop] = var_0_0.TIPS_ENUM.WEAPON_READY,
		[var_0_0.BuildType.ArmorShop] = var_0_0.TIPS_ENUM.ARMOR_READY
	}

	for iter_30_0, iter_30_1 in pairs(arg_30_1 or {}) do
		if iter_30_1.entity.cmdBuild and var_30_0[iter_30_1.entity.cmdBuild] then
			local var_30_1 = var_0_4.get(var_30_0[iter_30_1.entity.cmdBuild])

			self._tipIds[var_30_1.type] = self._tipIds[var_30_1.type] or {}

			local var_30_2 = {
				id = var_30_0[iter_30_1.entity.cmdBuild]
			}

			var_30_2.knightId = iter_30_1.entity:getEntityKnightStruct():getServerId()

			table.insert(self._tipIds[var_30_1.type], var_30_2)
		end
	end
end

function OutpostGameStage:getKnightWaitBuild()
	local var_31_0 = self._tipIds[var_0_0.TIPS_TYPE.KNIGHT] or {}

	if next(var_31_0) then
		return self.m_mapComp:getEntityObject(self._virtualWorld:getVirtualMap():getKnightById(var_31_0[1].knightId).oid)
	end
end

function OutpostGameStage:updateTipShow()
	local var_32_0 = {
		self.m_tip1Btn,
		self.m_tip2Btn,
		self.m_tip3Btn
	}
	local var_32_1 = {}

	for iter_32_0, iter_32_1 in ipairs(var_32_0) do
		if self._tipIds[iter_32_0] and self._tipIds[iter_32_0][1] then
			table.insert(var_32_1, {
				type = iter_32_0,
				data = self._tipIds[iter_32_0][1]
			})
		end
	end

	self.m_tipsNumController:setSelectedIndex(#var_32_1)

	if #var_32_1 > 0 then
		for iter_32_2, iter_32_3 in ipairs(var_32_1) do
			var_32_0[iter_32_2]:setVisible(true)
			var_32_0[iter_32_2]:updateTip(iter_32_3.type, iter_32_3.data)
		end
	end
end

function OutpostGameStage:getVirtualWorld()
	return self._virtualWorld
end

function OutpostGameStage:getMapComp()
	return self.m_mapComp
end

function OutpostGameStage:onCloseKnight()
	if self._isCloseKnight then
		return
	end

	self._isCloseKnight = true

	self.m_knightShowComp:playHide(handler(self, self._onCloseKnightFinish))
end

function OutpostGameStage:_onCloseKnightFinish()
	self._isCloseKnight = false

	self.m_knightShowController:setSelectedIndex(0)
end

function OutpostGameStage:onClickKnightBtn()
	self.m_knightShowController:setSelectedIndex(1)
	self.m_knightShowComp:playShow()
end

function OutpostGameStage:onClickBossBtn()
	if var_0_1:getBuildData():getBuild({
		type = var_0_0.BuildType.Boss
	}):isLockBuild() then
		g.core.module.ModuleManager:tip(g.core.lang:get(432621))
	else
		g.core.module.ModuleManager:pushModule(g.view.entrance.OUT_POST_BOSS_BUILD)
	end
end

function OutpostGameStage:onClickHomeBtn()
	g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME_LAND)
end

function OutpostGameStage:onClickSpeedBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.outpost.view.speed.OutpostSpeedPop").new()))
end

function OutpostGameStage:receiveCompEvent(arg_41_1, arg_41_2)
	if arg_41_1 == "OutpostKnightStationComp_jump_knight" then
		local var_41_0 = self._virtualWorld:getVirtualMap():getKnightById((arg_41_2.struct:getServerId()))

		if var_41_0 then
			local var_41_1, var_41_2 = var_41_0:getPos()

			self.m_mapComp:moveToPoint(OutpostCommon.pixelToCoord(var_41_1, var_41_2))
		end
	elseif arg_41_1 == "Outpost_close_Knight_comp" then
		self.m_knightShowController:setSelectedIndex(0)
	end
end

function OutpostGameStage:onUpdateTipsShow()
	return
end

function OutpostGameStage:onKnightCallBuild(arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	local var_43_0 = self:getVirtualWorld():getVirtualMap():getKnightById(arg_43_4.knightId)

	if var_43_0 then
		var_43_0:setEntityCmdStart(arg_43_4.buildType, arg_43_4.equipPos)
	end
end

function OutpostGameStage:onJumpToPos(arg_44_1, arg_44_2, arg_44_3, arg_44_4)
	if arg_44_4.pos then
		self.m_mapComp:moveToPoint(arg_44_4.pos.x, arg_44_4.pos.y)
	elseif arg_44_4.knightId then
		local var_44_0 = self:getVirtualWorld():getVirtualMap():getKnightById(arg_44_4.knightId)

		if var_44_0 then
			local var_44_1, var_44_2 = var_44_0:getPos()

			self.m_mapComp:moveToPoint(OutpostCommon.pixelToCoord(var_44_1, var_44_2))
		end
	end

	if arg_44_4.box then
		self:newScheduleOnce(handler(self, function(arg_45_0)
			arg_45_0.m_mapComp:showDropFinger((arg_45_0:getVirtualWorld():getVirtualMap():getBossBoxEntity(arg_44_4.box.id)))
		end))
	end
end

function OutpostGameStage:onJumpToBuild(arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	local var_46_0 = arg_46_4.buildType

	self:newScheduleOnce(handler(self, function(arg_47_0)
		arg_47_0:_jumpToBuild(var_46_0)
	end))
end

function OutpostGameStage:onJumpToBattleBuild()
	self:_jumpToBuild(var_0_0.BuildType.WeaponShop)
end

function OutpostGameStage:_jumpToBuild(arg_49_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_JUMP_TO_BUILD_2, false, 0, {
			buildType = arg_49_1
		})
	end, 0.2)

	local var_49_0 = var_0_1:getBuildData():getBuild({
		type = arg_49_1
	})

	if var_49_0 then
		local var_49_1 = var_49_0:getBuildPos()

		self.m_mapComp:moveToPoint(var_49_1.x, var_49_1.y)
	end
end

function OutpostGameStage:_onTopHomeClick()
	if var_0_1:isCanOutOutpost() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_EXIT_PLAY_TRANSITION)
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(432640))
	end
end

function OutpostGameStage:_onTopReturnClick()
	if var_0_1:isCanOutOutpost() then
		self.m_topBarComp:checkFullPageExitAnim()
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(432640))
	end
end

function OutpostGameStage:onClickBackBtn()
	if var_0_1:isCanOutOutpost() then
		self.m_topBarComp:checkFullPageExitAnim()
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(432640))
	end
end

function OutpostGameStage:tipsDropItem()
	local var_54_0 = self._virtualWorld:getVirtualMap():getOneDrop()

	if var_54_0 then
		local var_54_1, var_54_2 = var_54_0:getPos()

		self.m_mapComp:moveToPoint(OutpostCommon.pixelToCoord(var_54_1, var_54_2))
		self:newScheduleOnce(handler(self, function()
			self.m_mapComp:showDropFinger(var_54_0)
		end))
	end
end

function OutpostGameStage:_onShopClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP_POPUP, {
		isAsPopUp = true,
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.OUTPOST_SHOP
	})
end

function OutpostGameStage:_onBagClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.outpost.view.bag.OutpostBagPop").new()))
end

function OutpostGameStage:onGuidePushLimitTask()
	if not var_0_1:getTaskData():isTriggerLimit() then
		return
	end

	g.core.module.ModuleManager:pushPopup((require("app.view.module.outpost.view.task.OutpostLimitTimeTaskPop").new()))
end

function OutpostGameStage:onRemoved()
	var_0_1:clearWorldEvent()
	var_0_1:clearCacheKnightSpine()
	var_0_1:saveBossHp()
	self._virtualWorld:exitWorld()
	cc.Director:getInstance():getScheduler():setTimeScale(1)
	g.core.network.GameNetProxy:send_C2S_Outpost_Leave({
		knights = var_0_1:getLeaveMapSaveKnights()
	})
end

return OutpostGameStage
