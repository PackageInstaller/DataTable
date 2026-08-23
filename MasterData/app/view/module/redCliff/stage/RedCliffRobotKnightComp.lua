local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_1 = g.core.const.ConstMgr.RedCliffConst
local var_0_2 = g.core.model.User.redCliffData
local RedCliffRoleVirtual = require("app.view.module.redCliff.stage.entity.RedCliffRoleVirtual")
local RedCliffRobotKnightComp = class("RedCliffRobotKnightComp", require("app.fairyGUI.redCliff.UI_RedCliffRobotKnightComp"))

function RedCliffRobotKnightComp:ctor()
	self._knightVisual = nil
	self._routeIndex = 1
	self._route = nil
	self._robotKey = 0
	self._callback = nil
	self._target = nil
	self._endCoord = nil

	self:_createKnightSpine()
end

function RedCliffRobotKnightComp:updateRobot(arg_2_1)
	self._robotKey = arg_2_1

	self:_getRobotPath()
end

function RedCliffRobotKnightComp:resetRobot()
	self:setVisible(false)

	self._route = nil
	self._routeIndex = 1
	self._robotKey = 0

	var_0_2:saveEditorRobot(self._endCoord, false)

	self._endCoord = nil
end

function RedCliffRobotKnightComp:getCurCoord()
	if self._route then
		self._routeIndex = self._routeIndex + 1

		return self._route[self._routeIndex]
	end

	return nil
end

function RedCliffRobotKnightComp:getLastCoord()
	return (self._route or nil) and (self._route[self._routeIndex - 1] or nil)
end

function RedCliffRobotKnightComp:getRobotKey()
	return self._robotKey
end

function RedCliffRobotKnightComp:getRebornCoord()
	return (self._route or nil) and (self._route[1] or nil)
end

function RedCliffRobotKnightComp:getRobotPath()
	return self._route
end

function RedCliffRobotKnightComp:_getRobotPath()
	self._endCoord = self:_getRandomTargetCoord()
	self._route = self._endCoord and var_0_2:decomposePathArr(var_0_2:getRouteArray(var_0_2:getEditorStructByComponentId((var_0_2:getRandomRebornId())):getVertexCoord(), self._endCoord), var_0_1.ROBOT_MOVE_SPEED) or nil
end

function RedCliffRobotKnightComp:_getRandomTargetCoord()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs((var_0_2:getEditorStructIdMap())) do
		if iter_10_1:getPlayer() then
			local var_10_1 = iter_10_1:getNearCoord()

			if not var_0_2:isEditorHasRobot(var_10_1) then
				table.insert(var_10_0, var_10_1)
			end
		end
	end

	if #var_10_0 > 0 then
		local var_10_2 = var_10_0[math.random(1, #var_10_0)]

		var_0_2:saveEditorRobot(var_10_2, true)

		return var_10_2
	end

	return nil
end

function RedCliffRobotKnightComp:_genRandomResId()
	local var_11_0 = {
		210005,
		210003,
		200005,
		200003
	}

	return var_11_0[math.random(1, #var_11_0)]
end

function RedCliffRobotKnightComp:_createKnightSpine()
	if not self._knightVisual then
		self._knightVisual = RedCliffRoleVirtual.new((self:_genRandomResId()))

		self.m_knightNode:addNode(self._knightVisual)
	end
end

function RedCliffRobotKnightComp:playRobotAttackAnim(arg_13_1, arg_13_2)
	self._knightVisual:addSpineEventListener(handler(self, self._attackFinish))
	self:playInnerAction(BattleConst.SPINE_ACTION_TYPE.ATTACK, false)

	self._callback = arg_13_1
	self._target = arg_13_2
end

function RedCliffRobotKnightComp:_attackFinish(arg_14_1)
	if arg_14_1.animation == BattleConst.SPINE_ACTION_TYPE.ATTACK and arg_14_1.type == BattleConst.SPINE_EVENT.COMPLETE then
		self._knightVisual:addSpineEventListener(handler(self, self._deadFinish))
		self:playInnerAction(BattleConst.SPINE_ACTION_TYPE.DEAD, false)
	end
end

function RedCliffRobotKnightComp:_deadFinish(arg_15_1)
	if arg_15_1.animation == BattleConst.SPINE_ACTION_TYPE.DEAD and arg_15_1.type == BattleConst.SPINE_EVENT.COMPLETE then
		self._callback(self._target)
		self._knightVisual:addSpineEventListener(nil)
	end
end

function RedCliffRobotKnightComp:playInnerAction(arg_16_1, arg_16_2)
	self._knightVisual:playInnerAction(arg_16_1, arg_16_2)
end

function RedCliffRobotKnightComp:setInnerDir(arg_17_1)
	self._knightVisual:setInnerDir(arg_17_1)
end

return RedCliffRobotKnightComp
