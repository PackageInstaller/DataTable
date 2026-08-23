local var_0_0 = g.core.network.GameNetProxy
local var_0_1 = g.core.module.ModuleManager
local RedCliffMapCommon = require("app.view.module.redCliff.common.RedCliffMapCommon")
local RedCliffMapWorld = import(".RedCliffMapWorld")
local var_0_4 = g.core.model.User.redCliffData
local var_0_5 = g.core.const.ConstMgr.RedCliffConst
local MapConst = require("app.core.ksmap.MapConst")
local KsMath = require("app.core.utils.KsMath")
local RedCliffMapComp = class("RedCliffMapComp", require("app.fairyGUI.redCliff.UI_RedCliffMapComp"))

function RedCliffMapComp:ctor()
	self._tiledWorld = nil
	self._movePosArr = {}
	self._moveCoordinate = nil

	self:_initTiledMap()
	self:addListen(self.m_floorComp)

	self._firstEnter = true
	self._isPlayingAnim = false
	self._popView = nil
end

function RedCliffMapComp:onLoad()
	if self._firstEnter then
		self:_initMainRolePos()

		self._firstEnter = false
	else
		self:updateCurShowComp()

		if not var_0_4:isSkipBattle() then
			self.m_floorComp:mapRolePlayInnerAction("idle")
			self:setIsPlaying(false)
			self:updateMapRoleStateAndMoveWorld()
		end
	end
end

function RedCliffMapComp:_initTiledMap()
	self._tiledWorld = RedCliffMapWorld.new(self, (var_0_4:getMyMapId()))

	self._tiledWorld:startObserver(self.m_touchComp)
	self.m_tileHolder:addNode(self._tiledWorld)
end

function RedCliffMapComp:updateCurShowComp()
	self.m_floorComp:updateCurShowComp()
end

function RedCliffMapComp:_initMainRolePos()
	self._tiledWorld:moveCell2SC((var_0_4:getEditorStructByComponentId((var_0_4:getMyPlayerStruct():getComponentId())):getVertexCoord()))
end

function RedCliffMapComp:updateOccupyView(arg_6_1)
	self.m_floorComp:updateOccupyView(arg_6_1)
end

function RedCliffMapComp:updateFloorCompPos(arg_7_1, arg_7_2)
	self.m_floorComp:setPosition(arg_7_1, arg_7_2)
	self.m_floorComp:updateCurPos(arg_7_1, arg_7_2)
end

function RedCliffMapComp:updateMainRolePos(arg_8_1)
	self.m_floorComp:updateMainRoleCoordinate(arg_8_1)
end

function RedCliffMapComp:updateMapRoleState()
	self.m_floorComp:updateMainRoleCoordinate((var_0_4:getEditorStructByComponentId((var_0_4:getMyPlayerStruct():getComponentId())):getVertexCoord()))
	self.m_floorComp:updateEditorRole()
end

function RedCliffMapComp:updateMapRoleStateAndMoveWorld()
	self:updateMapRoleState()
	self._tiledWorld:moveCell2SC((self.m_floorComp:getMainRoleCompCoordinate()))
end

function RedCliffMapComp:onMainRoleMoveFinish()
	local var_11_0, var_11_1 = var_0_4:getTargetCoordAndEditor()

	var_0_4:saveTargetCoordAndEditor(nil, nil)
	self.m_floorComp:mapRoleStopRun()

	if var_11_1 then
		local var_11_2 = var_11_1:getEditorType()

		if var_11_2 ~= var_0_5.EDITOR_TYPE.BARRIER and var_11_2 ~= var_0_5.EDITOR_TYPE.REBORN then
			local var_11_3, var_11_4 = self:_isAttackEnable(var_11_1)

			if var_11_3 then
				local var_11_5 = var_11_1:getPlayer()

				self:setIsPlaying(true)

				if var_11_5 then
					var_0_0:send_C2S_ChiBi_Battle({
						enemy_id = var_11_5:getUserId(),
						component_id = var_11_1:getComponentId()
					})
				else
					var_0_0:send_C2S_ChiBi_CheckBattle({
						user_id = 0,
						component_id = var_11_1:getComponentId(),
						battle_result = var_0_5.BATTLE_RESULT.WIN
					})
				end
			else
				var_0_1:tip(var_11_4)
			end
		end
	end
