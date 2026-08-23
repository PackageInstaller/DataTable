local var_0_0 = g.core.model.User.stormData
local DebugCommon = require("app.view.module.debug.common.DebugCommon")
local StormConst = require("app.view.module.storm.const.StormConst")
local var_0_3 = 4
local StormMiddleCityStage = class("StormMiddleCityStage", require("app.fairyGUI.storm.UI_StormMiddleCityStage"), function()
	return fgui.GComponent:create({
		pkgName = "storm",
		isFullScreen = true,
		pkgPath = "ui/storm/storm",
		resName = "StormMiddleCityStage"
	}, ...)
end)

function StormMiddleCityStage:ctor(arg_2_1)
	self._stormCache = nil
	self._stormId = arg_2_1.stormId
	self._page = nil
	self._oldPage = nil
	self._addEntityScheduler = nil
	self._isReset = false
	self._canTouchAndMove = true
	self._isFirstEnter = true
	self._laterAddEntity = {}
	self._isSkipBattleing = false

	self:_initStage()
	self.m_skillsBtn:addClickListener(handler(self, self._onSkillBtnClicked))
	self.m_resetBtn:addClickListener(handler(self, self._onResetBtnClick))
	self:getMapWorld():startObserver(self.m_touchMap)
	self.m_selectMapComp:setVisible(false)
	self.m_selectMapBtn:addClickListener(handler(self, self._onSelectMapBtnClick))
	self.m_touchComp:addClickListener(handler(self, self._onTouchCompClick))
	self.m_touchComp:setVisible(false)
	self.m_skipBattleBtn:addClickListener(handler(self, self._onSkipBattleClick))
	self:updateChangeMapBtn()
	self:checkBlitzState()
	self:initTopBar()
	self:onResetTimes()
end

function StormMiddleCityStage:onResetTimes()
	self.m_playTimesComp:initView({
		isResetRecover = true,
		playNum = g.core.model.User.stormData:getMiddleCityPlayNumId(self._stormId),
		getTimesFunc = function()
			return g.core.model.User.shopData:getLeftCount(g.core.model.User.stormData:getMiddleCityPlayNumId(self._stormId))
		end,
		refreshEvent = {
			g.core.event.enum.EVENT_NET_S2C_STORM_RESET,
			g.core.event.enum.EVENT_NET_S2C_STORM_CLEAR
		}
	})
end

function StormMiddleCityStage:updateChangeMapBtn()
	local var_5_0 = 0

	for iter_5_0, iter_5_1 in pairs((g.core.model.User.stormData:getMiddleCityMap(self._stormId))) do
		if g.core.model.User.stormData:isPresetUnlock(iter_5_0) then
			var_5_0 = var_5_0 + 1
		end
	end

	if var_5_0 > 1 then
		self.m_selectMapBtn:setVisible(true)
	else
		self.m_selectMapBtn:setVisible(false)
	end
end

function StormMiddleCityStage:isCanTouchMovie()
	return self._canTouchAndMove
end

function StormMiddleCityStage:_onSkillBtnClicked()
	g.core.module.ModuleManager:pushModule(g.view.entrance.STORM_SKILL_LAYER)
end

function StormMiddleCityStage:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "StormChangeMap" then
		self:_onTouchCompClick()
		self:changeCityMap(arg_8_2.id)
	end
end

function StormMiddleCityStage:startWorldFinish()
	g.core.network.GameNetProxy:send_C2S_Storm_StormInfo({
		storm_id = self._stormId
	})
	self:checkBlitzState()
end

function StormMiddleCityStage:checkBlitzState()
	if g.core.model.User.stormData:isUnlockBlitz(self._stormId) then
		self.m_resetBtn:setTitle(g.core.lang:get(304511))
	else
		self.m_resetBtn:setTitle(g.core.lang:get(304510))
	end
end

function StormMiddleCityStage:changeCityMap(arg_11_1)
	self._stormId = arg_11_1

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_resetBtn,
		customData = {
			id = self._stormId
		}
	})

	self._page = nil

	if self._mapWorld then
		self._mapWorld:removeSelf()

		self._mapWorld = nil
	end

	self:_initStage()
	self:getMapWorld():startObserver(self.m_touchMap)
	self:getMapWorld():startWorld(true)
	self:setMapInView()
	self:onResetTimes()
