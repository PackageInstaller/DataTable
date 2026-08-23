local BattleConst = require("app.view.battle.const.BattleConst")
local KsMath = require("app.core.utils.KsMath")
local WalkLine = import(".WalkLine")
local MapConst = import("..MapConst")
local MapRole = class("MapRole", (import(".MapEntity")))

function MapRole:ctor(arg_1_1)
	MapRole.super.ctor(self, arg_1_1)

	self._walkSpeed = MapConst.MOVE_SPEED
	self._walkPathArr = nil
	self._walkIndex = 0
	self._curWalkLine = nil

	self:initRole()
end

function MapRole:initRole()
	self._curWalkLine = WalkLine.new()
end

function MapRole:setWalkSpeed(arg_3_1)
	self._walkSpeed = arg_3_1
end

function MapRole:walkStart(arg_4_1, arg_4_2)
	self._visualIns:playInnerAction(BattleConst.SPINE_ACTION_TYPE.RUN)

	self._walkPathArr = arg_4_1
	self._walkIndex = 1

	local var_4_0 = self:getWorldPos()

	if self:_checkNeedJump(var_4_0, arg_4_2) then
		self._walkIndex = #self._walkPathArr
		var_4_0 = cc.p(self._fatherWorld:getMapGround():coordToPixel(self._walkPathArr[self._walkIndex].x, self._walkPathArr[self._walkIndex].y))

		self._visualIns:playJumpEffect()
	end

	self._curWalkLine:setLine(var_4_0, var_4_0)
end

function MapRole:walkStop()
	self._fatherWorld:getMapStage():setAutoSearchPath(false)

	if self._walkPathArr then
		self._visualIns:playInnerAction(BattleConst.SPINE_ACTION_TYPE.IDLE)

		self._walkPathArr = nil
	end
end

function MapRole:playAttack()
	self._visualIns:playOnceAction(BattleConst.SPINE_ACTION_TYPE.ATTACK)
	g.core.common.Scheduler:newScheduleOnce(function()
		self._visualIns:playInnerAction(BattleConst.SPINE_ACTION_TYPE.IDLE)
	end, 1.25)
end

function MapRole:tickWalk(arg_8_1)
	if self._walkPathArr == nil then
		return nil
	end

	local var_8_0, var_8_1 = self._curWalkLine:step(self._walkSpeed * arg_8_1)

	if var_8_1 >= 0 then
		self._walkIndex = self._walkIndex + 1

		if self._walkPathArr[self._walkIndex] then
			local var_8_2 = cc.p(self._fatherWorld:getMapGround():coordToPixel(self._walkPathArr[self._walkIndex].x, self._walkPathArr[self._walkIndex].y))

			self._curWalkLine:setLine(var_8_0, var_8_2)

			var_8_0, var_8_1 = self._curWalkLine:step(var_8_1)

			if var_8_2.x > var_8_0.x then
				self._visualIns:setInnerDir(MapConst.DIRECTION.RIGHT)
			elseif var_8_2.x < var_8_0.x then
				self._visualIns:setInnerDir(MapConst.DIRECTION.LEFT)
			end
		end
	end

	self._visualIns:setPosBothZ(var_8_0)
	self:resyncCoord(var_8_0)

	if self:isMainRole() then
		self._fatherWorld:setFollowCenter(var_8_0)
	end

	if var_8_1 >= 0 then
		self:walkStop()

		return true
	else
		return false
	end
end

function MapRole:_checkNeedJump(arg_9_1, arg_9_2)
	if arg_9_2 then
		return false
	end

	return not KsMath:rectIn(self._fatherWorld:convertScreenCenter(), display.width / 2, display.height / 2)
end

function MapRole:_onCoordChanged()
	if self._fatherWorld == nil then
		return
	end

	local var_10_0 = self:getCoord()

	self._visualIns:setHalfOpacity(self._fatherWorld:getMapGround():getHoldType(var_10_0.x, var_10_0.y) == 1)
end

function MapRole:refreshDir(arg_11_1)
	if not self._visualIns then
		return
	end

	local var_11_0 = self:getCoord()

	if arg_11_1.x > var_11_0.x then
		self._visualIns:setInnerDir(MapConst.DIRECTION.RIGHT)
	elseif arg_11_1.x < var_11_0.x then
		self._visualIns:setInnerDir(MapConst.DIRECTION.LEFT)
	elseif arg_11_1.y > var_11_0.y then
		self._visualIns:setInnerDir(MapConst.DIRECTION.LEFT)
	elseif arg_11_1.y < var_11_0.y then
		self._visualIns:setInnerDir(MapConst.DIRECTION.RIGHT)
	end
end

return MapRole
