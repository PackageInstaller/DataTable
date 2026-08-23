local var_0_0 = g.core.config.knight_base_info
local KsAStar = require("app.core.utils.KsAStar")
local KsMath = require("app.core.utils.KsMath")
local MysteryMapGround = import(".MysteryMapGround")
local MysteryGameTouch = import(".MysteryGameTouch")
local MysterMapConst = import(".MysterMapConst")
local BattleConst = require("app.view.battle.const.BattleConst")
local MapConst = require("app.core.ksmap.MapConst")
local var_0_8 = g.core.model.User.mysteryData
local MysteryEntityFactory = require("app.view.module.mystery.view.map.Entity.MysteryEntityFactory")
local MysteryGameWorld = class("MysteryGameWorld", require("app.core.ksmap.MapWorld"))

function MysteryGameWorld:ctor(arg_1_1, arg_1_2)
	self._refMainRole = nil
	self._bindEntityDict = {}

	MysteryGameWorld.super.ctor(self, arg_1_1, arg_1_2)

	self._followCenter = nil
	self._chapterInfo = nil
	self._lastMoveSendTime = 0
	self._bubbleSchedule = nil

	self:addMainRole()
end

function MysteryGameWorld:addMainRole()
	if self._refMainRole then
		self:delEntity(self._refMainRole)

		self._refMainRole = nil
	end

	local var_2_0 = self:doCreateFactory():createRecord()

	var_2_0.isMain = true
	var_2_0.dName = g.core.model.User:getName()
	var_2_0.resID = g.core.model.User.knightsData:getMainKnight():getResInfo().fight_id
	var_2_0.type = MysterMapConst.RESTYPE.KNIGHT
	var_2_0.scale = 0.8
	var_2_0.bindID = g.core.model.User:getId()

	local var_2_1 = self:doCreateFactory().createEntity(var_2_0)

	var_2_1:setCoord((self:getOrgCoord()))
	var_2_1:setAttachName(MysterMapConst.MAP_DECORATE)

	if var_2_1.setWalkSpeed then
		var_2_1:setWalkSpeed(MysterMapConst.MOVE_SPEED)
	end

	self:addEntity(var_2_1)

	self._refMainRole = var_2_1
end

function MysteryGameWorld:removeOldRoomUser()
	for iter_3_0, iter_3_1 in pairs((var_0_8:getOldRoomUser())) do
		self:delUserEntity(iter_3_0)
	end
end

function MysteryGameWorld:createUserEntity()
	for iter_4_0, iter_4_1 in pairs(var_0_8:getRoomUserData() or {}) do
		if iter_4_0 ~= g.core.model.User:getId() and iter_4_1.snapShot and not self:getBindEntity(iter_4_0) then
			local var_4_0 = self:doCreateFactory():createRecord()

			var_4_0.isMain = false
			var_4_0.dName = iter_4_1.snapShot.name
			var_4_0.resID = self:getKnightResId(iter_4_1.snapShot)
			var_4_0.type = MysterMapConst.RESTYPE.KNIGHT
			var_4_0.scale = 0.8
			var_4_0.bindID = iter_4_1.snapShot.id
			var_4_0.bParam = {
				snapshot = iter_4_1.snapShot
			}

			local var_4_1 = self:doCreateFactory().createEntity(var_4_0)

			var_4_1:setCoord(iter_4_1.pos)
			var_4_1:setAttachName(MysterMapConst.MAP_DECORATE)

			if var_4_1.setWalkSpeed then
				var_4_1:setWalkSpeed(MysterMapConst.MOVE_SPEED)
			end

			self:addEntity(var_4_1)
		end
	end
end

function MysteryGameWorld:_checkEntityInView()
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
				if iter_5_5:getResType() == MysterMapConst.RESTYPE.KNIGHT then
					iter_5_5:setInView(true)
				else
					iter_5_5:setInView((iter_5_5:checkIsNeedShow(var_5_1)))
				end
			end
		end
	end
end

function MysteryGameWorld:delUserEntity(arg_6_1)
	if arg_6_1 ~= g.core.model.User:getId() then
		local var_6_0 = self:getBindEntity(arg_6_1)

		if var_6_0 then
			self:delEntity(var_6_0)
		end

		self:deletePlayerDetailList(arg_6_1)
	end
end

