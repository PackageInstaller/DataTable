local var_0_0 = g.core.model.User.stormData
local StormWorld = require("app.view.module.storm.view.smallCity.StormWorld")
local StormConst = require("app.view.module.storm.const.StormConst")
local var_0_3 = {
	[2] = g.core.const.ConstMgr.LineUpConst.MulTeamType.STORM_2,
	[3] = g.core.const.ConstMgr.LineUpConst.MulTeamType.STORM_3,
	[4] = g.core.const.ConstMgr.LineUpConst.MulTeamType.STORM_4
}
local StormMainLayer = class("StormMainLayer", require("app.fairyGUI.storm.UI_StormSmallCityStage"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/storm/storm",
		resName = "StormSmallCityStage",
		pkgName = "storm"
	}, ...)
end)

function StormMainLayer:ctor(arg_2_1)
	self._stormCache = {}
	self._endShow = false
	self._stormId = arg_2_1.stormId

	self:_initStage()
	self:getMapWorld():startObserver(self.m_touchMap)
	self.m_locationBtn:addClickListener(handler(self, self._onJumpMainRoleClick))
	self.m_bagBtn:addClickListener(handler(self, self._onBagBtnClick))
	self.m_skipBattleBtn:addClickListener(handler(self, self._onSkipBattleClick))
	self:initTopBar()

	self._isSkipBattleing = false
	self._target = nil

	self.m_playTimesComp:initView({
		type = g.core.common.Goods.RESOURCE.TYPE_TIRED,
		getTimesFunc = function()
			return g.core.model.User.bagData:getCountById(g.core.const.ConstMgr.BAG_TYPE.RESOURCE, 24)
		end
	})
end

function StormMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_STORMINFO, self._onRcvStormInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_AWARD, self._onRcvStormAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_BREAK, self._onRcvStormBreak, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MAIN_ROLE_COORD_CHANGE, self._onMainRoleCoordChange, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_CHALLENGEFINISH, self._onRcvBattleFinish, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_FIND_TARGET_EVENT_ITEM, self._onEventFindTargetItem, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_CHALLENGEBEGIN, self._onStormChallengeBegin, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_GET, self._onFormationGet, self)
	self:getMapWorld():startWorld()
	self:setHeadArrow(false)
	self:_updateView()
	self.m_playTimesComp:updateView()
	g.core.network.GameNetProxy:send_C2S_Storm_StormInfo({
		storm_id = self._stormId
	})
	g.core.resource.ResourceManager:clearResource()
end

function StormMainLayer:onUnload()
	g.core.battle.BattleShowResult:enableAll()
end

function StormMainLayer:initTopBar()
	self.m_topBar:setResInfoById(39)
end

function StormMainLayer:_onCurCityClose()
	self.m_topBar:checkFullPageExitAnim()
end

function StormMainLayer:_onStormChallengeBegin(arg_8_1, arg_8_2, arg_8_3)
	if var_0_0:isSmallCitySkipBattle() then
		g.core.battle.BattleShowResult:disableAll()
		g.core.battle.BattleProxy:fastBattle(arg_8_3.battle_id)

		return
	end

	local BattleConst = require("app.view.battle.const.BattleConst")

	g.core.battle.BattleProxy:enterBattle({
		soundType = 4,
		type = BattleConst.TYPE_STORM,
		battle_id = arg_8_3.battle_id,
		skip = BattleConst.SKIP_TYPE.HIDE,
		battleType = BattleConst.BATTLE_TYPE.PVE,
		bgId = g.core.config.storm_info.get(self._stormId).battle_stage,
		prefixScene = {
			entranceModule = g.view.entrance.STORM_SMALL_CITY,
			entranceData = {
				stormId = self._stormId
			}
		}
	})
end

function StormMainLayer:_onRcvBattleFinish(arg_9_1, arg_9_2, arg_9_3)
	if var_0_0:isSmallCitySkipBattle() then
		self:updateMapEntity()

		if arg_9_3.is_win then
			g.core.module.ModuleManager:tip(g.core.lang:get(304545))
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(304546))
		end

		self._isSkipBattleing = false
	end
end

