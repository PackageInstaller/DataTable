local var_0_0 = g.core.config.knight_info
local var_0_1 = g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER
local var_0_2 = g.core.config.knight_base_info
local KsAStar = require("app.core.utils.KsAStar")
local KsMath = require("app.core.utils.KsMath")
local AllianceTrialMapGround = require("app.view.module.allianceTrial.map.AllianceTrialMapGround")
local AllianceTrialGameTouch = require("app.view.module.allianceTrial.map.AllianceTrialGameTouch")
local AllianceTrialMapConst = require("app.view.module.allianceTrial.const.AllianceTrialMapConst")
local BattleConst = require("app.view.battle.const.BattleConst")
local MapConst = require("app.core.ksmap.MapConst")
local var_0_10 = g.core.const.ConstMgr.SnapShotCacheConst
local var_0_11 = g.core.model.User.snapShotCacheData
local var_0_12 = g.core.const.ConstMgr.AllianceConst
local var_0_13 = g.core.model.User.allianceTrialData
local AllianceTrialEntityFactory = require("app.view.module.allianceTrial.map.AllianceTrialEntityFactory")
local AllianceTrialGameWorld = class("AllianceTrialGameWorld", require("app.core.ksmap.MapWorld"))

function AllianceTrialGameWorld:ctor(arg_1_1, arg_1_2)
	self._refTalkTarget = nil
	self._refMainRole = nil
	self._bindEntityDict = {}

	AllianceTrialGameWorld.super.ctor(self, arg_1_1, arg_1_2)

	self._followCenter = nil
	self._lastMoveSendTime = 0
	self._myId = g.core.model.User:getId()
	self._scheduleList = {}
	self._monsterShamUserDict = {}
	self._randomPosDirList = {
		cc.p(-1, -1),
		cc.p(-1, 0),
		cc.p(-1, 1),
		cc.p(0, -1),
		cc.p(0, 1),
		cc.p(1, -1),
		cc.p(1, 0),
		cc.p(1, 1)
	}

	self:_addMainRole()
end

function AllianceTrialGameWorld:_addMainRole()
	if self._refMainRole then
		self:delEntity(self._refMainRole)

		self._refMainRole = nil
	end

	local var_2_0 = self:doCreateFactory():createRecord()

	var_2_0.isMain = true
	var_2_0.dName = g.core.model.User:getName()
	var_2_0.resID = self:getKnightResId(g.core.model.User:packUser())
	var_2_0.type = AllianceTrialMapConst.RESTYPE.KNIGHT
	var_2_0.scale = 0.8
	var_2_0.bindID = self._myId

	local var_2_1 = self:doCreateFactory().createEntity(var_2_0)

	var_2_1:setCoord((self:getOrgCoord()))
	var_2_1:setAttachName(AllianceTrialMapConst.MAP_DECORATE)

	if var_2_1.setWalkSpeed then
		var_2_1:setWalkSpeed(AllianceTrialMapConst.MOVE_SPEED)
	end

	self:addEntity(var_2_1)

	self._refMainRole = var_2_1
end

function AllianceTrialGameWorld:removeOldRoomUser()
	for iter_3_0, iter_3_1 in pairs((var_0_13:getNeedRemoveUser())) do
		self:delUserEntity(iter_3_0)
	end

	var_0_13:resetNeedRemoveUser()
end

function AllianceTrialGameWorld:createUserEntity()
	for iter_4_0, iter_4_1 in pairs(var_0_13:getUserDict() or {}) do
		if iter_4_0 ~= self._myId and not self:getBindEntity(iter_4_0) then
			local var_4_0 = var_0_11:getSnapShot(var_0_1, iter_4_0)

			if var_4_0 then
				self:_createUser(var_4_0, iter_4_1, iter_4_0)
			end
		end
	end
end