end

function StormMiddleCityStage:_onSelectMapBtnClick()
	self.m_selectMapComp:updateComp()
	self.m_selectMapComp:setSelectId(self._stormId)
	self.m_selectMapComp:setVisible(true)
	self.m_touchComp:setVisible(true)
end

function StormMiddleCityStage:_onTouchCompClick()
	self.m_selectMapComp:setVisible(false)
	self.m_touchComp:setVisible(false)
end

function StormMiddleCityStage:_onSkipBattleClick()
	var_0_0:setMiddleCitySkipBattleState((self.m_skipBattleBtn:isSelected()))
end

function StormMiddleCityStage:initTopBar()
	self.m_topBar:setResInfoById(39)
end

function StormMiddleCityStage:onLoad()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_resetBtn,
		customData = {
			id = self._stormId
		}
	})
	self:getMapWorld():startWorld()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_STORMINFO, self._onRcvStormInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_AWARD, self._onRcvStormAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_RESET, self._onRcvStormReset, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_GETENEMY, self._onRcvStormGetEnemy, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_CLEAR, self._onRcvStormClear, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_GETBATTLEUSER, self._onGetBattleUser, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_CHALLENGEBEGIN, self._onStormChallengeBegin, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_CHALLENGEFINISH, self._onStormChallengeFinish, self)
	self:setMapInView()
	g.core.model.User.stormData:isStormRequested(self._stormId)
	g.core.network.GameNetProxy:send_C2S_Storm_StormInfo({
		storm_id = self._stormId
	})
	self.m_playTimesComp:updateView()
	g.core.resource.ResourceManager:clearResource()
end

function StormMiddleCityStage:_onStormChallengeBegin(arg_17_1, arg_17_2, arg_17_3)
	if var_0_0:isMiddleCitySkipBattle() then
		g.core.battle.BattleShowResult:enableAll()
		g.core.battle.BattleProxy:fastBattle(arg_17_3.battle_id)

		return
	end

	local BattleConst = require("app.view.battle.const.BattleConst")

	if DebugCommon.getDebugGlobalValueByKey("storm_middle_battle") == true then
		g.core.battle.BattleShowResult:disableAll()
		g.core.battle.BattleProxy:fastBattle(arg_17_3.battle_id)
		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.battle.BattleShowResult:enableAll()
			g.core.module.ModuleManager:tip("battle end")
			g.core.network.GameNetProxy:send_C2S_Storm_StormInfo({
				storm_id = self._stormId
			})
		end, 0.2)

		return
	end

	g.core.battle.BattleProxy:enterBattle({
		soundType = 4,
		type = BattleConst.TYPE_STORM,
		battle_id = arg_17_3.battle_id,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		battleType = BattleConst.BATTLE_TYPE.PVE,
		bgId = g.core.config.storm_info.get(self._stormId).battle_stage,
		prefixScene = {
			entranceModule = g.view.entrance.STORM_MIDDLE_CITY,
			entranceData = {
				stormId = self._stormId
			}
		}
	})
end

function StormMiddleCityStage:_onStormChallengeFinish()
	if var_0_0:isMiddleCitySkipBattle() then
		self:setMapInView()
		self.m_playTimesComp:updateView()

		self._isSkipBattleing = false
	end
end

function StormMiddleCityStage:_onRcvStormClear(arg_20_1, arg_20_2, arg_20_3)
	self._sentAward = {}
	self._page = 1

	self:getMapWorld():setCurPage(self._page, true)
	self:_updateStageClear()
	self:getMapWorld():resetPlayerPos()
	self.m_stageLvTxt:setText(self._page)
	self.m_playTimesComp:unSkipTimesChange()
	self:checkLineTipShow()
end

function StormMiddleCityStage:_updateStageClear()
	self:getMapWorld():clearEntity()
end