function MysteryGameWorld:getKnightResId(arg_7_1)
	if arg_7_1.skin and arg_7_1.skin > 0 then
		local var_7_0 = g.core.config.skin_info.fetch(arg_7_1.skin)

		if var_7_0 then
			local var_7_1 = var_0_0.fetch(var_7_0.res)

			if var_7_1 then
				return var_7_1.fight_id
			end
		end
	end

	return g.core.config.knight_info.get(arg_7_1.base_id).res_id
end

function MysteryGameWorld:startWorld()
	local var_8_0 = self:getMapStage():getStayCoord()

	if var_8_0 == nil then
		var_8_0 = self:getOrgCoord()
	else
		self._refMainRole:jump2Coord(var_8_0)
	end

	self:jump2MainRole()
end

function MysteryGameWorld:_doTickUpdate(arg_9_1)
	if self._refMainRole:tickWalk(arg_9_1) then
		self:getMapStage():saveStayCoord(self._refMainRole:getCoord())
		self:_sendMysteryMove()

		if self._refTalkTarget then
			self:getMapStage():talkTrigger(self._refTalkTarget)
			self:_setTalkTarget(nil)
		end
	end

	self:_checkFollowing(arg_9_1)
	self:_autoInertiaUpdate(arg_9_1)
	self:_checkEntityInView()
	self:_checkNameInit()

	for iter_9_0, iter_9_1 in pairs(var_0_8:getRoomUserData() or {}) do
		local var_9_0 = self:getBindEntity(iter_9_0)

		if iter_9_0 ~= g.core.model.User:getId() and var_9_0 then
			var_9_0:tickWalk(arg_9_1)
		end
	end

	self:_updateMonsterExistState()
end

function MysteryGameWorld:getBindEntity(arg_10_1)
	return self._bindEntityDict[arg_10_1]
end

function MysteryGameWorld:setShowFootEffect(arg_11_1, arg_11_2)
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

function MysteryGameWorld:setEntityVisible(arg_12_1, arg_12_2)
	if self._bindEntityDict[arg_12_1] then
		self._bindEntityDict[arg_12_1]:setShow(arg_12_2)

		local var_12_0 = self._bindEntityDict[arg_12_1]:getVisual()

		if var_12_0 then
			var_12_0:setBillBoardVisible(arg_12_2)
		end
	end
end

function MysteryGameWorld:autoRouteTalk(arg_13_1, arg_13_2)
	self:_setTalkTarget(arg_13_1)
	self:showSelfOpView(false)

	local var_13_0 = KsAStar.searchTalkPath(self._refMainRole:getCoord(), arg_13_1:getCoord(), self)

	if var_13_0 then
		self._refMainRole:walkStart(var_13_0, arg_13_2)
	end
end

function MysteryGameWorld:autoRouteTo(arg_14_1)
	self:_setTalkTarget(nil)

	local var_14_0 = self._refMainRole:getCoord()

	if KsMath.IsSameCoord(var_14_0, arg_14_1) then
		return false
	end

	self:hidePlayerOpView()

	local var_14_1 = KsAStar.searchNearPath(var_14_0, arg_14_1, self)

	if var_14_1 then
		self._refMainRole:walkStart(var_14_1, true)
	end
end

function MysteryGameWorld:_sendMysteryMove()
	g.core.network.GameNetProxy:send_C2S_Mystery_Move({
		pos = self._refMainRole:getCoord()
	})
end

function MysteryGameWorld:playerRouteToCoord(arg_16_1, arg_16_2)
	if arg_16_1 == nil then
		return false
	end

	local var_16_0 = self:getBindEntity(arg_16_1)

	if var_16_0 == nil then
		return false
	end

	local var_16_1 = var_16_0:getCoord()

	if KsMath.IsSameCoord(var_16_1, arg_16_2) then
		return false
	end

	local var_16_2 = KsAStar.searchNearPath(var_16_1, arg_16_2, self)

	if var_16_2 then
		var_16_0:walkStart(var_16_2, true)
	else
		var_16_0:setCoord(arg_16_2)
	end
end

