local KsAStar = require("app.core.utils.KsAStar")
local KsMath = require("app.core.utils.KsMath")
local MapConst = require("app.core.ksmap.MapConst")
local ThemeBioMapGround = import(".ThemeBioMapGround")
local ThemeGameTouch = import(".ThemeGameTouch")
local ThemeBioMapConst = import(".ThemeBioMapConst")
local var_0_6 = g.core.model.User.themeData
local ThemeBioGameWorld = class("ThemeBioGameWorld", require("app.core.ksmap.MapWorld"))

function ThemeBioGameWorld:ctor(arg_1_1, arg_1_2, arg_1_3)
	self:setAutoRoleSkin(false)

	self._refMainRole = nil
	self._bindEntityDict = {}

	self:setAutoRoleSkin(false)
	ThemeBioGameWorld.super.ctor(self, arg_1_1, arg_1_2)

	self._refTalkTarget = nil
	self._followCenter = nil
	self._chapterInfo = nil
	self._activeThemeValue = arg_1_3 or 1
	self._themeBioData = var_0_6:getThemeData(self._activeThemeValue):getThemeBioData()
end

function ThemeBioGameWorld:startWorld()
	local var_2_0 = self:getMapStage():getStayCoord()

	if var_2_0 == nil then
		var_2_0 = self:getOrgCoord()
	else
		self._refMainRole:jump2Coord(var_2_0)
	end

	self:jump2MainRole()
end

function ThemeBioGameWorld:_doTickUpdate(arg_3_1)
	if self._refMainRole:tickWalk(arg_3_1) then
		self:getMapStage():saveStayCoord(self._refMainRole:getCoord())

		if self._refTalkTarget then
			self:getMapStage():talkTrigger(self._refTalkTarget)
			self:_setTalkTarget(nil)
		end
	end

	self:_checkFollowing(arg_3_1)
	self:_autoInertiaUpdate(arg_3_1)
	self:_checkEntityInView()
	self:_checkNameInit()
	self:getMapStage():refreshTargetVector()
end

function ThemeBioGameWorld:getBindEntity(arg_4_1)
	return self._bindEntityDict[arg_4_1]
end

function ThemeBioGameWorld:refreshEntityState(arg_5_1)
	self._chapterInfo = arg_5_1

	for iter_5_0, iter_5_1 in pairs(self._bindEntityDict) do
		local var_5_0 = false
		local var_5_1 = 0
		local var_5_2 = true

		if not iter_5_1:getIsInteractEntity() then
			assert(arg_5_1.res[iter_5_0], "has resId " .. iter_5_0 .. " in map with no mission")

			for iter_5_2, iter_5_3 in ipairs(arg_5_1.res[iter_5_0]) do
				local var_5_3 = self._themeBioData:getMission(iter_5_3)

				self:_refreshRoleEntityName(iter_5_1, var_5_3.resource_name)

				var_5_0 = var_5_0 or var_5_3.canShow

				local var_5_4 = self._themeBioData:getChain(var_5_3.chain)

				if (var_5_4.type == 2 or var_5_4.type == 4) and var_5_3.canTrigger and var_5_3.if_show_point == 1 then
					var_5_1 = 1
				end

				if var_5_3.repeatable == 1 and var_5_3.type == 1 and var_5_3.unlock then
					if var_5_4.type == 2 or var_5_4.type == 4 then
						var_5_2 = false
					end

					var_5_1 = 2
				end

				if var_5_4.type == 1 and var_5_3.unlock and not var_5_3.finish then
					var_5_1 = 3
				end
			end
		else
			var_5_0 = true
		end

		iter_5_1:setShow(var_5_0)
		iter_5_1:setSignShow(var_5_1, var_5_2)
	end
end

function ThemeBioGameWorld:autoRouteTalk(arg_6_1, arg_6_2)
	self:_setTalkTarget(arg_6_1)

	local var_6_0 = KsAStar.searchTalkPath(self._refMainRole:getCoord(), arg_6_1:getCoord(), self)

	if var_6_0 == nil then
		g.core.module.ModuleManager:tip(g.core.lang:get(409105))
	else
		self._refMainRole:walkStart(var_6_0, arg_6_2)
	end
end

function ThemeBioGameWorld:autoRouteTo(arg_7_1)
	self:_setTalkTarget(nil)

	local var_7_0 = self._refMainRole:getCoord()

	if KsMath.IsSameCoord(var_7_0, arg_7_1) then
		return false
	end

	local var_7_1 = KsAStar.searchNearPath(var_7_0, arg_7_1, self)

	if var_7_1 == nil then
		g.core.module.ModuleManager:tip(g.core.lang:get(409105))
	else
		self._refMainRole:walkStart(var_7_1)
	end
end

function ThemeBioGameWorld:onSingleClick(arg_8_1)
	self:getMapStage():pickupStop()

	local var_8_0 = self:convertToNodeSpace(arg_8_1)
	local var_8_1, var_8_2 = self:getMapGround():pixelToCoord(var_8_0.x, var_8_0.y)

	if self:getMapGround():checkCoordInvalid(var_8_1, var_8_2) then
		g.core.module.ModuleManager:tip(g.core.lang:get(409106))

		return
	end

	self._refMainRole:walkStop()

	local var_8_3 = self:_checkEntityHit(var_8_0)

	if var_8_3 then
		self:autoRouteTalk(var_8_3)
	else
		self:autoRouteTo((cc.p(var_8_1, var_8_2)))
	end
end

function ThemeBioGameWorld:setFollowCenter(arg_9_1)
	self._followCenter = arg_9_1
