local KsAStar = require("app.core.utils.KsAStar")
local KsMath = require("app.core.utils.KsMath")
local MapConst = require("app.core.ksmap.MapConst")
local var_0_3 = require("app.core.ksmap.MapConst")
local StormEntityFactory = require("app.view.module.storm.base.StormEntityFactory")
local StormGround = require("app.view.module.storm.view.smallCity.StormGround")
local StormTouch = require("app.view.module.storm.view.smallCity.StormTouch")
local StormSmallCityConst = require("app.view.module.storm.const.StormSmallCityConst")
local StormConst = require("app.view.module.storm.const.StormConst")
local var_0_9 = g.core.config.storm_event_info
local var_0_10 = g.core.config.storm_cell_event_info
local StormWorld = class("StormWorld", require("app.core.ksmap.MapWorld"))

function StormWorld:ctor(arg_1_1, arg_1_2)
	self._refMainRole = nil
	self._bindEntityDict = {}
	self._isUpdated = false
	self._normalRewardPosDict = {}
	self._circleProgressNodeList = {}

	StormWorld.super.ctor(self, arg_1_1, arg_1_2)
	self:addMainRole()

	self._refTalkTarget = nil
	self._followCenter = nil
end

function StormWorld:addMainRole()
	if self._refMainRole then
		self:delEntity(self._refMainRole)

		self._refMainRole = nil
	end

	local var_2_0 = self:doCreateFactory():createRecord()

	var_2_0.isMain = true
	var_2_0.dName = g.core.model.User:getName()
	var_2_0.resID = g.core.model.User.knightsData:getMainKnight():getResInfo().fight_id
	var_2_0.type = var_0_3.RESTYPE.KNIGHT
	var_2_0.scale = 0.8

	local var_2_1 = require("app.view.module.storm.base.StormMainRole").new(var_2_0)

	var_2_1:setCoord((self:getOrgCoord()))
	var_2_1:setAttachName(StormSmallCityConst.MAP_DECORATE)
	self:addEntity(var_2_1)
	var_2_1:setFightValue(g.core.utils.Number.transTextNumFormation((g.core.model.User:getFightValue())))

	self._refMainRole = var_2_1
end

function StormWorld:setUpdateState(arg_3_1)
	self._isUpdated = true
end

function StormWorld:updateEntity(arg_4_1)
	if not arg_4_1 or not next(arg_4_1) then
		return
	end

	local var_4_0 = self._bindEntityDict

	self._bindEntityDict = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		if var_4_0[iter_4_1.cell_id] then
			self._bindEntityDict[iter_4_1.cell_id] = var_4_0[iter_4_1.cell_id]
			var_4_0[iter_4_1.cell_id] = nil

			for iter_4_2, iter_4_3 in ipairs(self._bindEntityDict[iter_4_1.cell_id]) do
				iter_4_3:setShow(true)

				if not iter_4_3.ev_id then
					iter_4_3.ev_id = iter_4_1.ev_id

					local var_4_1 = var_0_9.get(iter_4_1.ev_id)

					iter_4_3.event_type = var_4_1.event_type

					local var_4_2 = var_0_10.fetch(iter_4_1.cell_id)

					if var_4_2 and iter_4_3.setFightValue then
						iter_4_3:setFightValue(g.core.utils.Number.transTextNumFormation(var_4_1.fight_power))
					end

					if var_4_2 and iter_4_3.setName then
						iter_4_3:setName(var_4_1.name)
					end
				end
			end
		end
	end

	for iter_4_4, iter_4_5 in pairs(var_4_0) do
		if type(iter_4_5) == "table" then
			for iter_4_6, iter_4_7 in ipairs(iter_4_5) do
				self:delEntity(iter_4_7)
			end
		else
			self:delEntity(iter_4_5)
		end
	end

	self:updateTempHolder()
end

function StormWorld:getReward(arg_5_1)
	if self._bindEntityDict[arg_5_1.cell_id][1] then
		self:delEntity(self._bindEntityDict[arg_5_1.cell_id][1])
	end
end

function StormWorld:updateTempHolder()
	self:getMapGround():updateTempGroundHold(self._bindEntityDict)
end

function StormWorld:clearFogEntityVisible(arg_7_1, arg_7_2)
	if not self._entityFieldDict[StormSmallCityConst.MAP_FLOOR] then
		return
	end

	for iter_7_0 = -arg_7_2, arg_7_2 do
		for iter_7_1 = -arg_7_2, arg_7_2 do
			local var_7_0 = self._entityFieldDict[StormSmallCityConst.MAP_FLOOR]:getElements((KsMath.coord2Unified(arg_7_1.x + iter_7_0, arg_7_1.y + iter_7_1)))

			if var_7_0 then
				for iter_7_2 = 1, #var_7_0 do
					if not var_7_0[iter_7_2]:isMainRole() then
						var_7_0[iter_7_2]:setShow(true)
					end
				end
			end
		end
	end