function StormMainLayer:_onFormationGet(arg_10_1, arg_10_2, arg_10_3)
	if var_0_0:isSmallCitySkipBattle() then
		local function var_10_0(arg_11_0)
			for iter_11_0, iter_11_1 in pairs(arg_11_0) do
				if iter_11_1 > 0 then
					return true
				end
			end

			return false
		end

		local var_10_1 = not (not arg_10_3.formations or #arg_10_3.formations <= 0)

		if var_10_1 then
			for iter_10_0, iter_10_1 in pairs(arg_10_3.formations) do
				var_10_1 = var_10_1 and var_10_0(iter_10_1.knight_id)
			end
		end

		if var_10_1 then
			g.core.network.GameNetProxy:send_C2S_Storm_ChallengeBegin({
				storm_id = self._stormId,
				cell_id = self._target:getBindID()
			})
			self:getMapWorld():getMainRole():playAttack()
		else
			self._isSkipBattleing = false

			local var_10_2 = g.core.config.storm_event_info.get(self._target.ev_id)
			local var_10_3 = 0

			while g.core.config.storm_event_info.hasKey("event_value" .. 1) do
				if var_10_2["event_value" .. 1] > 0 then
					var_10_3 = var_10_3 + 1
				end
			end

			g.core.module.ModuleManager:pushModule(g.view.entrance.MULTI_TEAM_LAYER, {
				mulTeamType = var_0_3[var_10_3],
				tabNum = var_10_3,
				customData = {
					eventInfo = var_10_2,
					stormId = self._stormId,
					cellId = self._target:getBindID()
				}
			})
			g.core.module.ModuleManager:tip(g.core.lang:get(304547))
		end
	end
end

function StormMainLayer:_onEventFindTargetItem(arg_12_1, arg_12_2)
	self:getMapWorld():findTargetItem(arg_12_2)
end

function StormMainLayer:getNormalReward(arg_13_1)
	local var_13_0 = self._stormId
	local var_13_1 = arg_13_1:getBindID()

	self:getMapWorld():doDestroyObstacle(var_13_1, function()
		g.core.network.GameNetProxy:send_C2S_Storm_Award({
			storm_id = var_13_0,
			cell_id = var_13_1
		})
	end, true)
end

function StormMainLayer:_onRcvStormAward(arg_15_1, arg_15_2, arg_15_3)
	g.core.module.ModuleManager:awardSummary(arg_15_3.awards, nil, nil, nil, handler(self, self._showAwardFinish))
	self:getMapWorld():getReward(arg_15_3)
	self:_updateView()
end

function StormMainLayer:_onRcvStormBreak(arg_16_1, arg_16_2, arg_16_3)
	self:getMapWorld():doDestroyObstacle(arg_16_3.cell_id)
end

function StormMainLayer:_onMainRoleCoordChange(arg_17_1, arg_17_2)
	self:getMapGround():clearFog(arg_17_2, StormConst.CLEAR_FOG_RANGE.MAIN_ROLE_MOVE)
	self:getMapWorld():clearFogEntityVisible(arg_17_2, StormConst.CLEAR_FOG_RANGE.MAIN_ROLE_MOVE)
end

function StormMainLayer:updateStageView()
	self:_updateView()
end

function StormMainLayer:updateProcess()
	local var_19_0, var_19_1, var_19_2 = g.core.model.User.stormData:getCityPercent(self._stormId)

	self.m_processTxt:setText(var_19_1 .. "/" .. var_19_2)

	if var_19_2 <= var_19_1 and not self._endShow then
		self._endShow = true
	end
end

function StormMainLayer:_showAwardFinish()
	if self._endShow then
		self:_onCurCityFinish()
	end
end

function StormMainLayer:_onCurCityFinish()
	g.core.model.User.stormData:setSmallCityFinish()
	g.core.model.User.stormData:setFinishId(self._stormId)
	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseLineTipsPop").new({
		delay = 1,
		englishTitle = g.core.lang:get(109614),
		title = g.core.lang:get(304528),
		callBack = function()
			if self and self.m_topBar then
				self.m_topBar:checkFullPageExitAnim()
			end
		end
	}), {
		blackOpacity = 0
	})