end

function ThemeBioGameWorld:jump2MainRole()
	self:moveCell2SC((self._refMainRole:getCoord()))
end

function ThemeBioGameWorld:stopWalkRole()
	self._refMainRole:walkStop()
end

function ThemeBioGameWorld:startInertiaWorld(arg_12_1, arg_12_2)
	if self._followCenter then
		return
	end

	self._autoInertiaDir = arg_12_1

	if self._autoInertiaDir == nil then
		return
	end

	self._autoInertiaDist = arg_12_2 * ThemeBioMapConst.INER_SENSITITY
end

function ThemeBioGameWorld:doCanMoveAStar(arg_13_1, arg_13_2)
	local var_13_0 = self:getMapGround()

	if var_13_0:checkCoordInvalid(arg_13_2.x, arg_13_2.y) then
		return false
	end

	return var_13_0:getHoldType(arg_13_2.x, arg_13_2.y) ~= nil
end

function ThemeBioGameWorld:_doCreateGround()
	return ThemeBioMapGround.new(self)
end

function ThemeBioGameWorld:_doCreateTouch()
	return nil
end

function ThemeBioGameWorld:_doInitTouchMatch()
	self._mapTouch = ThemeGameTouch.new(self)
end

function ThemeBioGameWorld:_doAddEntity(arg_17_1)
	if arg_17_1:isMainRole() then
		self._refMainRole = arg_17_1

		self._refMainRole:setInView(true)

		local var_17_0 = g.core.config.knight_base_info.get(tonumber(arg_17_1:getResId())).name

		if var_17_0 and var_17_0 ~= "" then
			arg_17_1:setRoleName(var_17_0)
		end
	end

	local var_17_1 = arg_17_1:getBindID()

	if var_17_1 > 0 then
		self._bindEntityDict[var_17_1] = arg_17_1
	end
end

function ThemeBioGameWorld:_doDelEntity(arg_18_1)
	local var_18_0 = arg_18_1:getBindID()

	if var_18_0 > 0 then
		self._bindEntityDict[var_18_0] = nil
	end
end

function ThemeBioGameWorld:doDragWorld(arg_19_1)
	if self._followCenter then
		return
	end

	self:moveWorld(arg_19_1)
	self:_checkRoleInScreen()
end

function ThemeBioGameWorld:_checkEntityHit(arg_20_1)
	for iter_20_0, iter_20_1 in pairs(self._bindEntityDict) do
		if iter_20_1 ~= self._refMainRole and iter_20_1:checkHit(arg_20_1) then
			return iter_20_1
		end
	end

	return nil
end

function ThemeBioGameWorld:_setTalkTarget(arg_21_1)
	self._refTalkTarget = arg_21_1
end

function ThemeBioGameWorld:_checkFollowing(arg_22_1)
	if self._followCenter == nil then
		return
	end

	local var_22_0 = self:convertScreenCenter()
	local var_22_1 = KsMath.calculateDistance(self._followCenter, var_22_0)

	if var_22_1 < 50 then
		self._followCenter = nil

		return
	end

	local var_22_2, var_22_3 = self:movePA2PB(self._followCenter, (KsMath.walkDistance(self._followCenter, var_22_0, MapConst.MOVE_SPEED * (var_22_1 / 200) * arg_22_1)))

	if var_22_2 or var_22_3 then
		self._followCenter = nil
	end
end

function ThemeBioGameWorld:_checkRoleInScreen()
	local var_23_0 = self._refMainRole:getWorldPos()
	local var_23_1 = self:convertScreenCenter()

	if KsMath.rectIn(var_23_0, var_23_1, display.width / 2, display.height / 2) then
		self:getMapStage():setHeadArrow(false)

		return true
	end

	local var_23_2 = cc.p(50, display.height / 2)

	if var_23_0.x > var_23_1.x then
		var_23_2.x = display.width - 50
	end

	self:getMapStage():setHeadArrow(true, var_23_2.x, (KsMath.calculateRotation(self:convertToNodeSpace(var_23_2), var_23_0)))

	return false
end

function ThemeBioGameWorld:_autoInertiaUpdate(arg_24_1)
	if self._autoInertiaDir == nil then
		return
	end

	local var_24_0, var_24_1 = self:moveWorld(cc.p(self._autoInertiaDir.x * self._autoInertiaDist, self._autoInertiaDir.y * self._autoInertiaDist))

	self._autoInertiaDist = self._autoInertiaDist - ThemeBioMapConst.INER_ACCE

	if var_24_0 or var_24_1 or self._autoInertiaDist <= 0 then
		self._autoInertiaDir = nil
	end
end

function ThemeBioGameWorld:_refreshRoleEntityName(arg_25_1, arg_25_2)
	if arg_25_1:getResType() == MapConst.RESTYPE.KNIGHT then
		if arg_25_2 and arg_25_2 ~= "" and arg_25_1:setRoleName(arg_25_2) then
			arg_25_1:setNameInit(true)
		end
	end
end

function ThemeBioGameWorld:_checkNameInit()
	if self._chapterInfo then
		for iter_26_0, iter_26_1 in pairs(self._bindEntityDict) do
			if not iter_26_1:getNameIsInit() and iter_26_1:isHasVisualIns() and not iter_26_1:getIsInteractEntity() then
				for iter_26_2, iter_26_3 in ipairs(self._chapterInfo.res[iter_26_0]) do
					self:_refreshRoleEntityName(iter_26_1, self._themeBioData:getMission(iter_26_3).resource_name)
				end
			end
		end
	end
end

return ThemeBioGameWorld