function StormMiddleCityStage:setMapInView()
	local var_22_0 = g.core.model.User.stormData:getMiddleCityData(self._stormId).events or {}

	self:getMapWorld():updateEventEntity(var_22_0)

	self._specailBoxEvent = nil

	local var_22_1 = self:_calcCurPage()

	if #var_22_0 > 0 then
		for iter_22_0, iter_22_1 in ipairs(var_22_0) do
			if g.core.config.storm_cell_event_info.get(iter_22_1.cell_id).event_id_5 == iter_22_1.ev_id then
				self._specailBoxEvent = iter_22_1
			end
		end
	else
		var_22_1 = 1
	end

	if not self._page or self._page ~= var_22_1 then
		self:getMapWorld():setCurPage(var_22_1, true)
	end

	self._page = var_22_1

	self.m_stageLvTxt:setText(self._page)
	self:_updateMap()
end

function StormMiddleCityStage:_onRcvStormInfo()
	self:setMapInView()
	self:checkLineTipShow()
	self.m_playTimesComp:updateView()
end

function StormMiddleCityStage:_onRcvStormGetEnemy()
	self:_updateMap(true)
end

function StormMiddleCityStage:_onResetBtnClick()
	self.m_resetBtn:setTouchable(false)
	self:newScheduleOnce(handler(self, self._onColdDown), 1)

	if g.core.model.User.stormData:isUnlockBlitz(self._stormId) then
		if g.core.model.User.stormData:isMiddleCityCleared(self._stormId) then
			g.core.module.ModuleManager:tip(g.core.lang:get(304505))
		else
			local var_25_0 = require("app.view.base.pop.BaseConfirmPop").new

			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(304502),
				desc = g.core.lang:get(304540),
				onConfirm = function()
					g.core.module.ModuleManager:pushPopup(require("app.view.module.storm.view.pop.StormClearFinishPop").new({
						stormId = self._stormId
					}), {
						touchDisappear = true
					})
					self.m_playTimesComp:skipTimesChange()
				end
			}), {
				touchDisappear = true
			})
		end
	elseif not g.core.model.User.stormData:isMiddleCityCleared(self._stormId) then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(304502),
			desc = g.core.lang:get(304503, {
				name = g.core.config.storm_info.get(self._stormId).name
			}),
			onConfirm = handler(self, self.onResetConfirm)
		}), {
			touchDisappear = true
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(304504))
	end
end

function StormMiddleCityStage:_onColdDown()
	self.m_resetBtn:setTouchable(true)
end

function StormMiddleCityStage:onResetConfirm()
	g.core.network.GameNetProxy:send_C2S_Storm_Reset({
		storm_id = self._stormId
	})
end

function StormMiddleCityStage:_onRcvStormReset()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_ENTER_PLAY_TRANSITION, false, {
		isSpine = true,
		forceCallFunc = true,
		callback = function()
			self:getMapWorld():onResetPlayerPos()
			self:changeCityMap(self._stormId)
		end
	})
end

function StormMiddleCityStage:addEntityLater(arg_31_1, arg_31_2)
	table.insert(self._laterAddEntity, {
		cellId = arg_31_1,
		user = arg_31_2
	})
	self:checkAndScheduleAddEntity()
end

function StormMiddleCityStage:checkAndScheduleAddEntity()
	if self._addEntityScheduler then
		return
	end

	if #self._laterAddEntity == 0 then
		return
	end

	self._addEntityScheduler = self:newSchedule(handler(self, self._onAddEntity), 0.03)
end

function StormMiddleCityStage:checkLineTipShow()
	if self._page == 1 then
		if g.core.model.User.stormData:isMiddleCityFight(self._stormId) then
			self.m_lineTipController:setSelectedIndex(0)
		else
			self.m_lineTipController:setSelectedIndex(1)
		end
	else
		self.m_lineTipController:setSelectedIndex(0)
	end
end

function StormMiddleCityStage:_onAddEntity()
	table.remove(self._laterAddEntity, 1)

	if not self._laterAddEntity[1] then
		self:cancelSchedule(self._addEntityScheduler)

		self._addEntityScheduler = nil

		self:onAutoMoveMap(self._isReset)
		self:getMapWorld():updateTempHolder()

		self._isReset = false

		return
	end

	self:getMapWorld():enemyEnterWorld(self._laterAddEntity[1].cellId, self._laterAddEntity[1].user)
end

