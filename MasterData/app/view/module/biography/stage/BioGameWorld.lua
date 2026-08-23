local KsAStar = require("app.core.utils.KsAStar")
local KsMath = require("app.core.utils.KsMath")
local MapConst = require("app.core.ksmap.MapConst")
local BioMapGround = import(".BioMapGround")
local BioGameTouch = import(".BioGameTouch")
local BioMapConst = import(".BioMapConst")
local BioGameWorld = class("BioGameWorld", require("app.core.ksmap.MapWorld"))

function BioGameWorld:ctor(arg_1_1, arg_1_2)
	self._refMainRole = nil
	self._bindEntityDict = {}

	self:setAutoRoleSkin(false)
	BioGameWorld.super.ctor(self, arg_1_1, arg_1_2)

	self._refTalkTarget = nil
	self._followCenter = nil
	self._chapterInfo = nil
end

function BioGameWorld:startWorld()
	local var_2_0 = self:getMapStage():getStayCoord()

	if var_2_0 == nil then
		var_2_0 = self:getOrgCoord()
	else
		self._refMainRole:jump2Coord(var_2_0)
	end

	self:jump2MainRole()
end

function BioGameWorld:_doTickUpdate(arg_3_1)
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

function BioGameWorld:getBindEntity(arg_4_1)
	return self._bindEntityDict[arg_4_1]
end

function BioGameWorld:refreshEntityState(arg_5_1)
	self._chapterInfo = arg_5_1

	for iter_5_0, iter_5_1 in pairs(self._bindEntityDict) do
		local var_5_0 = false
		local var_5_1 = 0
		local var_5_2 = true

		if not iter_5_1:getIsInteractEntity() then
			assert(arg_5_1.res[iter_5_0], "has resId " .. iter_5_0 .. " in map with no mission")

			for iter_5_2, iter_5_3 in ipairs(arg_5_1.res[iter_5_0]) do
				local var_5_3 = g.core.model.User.bioData:getMission(iter_5_3)

				self:_refreshRoleEntityName(iter_5_1, var_5_3.resource_name)

				var_5_0 = var_5_0 or var_5_3.canShow

				local var_5_4 = g.core.model.User.bioData:getChain(var_5_3.chain)

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

function BioGameWorld:autoRouteTalk(arg_6_1, arg_6_2)
	self:_setTalkTarget(arg_6_1)

	local var_6_0 = KsAStar.searchTalkPath(self._refMainRole:getCoord(), arg_6_1:getCoord(), self)

	if var_6_0 == nil then
		g.core.module.ModuleManager:tip(g.core.lang:get(302069))
	else
		self._refMainRole:walkStart(var_6_0, arg_6_2)
	end
end

function BioGameWorld:autoRouteTo(arg_7_1)
	self:_setTalkTarget(nil)

	local var_7_0 = self._refMainRole:getCoord()

	if KsMath.IsSameCoord(var_7_0, arg_7_1) then
		return false
	end

	local var_7_1 = KsAStar.searchNearPath(var_7_0, arg_7_1, self)

	if var_7_1 == nil then
		g.core.module.ModuleManager:tip(g.core.lang:get(302069))
	else
		self._refMainRole:walkStart(var_7_1)
	end
end

function BioGameWorld:onSingleClick(arg_8_1)
	self:getMapStage():pickupStop()

	local var_8_0 = self:convertToNodeSpace(arg_8_1)
	local var_8_1, var_8_2 = self:getMapGround():pixelToCoord(var_8_0.x, var_8_0.y)

	if self:getMapGround():checkCoordInvalid(var_8_1, var_8_2) then
		g.core.module.ModuleManager:tip(g.core.lang:get(302070))

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

function BioGameWorld:setFollowCenter(arg_9_1)
	self._followCenter = arg_9_1
end

function BioGameWorld:jump2MainRole()
	self:moveCell2SC((self._refMainRole:getCoord()))
end

function BioGameWorld:startInertiaWorld(arg_11_1, arg_11_2)
	if self._followCenter then
		return
	end

	self._autoInertiaDir = arg_11_1

	if self._autoInertiaDir == nil then
		return
	end

	self._autoInertiaDist = arg_11_2 * BioMapConst.INER_SENSITITY
end

function BioGameWorld:doCanMoveAStar(arg_12_1, arg_12_2)
	local var_12_0 = self:getMapGround()

	if var_12_0:checkCoordInvalid(arg_12_2.x, arg_12_2.y) then
		return false
	end

	return var_12_0:getHoldType(arg_12_2.x, arg_12_2.y) ~= nil