function AllianceTrialGameWorld:_checkEntityInView()
	local var_5_0 = self:convertScreenCenter()

	if KsMath.rectIn(self._lastPosSC, var_5_0, MapConst.PRE_LOAD_JITTER, MapConst.PRE_LOAD_JITTER / 2) then
		return
	end

	self._lastPosSC = var_5_0

	local var_5_1 = {
		x = var_5_0.x,
		y = var_5_0.y,
		width = display.width / 2 + MapConst.PRE_SHOW_DIS,
		height = display.height / 2 + MapConst.PRE_SHOW_DIS
	}

	for iter_5_0, iter_5_1 in pairs(self._entityFieldDict) do
		for iter_5_2, iter_5_3 in pairs((iter_5_1:getCoordModel())) do
			for iter_5_4, iter_5_5 in pairs(iter_5_3) do
				if iter_5_5:getResType() == AllianceTrialMapConst.RESTYPE.KNIGHT then
					iter_5_5:setInView(true)
				else
					iter_5_5:setInView((iter_5_5:checkIsNeedShow(var_5_1)))
				end
			end
		end
	end
end

function AllianceTrialGameWorld:delUserEntity(arg_6_1)
	if arg_6_1 ~= self._myId then
		local var_6_0 = self:getBindEntity(arg_6_1)

		if var_6_0 then
			self:delEntity(var_6_0)
		end
	end
end

function AllianceTrialGameWorld:getKnightResId(arg_7_1)
	if arg_7_1.skin and arg_7_1.skin > 0 then
		local var_7_0 = g.core.config.skin_info.fetch(arg_7_1.skin)

		if var_7_0 then
			local var_7_1 = var_0_2.fetch(var_7_0.res)

			if var_7_1 then
				return var_7_1.fight_id
			end
		end
	end

	return g.core.config.knight_info.get(arg_7_1.base_id).res_id
end

function AllianceTrialGameWorld:startWorld()
	self._refMainRole:jump2Coord(var_0_13:getUserPos(self._myId))
	self:jump2MainRole()
end

function AllianceTrialGameWorld:_doTickUpdate(arg_9_1)
	if self._refMainRole:tickWalk(arg_9_1) then
		self:_sendAllianceTrialMove()

		if self._refTalkTarget then
			self:getMapStage():talkTrigger(self._refTalkTarget)
			self:_setTalkTarget(nil)
		end
	end

	self:_checkFollowing(arg_9_1)
	self:_autoInertiaUpdate(arg_9_1)
	self:_checkEntityInView()
	self:_checkNameInit()

	for iter_9_0, iter_9_1 in pairs(var_0_13:getUserDict() or {}) do
		local var_9_0 = self:getBindEntity(iter_9_0)

		if iter_9_0 ~= self._myId and var_9_0 then
			var_9_0:tickWalk(arg_9_1)
		end
	end

	for iter_9_2, iter_9_3 in pairs(self._bindEntityDict) do
		if iter_9_2 ~= self._myId and iter_9_3:getResType() == AllianceTrialMapConst.RESTYPE.KNIGHT then
			iter_9_3:tickWalk(arg_9_1)
		end
	end
end

function AllianceTrialGameWorld:getBindEntity(arg_10_1)
	return self._bindEntityDict[arg_10_1]
end

function AllianceTrialGameWorld:setShowFootEffect(arg_11_1, arg_11_2)
	if arg_11_1 then
		local var_11_0 = arg_11_1:getVisual()

		if var_11_0 then
			if arg_11_2 then
				var_11_0:addEffectSpine()
			else
				var_11_0:removeLightEffectSpine()
			end
		end
	end
end

function AllianceTrialGameWorld:autoRouteTalk(arg_12_1, arg_12_2)
	local var_12_0 = var_0_13:getMonsterInfoByBindId(arg_12_1:getBindID())

	if var_12_0 and not var_0_13:canChallengeMonster(var_12_0.id) then
		g.core.module.ModuleManager:tip(g.core.lang:get(430403))

		return
	end

	self:_setTalkTarget(arg_12_1)

	local var_12_1 = KsAStar.searchTalkPath(self._refMainRole:getCoord(), arg_12_1:getCoord(), self)

	if var_12_1 then
		self._refMainRole:walkStart(var_12_1, arg_12_2)
	end