end

function RedCliffMapComp:playAttackAnimation(arg_12_1, arg_12_2)
	self._isPlayingAnim = true

	self.m_floorComp:playAttackAnimation(arg_12_1, arg_12_2)
end

function RedCliffMapComp:updateMapRoleCd()
	self.m_floorComp:updateMapRoleCd()
end

function RedCliffMapComp:updateFertile()
	self.m_floorComp:updateFertile()
end

function RedCliffMapComp:updateEditorCd()
	self.m_floorComp:updateEditorCd()
end

function RedCliffMapComp:setIsPlaying(arg_16_1)
	self._isPlayingAnim = arg_16_1
end

function RedCliffMapComp:isPlaying()
	return self._isPlayingAnim
end

function RedCliffMapComp:onRobotMoveFinish()
	self.m_floorComp:onRobotMoveFinish()
end

function RedCliffMapComp:getMapWorld()
	return self._tiledWorld
end

function RedCliffMapComp:getMapGround()
	return self._mapWorld:getMapGround()
end

function RedCliffMapComp:moveToPoint(arg_21_1, arg_21_2)
	self._tiledWorld:moveCell2SC({
		x = arg_21_1,
		y = arg_21_2
	})
end

function RedCliffMapComp:onSingleClick(arg_22_1, arg_22_2)
	if self._isPlayingAnim then
		return
	end

	local var_22_0, var_22_1 = self:_isMoveEnable()

	if var_22_0 then
		local var_22_2 = var_0_4:getEditorStructByCoord(cc.p(arg_22_1, arg_22_2))

		if var_22_2 and var_22_2:isBarrier() and not var_22_2:canStandOn() then
			var_0_1:tip(g.core.lang:get(421103))

			return false
		end

		local var_22_3 = self:_isMoveWorth(var_22_2)

		if not var_22_2 or var_22_2:canStandOn() then
			var_0_4:saveTargetCoordAndEditor(cc.p(arg_22_1, arg_22_2), var_22_2)

			if var_22_3 then
				self:_moveToCoord(arg_22_1, arg_22_2)
			else
				self:_popMoveTip(var_22_2)
			end
		else
			local var_22_4 = var_22_2:getEditorType()
			local var_22_5, var_22_6 = self:_isAttackEnable(var_22_2)

			if var_22_5 then
				local var_22_7 = var_0_4:getMyEditorStruct()
				local var_22_8 = var_22_2:getNearCoord()

				var_0_4:saveTargetCoordAndEditor(var_22_8, var_22_2)

				if var_22_3 then
					if var_22_7 and var_22_7:getEditorType() ~= var_0_5.EDITOR_TYPE.REBORN then
						var_0_0:send_C2S_ChiBi_LevelComponent({})
					else
						self:_moveToCoord(var_22_8.x, var_22_8.y)
					end
				elseif var_22_4 == var_0_5.EDITOR_TYPE.BARRIER then
					var_0_1:tip(g.core.lang:get(421034))
				else
					self:_popMoveTip()
				end
			else
				var_0_1:tip(var_22_6)
			end
		end
	else
		var_0_1:tip(var_22_1)
	end
end

function RedCliffMapComp:getMainRolePos()
	local var_23_0, var_23_1 = RedCliffMapCommon.getWorldPosByGlobalCoordinate((self.m_floorComp:getMainRoleCompCoordinate()))

	return cc.p(var_23_0, var_23_1)
end

function RedCliffMapComp:leaveCompAndMove()
	self.m_floorComp:updateMapRole()

	local var_24_0 = var_0_4:getTargetCoordAndEditor()

	self:_moveToCoord(var_24_0.x, var_24_0.y)
end

function RedCliffMapComp:updateMainRoleDirection(arg_25_1, arg_25_2)
	local var_25_0, var_25_1 = RedCliffMapCommon.coordToCompPos(arg_25_1)
	local var_25_2, var_25_3 = RedCliffMapCommon.coordToCompPos(arg_25_2)

	if var_25_0 < var_25_2 then
		self.m_floorComp:updateMainRoleDir(MapConst.DIRECTION.RIGHT)
	else
		self.m_floorComp:updateMainRoleDir(MapConst.DIRECTION.LEFT)
	end
