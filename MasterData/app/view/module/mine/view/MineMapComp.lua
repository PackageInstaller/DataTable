local MineConst = require("app.view.module.mine.const.MineConst")
local MineConfig = require("app.view.module.mine.const.MineConfig")
local var_0_2 = 0.7692307692307692
local CommonKnight = require("app.view.common.CommonKnight")
local var_0_5 = g.core.model.User.mineData
local MineMapComp = class("MineMapComp", require("app.fairyGUI.mine.UI_MineMapComp"))

function MineMapComp:ctor()
	self.m_bg:setURL("bg/mine/bg_qsmy_map.jpg")
	self.m_cloudLoader:setURL("bg/mine/bg_qsmy_mapyun.png")

	self._ownEntity = nil
	self._goldRadio = 1
	self._curGold = 0
	self._maxGold = g.core.config.mine_parameter_info.indexOf(1).max_gold
	self._goldSchedule = nil
	self._isOutputGold = false
	self._routeMap = {}
	self._isEnterBattle = false
	self._robotRunPlayerList = {}
	self._onTheWay = false
	self._delayUpdateReq = false
	self._cocosObj = self:displayObject()

	self._cocosObj:setRotation3D({
		z = 0,
		y = 0,
		x = MineConst.X_ROTATE
	})
	self.m_awardComp:displayObject():setRotation3D({
		z = 0,
		y = 0,
		x = -MineConst.X_ROTATE
	})
	self:_initRoute()
	self:addLoopEff()
	self:_updateCity()
end

function MineMapComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_GETGOLD, handler(self, self._onRcvGetGold), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_MOVECITY, handler(self, self._onRcvMoveCity), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_EVENTNOTIFY, handler(self, self._onRcvEventNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_CAPTURENOTIFY, handler(self, self._onRcvCaptureNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_ATTACKUSERFINISH, handler(self, self._onRcvAttackFinish), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MINE_PLAYER_DEAD, handler(self, self._onRcvDead), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MINE_ENTER_BATTLE, handler(self, self.updateBattleFlag), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_MASS, handler(self, self._onRcvMineMass), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_MASSNOTIFY, handler(self, self._onRcvMineMassNotify), self)
	self:newSchedule(handler(self, self._robotMoveShow), self._showTime)

	self._isEnterBattle = false
end

function MineMapComp:_robotMoveShow()
	local var_3_0 = math.random(1, 40)
	local var_3_1 = math.random(1, 40)

	if var_3_0 == var_3_1 then
		return
	end

	if math.random(0, 10000) > 10000 * self._showGate then
		return
	end

	local var_3_2 = var_0_5:getMovePath(var_3_0, var_3_1)
	local var_3_3 = {}

	for iter_3_0 = 1, #var_3_2 - 1 do
		if self._routeMap[var_3_2[iter_3_0] .. "_" .. var_3_2[iter_3_0 + 1]] then
			table.insertto(var_3_3, self._routeMap[var_3_2[iter_3_0] .. "_" .. var_3_2[iter_3_0 + 1]], 0)
		end
	end

	local var_3_4 = fgui.UIPackage:createObject("base_new", "BasePlaceHolderComp")
	local var_3_5 = CommonKnight.new({
		resId = g.core.config.mine_character_info.indexOf((math.random(1, self._randKnightLen))).id
	})

	var_3_4:addChild(var_3_5)
	self.m_playerComp:addChild(var_3_4)
	var_3_4:setScale(0.6 * var_0_2)
	var_3_5:displayObject():setRotation3D({
		z = 0,
		y = 0,
		x = -MineConst.X_ROTATE
	})
	var_3_4:setPosition(MineConfig[var_3_0 .. "_stand"])
	require("app.core.common.Route"):new(var_3_3):moveToEndOfRoute({
		isAnim = true,
		finishFunc = function()
			var_3_5:removeFromParent()
		end
	})
end

function MineMapComp:_initRoute()
	self._randKnightLen = g.core.config.mine_character_info.getLength()
	self._showTime = g.core.config.mine_parameter_info.indexOf(1).show_time
	self._showGate = g.core.config.mine_parameter_info.indexOf(1).show_rate / 100

	for iter_5_0, iter_5_1 in g.core.config.mine_map_info.ipairs() do
		for iter_5_2 = 1, 4 do
			if iter_5_1["near_city_id" .. iter_5_2] > 0 then
				local var_5_1 = iter_5_1.id
				local var_5_2 = iter_5_1["near_city_id" .. iter_5_2]

				if iter_5_1.id == iter_5_1["near_city_id" .. iter_5_2] then
					break
				end

				local var_5_3 = var_5_1 .. "_" .. var_5_2

				if not MineConfig[(var_5_1 .. "_" .. var_5_2) .. "_" .. 1] then
					var_5_2 = var_5_1
					var_5_1 = var_5_2
					var_5_3 = var_5_2 .. "_" .. var_5_1
				end

				if not self._routeMap[var_5_3] then
					local var_5_4 = {}

					repeat
						local var_5_6

						if MineConfig[var_5_3 .. "_" .. 1] then
							table.insert(var_5_4, MineConfig[var_5_3 .. "_" .. 1])

							var_5_6 = 1 + 1
						end
					until MineConfig[var_5_3 .. "_" .. 1] == nil

					self._routeMap[var_5_3] = var_5_4

					local var_5_7 = {}

					for iter_5_3 = #var_5_4, 1, -1 do
						table.insert(var_5_7, clone(var_5_4[iter_5_3]))
					end

					self._routeMap[var_5_2 .. "_" .. var_5_1] = var_5_7
				end
			end
		end
	end
end

function MineMapComp:_onCrossDayUpdate()
	if self._onTheWay then
		self._delayUpdateReq = true
	else
		g.core.network.GameNetProxy:send_C2S_Mine_GetInfo({})
	end
end

function MineMapComp:_checkDelayUpdate()
	if self._delayUpdateReq then
		self._delayUpdateReq = false

		g.core.network.GameNetProxy:send_C2S_Mine_GetInfo({})
	end
end

function MineMapComp:_onRcvGetGold(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	self._ownCity = var_0_5:getOwnCity()
	self._curGold = 0

	self:_updateGoldProgState(self._ownCity)
	self:_checkGoldSchedule()
	g.core.network.GameNetProxy:send_C2S_Mine_GetMission({})
	g.core.module.ModuleManager:awardSummary(arg_8_4.award or {})
end

function MineMapComp:_onRcvDead()
	if self._isEnterBattle then
		return
	end

	self._ownCity = var_0_5:getOwnCity()
	self._isOutputGold = var_0_5:isOutputGold()
	self._goldRadio = var_0_5:getGoldRadio()

	self:_updateGoldProgState(self._ownCity)
	self:_updateMainPlayer()
	self:_checkGoldSchedule()
	self:_addMainDeadPop()
end

function MineMapComp:updateBattleFlag()
	self._isEnterBattle = true
end

function MineMapComp:_addMainDeadPop()
	local var_11_0 = g.core.common.Storage:load("mine.json") or {}

	var_11_0.isRecord = true

	g.core.common.Storage:save("mine.json", var_11_0)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.mine.view.pop.MineFailPop").new(), {
		blackOpacity = 0.5
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.MINE_FAIL_POP)
end

function MineMapComp:_checkMainDead()
	local var_12_0 = g.core.common.Storage:load("mine.json") or {}

	if var_0_5:getCurPower() <= 0 then
		if not (var_12_0.isRecord or false) then
			self:_addMainDeadPop()

			var_12_0.isRecord = true

			g.core.common.Storage:save("mine.json", var_12_0)
		end
	else
		var_12_0.isRecord = false

		g.core.common.Storage:save("mine.json", var_12_0)
	end
end

function MineMapComp:_updateGoldProgState(arg_13_1)
	local var_13_0 = self.m_cityComp:getChild("Comp_city_" .. arg_13_1)

	if var_13_0 then
		self.m_awardComp:setPosition(var_13_0:getX(), var_13_0:getY() - 100)
	end

	if arg_13_1 == 1 or arg_13_1 == 2 then
		self.m_awardComp:setSize(500, 500)
	else
		self.m_awardComp:setSize(200, 200)
	end

	self.m_awardComp:setProgVisible(self._curGold > 0)
	self.m_awardComp:updateGoldNum(self._curGold)

	if self._curGold >= self._maxGold then
		self.m_awardComp:updateGoldProg(100)
	end
end

function MineMapComp:_updateMainPlayer()
	self._ownEntity:stopAllFGActions()

	local var_14_0 = self._ownEntity:getChild("knightPic")

	if var_14_0 then
		var_14_0:playReadyAction()
	end

	self:showShieldEff(true)
	self._ownEntity:setPosition(MineConfig[self._ownCity .. "_stand"])
	self:setTouchable(true)
end

function MineMapComp:_onRcvAttackFinish(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	if arg_15_4.ret ~= g.core.network.proto.RET_OK then
		return
	end

	local var_15_0 = arg_15_4.cityStatusInfo
	local var_15_1 = self.m_cityComp:getChild("Comp_city_" .. arg_15_4.cityStatusInfo.cityId)

	if var_15_1 then
		var_15_1:updateCity(var_0_5:getCityObjMap()[var_15_0.cityId])
	end
end

function MineMapComp:_onRcvEventNotify()
	for iter_16_0 = 1, g.core.config.mine_map_info.getLength() do
		if self.m_cityComp:getChild("Comp_city_" .. iter_16_0) then
			-- block empty
		end
	end
end

function MineMapComp:_onRcvCaptureNotify(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = self.m_cityComp:getChild("Comp_city_" .. arg_17_4.cityStatusInfo.cityId)

	if var_17_0 then
		var_17_0:updateCity(var_0_5:getCityObjMap()[arg_17_4.cityStatusInfo.cityId])
	end
end

function MineMapComp:addLoopEff()
	self.m_effectComp:addEffectSpine({
		remove = true,
		name = "eff_ui_mine_line",
		isLoop = false
	})
	self.m_cloudComp:addEffectSpine({
		isLoop = true,
		name = "eff_ui_mine_cloud"
	})
end

function MineMapComp:_onRcvMoveCity(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	self._ownCity = var_0_5:getOwnCity()
	self._isOutputGold = var_0_5:isOutputGold()
	self._goldRadio = var_0_5:getGoldRadio()

	local var_19_0 = arg_19_4.cityId or {}

	self:playMainRoleMove({
		movePath = var_19_0
	})

	local var_19_1 = var_0_5:getCityObjMap()

	self.m_cityComp:getChild("Comp_city_" .. var_19_0[1]):updateCity(var_19_1[var_19_0[1]])
	self.m_cityComp:getChild("Comp_city_" .. var_19_0[#var_19_0]):updateCity(var_19_1[var_19_0[#var_19_0]])
end

function MineMapComp:playMainRoleMove(arg_20_1)
	local var_20_0 = arg_20_1.movePath[#arg_20_1.movePath]
	local var_20_1 = {}

	for iter_20_0 = 1, #arg_20_1.movePath - 1 do
		if self._routeMap[arg_20_1.movePath[iter_20_0] .. "_" .. arg_20_1.movePath[iter_20_0 + 1]] then
			table.insertto(var_20_1, self._routeMap[arg_20_1.movePath[iter_20_0] .. "_" .. arg_20_1.movePath[iter_20_0 + 1]], 0)
		end
	end

	self._onTheWay = true

	if var_20_1 and next(var_20_1) then
		self.m_awardComp:setProgVisible(false)
		self:_stopGoldSchedule()

		self._ownCity = arg_20_1.movePath[#arg_20_1.movePath]

		if MineConfig[arg_20_1.movePath[#arg_20_1.movePath] .. "_stand"] then
			table.insert(var_20_1, MineConfig[arg_20_1.movePath[#arg_20_1.movePath] .. "_stand"])
		end

		self:showShieldEff(false)
		self:setTouchable(false)
		require("app.core.common.Route").new(self._ownEntity, var_20_1):moveToEndOfRoute({
			isAnim = true,
			finishFunc = handler(self, function()
				self:setTouchable(true)

				self._curGold = var_0_5:getCurGold()

				self:_updateGoldProgState(var_20_0)
				self:_checkGoldSchedule()
				self:dispatchCompEvent("Mine_Move_City_move_end")
				g.core.module.ModuleManager:pushModule(g.view.entrance.MINE_CITY, {
					struct = var_0_5:getCityObjById(var_20_0)
				})

				self._onTheWay = false

				self:_checkDelayUpdate()
				self:showShieldEff(true)
			end)
		})
	end
end

function MineMapComp:updateAllCity(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	self._ownCity = var_0_5:getOwnCity()
	self._isOutputGold = var_0_5:isOutputGold()
	self._goldRadio = var_0_5:getGoldRadio()

	local var_22_0 = arg_22_4.cityId
	local var_22_1, var_22_2

	if not arg_22_4.cityId then
		var_22_0 = {}
		var_22_1 = g.model.User.mineData:getCityObjMap()
		var_22_2 = {}
	end

	var_22_2.struct = var_22_1[var_22_0[1]]

	self.m_cityComp:getChild("Comp_city_" .. var_22_0[1]):updateCity(var_22_2)
	self.m_cityComp:getChild("Comp_city_" .. var_22_0[#var_22_0]):updateCity({
		struct = var_22_1[var_22_0[#var_22_0]]
	})
end

function MineMapComp:getMainPlayer()
	return self._ownEntity
end

function MineMapComp:updateLandView()
	local var_24_0 = var_0_5:getTimeStage()

	if var_24_0 == MineConst.TIME_STAGE.NOT_AVAILABLE or var_24_0 == MineConst.TIME_STAGE.RESULT then
		return
	end

	self._ownCity = var_0_5:getOwnCity()

	if not self._ownEntity then
		self._ownEntity = fgui.UIPackage:createObject("base_new", "BasePlaceHolderComp")

		self._ownEntity:addChild((CommonKnight.new((g.core.common.GlobalFunc.getRoleSkinParamsBySnapShot((g.core.model.User:packUser()))))))
		self._ownEntity:setScale(0.6 * var_0_2)
		self._ownEntity:displayObject():setRotation3D({
			z = 0,
			y = 0,
			x = -MineConst.X_ROTATE
		})
		self.m_playerComp:addChild(self._ownEntity)
		self._ownEntity:setPosition(MineConfig[self._ownCity .. "_stand"])
		self:showShieldEff(true)
	end

	self._ownCity = var_0_5:getOwnCity()
	self._isOutputGold = var_0_5:isOutputGold()
	self._goldRadio = var_0_5:getGoldRadio()
	self._curGold = var_0_5:getCurGold()

	self:_updateCity()
	self:_updateMainPlayer()
	self:_checkGoldSchedule()
	self:_updateGoldProgState(self._ownCity)
	self:_checkMainDead()
end

function MineMapComp:_updateCity()
	for iter_25_0, iter_25_1 in pairs((var_0_5:getCityObjMap())) do
		local var_25_0 = self.m_cityComp:getChild("Comp_city_" .. iter_25_0)

		if not var_25_0 then
			var_25_0 = fgui.UIPackage:createObject("mine", "MineCityComp", self)

			var_25_0:setScale(var_0_2)
			self.m_cityComp:addChild(var_25_0)
			var_25_0:setPosition(MineConfig["Comp_city_" .. iter_25_0])
			var_25_0:setName("Comp_city_" .. iter_25_0)
			var_25_0:displayObject():setRotation3D({
				z = 0,
				y = 0,
				x = -MineConst.X_ROTATE
			})
			var_25_0:setSortingOrder(MineConfig["Comp_city_" .. iter_25_0].y)
		end

		var_25_0:updateCity(iter_25_1)
	end
end

function MineMapComp:_checkGoldSchedule()
	self._circleTime = 0

	if self._isOutputGold and self._curGold < self._maxGold then
		if self._goldSchedule then
			self:cancelSchedule(self._goldSchedule)
		end

		self._goldSchedule = self:newSchedule(handler(self, self._updateCountDown), 0)
	elseif self._goldSchedule then
		self:cancelSchedule(self._goldSchedule)

		self._goldSchedule = nil
	end
end

function MineMapComp:_stopGoldSchedule()
	if self._goldSchedule then
		self:cancelSchedule(self._goldSchedule)

		self._goldSchedule = nil
	end
end

function MineMapComp:getMapPosByCityId(arg_28_1)
	local var_28_0 = self.m_cityComp:getChild("Comp_city_" .. arg_28_1)

	if not var_28_0 then
		return
	end

	local var_28_1 = var_28_0:getPosition()
	local var_28_2 = var_28_0:getSize()

	return var_28_1.x + var_28_2.width / 2, var_28_1.y + var_28_2.height / 2
end

function MineMapComp:_updateCountDown(arg_29_1, arg_29_2)
	if self._goldRadio <= 0 then
		return
	end

	if self._circleTime >= self._goldRadio then
		self._goldRadio = var_0_5:getGoldRadio()

		self.m_awardComp:updateGoldProg(0)

		self._curGold = self._curGold + 1

		self:_updateGoldProgState(self._ownCity)

		self._circleTime = arg_29_2

		if self._curGold >= self._maxGold then
			self:cancelSchedule(self._goldSchedule)

			self._goldSchedule = nil
		end
	else
		self._circleTime = self._circleTime + arg_29_2

		self.m_awardComp:updateGoldProg(100 * self._circleTime / self._goldRadio)
	end
end

function MineMapComp:getMainRolePos()
	if self._ownEntity then
		return (self._ownEntity:getPosition())
	else
		return {
			x = 0,
			y = 0
		}
	end
end

function MineMapComp:_onRcvMineMass(arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	self:_updateMass()
end

function MineMapComp:_onRcvMineMassNotify(arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	self:_updateMass()
end

function MineMapComp:getCityPosById(arg_33_1)
	return self.m_cityComp:getChild("Comp_city_" .. arg_33_1):getPosition()
end

function MineMapComp:_updateMass()
	local var_34_0 = var_0_5:getLastGatherCityId()

	if var_34_0 > 0 then
		local var_34_1 = self.m_cityComp:getChild("Comp_city_" .. var_34_0)

		if var_34_1 then
			var_34_1:updateCity((var_0_5:getCityObjById(var_34_0)))
		end
	end

	if var_0_5:isGathering() then
		local var_34_2 = var_0_5:getGatherCityId()

		if var_34_2 > 0 then
			local var_34_3 = self.m_cityComp:getChild("Comp_city_" .. var_34_2)

			if var_34_3 then
				var_34_3:updateCity((var_0_5:getCityObjById(var_34_2)))
			end
		end
	end
end

function MineMapComp:showShieldEff(arg_35_1)
	if not var_0_5:isMeHasShield() then
		-- block empty
	end

	if not self._shieldEff then
		self._shieldEff = self._ownEntity:addEffectSpine({
			y = 120,
			name = "eff_ui_mine_shield",
			x = 0,
			isLoop = true
		})
	else
		self._shieldEff:setVisible(arg_35_1)
	end
end

function MineMapComp:checkShieldInTime()
	if not var_0_5:isMeHasShield() then
		if self._shieldEff then
			self._shieldEff:setVisible(false)
		end
	elseif self._shieldEff then
		self._shieldEff:setVisible(true)
	elseif self._ownEntity then
		self._shieldEff = self._ownEntity:addEffectSpine({
			y = 120,
			name = "eff_ui_mine_shield",
			x = 0,
			isLoop = true
		})
	end
end

function MineMapComp:onUnload()
	self:cancelAllSchedule()
end

return MineMapComp