end

function StormWorld:startWorld()
	local var_8_0 = self:getMapStage():getStayCoord()

	if var_8_0 == nil then
		var_8_0 = self:getOrgCoord()
	else
		self._refMainRole:jump2Coord(var_8_0)
	end

	self:jump2MainRole()
end

function StormWorld:_doTickUpdate(arg_9_1)
	if self._refMainRole:tickWalk(arg_9_1) then
		self:getMapStage():saveStayCoord(self._refMainRole:getCoord())

		if self._refTalkTarget then
			self:getMapStage():talkTrigger(self._refTalkTarget)
			self:_setTalkTarget(nil)
		end
	end

	self:_checkFollowing(arg_9_1)
	self:_autoInertiaUpdate(arg_9_1)
	self:_checkEntityInView()
	self:getMapStage():refreshClueTargetLocation()
end

function StormWorld:getBindEntity(arg_10_1)
	return self._bindEntityDict[arg_10_1]
end

function StormWorld:autoRouteTalk(arg_11_1, arg_11_2)
	self:_setTalkTarget(arg_11_1)

	local var_11_0 = KsAStar.searchTalkPath(self._refMainRole:getCoord(), arg_11_1:getCoord(), self)

	if var_11_0 == nil then
		if arg_11_1.event_type == StormConst.EVENT_TYPE.NORMAL_AWARD then
			g.core.module.ModuleManager:pushPopup(require("app.view.module.storm.view.pop.StormRewardPreviewPop").new(var_0_9.fetch(arg_11_1.ev_id).challenge_reward), {
				touchDisappear = true
			})
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(304512))
		end
	else
		self._refMainRole:walkStart(var_11_0, arg_11_2)
	end
end

function StormWorld:autoRouteTo(arg_12_1, arg_12_2)
	self:_setTalkTarget(nil)

	local var_12_0 = self._refMainRole:getCoord()

	if KsMath.IsSameCoord(var_12_0, arg_12_1) then
		return false
	end

	local var_12_1 = KsAStar.searchPath(var_12_0, arg_12_1, self)

	if var_12_1 == nil then
		if arg_12_2 then
			g.core.module.ModuleManager:pushPopup(require("app.view.module.storm.view.pop.StormRewardPreviewPop").new(var_0_9.fetch(arg_12_2.ev_id).challenge_reward), {
				touchDisappear = true
			})
		else
			self._refMainRole:walkStart((KsAStar.searchNearPath(var_12_0, arg_12_1, self)))
		end
	else
		self._refMainRole:walkStart(var_12_1)
	end
end

function StormWorld:onSingleClick(arg_13_1)
	self:getMapStage():pickupStop()

	local var_13_0 = self:convertToNodeSpace(arg_13_1)
	local var_13_1, var_13_2 = self:getMapGround():pixelToCoord(var_13_0.x, var_13_0.y)

	if self:getMapGround():checkCoordInvalid(var_13_1, var_13_2) then
		g.core.module.ModuleManager:tip(g.core.lang:get(304513))

		return
	end

	self._refMainRole:walkStop()

	local var_13_3 = self:_checkEntityHit(var_13_0)

	if var_13_3 then
		self:autoRouteTalk(var_13_3)
	else
		self:autoRouteTo(cc.p(var_13_1, var_13_2), var_13_3)
	end
end

function StormWorld:setFollowCenter(arg_14_1)
	self._followCenter = arg_14_1
end

function StormWorld:jump2MainRole()
	self:moveCell2SC((self._refMainRole:getCoord()))
end

function StormWorld:findTargetItem(arg_16_1)
	for iter_16_0, iter_16_1 in pairs(self._bindEntityDict) do
		for iter_16_2, iter_16_3 in ipairs(iter_16_1) do
			if iter_16_3.ev_id == arg_16_1.event_id then
				self:moveCell2SC((iter_16_3:getCoord()))

				return
			end
		end
	end
end

function StormWorld:getNeedGuideTarget()
	local var_17_0

	for iter_17_0, iter_17_1 in pairs(self._bindEntityDict) do
		for iter_17_2, iter_17_3 in ipairs(iter_17_1) do
			local var_17_1 = var_0_9.fetch(iter_17_3.ev_id)

			var_17_0 = var_17_1 and var_17_1.event_type == StormConst.EVENT_TYPE.SPECAIL_BARRIER and (not var_17_0 and var_17_1 or var_17_1.id < var_17_0.id and var_17_1) or var_17_0
		end
	end

	if var_17_0 and var_17_0.if_clue > 0 then
		return self:findTargetByEventId((g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_ITEM, var_17_0.event_value1) >= var_17_0.cost_success or nil) and (var_17_0.id or var_17_0.if_clue))
	end