end

function RedCliffMapComp:_moveToCoord(arg_26_1, arg_26_2)
	local var_26_0 = self:getMapWorld():getLastCoord()

	var_26_0 = var_26_0 or self.m_floorComp:getMainRoleCompCoordinate()

	self:_getMovePath(var_26_0, cc.p(arg_26_1, arg_26_2))
end

function RedCliffMapComp:_getMovePath(arg_27_1, arg_27_2)
	local var_27_0 = var_0_4:getRouteArray(arg_27_1, arg_27_2)

	if var_27_0 then
		local var_27_1 = self:_decomposePathArr(var_27_0)

		self._moveCoordArr = var_27_1

		self:getMapWorld():updateMainRoleRoutePath(var_27_1)
		self._tiledWorld:setIsFollow(true)
		self.m_floorComp:mapRoleStartRun()
	end
end

function RedCliffMapComp:_decomposePathArr(arg_28_1)
	local var_28_0 = {}

	while 2 <= #arg_28_1 do
		local var_28_1 = KsMath.calculateDistance(arg_28_1[1], arg_28_1[2]) / var_0_5.MOVE_SPEED
		local var_28_2 = cc.pMul(cc.pSub(arg_28_1[2], arg_28_1[1]), 1 / var_28_1)

		for iter_28_0 = 1, var_28_1 - 1 do
			local var_28_3 = cc.pAdd(arg_28_1[1], var_28_2)

			table.insert(var_28_0, var_28_3)

			local var_28_4 = var_28_3
		end

		var_28_0[#var_28_0 + 1] = arg_28_1[2]
		var_28_4 = arg_28_1[2]
	end

	return var_28_0
end

function RedCliffMapComp:_isMoveEnable()
	local var_29_0 = var_0_4:getMyPlayerStruct()

	if var_29_0 then
		if var_29_0:isDead() then
			return false, (g.core.lang:get(421101))
		end

		return true, nil
	end

	return false, "玩家数据异常"
end

function RedCliffMapComp:_isAttackEnable(arg_30_1)
	if not arg_30_1 then
		return false, (g.core.lang:get(421119))
	end

	local var_30_1 = arg_30_1:getPlayer()

	if var_30_1 then
		if var_30_1:isSelf() then
			return false, (g.core.lang:get(421032))
		end

		if var_30_1:isProtect() then
			return false, (g.core.lang:get(421033))
		end
	end

	if var_0_4:getMyPlayerStruct():isCool() then
		return false, (g.core.lang:get(421102))
	end

	return true, nil
end

function RedCliffMapComp:_isMoveWorth(arg_31_1)
	local var_31_0 = var_0_4:getMyEditorStruct()

	if not var_31_0 or var_31_0:getEditorType() == var_0_5.EDITOR_TYPE.REBORN then
		return true
	end

	return arg_31_1 and var_31_0:getEditorType() <= arg_31_1:getEditorType()
end

function RedCliffMapComp:_popMoveTip()
	self._popView = nil
	self._popView = require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(1257),
		confirmText = g.core.lang:get(1160),
		cancelText = g.core.lang:get(1037),
		desc = g.core.lang:get(421031),
		onConfirm = handler(self, function(arg_33_0)
			var_0_0:send_C2S_ChiBi_LevelComponent({})

			arg_33_0._popView = nil
		end),
		onCancel = handler(self, function(arg_34_0)
			var_0_4:saveTargetCoordAndEditor(nil, nil)

			arg_34_0._popView = nil
		end)
	})

	var_0_1:pushPopup(self._popView)
end

function RedCliffMapComp:closePopView()
	if self._popView then
		var_0_1:onlyPopSelfByDisplay(self._popView)

		self._popView = nil
	end
end

function RedCliffMapComp:generateRandomPlayer(arg_36_1)
	self.m_floorComp:generateRandomPlayer(arg_36_1)
end

function RedCliffMapComp:updateRobotCompPosition()
	self.m_floorComp:updateRobotCompPosition()
end

return RedCliffMapComp