end

function AllianceTrialGameWorld:autoRouteTo(arg_13_1)
	self:_setTalkTarget(nil)

	local var_13_0 = self._refMainRole:getCoord()

	if KsMath.IsSameCoord(var_13_0, arg_13_1) then
		return false
	end

	local var_13_1 = KsAStar.searchNearPath(var_13_0, arg_13_1, self)

	if var_13_1 then
		self._refMainRole:walkStart(var_13_1, true)
	end
end

function AllianceTrialGameWorld:_sendAllianceTrialMove()
	local var_14_0 = self._refMainRole:getCoord()

	var_0_13:setUserMove(self._myId, var_14_0)
	g.core.network.GameNetProxy:send_C2S_AllianceTrial_Move({
		pos = var_14_0
	})
end

function AllianceTrialGameWorld:playerRouteToCoord(arg_15_1, arg_15_2)
	if arg_15_1 == nil then
		return false
	end

	local var_15_0 = self:getBindEntity(arg_15_1)

	if self._scheduleList[arg_15_1] then
		g.core.common.Scheduler:cancelSchedule(self._scheduleList[arg_15_1])

		self._scheduleList[arg_15_1] = nil
	end

	if var_15_0 == nil or not var_15_0:isHasVisualIns() then
		return false
	end

	local var_15_1 = var_15_0:getCoord()

	if KsMath.IsSameCoord(var_15_1, arg_15_2) then
		return false
	end

	local var_15_2 = KsAStar.searchNearPath(var_15_1, arg_15_2, self)

	if var_15_2 then
		var_15_0:walkStart(var_15_2, true)
	else
		var_15_0:setCoord(arg_15_2)
	end
end