end

function StormWorld:findTargetByEventId(arg_18_1)
	for iter_18_0, iter_18_1 in pairs(self._bindEntityDict) do
		for iter_18_2, iter_18_3 in ipairs(iter_18_1) do
			if iter_18_3.ev_id == arg_18_1 then
				return iter_18_3
			end
		end
	end
end

function StormWorld:getGuideTargetByEventType(arg_19_1)
	local var_19_0

	for iter_19_0, iter_19_1 in pairs(self._bindEntityDict) do
		for iter_19_2, iter_19_3 in ipairs(iter_19_1) do
			local var_19_1 = var_0_9.fetch(iter_19_3.ev_id)

			var_19_0 = var_19_1 and var_19_1.event_type == arg_19_1 and (not var_19_0 and iter_19_3 or iter_19_3.ev_id < var_19_0.ev_id and iter_19_3) or var_19_0
		end
	end

	return var_19_0
end

function StormWorld:moveWorld(arg_20_1)
	local var_20_0, var_20_1 = self.super.moveWorld(self, arg_20_1)

	self:getMapGround():updateFogInView()

	return var_20_0, var_20_1
end

function StormWorld:startInertiaWorld(arg_21_1, arg_21_2)
	if self._followCenter then
		return
	end

	self._autoInertiaDir = arg_21_1

	if self._autoInertiaDir == nil then
		return
	end

	self._autoInertiaDist = arg_21_2 * StormSmallCityConst.INER_SENSITITY
end

function StormWorld:doCanMoveAStar(arg_22_1, arg_22_2)
	local var_22_0 = self:getMapGround()

	if var_22_0:checkCoordInvalid(arg_22_2.x, arg_22_2.y) then
		return false
	end

	return var_22_0:getHoldType(arg_22_2.x, arg_22_2.y) ~= nil
end

function StormWorld:_doCreateGround()
	return StormGround.new(self)
end

function StormWorld:_doCreateTouch()
	return nil
end

function StormWorld:_doInitTouchMatch()
	self._mapTouch = StormTouch.new(self)
end

function StormWorld:_doAddEntity(arg_26_1)
	local var_26_0 = arg_26_1:isMainRole()

	if var_26_0 then
		self._refMainRole = arg_26_1

		self._refMainRole:setInView(true)
	end

	local var_26_1 = arg_26_1:getBindID()

	if var_26_1 > 0 then
		if var_0_9.fetch(var_0_10.fetch(var_26_1).event_id_1).event_type == StormConst.EVENT_TYPE.NORMAL_AWARD then
			local var_26_2 = arg_26_1:getCoord()

			self._normalRewardPosDict[var_26_2.x] = self._normalRewardPosDict[var_26_2.x] or {}
			self._normalRewardPosDict[var_26_2.x][var_26_2.y] = arg_26_1
		end

		self._bindEntityDict[var_26_1] = self._bindEntityDict[var_26_1] or {}

		table.insert(self._bindEntityDict[var_26_1], arg_26_1)

		if arg_26_1._resType == var_0_3.RESTYPE.KNIGHT then
			self._bindEntityDict[var_26_1].owner = arg_26_1
		elseif arg_26_1._resType == var_0_3.RESTYPE.IMAGE and arg_26_1._resID ~= "pic_0.png" then
			self._bindEntityDict[var_26_1].owner = arg_26_1
		end

		if not var_26_0 then
			arg_26_1:setShow(false)
		end
	end

	if arg_26_1.getClearFogRangeAtBirth then
		local var_26_3 = arg_26_1:getClearFogRangeAtBirth()

		if var_26_3 > 0 then
			local var_26_4 = arg_26_1:getCoord()

			self:getMapGround():clearFog(var_26_4, var_26_3)
			self:clearFogEntityVisible(var_26_4, var_26_3)
		end
	end
end

function StormWorld:_doDelEntity(arg_27_1)
	local var_27_0 = arg_27_1:getBindID()
	local var_27_1 = arg_27_1:getCoord()

	if var_27_0 > 0 then
		self._bindEntityDict[var_27_0] = nil
	end

	if self._normalRewardPosDict[var_27_1.x] and self._normalRewardPosDict[var_27_1.x][var_27_1.y] then
		self._normalRewardPosDict[var_27_1.x][var_27_1.y] = nil
	end

	self:updateTempHolder()
end

function StormWorld:doDragWorld(arg_28_1)
	if self._followCenter then
		return
	end

	self:moveWorld(arg_28_1)
	self:_checkRoleInScreen()
end