function MysteryGameWorld:playerAttackMonster(arg_17_1)
	local var_17_0 = self:getBindEntity(arg_17_1)
	local var_17_1 = var_0_8:getRoomUserData() or {}

	if var_17_1[arg_17_1] and var_17_1[arg_17_1].isAttack and var_17_0 then
		local var_17_2 = var_17_0:getVisual()

		if var_17_2 then
			var_17_2:runAction((cc.Sequence:create(cc.CallFunc:create(handler(self, function()
				var_17_2:setRoleAction(BattleConst.SPINE_ACTION_TYPE.ATTACK, false)
			end)), cc.DelayTime:create(1), cc.CallFunc:create(handler(self, function()
				var_17_2:setRoleAction(BattleConst.SPINE_ACTION_TYPE.IDLE, true)
			end)))))
		end
	end
end

function MysteryGameWorld:onSingleClick(arg_20_1)
	local var_20_0 = self:convertToNodeSpace(arg_20_1)
	local var_20_1, var_20_2 = self:getMapGround():pixelToCoord(var_20_0.x, var_20_0.y)

	if self:getMapGround():checkCoordInvalid(var_20_1, var_20_2) then
		g.core.module.ModuleManager:tip(g.core.lang:get(302070))

		return
	end

	self._refMainRole:walkStop()

	local var_20_3 = self:_checkEntityHit(var_20_0)

	if var_20_3 then
		local var_20_4 = self:_checkPlayerHit(var_20_0)

		if next(var_20_4) then
			self:showOtherOpView(true, var_20_4)
		else
			self:showOtherOpView(false)
		end

		if self._refMainRole:checkHit(var_20_0) then
			self:showSelfOpView(true)
		else
			self:autoRouteTalk(var_20_3, true)
			self:showSelfOpView(false)
		end
	elseif self._refMainRole:checkHit(var_20_0) then
		self:showSelfOpView(true)
	else
		self:autoRouteTo((cc.p(var_20_1, var_20_2)))
		self:showSelfOpView(false)
		self:showOtherOpView(false)
	end
end

function MysteryGameWorld:showSelfOpView(arg_21_1)
	if self._refMainRole then
		local var_21_0, var_21_1 = self._refMainRole:getVisual():getPosition()

		self:getMapStage():showSelfOpView(arg_21_1, self:getMapGround():convertToWorldSpace((cc.p(var_21_0, var_21_1))))
	end
end

function MysteryGameWorld:showOtherOpView(arg_22_1, arg_22_2)
	if arg_22_1 and arg_22_2 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.MYSTERY_SHOW_GRID_PLAYER, false, {
			isShow = true,
			showTarget = arg_22_2
		})
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.MYSTERY_SHOW_GRID_PLAYER, false, {
			isShow = false
		})
	end
end

function MysteryGameWorld:deletePlayerDetailList(arg_23_1)
	return
end

function MysteryGameWorld:hidePlayerOpView()
	self:showOtherOpView(false)
	self:showSelfOpView(false)
end

function MysteryGameWorld:setFollowCenter(arg_25_1)
	self._followCenter = arg_25_1
end

function MysteryGameWorld:jump2MainRole()
	self:moveCell2SC((self._refMainRole:getCoord()))
	self:hidePlayerOpView()
end

function MysteryGameWorld:startInertiaWorld(arg_27_1, arg_27_2)
	if self._followCenter then
		return
	end

	self._autoInertiaDir = arg_27_1

	if self._autoInertiaDir == nil then
		return
	end

	self._autoInertiaDist = arg_27_2 * MysterMapConst.INER_SENSITITY
end

function MysteryGameWorld:doCanMoveAStar(arg_28_1, arg_28_2)
	local var_28_0 = self:getMapGround()

	if var_28_0:checkCoordInvalid(arg_28_2.x, arg_28_2.y) then
		return false
	end

	return var_28_0:getHoldType(arg_28_2.x, arg_28_2.y) ~= nil
end

function MysteryGameWorld:_doCreateGround()
	return MysteryMapGround.new(self)
end

function MysteryGameWorld:_doCreateTouch()
	return nil
end

function MysteryGameWorld:doCreateFactory()
	return MysteryEntityFactory
end

function MysteryGameWorld:_doInitTouchMatch()
	self._mapTouch = MysteryGameTouch.new(self)
end

