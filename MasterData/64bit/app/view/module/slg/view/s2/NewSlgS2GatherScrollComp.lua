local var_0_0 = g.core.model.User.newSlgData
local var_0_1 = g.core.model.User.allianceData
local NewSlgS2GatherScrollComp = class("NewSlgS2GatherScrollComp")
local var_0_3 = g.core.const.ConstMgr.NewSlgConst
local var_0_4 = 364
local var_0_5 = 0

function NewSlgS2GatherScrollComp:ctor()
	self._compPlace = self:getChild("Comp_place")
	self._compPlace2 = self:getChild("Comp_place2")
	self._oriX = self._compPlace:getX()
	self._emptyCtrl = self:getController("isEmpty")
end

function NewSlgS2GatherScrollComp:updateView()
	self._compPlace:removeChildren()

	self._lastComp = nil

	self:_updateCityTeam()
	self:_updateFarmTeam()
	self:_updateBossTeam()

	if #self._attDataArr > 0 then
		local var_2_0 = fgui.UIPackage:createObject("newSlg", "NewSlgS2GatherTitle", self)

		self._compPlace:addChild(var_2_0)
		var_2_0:setPosition(cc.p(self._oriX, self:_getH()))
		var_2_0:setTitle(g.core.lang:get(429625))
		var_2_0:setCtrlState("gatherType", {
			index = var_0_3.Slg2GatherType.ATTACK
		})

		self._lastComp = var_2_0

		for iter_2_0, iter_2_1 in ipairs(self._attDataArr) do
			self:_addGatherCell(iter_2_1)
		end
	end

	if #self._defDataArr > 0 then
		local var_2_1 = fgui.UIPackage:createObject("newSlg", "NewSlgS2GatherTitle", self)

		self._compPlace:addChild(var_2_1)
		var_2_1:setPosition(cc.p(self._oriX, self:_getH()))
		var_2_1:setTitle(g.core.lang:get(429626))
		var_2_1:setCtrlState("gatherType", {
			index = var_0_3.Slg2GatherType.DEFEND
		})

		self._lastComp = var_2_1

		for iter_2_2, iter_2_3 in ipairs(self._defDataArr) do
			self:_addGatherCell(iter_2_3)
		end
	end

	if #self._statusArr > 0 then
		local var_2_2 = fgui.UIPackage:createObject("newSlg", "NewSlgS2GatherTitle", self)

		self._compPlace:addChild(var_2_2)
		var_2_2:setPosition(cc.p(self._oriX, self:_getH()))
		var_2_2:setTitle(g.core.lang:get(429572))
		var_2_2:setCtrlState("gatherType", {
			index = var_0_3.Slg2GatherType.BOSS
		})

		self._lastComp = var_2_2

		for iter_2_4, iter_2_5 in ipairs(self._statusArr) do
			self:_addGatherCell(iter_2_5)
		end
	end

	if #self._attDataArr == 0 and #self._defDataArr == 0 and #self._statusArr == 0 then
		self._emptyCtrl:setSelectedIndex(1)

		return false
	end

	self._emptyCtrl:setSelectedIndex(0)

	local var_2_3 = var_0_4

	if self._lastComp then
		local var_2_4 = self._lastComp:getY() + self._lastComp:getHeight() + 10 + self._compPlace:getY()

		self._compPlace2:setY(var_2_4)

		var_2_3 = math.min(var_0_4, var_2_4)
	end

	return true, var_2_3
end

function NewSlgS2GatherScrollComp:_addGatherCell(arg_3_1)
	local var_3_0 = fgui.UIPackage:createObject("newSlg", "NewSlgS2GatherCompCell", self)

	self._compPlace:addChild(var_3_0)
	var_3_0:setPosition(cc.p(self._oriX, self:_getH()))
	var_3_0:updateCell(arg_3_1)

	self._lastComp = var_3_0
end

function NewSlgS2GatherScrollComp:_updateCityTeam()
	self._attDataArr = {}
	self._defDataArr = {}

	local var_4_0 = var_0_0:getCityPeriod()

	if var_4_0 == var_0_3.Slg2CityState.declare_war then
		self:_updateCityDeclarePeriod()
	elseif var_4_0 == var_0_3.Slg2CityState.gather then
		self:_updateCityGatherPeriod()
	elseif var_4_0 == var_0_3.Slg2CityState.battle then
		self:_updateCityBattlePeriod()
	end

	if var_4_0 == var_0_3.Slg2CityState.declare_war then
		self:_updateCityDeclarePeriod2()
	elseif var_4_0 == var_0_3.Slg2CityState.gather then
		self:_updateCityGatherPeriod2()
	elseif var_4_0 == var_0_3.Slg2CityState.battle then
		self:_updateCityBattlePeriod2()
	end