function StormMiddleCityStage:_updateMap(arg_35_1)
	self._eventMap = {}

	local var_35_0 = {}

	for iter_35_0, iter_35_1 in ipairs(g.core.model.User.stormData:getMiddleCityData(self._stormId).events or {}) do
		local var_35_1 = g.core.config.storm_cell_event_info.get(iter_35_1.cell_id)
		local var_35_2 = g.core.config.storm_event_info.get(iter_35_1.ev_id)

		if var_35_2.event_type == StormConst.EVENT_TYPE.ENEMY then
			if iter_35_1.enemy then
				self:getMapWorld():enemyEnterWorld(iter_35_1.cell_id, iter_35_1.enemy)
			elseif var_35_1.page == self._page then
				table.insert(var_35_0, iter_35_1.cell_id)
			end
		elseif var_35_2.event_type == StormConst.EVENT_TYPE.BOX then
			self:getMapWorld():boxEnterWorld(iter_35_1.cell_id, self._specailBoxEvent and var_35_2.id == self._specailBoxEvent.ev_id and g.core.common.Path:getChestByLevelAndState(1, 1) or g.core.common.Path:getProgressBoxIcon(4, 1))
		end
	end

	self:getMapWorld():updateTempHolder()

	if not arg_35_1 and #var_35_0 > 0 then
		g.core.network.GameNetProxy:send_C2S_Storm_GetEnemy({
			storm_id = self._stormId,
			cell_ids = var_35_0
		})
	end

	self._isFirstEnter = false
end

function StormMiddleCityStage:_calcCurPage()
	local var_36_0 = g.core.model.User.stormData:getMiddleCityData(self._stormId).events or {}
	local var_36_1 = g.core.model.User.stormData:getCityMaxPage(self._stormId)

	for iter_36_0, iter_36_1 in ipairs(var_36_0) do
		local var_36_2 = g.core.config.storm_event_info.get(iter_36_1.ev_id)

		if var_36_2.event_type == StormConst.EVENT_TYPE.NORMAL_AWARD or var_36_2.event_type == StormConst.EVENT_TYPE.BOX then
			var_36_1 = math.min(g.core.config.storm_cell_event_info.get(iter_36_1.cell_id).page, var_36_1)
		end
	end

	return var_36_1
end

function StormMiddleCityStage:_initStage()
	local var_37_0 = g.core.config.storm_info.get(self._stormId)

	self.m_topBar:setTitle(var_37_0.name)

	self._worldId = var_37_0.map_id

	self.m_skipBattleBtn:setSelected(var_0_0:isMiddleCitySkipBattle())
	self:_deserializeStorm()
	self:_initMapWorld()
end

function StormMiddleCityStage:_initMapWorld()
	self._mapWorld = require("app.view.module.storm.view.middleCity.StormMiddleCityWorld").new(self, g.core.config.storm_info.get(self._stormId).map_id)

	self.m_worldHold:addNode(self._mapWorld)
	self.m_worldHold:setScale(0.8)
	self._mapWorld:setPlayerBillBoardScale(1.5)
end

function StormMiddleCityStage:getMapWorld()
	return self._mapWorld
end

function StormMiddleCityStage:getMapGround()
	return self._mapWorld:getMapGround()
end

function StormMiddleCityStage:talkTrigger(arg_41_1)
	local var_41_0 = arg_41_1:getBindID()

	if not g.core.model.User.stormData:isPerEventFinish(var_41_0, self._stormId) then
		g.core.module.ModuleManager:tip(g.core.lang:get(304531))

		return
	end

	local var_41_1 = g.core.config.storm_event_info.get(g.core.config.storm_cell_event_info.get(var_41_0).event_id_1)

	if var_41_1.event_type == StormConst.EVENT_TYPE.ENEMY then
		g.core.network.GameNetProxy:send_C2S_Storm_GetBattleUser({
			storm_id = self._stormId,
			cell_id = arg_41_1:getBindID()
		})
	elseif var_41_1.event_type == StormConst.EVENT_TYPE.BOX then
		local var_41_2 = self._stormId
		local var_41_3 = arg_41_1:getBindID()

		self:getMapWorld():showBoxAwardProgress(var_41_3, handler(self, function()
			g.core.network.GameNetProxy:send_C2S_Storm_Award({
				storm_id = var_41_2,
				cell_id = var_41_3
			})
		end))
	end