function StormWorld:_checkEntityHit(arg_29_1)
	if self._inDestroy then
		return nil
	end

	for iter_29_0, iter_29_1 in pairs(self._bindEntityDict) do
		for iter_29_2, iter_29_3 in ipairs(iter_29_1) do
			if iter_29_3:checkHit(arg_29_1) then
				if iter_29_1.owner then
					return iter_29_1.owner
				end

				local var_29_0 = #iter_29_1

				if #iter_29_1 > 2 then
					var_29_0 = math.ceil(var_29_0 / 2)
				end

				return iter_29_1[var_29_0]
			end
		end
	end

	return nil
end

function StormWorld:_setTalkTarget(arg_30_1)
	self._refTalkTarget = arg_30_1
end

function StormWorld:_checkFollowing(arg_31_1)
	if self._followCenter == nil then
		return
	end

	local var_31_0 = self:convertScreenCenter()
	local var_31_1 = KsMath.calculateDistance(self._followCenter, var_31_0)

	if var_31_1 < 50 then
		self._followCenter = nil

		return
	end

	local var_31_2, var_31_3 = self:movePA2PB(self._followCenter, (KsMath.walkDistance(self._followCenter, var_31_0, var_0_3.MOVE_SPEED * (var_31_1 / 200) * arg_31_1)))

	if var_31_2 or var_31_3 then
		self._followCenter = nil
	end
end

function StormWorld:_checkRoleInScreen()
	local var_32_0 = self._refMainRole:getWorldPos()
	local var_32_1 = self:convertScreenCenter()

	if KsMath.rectIn(var_32_0, var_32_1, display.width / 2, display.height / 2) then
		self:getMapStage():setHeadArrow(false)

		return true
	end

	local var_32_2 = cc.p(50, display.height / 2)

	if var_32_0.x > var_32_1.x then
		var_32_2.x = display.width - 50
	end

	self:getMapStage():setHeadArrow(true, var_32_2.x, (KsMath.calculateRotation(self:convertToNodeSpace(var_32_2), var_32_0)))

	return false
end

function StormWorld:_autoInertiaUpdate(arg_33_1)
	if self._autoInertiaDir == nil then
		return
	end

	local var_33_0, var_33_1 = self:moveWorld(cc.p(self._autoInertiaDir.x * self._autoInertiaDist, self._autoInertiaDir.y * self._autoInertiaDist))

	self._autoInertiaDist = self._autoInertiaDist - StormSmallCityConst.INER_ACCE

	if var_33_0 or var_33_1 or self._autoInertiaDist <= 0 then
		self._autoInertiaDir = nil
	end
end

function StormWorld:doCreateFactory()
	return StormEntityFactory
end

function StormWorld:doDestroyObstacle(arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = arg_35_2
	local var_35_1 = arg_35_1

	if self._bindEntityDict[arg_35_1] and self._bindEntityDict[arg_35_1][1] and not self._circleProgressNodeList[arg_35_1] then
		self._inDestroy = true

		local var_35_2 = self:getMapGround():getFogDadNode()

		if var_35_2 then
			local var_35_3 = cc.Node:create()

			self._circleProgressNodeList[arg_35_1] = var_35_3

			local var_35_5 = display.newSprite((arg_35_3 or nil) and "ui_cocos/storm/icon_shiquzhong.png")
			local var_35_6 = cc.ProgressTimer:create((display.newSprite("ui_cocos/storm/pic_jindutiao.png")))

			var_35_6:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
			var_35_3:addChild((display.newSprite("ui_cocos/storm/pic_jindutiao_2.png")))
			var_35_3:addChild(var_35_6)
			var_35_3:addChild(var_35_5)
			var_35_6:runAction(cc.Sequence:create(cc.ProgressFromTo:create(2, 0, 100), cc.CallFunc:create(handler(self, function()
				if var_35_0 then
					var_35_0()
				end

				self:onDestroyFinish(var_35_1)
			end))))

			local var_35_7 = self._bindEntityDict[arg_35_1][1]:getCoord()

			var_35_2:addChild(var_35_3)

			local var_35_8, var_35_9 = self:getMapGround():coordToPixel(var_35_7.x, var_35_7.y)

			var_35_3:setPosition(var_35_8, var_35_9 + 70)
		end
	end
end

function StormWorld:onDestroyFinish(arg_37_1)
	self._inDestroy = false

	if arg_37_1 and self._circleProgressNodeList and self._circleProgressNodeList[arg_37_1] then
		self._circleProgressNodeList[arg_37_1]:removeFromParent()

		self._circleProgressNodeList[arg_37_1] = nil
	end

	self:getMapStage():updateStageView()
end

function StormWorld:getMainRole()
	return self._refMainRole
end

return StormWorld