end

function NewSlgS2GatherScrollComp:_updateBossTeam()
	self._statusArr = {}

	for iter_5_0, iter_5_1 in pairs((var_0_0:getMyTeamMap())) do
		local var_5_0 = var_0_0:getTeamStateByTeam(iter_5_1)

		if var_5_0.monsterType == var_0_3.MONSTER_TYPE.BOSS and (var_5_0.state == var_0_3.TEAM_CLIENT_STATUS_TYPE.FIGHTING or var_5_0.state == var_0_3.TEAM_CLIENT_STATUS_TYPE.MARCHING) then
			table.insert(self._statusArr, {
				showBtnType = 2,
				hasDeclare = true,
				gatherType = 2,
				period = 0,
				titleDesc = var_5_0.text,
				st = var_5_0.startTime,
				et = var_5_0.startTime + var_5_0.totalTime,
				teamId = var_5_0.teamId
			})
		end
	end
end

function NewSlgS2GatherScrollComp:_updateFarmTeam()
	self._atkingFarmTeamArr = {}

	for iter_6_0, iter_6_1 in ipairs((g.core.model.User.newSlgData:getAtkingFarmArr())) do
		table.insert(self._atkingFarmTeamArr, {
			showBtnType = 2,
			gatherType = 3,
			showType = 0,
			farmInfo = iter_6_1,
			titleDesc = g.core.lang:get("NEW_SLG_FARM_TEAM_DESC7", {
				name = iter_6_1.name,
				level = iter_6_1.level
			})
		})
	end

	self._occingFarmTeamArr = {}

	for iter_6_2, iter_6_3 in ipairs((g.core.model.User.newSlgData:getOccingFarmArr())) do
		table.insert(self._occingFarmTeamArr, {
			showBtnType = 2,
			gatherType = 3,
			showType = 0,
			farmInfo = iter_6_3,
			titleDesc = g.core.lang:get("NEW_SLG_FARM_TEAM_DESC8", {
				name = iter_6_3.name,
				level = iter_6_3.level
			})
		})
	end
end

function NewSlgS2GatherScrollComp:_updateCityBattlePeriod()
	local var_7_0, var_7_1, var_7_2 = var_0_0:getCityPeriod()
	local var_7_3 = var_0_0:getCanDeclareCities()

	if #var_7_3 == 0 then
		table.insert(self._attDataArr, {
			showBtnType = 1,
			gatherType = 0,
			showType = 1,
			st = var_7_1,
			et = var_7_2,
			period = var_7_0,
			titleDesc = g.core.lang:get(429639)
		})
	else
		for iter_7_0, iter_7_1 in ipairs(var_7_3) do
			local var_7_4 = var_0_0:getCityInfoById(iter_7_1)

			if var_0_0:getSelfGatherNum(iter_7_1) > 0 and var_0_0:isChariotMoveTime() or var_0_0:isCityFighting(iter_7_1) then
				table.insert(self._attDataArr, {
					gatherType = 0,
					showBtnType = 2,
					hasDeclare = true,
					showType = 1,
					st = var_7_1,
					et = var_7_2,
					period = var_7_0,
					cityInfo = var_7_4,
					titleDesc = g.core.lang:get(429637, {
						level = var_7_4.level,
						name = var_7_4.name
					})
				})
			end
		end
	end
end

function NewSlgS2GatherScrollComp:_updateCityBattlePeriod2()
	local var_8_0, var_8_1, var_8_2 = var_0_0:getCityPeriod()
	local var_8_3 = var_0_1:getAllianceId()

	for iter_8_0, iter_8_1 in ipairs(var_0_0:getAllianceData().occupiedCities) do
		local var_8_4 = var_0_0:getCityInfoById(iter_8_1)
		local var_8_5 = var_0_0:getOtherGatherNum(iter_8_1)
		local var_8_6 = false

		for iter_8_2, iter_8_3 in ipairs((var_0_0:getCityDeclaredAlliances(iter_8_1))) do
			if iter_8_3 ~= var_8_3 and var_0_0:isChariotMoveTime() and var_8_5 > 0 then
				var_8_6 = true

				break
			end
		end

		if not var_8_6 and var_0_0:isCityFighting(iter_8_1) then
			var_8_6 = true
		end

		if var_8_6 then
			table.insert(self._defDataArr, {
				gatherType = 1,
				showBtnType = 2,
				hasDeclare = true,
				showType = 1,
				st = var_8_1,
				et = var_8_2,
				cityInfo = var_8_4,
				period = var_8_0,
				titleDesc = g.core.lang:get(429638, {
					level = var_8_4.level,
					name = var_8_4.name
				})
			})
		end
	end