end

function StormMainLayer:_initStage()
	self:_deserializeStorm()

	local var_23_0 = g.core.config.storm_info.get(self._stormId)

	self.m_topBar:setTitle(var_23_0.name)

	self._worldId = var_23_0.map_id

	self.m_skipBattleBtn:setSelected(var_0_0:isSmallCitySkipBattle())
	self:_initMapWorld()
end

function StormMainLayer:updateMapEntity()
	self:getMapWorld():updateEntity(g.core.model.User.stormData:getSmallCityData(self._stormId).events)
end

function StormMainLayer:_initMapWorld()
	self._mapWorld = StormWorld.new(self, g.core.config.storm_info.get(self._stormId).map_id)

	self.m_worldHold:addNode(self._mapWorld)
end

function StormMainLayer:_updateView()
	self:updateProcess()
	self:updateMapEntity()
end

function StormMainLayer:getMapWorld()
	return self._mapWorld
end

function StormMainLayer:setHeadArrow(arg_28_1)
	self.m_locationBtn:setVisible(arg_28_1)
end

function StormMainLayer:_serializeStorm(arg_29_1)
	self._stormCache[tostring(self._stormId)] = arg_29_1

	g.core.common.Storage:save("storm_small_map_new2.json", self._stormCache)
end

function StormMainLayer:_deserializeStorm()
	self._stormCache = g.core.common.Storage:load("storm_small_map_new2.json") or {}
end

function StormMainLayer:getMapGround()
	return self._mapWorld:getMapGround()
end

function StormMainLayer:pickupStop()
	return
end

function StormMainLayer:_onJumpMainRoleClick()
	self._mapWorld:jump2MainRole()
	self:setHeadArrow(false)
end

function StormMainLayer:_onBagBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.storm.view.pop.StormSmallCityBagPop").new(), {
		touchDisappear = true
	})
end

function StormMainLayer:_onSkipBattleClick()
	var_0_0:setSmallCitySkipBattleState((self.m_skipBattleBtn:isSelected()))
end

function StormMainLayer:saveStayCoord(arg_36_1)
	self:_serializeStorm(arg_36_1)
end

function StormMainLayer:getStayCoord()
	return self._stormCache[tostring(self._stormId)]
end

function StormMainLayer:talkTrigger(arg_38_1)
	if arg_38_1.event_type == StormConst.EVENT_TYPE.MONSTER then
		local var_38_1

		if var_0_0:isSmallCitySkipBattle() then
			local var_38_0

			if self._isSkipBattleing then
				do return end

				var_38_0 = g.core.config.storm_event_info.get(arg_38_1.ev_id)
			end

			if math.max(var_38_0.cost_success, var_38_0.cost_fail) > g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.TYPE_TIRED) then
				g.core.module.ModuleManager:tip(g.core.lang:get(304509))

				return
			end

			self._isSkipBattleing = true

			g.core.network.GameNetProxy:send_C2S_Storm_ChallengeBegin({
				storm_id = self._stormId,
				cell_id = arg_38_1:getBindID()
			})
			self:getMapWorld():getMainRole():playAttack()

			do return end

			var_38_1 = require("app.view.module.storm.view.pop.StormSmallCityBattleInfoPop").new
		end

		g.core.module.ModuleManager:pushPopup(require("app.view.module.storm.view.pop.StormSmallCityBattleInfoPop").new({
			stormId = self._stormId,
			cellEventId = arg_38_1:getBindID(),
			eventInfo = g.core.config.storm_event_info.get(arg_38_1.ev_id)
		}), {
			touchDisappear = true
		})
	elseif arg_38_1.event_type == StormConst.EVENT_TYPE.SPECAIL_BARRIER then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.storm.view.pop.StormRoadBlockTipPop").new({
			storm_id = self._stormId,
			event_id = arg_38_1.ev_id,
			cell_id = arg_38_1:getBindID()
		}), {
			touchDisappear = true
		})
	elseif arg_38_1.event_type == StormConst.EVENT_TYPE.NORMAL_AWARD then
		self:getNormalReward(arg_38_1)
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.ITEM_GET)
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.ITEM_OFF)
	elseif arg_38_1.event_type == StormConst.EVENT_TYPE.MUL_TEAM_MONSTER then
		local var_38_6

		if var_0_0:isSmallCitySkipBattle() then
			local var_38_2

			if self._isSkipBattleing then
				do return end

				var_38_2 = g.core.config.storm_event_info.get(arg_38_1.ev_id)
			end

			if math.max(var_38_2.cost_success, var_38_2.cost_fail) > g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.TYPE_TIRED) then
				g.core.module.ModuleManager:tip(g.core.lang:get(304509))

				return
			end

			self._isSkipBattleing = true
			self._target = arg_38_1

			local var_38_3 = 0
			local var_38_5

			::label_38_0::

			if g.core.config.storm_event_info.hasKey("event_value" .. 1) then
				repeat
					if var_38_2["event_value" .. 1] > 0 then
						var_38_3 = var_38_3 + 1
					end

					goto label_38_0
				until true

				var_38_5 = {}
			end

			var_38_5.tp = var_0_3[var_38_3]

			g.core.network.GameNetProxy:send_C2S_Formation_Get(var_38_5)

			do return end

			var_38_6 = require("app.view.module.storm.view.pop.StormSmallCityBattleInfoPop").new
		end

		g.core.module.ModuleManager:pushPopup(require("app.view.module.storm.view.pop.StormSmallCityBattleInfoPop").new({
			isMul = true,
			stormId = self._stormId,
			cellEventId = arg_38_1:getBindID(),
			eventInfo = g.core.config.storm_event_info.get(arg_38_1.ev_id)
		}), {
			touchDisappear = true
		})
	end