function MysteryGameWorld:_doAddEntity(arg_33_1)
	if arg_33_1:isMainRole() then
		self._refMainRole = arg_33_1

		self._refMainRole:setInView(true)
	end

	local var_33_0 = arg_33_1:getBindID()

	if (var_0_8:getRoomUserData() or {})[var_33_0] then
		arg_33_1:setInView(true)
	end

	if var_33_0 > 0 then
		self._bindEntityDict[var_33_0] = arg_33_1
	end
end

function MysteryGameWorld:_doDelEntity(arg_34_1)
	local var_34_0 = arg_34_1:getBindID()

	if var_34_0 > 0 then
		self._bindEntityDict[var_34_0] = nil
	end
end

function MysteryGameWorld:doDragWorld(arg_35_1)
	if self._followCenter then
		return
	end

	self:showSelfOpView(false)
	self:moveWorld(arg_35_1)
end

function MysteryGameWorld:moveWorld(arg_36_1)
	local var_36_0, var_36_1 = self.super.moveWorld(self, arg_36_1)

	self:fitOpPosition()

	return var_36_0, var_36_1
end

function MysteryGameWorld:_checkEntityHit(arg_37_1)
	for iter_37_0, iter_37_1 in pairs(self._bindEntityDict) do
		if iter_37_1 ~= self._refMainRole and iter_37_1:checkHit(arg_37_1) then
			return iter_37_1
		end
	end

	return nil
end

function MysteryGameWorld:_checkPlayerHit(arg_38_1)
	local var_38_0 = {}

	for iter_38_0, iter_38_1 in pairs((var_0_8:getRoomUserData())) do
		local var_38_1 = self:getBindEntity(iter_38_0)

		if var_38_1 and var_38_1 ~= self._refMainRole and var_38_1:checkHit(arg_38_1) then
			table.insert(var_38_0, var_38_1)
		end
	end

	return var_38_0
end

function MysteryGameWorld:_setTalkTarget(arg_39_1)
	if arg_39_1 then
		self:setShowFootEffect(arg_39_1, true)
	else
		self:setShowFootEffect(self._refTalkTarget, false)
	end

	self._refTalkTarget = arg_39_1
end

function MysteryGameWorld:_checkFollowing(arg_40_1)
	if self._followCenter == nil then
		return
	end

	local var_40_0 = self:convertScreenCenter()
	local var_40_1 = KsMath.calculateDistance(self._followCenter, var_40_0)

	if var_40_1 < 50 then
		self._followCenter = nil

		return
	end

	local var_40_2, var_40_3 = self:movePA2PB(self._followCenter, (KsMath.walkDistance(self._followCenter, var_40_0, MysterMapConst.MOVE_SPEED * (var_40_1 / 200) * arg_40_1)))

	if var_40_2 or var_40_3 then
		self._followCenter = nil
	end

	self:fitOpPosition()
end

function MysteryGameWorld:fitOpPosition()
	if self._refMainRole then
		local var_41_0, var_41_1 = self._refMainRole:getVisual():getPosition()

		self:getMapStage():updateOpPosition(self:getMapGround():convertToWorldSpace((cc.p(var_41_0, var_41_1))))
	end
end

function MysteryGameWorld:_autoInertiaUpdate(arg_42_1)
	if self._autoInertiaDir == nil then
		return
	end

	local var_42_0, var_42_1 = self:moveWorld(cc.p(self._autoInertiaDir.x * self._autoInertiaDist, self._autoInertiaDir.y * self._autoInertiaDist))

	self._autoInertiaDist = self._autoInertiaDist - MysterMapConst.INER_ACCE

	if var_42_0 or var_42_1 or self._autoInertiaDist <= 0 then
		self._autoInertiaDir = nil
	end
end

function MysteryGameWorld:showChatBubble(arg_43_1)
	if g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.MYSTERY_BUBBLE_TIME).parameter > g.core.common.ServerTime:getTime() - var_0_8:getLastMysteryChatTime() then
		g.core.module.ModuleManager:tip(g.core.lang:get(423027))
	else
		self._refMainRole:getVisual():showChatBubble(arg_43_1.id, arg_43_1.isEmotion, true)
		g.core.network.GameNetProxy:send_C2S_Mystery_SendLook({
			look = arg_43_1.id,
			look_type = arg_43_1.isEmotion and 1 or 0
		})
	end

	self:hidePlayerOpView()
end