end

function NewSlgS2GatherScrollComp:_updateCityGatherPeriod()
	local var_9_0, var_9_1, var_9_2 = var_0_0:getCityPeriod()
	local var_9_3 = var_0_0:getNextAttackCityIds()

	if #var_9_3 == 1 and var_9_3[1] == 0 then
		table.insert(self._attDataArr, {
			showBtnType = 1,
			hasDeclare = false,
			gatherType = 0,
			period = var_9_0,
			st = var_9_1,
			et = var_9_2,
			titleDesc = g.core.lang:get(429640)
		})
	else
		for iter_9_0, iter_9_1 in ipairs(var_9_3) do
			local var_9_4 = var_0_0:getCityInfoById(iter_9_1)

			table.insert(self._attDataArr, {
				showBtnType = 3,
				hasDeclare = true,
				gatherType = 0,
				period = var_9_0,
				st = var_9_1,
				et = var_9_2,
				cityInfo = var_9_4,
				titleDesc = g.core.lang:get(429048, {
					level = var_9_4.level,
					name = var_9_4.name
				})
			})
		end
	end
end

function NewSlgS2GatherScrollComp:_updateCityGatherPeriod2()
	local var_10_0, var_10_1, var_10_2 = var_0_0:getCityPeriod()
	local var_10_3 = var_0_1:getAllianceId()

	for iter_10_0, iter_10_1 in ipairs(var_0_0:getAllianceData().occupiedCities) do
		for iter_10_2, iter_10_3 in ipairs((var_0_0:getCityDeclaredAlliances(iter_10_1))) do
			if iter_10_3 ~= var_10_3 then
				local var_10_4 = var_0_0:getCityInfoById(iter_10_1)

				table.insert(self._defDataArr, {
					showBtnType = 3,
					hasDeclare = true,
					gatherType = 1,
					st = var_10_1,
					et = var_10_2,
					cityInfo = var_10_4,
					period = var_10_0,
					titleDesc = g.core.lang:get(429636, {
						level = var_10_4.level,
						name = var_10_4.name
					})
				})

				break
			end
		end
	end
end

function NewSlgS2GatherScrollComp:_updateCityDeclarePeriod()
	local var_11_0, var_11_1, var_11_2 = var_0_0:getCityPeriod()
	local var_11_3 = var_0_0:getAllianceData().declareCities

	if #var_11_3 == 0 then
		table.insert(self._attDataArr, {
			showBtnType = 1,
			hasDeclare = false,
			gatherType = var_0_3.Slg2GatherType.ATTACK,
			period = var_11_0,
			st = var_11_1,
			et = var_11_2,
			titleDesc = g.core.lang:get(429633)
		})
	else
		for iter_11_0, iter_11_1 in ipairs(var_11_3) do
			local var_11_4 = var_0_0:getCityInfoById(iter_11_1)

			table.insert(self._attDataArr, {
				showBtnType = 2,
				hasDeclare = true,
				gatherType = var_0_3.Slg2GatherType.ATTACK,
				period = var_11_0,
				st = var_11_1,
				et = var_11_2,
				cityInfo = var_11_4,
				titleDesc = g.core.lang:get(429634, {
					level = var_11_4.level,
					name = var_11_4.name
				})
			})
		end
	end
end

function NewSlgS2GatherScrollComp:_updateCityDeclarePeriod2()
	local var_12_0, var_12_1, var_12_2 = var_0_0:getCityPeriod()
	local var_12_3 = var_0_1:getAllianceId()

	for iter_12_0, iter_12_1 in ipairs(var_0_0:getAllianceData().occupiedCities) do
		for iter_12_2, iter_12_3 in ipairs((var_0_0:getCityDeclaredAlliances(iter_12_1))) do
			if iter_12_3 ~= var_12_3 then
				local var_12_4 = var_0_0:getCityInfoById(iter_12_1)

				table.insert(self._defDataArr, {
					showBtnType = 2,
					hasDeclare = true,
					gatherType = 1,
					st = var_12_1,
					et = var_12_2,
					cityInfo = var_12_4,
					period = var_12_0,
					titleDesc = g.core.lang:get(429635, {
						level = var_12_4.level,
						name = var_12_4.name
					})
				})

				break
			end
		end
	end
end

function NewSlgS2GatherScrollComp:_getH()
	if not self._lastComp then
		return 0
	end

	return self._lastComp:getY() + self._lastComp:getHeight() + var_0_5
end

return NewSlgS2GatherScrollComp