end

function StormMainLayer:refreshClueTargetLocation()
	local var_39_0 = self:getMapWorld():getNeedGuideTarget()
	local var_39_1 = self:getMapWorld():getGuideTargetByEventType(StormConst.EVENT_TYPE.NORMAL_AWARD)
	local var_39_2 = self:getMapWorld():getGuideTargetByEventType(StormConst.EVENT_TYPE.MONSTER)

	if var_39_0 then
		if self:getMapWorld():checkSingleEntityInView(var_39_0) then
			self.m_directionComp:updateGuideClue(false)

			return
		end

		local var_39_3, var_39_4 = self:getAngleAndAreaId(var_39_0)

		self.m_directionComp:updateGuideClue(true, var_39_3, var_39_4)
	else
		self.m_directionComp:updateGuideClue(false)
	end

	if var_39_1 then
		if self:getMapWorld():checkSingleEntityInView(var_39_1) then
			self.m_directionComp:updateGuideBox(false)

			return
		end

		local var_39_5, var_39_6 = self:getAngleAndAreaId(var_39_1)

		self.m_directionComp:updateGuideBox(true, var_39_5, var_39_6)
	else
		self.m_directionComp:updateGuideBox(false)
	end

	if var_39_2 then
		if self:getMapWorld():checkSingleEntityInView(var_39_2) then
			self.m_directionComp:updateGuideMonster(false)

			return
		end

		local var_39_7, var_39_8 = self:getAngleAndAreaId(var_39_2)

		self.m_directionComp:updateGuideMonster(true, var_39_7, var_39_8)
	else
		self.m_directionComp:updateGuideMonster(false)
	end
end

function StormMainLayer:getAngleAndAreaId(arg_40_1)
	local var_40_0 = arg_40_1:getCoord()
	local var_40_1, var_40_2 = self:getMapGround():coordToPixel(var_40_0.x, var_40_0.y)
	local var_40_3, var_40_4 = self:getMapWorld():getTargetAngelFromScreenCenter((cc.pNormalize((cc.pSub(cc.p(var_40_1 - 100, var_40_2 + 100), (self:getMapGround():convertToNodeSpace(display.center)))))))

	return var_40_3, var_40_4
end

function StormMainLayer:setAutoSearchPath(arg_41_1)
	return
end

function StormMainLayer:_onRcvStormInfo()
	self:_updateView()
	self:getMapWorld():setUpdateState(true)
end

return StormMainLayer