function MysteryGameWorld:showOtherChatBubble(arg_44_1)
	local var_44_0 = self:getBindEntity(arg_44_1.uid)

	if var_44_0 then
		var_44_0:getVisual():showChatBubble(arg_44_1.look, arg_44_1.look_type == 1, false)
	end
end

function MysteryGameWorld:refreshEntityState(arg_45_1)
	self._chapterInfo = arg_45_1
	self._chapterData = var_0_8:getChapterDataById(arg_45_1.id)

	for iter_45_0, iter_45_1 in pairs(self._bindEntityDict) do
		if iter_45_1 ~= self._refMainRole then
			local var_45_0 = self._chapterData:getStageInfoByBindId(iter_45_0)

			if var_45_0 then
				self:_setRoleEntityInfo(iter_45_1, var_45_0.stage_name)
			end
		end
	end

	self._bubbleSchedule = g.core.common.Scheduler:newSchedule(handler(self, self._showTalkBubble), 7)
end

function MysteryGameWorld:createShowTalkEntity()
	local var_46_0 = {}

	if self._bindEntityDict then
		for iter_46_0, iter_46_1 in pairs(self._bindEntityDict) do
			local var_46_1 = self._chapterData:getStageInfoByBindId((iter_46_1:getBindID()))

			if var_46_1 and string.len(var_46_1.lines1) > 0 then
				var_46_0[var_46_1.group] = var_46_0[var_46_1.group] or {}

				table.insert(var_46_0[var_46_1.group], iter_46_1)
			end
		end
	end

	return var_46_0
end

function MysteryGameWorld:_showTalkBubble()
	if tolua.isnull(self) then
		return
	end

	local var_47_0 = false
	local var_47_1 = self:createShowTalkEntity()

	if var_47_1 then
		for iter_47_0, iter_47_1 in pairs(var_47_1) do
			local var_47_2 = iter_47_1[math.random(1, #iter_47_1)]
			local var_47_3 = self._chapterData:getStageInfoByBindId((var_47_2:getBindID()))

			if var_47_3 and string.len(var_47_3.lines1) > 0 then
				var_47_0 = true

				var_47_2:showBubbleTalk(var_47_3.lines1, (math.random(1, 5)))
			end
		end
	else
		var_47_0 = false
	end

	if not var_47_0 and self._bubbleSchedule then
		g.core.common.Scheduler:cancelSchedule(self._bubbleSchedule)

		self._bubbleSchedule = nil
	end
end

function MysteryGameWorld:_setRoleEntityInfo(arg_48_1, arg_48_2)
	if arg_48_1:getResType() == MysterMapConst.RESTYPE.KNIGHT and arg_48_2 and string.len(arg_48_2) > 0 and arg_48_1:setRoleName(arg_48_2) then
		arg_48_1:setNameInit(true)
	end
end

function MysteryGameWorld:_checkNameInit()
	if self._chapterInfo then
		for iter_49_0, iter_49_1 in pairs(self._bindEntityDict) do
			if not iter_49_1:getNameIsInit() and iter_49_1:isHasVisualIns() and iter_49_1 ~= self._refMainRole then
				local var_49_0 = self._chapterData:getStageInfoByBindId(iter_49_0)

				if var_49_0 then
					self:_setRoleEntityInfo(iter_49_1, var_49_0.stage_name)
				end
			end
		end
	end
end

function MysteryGameWorld:_updateMonsterExistState()
	for iter_50_0, iter_50_1 in pairs(self._bindEntityDict) do
		local var_50_0 = self._chapterData:getStageInfoByBindId(iter_50_0)

		if var_50_0 then
			self:setEntityVisible(var_50_0.number, (var_0_8:getStageDataById(var_50_0.id):isMonsterExist()))
		end
	end
end

function MysteryGameWorld:sendEnterMystery(arg_51_1)
	local var_51_0 = var_0_8:getCurRoomId()

	g.core.network.GameNetProxy:send_C2S_Mystery_Enter({
		mystery_id = var_0_8:getCurChapterId(),
		room_id = arg_51_1 and arg_51_1 or var_51_0,
		pos = self._refMainRole:getCoord()
	})
end

function MysteryGameWorld:endWorld()
	if self._bubbleSchedule then
		g.core.common.Scheduler:cancelSchedule(self._bubbleSchedule)

		self._bubbleSchedule = nil
	end
end

return MysteryGameWorld