end

function StormMiddleCityStage:_onGetBattleUser(arg_43_1, arg_43_2, arg_43_3)
	local var_43_0

	if var_0_0:isMiddleCitySkipBattle() then
		if self._isSkipBattleing then
			return
		end

		if g.core.model.User.shopData:getLeftCount((g.core.model.User.stormData:getMiddleCityPlayNumId(arg_43_3.storm_id))) <= 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(304507))

			return
		end

		self._isSkipBattleing = true

		g.core.network.GameNetProxy:send_C2S_Storm_ChallengeBegin({
			storm_id = arg_43_3.storm_id,
			cell_id = arg_43_3.cell_id
		})
		self:getMapWorld():getMainRole():playAttack()

		do return end

		var_43_0 = {
			stormId = arg_43_3.storm_id,
			cellEventId = arg_43_3.cell_id,
			content = arg_43_3
		}
	end

	var_43_0.eventInfo = g.core.config.storm_event_info.get(g.core.config.storm_cell_event_info.get(arg_43_3.cell_id).event_id_1)

	g.core.module.ModuleManager:pushPopup(require("app.view.module.storm.view.pop.StormMiddleCityBattleInfoPop").new(var_43_0), {
		touchDisappear = true
	})
end

function StormMiddleCityStage:_serializeStorm(arg_44_1)
	self._stormCache = arg_44_1

	g.core.common.Storage:save("storm_middle_map_" .. self._stormId .. ".json", self._stormCache)
end

function StormMiddleCityStage:_deserializeStorm()
	self._stormCache = g.core.common.Storage:load("storm_middle_map_" .. self._stormId .. ".json") or nil
end

function StormMiddleCityStage:saveStayCoord(arg_46_1)
	arg_46_1.page = self._page

	self:_serializeStorm(arg_46_1)
end

function StormMiddleCityStage:getStayCoord()
	return self._stormCache
end

function StormMiddleCityStage:_onRcvStormAward(arg_48_1, arg_48_2, arg_48_3)
	g.core.module.ModuleManager:awardSummary(arg_48_3.awards or {}, true, nil, nil, self._page == var_0_3 and function()
		if not tolua.isnull(self) then
			self:_onRewardFinish()
		end
	end or function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_ENTER_PLAY_TRANSITION, false, {
			isSpine = true,
			forceCallFunc = true,
			callback = function()
				if self then
					if self.checkPageChange then
						self:checkPageChange()
					end

					if self.onAutoMoveMap then
						self:onAutoMoveMap(false)
					end
				end
			end
		})
	end)
	self:getMapWorld():removeBoxByBindId(arg_48_3.cell_id)
end

function StormMiddleCityStage:_onRewardFinish()
	self:newScheduleOnce(function()
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseLineTipsPop").new({
			delay = 1,
			englishTitle = "MISSION COMPLETED",
			title = g.core.lang:get(304528)
		}), {
			blackOpacity = 0
		})
	end, 0)
end

function StormMiddleCityStage:checkPageChange()
	self._page = self:_calcCurPage()

	self.m_stageLvTxt:setText(self._page)

	self._oldPage = self._page

	if self._page ~= self._page then
		self:_updateMap()
	end
end

function StormMiddleCityStage:onAutoMoveMap(arg_55_1)
	if self._oldPage and self._page then
		self:getMapWorld():playChangePageAnim(self._oldPage, self._page, arg_55_1)

		self._oldPage = nil
	end
end

function StormMiddleCityStage:playChangePageAnim()
	return
end

function StormMiddleCityStage:pickupStop()
	return
end

function StormMiddleCityStage:setAutoSearchPath(arg_58_1)
	return
end

function StormMiddleCityStage:onUnload()
	if self._addEntityScheduler then
		self:cancelSchedule(self._addEntityScheduler)

		self._addEntityScheduler = nil
	end

	self:cancelAllSchedule()
end

function StormMiddleCityStage:getStormId()
	return self._stormId
end

return StormMiddleCityStage