function AllianceTrialGameWorld:playerAttackMonster(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = self:getBindEntity(arg_16_1)

	if var_16_0 then
		local var_16_1 = var_16_0:getVisual()

		if var_16_1 and not var_16_1:isAttacking() then
			var_16_1:runAction((cc.Sequence:create(cc.CallFunc:create(handler(self, function()
				var_16_1:setIsAttacking(true)
				var_16_1:playOnceAction(BattleConst.SPINE_ACTION_TYPE.ATTACK)
			end)), cc.DelayTime:create(1), cc.CallFunc:create(handler(self, function()
				var_16_1:setIsAttacking(false)
				var_16_1:playInnerAction(BattleConst.SPINE_ACTION_TYPE.IDLE)

				if arg_16_2 then
					arg_16_2()
				end
			end)))))
		end

		if arg_16_3 then
			var_16_0:refreshDir(arg_16_3)
		end
	end
end

function AllianceTrialGameWorld:onSingleClick(arg_19_1)
	local var_19_0 = self:convertToNodeSpace(arg_19_1)
	local var_19_1, var_19_2 = self:getMapGround():pixelToCoord(var_19_0.x, var_19_0.y)

	if self:getMapGround():checkCoordInvalid(var_19_1, var_19_2) then
		g.core.module.ModuleManager:tip(g.core.lang:get(302070))

		return
	end

	self._refMainRole:walkStop()

	local var_19_3 = self:_checkEntityHit(var_19_0)

	if var_19_3 then
		self:autoRouteTalk(var_19_3, true)
	else
		self:autoRouteTo((cc.p(var_19_1, var_19_2)))
	end
end

function AllianceTrialGameWorld:setFollowCenter(arg_20_1)
	self._followCenter = arg_20_1
end

function AllianceTrialGameWorld:jump2MainRole()
	self:moveCell2SC((self._refMainRole:getCoord()))
end

function AllianceTrialGameWorld:startInertiaWorld(arg_22_1, arg_22_2)
	if self._followCenter then
		return
	end

	self._autoInertiaDir = arg_22_1

	if self._autoInertiaDir == nil then
		return
	end

	self._autoInertiaDist = arg_22_2 * AllianceTrialMapConst.INER_SENSITITY
end

function AllianceTrialGameWorld:getMapStage()
	return self._fatherStage
end

function AllianceTrialGameWorld:getMapGround()
	return self._vislGround
end

function AllianceTrialGameWorld:doCanMoveAStar(arg_25_1, arg_25_2)
	local var_25_0 = self:getMapGround()

	if var_25_0:checkCoordInvalid(arg_25_2.x, arg_25_2.y) then
		return false
	end

	return var_25_0:getHoldType(arg_25_2.x, arg_25_2.y) ~= nil
end

function AllianceTrialGameWorld:_doCreateGround()
	return AllianceTrialMapGround.new(self)
end

function AllianceTrialGameWorld:_doCreateTouch()
	return nil
end

function AllianceTrialGameWorld:doCreateFactory()
	return AllianceTrialEntityFactory
end

function AllianceTrialGameWorld:_doInitTouchMatch()
	self._mapTouch = AllianceTrialGameTouch.new(self)
end

function AllianceTrialGameWorld:_doAddEntity(arg_30_1)
	if arg_30_1:isMainRole() then
		self._refMainRole = arg_30_1

		self._refMainRole:setInView(true)
	end

	local var_30_0 = arg_30_1:getBindID()

	if (var_0_13:getUserDict() or {})[var_30_0] then
		arg_30_1:setInView(true)
	end

	if var_30_0 > 0 then
		self._bindEntityDict[var_30_0] = arg_30_1
	end
end

function AllianceTrialGameWorld:_doDelEntity(arg_31_1)
	local var_31_0 = arg_31_1:getBindID()

	if var_31_0 > 0 then
		self._bindEntityDict[var_31_0] = nil
	end
end

function AllianceTrialGameWorld:doDragWorld(arg_32_1)
	if self._followCenter then
		return
	end

	self:moveWorld(arg_32_1)
end

function AllianceTrialGameWorld:_checkEntityHit(arg_33_1)
	for iter_33_0, iter_33_1 in pairs(self._bindEntityDict) do
		if iter_33_1 ~= self._refMainRole and iter_33_1:checkHit(arg_33_1) then
			return iter_33_1
		end
	end

	return nil
end

function AllianceTrialGameWorld:_setTalkTarget(arg_34_1)
	if arg_34_1 then
		self:setShowFootEffect(arg_34_1, true)
	else
		self:setShowFootEffect(self._refTalkTarget, false)
	end

	self._refTalkTarget = arg_34_1
end

function AllianceTrialGameWorld:_checkFollowing(arg_35_1)
	if self._followCenter == nil then
		return
	end

	local var_35_0 = self:convertScreenCenter()
	local var_35_1 = KsMath.calculateDistance(self._followCenter, var_35_0)

	if var_35_1 < 50 then
		self._followCenter = nil

		return
	end

	local var_35_2, var_35_3 = self:movePA2PB(self._followCenter, (KsMath.walkDistance(self._followCenter, var_35_0, AllianceTrialMapConst.MOVE_SPEED * (var_35_1 / 200) * arg_35_1)))

	if var_35_2 or var_35_3 then
		self._followCenter = nil
	end
end

function AllianceTrialGameWorld:_autoInertiaUpdate(arg_36_1)
	if self._autoInertiaDir == nil then
		return
	end

	local var_36_0, var_36_1 = self:moveWorld(cc.p(self._autoInertiaDir.x * self._autoInertiaDist, self._autoInertiaDir.y * self._autoInertiaDist))

	self._autoInertiaDist = self._autoInertiaDist - AllianceTrialMapConst.INER_ACCE

	if var_36_0 or var_36_1 or self._autoInertiaDist <= 0 then
		self._autoInertiaDir = nil
	end
end

function AllianceTrialGameWorld:refreshEntityState()
	for iter_37_0, iter_37_1 in pairs(self._bindEntityDict) do
		if iter_37_0 ~= self._myId and not iter_37_1:getNameIsInit() then
			local var_37_0 = var_0_13:getMonsterInfoByBindId(iter_37_0)

			if var_37_0 then
				self:_setRoleEntityInfo(iter_37_1, var_0_0.get(var_37_0.knight_id).name, var_37_0)
			end
		end
	end
end

function AllianceTrialGameWorld:_setRoleEntityInfo(arg_38_1, arg_38_2, arg_38_3)
	if arg_38_1:getResType() == AllianceTrialMapConst.RESTYPE.KNIGHT then
		if arg_38_2 and string.len(arg_38_2) > 0 and arg_38_1:setRoleName(arg_38_2) then
			arg_38_1:setNameInit(true)
		end

		local var_38_0 = arg_38_1:getVisual()

		if var_38_0 and var_38_0:isMonster() then
			var_38_0:updateShowMonster(arg_38_3)
		end
	end
end

function AllianceTrialGameWorld:_checkNameInit()
	for iter_39_0, iter_39_1 in pairs(self._bindEntityDict) do
		if not iter_39_1:getNameIsInit() and iter_39_1:isHasVisualIns() and iter_39_0 ~= self._myId then
			local var_39_0 = var_0_13:getMonsterInfoByBindId(iter_39_0)

			if var_39_0 then
				self:_setRoleEntityInfo(iter_39_1, var_0_0.get(var_39_0.knight_id).name, var_39_0)
			end
		end
	end
end

function AllianceTrialGameWorld:updateMonsterState()
	for iter_40_0, iter_40_1 in pairs(self._bindEntityDict) do
		local var_40_0 = var_0_13:getMonsterInfoByBindId(iter_40_0)

		if var_40_0 then
			iter_40_1:setShow(true)

			local var_40_1 = iter_40_1:getVisual()

			if var_40_1 then
				var_40_1:setHpValue(var_0_13:getMonsterHp(var_40_0.id))

				if not var_0_13:canChallengeMonster(var_40_0.id) then
					for iter_40_2, iter_40_3 in ipairs(self._monsterShamUserDict[iter_40_0] or {}) do
						if self._scheduleList[iter_40_3] then
							g.core.common.Scheduler:cancelSchedule(self._scheduleList[iter_40_3])

							self._scheduleList[iter_40_3] = nil
						end
					end

					self._monsterShamUserDict[iter_40_0] = nil
				elseif var_0_13:isLevelFinish() then
					var_40_1:setFinalState()
				end
			end
		end
	end
end

function AllianceTrialGameWorld:createShamUser()
	for iter_41_0, iter_41_1 in pairs((var_0_13:getShamUserDict(var_0_12.TRIAL.SHAM_USER_A))) do
		self._monsterShamUserDict[iter_41_0] = self._monsterShamUserDict[iter_41_0] or {}

		local var_41_0 = math.random(3, 10)

		if var_0_13:canChallengeMonster(var_0_13:getMonsterInfoByBindId(iter_41_0).id) then
			for iter_41_2, iter_41_3 in ipairs(iter_41_1) do
				local var_41_1 = self:getShamInMonsterPos(iter_41_0, var_0_12.TRIAL.SHAM_USER_A)

				if iter_41_3 ~= self._myId and not self:getBindEntity(iter_41_3) and var_41_1 then
					local var_41_2 = var_0_11:getSnapShot(var_0_10.SNAP_SHOT_KEY.USER, iter_41_3)

					if var_41_2 then
						local var_41_3 = self:_createUser(var_41_2, var_41_1, iter_41_3)
						local var_41_4 = self:getBindEntity(iter_41_0)

						if var_41_4 then
							var_41_3:refreshDir(var_41_4:getCoord())
						end

						table.insert(self._monsterShamUserDict[iter_41_0], iter_41_3)

						self._scheduleList[iter_41_3] = g.core.common.Scheduler:newSchedule(function()
							self:playerAttackMonster(iter_41_3)
						end, var_41_0)
						var_41_0 = var_41_0 + math.random(1, 3)
					end
				end
			end
		end
	end

	for iter_41_4, iter_41_5 in pairs((var_0_13:getShamUserDict(var_0_12.TRIAL.SHAM_USER_B))) do
		self._monsterShamUserDict[iter_41_4] = self._monsterShamUserDict[iter_41_4] or {}

		local var_41_5 = math.random(5, 10)

		if var_0_13:canChallengeMonster(var_0_13:getMonsterInfoByBindId(iter_41_4).id) then
			for iter_41_6, iter_41_7 in ipairs(iter_41_5) do
				local var_41_6 = self:getShamInMonsterPos(iter_41_4, var_0_12.TRIAL.SHAM_USER_B)

				if iter_41_7 ~= self._myId and not self:getBindEntity(iter_41_7) and var_41_6 then
					local var_41_7 = var_0_11:getSnapShot(var_0_10.SNAP_SHOT_KEY.USER, iter_41_7)

					if var_41_7 then
						local var_41_8 = self:_createUser(var_41_7, var_41_6, iter_41_7)
						local var_41_9 = self:getBindEntity(iter_41_4)

						if var_41_9 then
							local var_41_10 = var_41_9:getCoord()
							local var_41_11 = cc.pAdd(var_41_10, self._randomPosDirList[math.random(1, #self._randomPosDirList)])

							if not KsMath.IsSameCoord(var_41_6, var_41_11) then
								local var_41_12 = KsAStar.searchNearPath(var_41_6, var_41_11, self)

								if var_41_12 then
									var_41_8:walkStart(var_41_12, true)
								end

								table.insert(self._monsterShamUserDict[iter_41_4], iter_41_7)

								self._scheduleList[iter_41_7] = g.core.common.Scheduler:newSchedule(function()
									self:playerAttackMonster(iter_41_7, nil, var_41_10)
								end, var_41_5)
								var_41_5 = var_41_5 + math.random(1, 3)
							end
						end
					end
				end
			end
		end
	end
end

function AllianceTrialGameWorld:_createUser(arg_44_1, arg_44_2, arg_44_3)
	local var_44_0 = self:doCreateFactory():createRecord()

	var_44_0.isMain = false
	var_44_0.dName = arg_44_1.name
	var_44_0.resID = self:getKnightResId(arg_44_1)
	var_44_0.type = AllianceTrialMapConst.RESTYPE.KNIGHT
	var_44_0.scale = 0.8
	var_44_0.bindID = arg_44_3

	local var_44_1 = self:doCreateFactory().createEntity(var_44_0)

	var_44_1:setCoord(arg_44_2)
	var_44_1:setAttachName(AllianceTrialMapConst.MAP_DECORATE)

	if var_44_1.setWalkSpeed then
		var_44_1:setWalkSpeed(AllianceTrialMapConst.MOVE_SPEED)
	end

	self:addEntity(var_44_1)
	var_44_1:setInView(true)

	return var_44_1
end

function AllianceTrialGameWorld:getShamInMonsterPos(arg_45_1, arg_45_2)
	local var_45_0 = self:getBindEntity(arg_45_1)

	if var_45_0 then
		if arg_45_2 == var_0_12.TRIAL.SHAM_USER_A then
			return cc.pAdd(var_45_0:getCoord(), self._randomPosDirList[math.random(1, #self._randomPosDirList)])
		else
			local var_45_1 = self:getMapGround()

			while 10 > 0 do
				local var_45_2 = math.random(1, var_45_1:getMapGridX())
				local var_45_3 = math.random(1, var_45_1:getMapGridY())

				if var_45_1:getHoldType(var_45_2, var_45_3) ~= nil then
					return cc.p(var_45_2, var_45_3)
				end
			end
		end
	end

	return nil
end

function AllianceTrialGameWorld:notifyAttackUser(arg_46_1)
	self:playerAttackMonster(arg_46_1)
end

function AllianceTrialGameWorld:removeAllSchedule()
	for iter_47_0, iter_47_1 in pairs(self._scheduleList) do
		g.core.common.Scheduler:cancelSchedule(iter_47_1)
	end

	self._scheduleList = {}
end

return AllianceTrialGameWorld