end

function BioGameWorld:_doCreateGround()
	return BioMapGround.new(self)
end

function BioGameWorld:_doCreateTouch()
	return nil
end

function BioGameWorld:_doInitTouchMatch()
	self._mapTouch = BioGameTouch.new(self)
end

function BioGameWorld:_doAddEntity(arg_16_1)
	if arg_16_1:isMainRole() then
		self._refMainRole = arg_16_1

		self._refMainRole:setInView(true)

		local var_16_0 = g.core.config.knight_base_info.get(tonumber(arg_16_1:getResId())).name

		if var_16_0 and var_16_0 ~= "" then
			arg_16_1:setRoleName(var_16_0)
		end
	end

	local var_16_1 = arg_16_1:getBindID()

	if var_16_1 > 0 then
		self._bindEntityDict[var_16_1] = arg_16_1
	end
end

function BioGameWorld:_doDelEntity(arg_17_1)
	local var_17_0 = arg_17_1:getBindID()

	if var_17_0 > 0 then
		self._bindEntityDict[var_17_0] = nil
	end
end

function BioGameWorld:doDragWorld(arg_18_1)
	if self._followCenter then
		return
	end

	self:moveWorld(arg_18_1)
	self:_checkRoleInScreen()
end

function BioGameWorld:_checkEntityHit(arg_19_1)
	for iter_19_0, iter_19_1 in pairs(self._bindEntityDict) do
		if iter_19_1 ~= self._refMainRole and iter_19_1:checkHit(arg_19_1) then
			return iter_19_1
		end
	end

	return nil
end

function BioGameWorld:_setTalkTarget(arg_20_1)
	self._refTalkTarget = arg_20_1
end

function BioGameWorld:_checkFollowing(arg_21_1)
	if self._followCenter == nil then
		return
	end

	local var_21_0 = self:convertScreenCenter()
	local var_21_1 = KsMath.calculateDistance(self._followCenter, var_21_0)

	if var_21_1 < 50 then
		self._followCenter = nil

		return
	end

	local var_21_2, var_21_3 = self:movePA2PB(self._followCenter, (KsMath.walkDistance(self._followCenter, var_21_0, MapConst.MOVE_SPEED * (var_21_1 / 200) * arg_21_1)))

	if var_21_2 or var_21_3 then
		self._followCenter = nil
	end
end

function BioGameWorld:_checkRoleInScreen()
	local var_22_0 = self._refMainRole:getWorldPos()
	local var_22_1 = self:convertScreenCenter()

	if KsMath.rectIn(var_22_0, var_22_1, display.width / 2, display.height / 2) then
		self:getMapStage():setHeadArrow(false)

		return true
	end

	local var_22_2 = cc.p(50, display.height / 2)

	if var_22_0.x > var_22_1.x then
		var_22_2.x = display.width - 50
	end

	self:getMapStage():setHeadArrow(true, var_22_2.x, (KsMath.calculateRotation(self:convertToNodeSpace(var_22_2), var_22_0)))

	return false
end

function BioGameWorld:_autoInertiaUpdate(arg_23_1)
	if self._autoInertiaDir == nil then
		return
	end

	local var_23_0, var_23_1 = self:moveWorld(cc.p(self._autoInertiaDir.x * self._autoInertiaDist, self._autoInertiaDir.y * self._autoInertiaDist))

	self._autoInertiaDist = self._autoInertiaDist - BioMapConst.INER_ACCE

	if var_23_0 or var_23_1 or self._autoInertiaDist <= 0 then
		self._autoInertiaDir = nil
	end
end

function BioGameWorld:_refreshRoleEntityName(arg_24_1, arg_24_2)
	if arg_24_1:getResType() == MapConst.RESTYPE.KNIGHT then
		if arg_24_2 and arg_24_2 ~= "" and arg_24_1:setRoleName(arg_24_2) then
			arg_24_1:setNameInit(true)
		end
	end
end

function BioGameWorld:_checkNameInit()
	if self._chapterInfo then
		for iter_25_0, iter_25_1 in pairs(self._bindEntityDict) do
			if not iter_25_1:getNameIsInit() and iter_25_1:isHasVisualIns() and not iter_25_1:getIsInteractEntity() then
				for iter_25_2, iter_25_3 in ipairs(self._chapterInfo.res[iter_25_0]) do
					self:_refreshRoleEntityName(iter_25_1, g.core.model.User.bioData:getMission(iter_25_3).resource_name)
				end
			end
		end
	end
end

return BioGameWorld
