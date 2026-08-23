local KsAStar = require("app.core.utils.KsAStar")
local KsMath = require("app.core.utils.KsMath")
local MapConst = require("app.core.ksmap.MapConst")
local StormSmallCityConst = require("app.view.module.storm.const.StormSmallCityConst")
local StormEntityFactory = require("app.view.module.storm.base.StormEntityFactory")
local StormConst = require("app.view.module.storm.const.StormConst")
local var_0_7 = g.core.config.storm_event_info
local StormMiddleCityWorld = class("StormMiddleCityWorld", require("app.core.ksmap.MapWorld"))

function StormMiddleCityWorld:ctor(arg_1_1, arg_1_2)
	self._pagePos = {}
	self._bindEntityDict = {}
	self._enemyBindDict = {}
	self._boxBindDict = {}
	self._curEnemyData = {}
	self._targetPage = -1
	self._YDX = nil
	self._totalMove = 0

	StormMiddleCityWorld.super.ctor(self, arg_1_1, arg_1_2)
	self:setVisible(false)
	self:addMainRole()
end

function StormMiddleCityWorld:addMainRole()
	if self._refMainRole then
		self:delEntity(self._refMainRole)

		self._refMainRole = nil
	end

	local var_2_0 = self:doCreateFactory():createRecord()

	var_2_0.isMain = true
	var_2_0.dName = g.core.model.User:getName()
	var_2_0.resID = g.core.model.User.knightsData:getMainKnight():getResInfo().fight_id
	var_2_0.type = MapConst.RESTYPE.KNIGHT
	var_2_0.scale = 0.8

	local var_2_1 = require("app.view.module.storm.base.StormMainRole").new(var_2_0)

	var_2_1:setCoord((self:getOrgCoord()))
	var_2_1:setAttachName(StormSmallCityConst.MAP_DECORATE)
	self:addEntity(var_2_1)
	var_2_1:setVisualBillboardScale(1.5)
	var_2_1:setFightValue(g.core.utils.Number.transTextNumFormation((g.core.model.User:getFightValue())))

	self._refMainRole = var_2_1
end

function StormMiddleCityWorld:enemyEnterWorld(arg_3_1, arg_3_2)
	if self._enemyBindDict[arg_3_1] then
		self:delEntity(self._enemyBindDict[arg_3_1])
	end

	local var_3_0 = self:doCreateFactory():createRecord()

	var_3_0.dName = arg_3_2.name
	var_3_0.bParam = {
		snapshot = arg_3_2
	}
	var_3_0.resID = arg_3_2.skin and arg_3_2.skin ~= 0 and g.core.config.knight_base_info.get(arg_3_2.skin).fight_id or arg_3_2.base_id

	if var_3_0.resID == arg_3_2.base_id then
		var_3_0.resID = g.core.config.knight_base_info.get(g.core.config.knight_info.get(arg_3_2.base_id).advance_id).fight_id
	end

	var_3_0.type = MapConst.RESTYPE.KNIGHT
	var_3_0.scale = 0.8
	var_3_0.bindID = arg_3_1

	local var_3_1 = require("app.view.module.storm.base.StormMainRole").new(var_3_0)

	if self._bindEntityDict[arg_3_1] then
		var_3_1:setCoord(self._bindEntityDict[arg_3_1]:getCoord())
	end

	var_3_1:setAttachName(StormSmallCityConst.MAP_DECORATE)
	self:addEntity(var_3_1)
	var_3_1:setFightValue(g.core.utils.Number.transTextNumFormation(arg_3_2.fight_value))
	var_3_1:setRoleScale(-1, 1)

	if g.core.model.User.stormData:isPerEventFinish(var_3_1:getBindID(), self:getMapStage():getStormId()) then
		var_3_1:setFightFlagShow(true)
	else
		var_3_1:setFightFlagShow(false)
	end

	self._enemyBindDict[arg_3_1] = var_3_1

	if self._entityBillBoardScale and var_3_1.setVisualBillboardScale then
		var_3_1:setVisualBillboardScale(self._entityBillBoardScale)
	end

	var_3_1:setInView(true)
end

function StormMiddleCityWorld:boxEnterWorld(arg_4_1, arg_4_2)
	if self._boxBindDict[arg_4_1] then
		self:delEntity(self._boxBindDict[arg_4_1])
	end

	local var_4_0 = self:doCreateFactory():createRecord()

	var_4_0.resID = "pic_wuzixiang.png"
	var_4_0.type = MapConst.RESTYPE.IMAGE
	var_4_0.scale = 1
	var_4_0.bindID = arg_4_1
	var_4_0.event_type = 6
	var_4_0.enterWithShow = true

	local var_4_1 = self:doCreateFactory().createEntity(var_4_0)

	var_4_1:setAttachName(StormSmallCityConst.MAP_DECORATE)

	if self._bindEntityDict[arg_4_1] then
		var_4_1:setCoord(self._bindEntityDict[arg_4_1]:getCoord())
	end

	self:addEntity(var_4_1)

	self._boxBindDict[arg_4_1] = var_4_1
end

function StormMiddleCityWorld:updateEventEntity(arg_5_1)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		var_5_0[iter_5_1.cell_id] = true
	end

	local var_5_1 = {}

	for iter_5_2, iter_5_3 in pairs(self._enemyBindDict) do
		if not var_5_0[iter_5_3:getBindID()] then
			table.insert(var_5_1, iter_5_3)
		end
	end

	for iter_5_4, iter_5_5 in ipairs(var_5_1) do
		self:delEntity(iter_5_5)
	end
end

function StormMiddleCityWorld:setPlayerBillBoardScale(arg_6_1)
	self._entityBillBoardScale = arg_6_1

	if self._enemyBindDict and next(self._enemyBindDict) then
		for iter_6_0, iter_6_1 in pairs(self._enemyBindDict) do
			if iter_6_1.setVisualBillboardScale then
				iter_6_1:setVisualBillboardScale(arg_6_1)
			end
		end
	end
end

function StormMiddleCityWorld:removeBoxByBindId(arg_7_1)
	if self._boxBindDict[arg_7_1] then
		local var_7_0 = self._boxBindDict[arg_7_1]:getCoord()

		self:getMapGround():setHoldType(var_7_0.x, var_7_0.y, 0)
		self:delEntity(self._boxBindDict[arg_7_1])
	end
end

function StormMiddleCityWorld:updateTempHolder()
	self:getMapGround():updateHoldMap({
		self._enemyBindDict,
		self._boxBindDict
	})
end

function StormMiddleCityWorld:startWorld(arg_9_1)
	local var_9_0 = self:getMapStage():getStayCoord()

	if var_9_0 == nil then
		var_9_0 = self:getOrgCoord()
	else
		self._refMainRole:jump2Coord(var_9_0)
	end

	self:calcAndMoveCenter()
	self:calcMoveParam()
	self:jump2MainRole()

	if arg_9_1 then
		self:getMapStage():startWorldFinish()
	end
end

function StormMiddleCityWorld:setCurPage(arg_10_1, arg_10_2)
	if not self._pagePos[arg_10_1] then
		return
	end

	local var_10_0 = self._pagePos[1].left.x

	self._page = arg_10_1

	self:setVisible(true)
	self:resetMoveRange(arg_10_1)

	local var_10_1, var_10_2 = self:getMapGround():coordToPixel(var_10_0, self._pagePos[arg_10_1].left.y)

	self:movePA2SC({
		x = var_10_1 + display.width / 2,
		y = var_10_2 + display.height / 2
	})
	self:calcMoveParam()

	if arg_10_2 then
		self:jump2MainRole()
	end
end

function StormMiddleCityWorld:calcAndMoveCenter()
	local var_11_0, var_11_1 = self:getMapGround():coordToPixel((self._pagePos[1].left.x + self._pagePos[4].right.x) / 2, (self._pagePos[1].left.y + self._pagePos[4].right.y) / 2)

	self:movePA2SC({
		x = var_11_0,
		y = var_11_1
	})
end

function StormMiddleCityWorld:resetPlayerPos()
	self._refMainRole:jump2Coord(self:getOrgCoord())
	self:jump2MainRole()
end

function StormMiddleCityWorld:calcMoveParam()
	local var_13_0, var_13_1 = self:getMapGround():coordToPixel(self._pagePos[1].left.x, self._pagePos[1].left.y)
	local var_13_2, var_13_3 = self:getMapGround():coordToPixel(self._pagePos[#self._pagePos].right.x, self._pagePos[#self._pagePos].right.y)

	self._YDX = (var_13_3 - var_13_1) / (var_13_2 - var_13_0)
end

function StormMiddleCityWorld:resetMoveRange(arg_14_1, arg_14_2)
	if arg_14_2 then
		local var_14_0, var_14_1 = self:getMapGround():coordToPixel(self._pagePos[arg_14_2].left.x, self._pagePos[arg_14_2].left.y)
		local var_14_2, var_14_3 = self:getMapGround():coordToPixel(self._pagePos[arg_14_1].right.x, self._pagePos[arg_14_1].right.y)

		self._minMoveX = -var_14_2 + display.width / 2
		self._maxMoveX = -var_14_0 - display.width / 2

		return
	end

	local var_14_4, var_14_5 = self:getMapGround():coordToPixel(self._pagePos[arg_14_1].left.x, self._pagePos[arg_14_1].left.y)
	local var_14_6, var_14_7 = self:getMapGround():coordToPixel(self._pagePos[arg_14_1].right.x, self._pagePos[arg_14_1].right.y)

	self._minMoveX = -var_14_6 + display.width / 2
	self._maxMoveX = -var_14_4 - display.width / 2
end

function StormMiddleCityWorld:jump2MainRole()
	self:moveCell2SC((self._refMainRole:getCoord()))
end

function StormMiddleCityWorld:autoRouteTalk(arg_16_1, arg_16_2)
	self:_setTalkTarget(arg_16_1)

	local var_16_0 = arg_16_1:getCoord()
	local var_16_1 = self._refMainRole:getCoord()
	local var_16_2 = KsAStar.searchTalkPath(var_16_1, var_16_0, self)

	if var_16_2 == nil then
		if arg_16_1.event_type == 6 then
			g.core.module.ModuleManager:pushPopup((require("app.view.module.storm.view.pop.StormMiddleRewardPreviewPop").new(arg_16_1)))
		else
			self._refMainRole:walkStart((KsAStar.searchNearPath(var_16_1, var_16_0, self)))
		end
	else
		self._refMainRole:walkStart(var_16_2, arg_16_2)
	end
end

function StormMiddleCityWorld:clearEntity()
	for iter_17_0, iter_17_1 in pairs(self._boxBindDict) do
		self:delEntity(iter_17_1)
	end

	for iter_17_2, iter_17_3 in pairs(self._enemyBindDict) do
		self:delEntity(iter_17_3)
	end
end

function StormMiddleCityWorld:autoRouteTo(arg_18_1, arg_18_2)
	self:_setTalkTarget(nil)

	local var_18_0 = self._refMainRole:getCoord()

	if KsMath.IsSameCoord(var_18_0, arg_18_1) then
		return false
	end

	local var_18_1 = KsAStar.searchPath(var_18_0, arg_18_1, self)

	if var_18_1 == nil then
		if arg_18_2 then
			g.core.module.ModuleManager:pushPopup(require("app.view.module.storm.view.pop.StormRewardPreviewPop").new(var_0_7.fetch(arg_18_2.ev_id).challenge_reward), {
				touchDisappear = true
			})
		else
			self._refMainRole:walkStart((KsAStar.searchNearPath(var_18_0, arg_18_1, self)))
		end
	else
		self._refMainRole:walkStart(var_18_1, true)
	end
end

function StormMiddleCityWorld:moveToNextStage(arg_19_1, arg_19_2, arg_19_3)
	if not self._pagePos[arg_19_2] then
		return
	end

	local var_19_0, var_19_1 = self:getMapGround():coordToPixel(self._pagePos[arg_19_2].left.x, self._pagePos[arg_19_2].left.y)

	self._totalMove = self:convertScreenCenter().x - (var_19_0 + display.width / 2)

	self:resetMoveRange(arg_19_2)
	self:moveWorld({
		x = self._totalMove
	})

	if not arg_19_3 then
		local var_19_2 = KsAStar.searchPath(self._refMainRole:getCoord(), self._pagePos[arg_19_2].bornpos, self)

		if var_19_2 then
			self._refMainRole:walkStart(var_19_2, true)
		end
	else
		self._isReset = false

		self._refMainRole:jump2Coord(self._pagePos[1].bornpos)
		self._refMainRole:playJumpEffect()
		self:getMapStage():saveStayCoord(self._refMainRole:getCoord())
	end
end

function StormMiddleCityWorld:playChangePageAnim(arg_20_1, arg_20_2, arg_20_3)
	self:moveToNextStage(arg_20_1, arg_20_2, arg_20_3)
end

function StormMiddleCityWorld:_checkPageAnimChange(arg_21_1)
	return
end

function StormMiddleCityWorld:_onPageChangeAnimEnd()
	self:resetMoveRange(self._targetPage)

	self._inChangePageAnim = false

	if not self._isReset then
		local var_22_0 = KsAStar.searchPath(self._refMainRole:getCoord(), self._pagePos[self._targetPage].bornpos, self)

		if var_22_0 then
			self._refMainRole:walkStart(var_22_0, true)
		end
	else
		self._isReset = false

		self._refMainRole:jump2Coord(self._pagePos[1].bornpos)
		self._refMainRole:playJumpEffect()
		self:getMapStage():saveStayCoord(self._refMainRole:getCoord())
	end
end

function StormMiddleCityWorld:onResetPlayerPos()
	self._refMainRole:jump2Coord(self._pagePos[1].bornpos)
	self:getMapStage():saveStayCoord(self._refMainRole:getCoord())
end

function StormMiddleCityWorld:doCanMoveAStar(arg_24_1, arg_24_2)
	local var_24_0 = self:getMapGround()

	if var_24_0:checkCoordInvalid(arg_24_2.x, arg_24_2.y) then
		return false
	end

	return var_24_0:getHoldType(arg_24_2.x, arg_24_2.y) ~= nil
end

function StormMiddleCityWorld:setFollowCenter(arg_25_1)
	self._followCenter = arg_25_1
end

function StormMiddleCityWorld:_setTalkTarget(arg_26_1)
	self._refTalkTarget = arg_26_1
end

function StormMiddleCityWorld:onSingleClick(arg_27_1)
	if not self:getMapStage():isCanTouchMovie() then
		return
	end

	self:getMapStage():pickupStop()

	local var_27_0 = self:convertToNodeSpace(arg_27_1)
	local var_27_1, var_27_2 = self:getMapGround():pixelToCoord(var_27_0.x, var_27_0.y)

	if self:getMapGround():checkCoordInvalid(var_27_1, var_27_2) then
		g.core.module.ModuleManager:tip(g.core.lang:get(304513))

		return
	end

	self._refMainRole:walkStop()

	local var_27_3 = self:_checkEntityHit(var_27_0)

	if var_27_3 then
		self:autoRouteTalk(var_27_3, true)
	else
		self:autoRouteTo(cc.p(var_27_1, var_27_2), var_27_3)
	end
end

function StormMiddleCityWorld:doCreateFactory()
	return StormEntityFactory
end

function StormMiddleCityWorld:doDragWorld(arg_29_1)
	if self._inChangePageAnim then
		return
	end

	if self._followCenter then
		return
	end

	self:moveWorld(arg_29_1)
end

function StormMiddleCityWorld:moveWorld(arg_30_1)
	if self._YDX then
		arg_30_1.y = arg_30_1.x * self._YDX

		local var_30_0, var_30_1 = self:getPosition()
		local var_30_2 = false

		if self._maxMoveX <= self._minMoveX then
			self:setPosition(var_30_0, var_30_1)
		elseif var_30_0 + arg_30_1.x > self._maxMoveX then
			if math.abs(self._maxMoveX - var_30_0) < 0.1 then
				var_30_2 = true
			end

			self:setPosition(self._maxMoveX, var_30_1 + (self._maxMoveX - var_30_0) * self._YDX)
		elseif var_30_0 + arg_30_1.x < self._minMoveX then
			if math.abs(self._minMoveX - var_30_0) < 0.1 then
				var_30_2 = true
			end

			self:setPosition(self._minMoveX, var_30_1 + (self._minMoveX - var_30_0) * self._YDX)
		else
			var_30_2 = true

			self:setPosition(var_30_0 + arg_30_1.x, var_30_1 + arg_30_1.x * self._YDX)
		end

		return var_30_2
	else
		local var_30_3, var_30_4 = self:getPosition()
		local var_30_5, var_30_6 = KsMath.rangeIn(var_30_3 + arg_30_1.x, self._minMoveX, self._maxMoveX)
		local var_30_7, var_30_8 = KsMath.rangeIn(var_30_4 + arg_30_1.y, self:_resetMoveRangeY(var_30_5))

		self:setPosition(var_30_5, var_30_7)

		return var_30_6, var_30_8
	end
end

function StormMiddleCityWorld:_doTickUpdate(arg_31_1)
	if self._refMainRole:tickWalk(arg_31_1) then
		self:getMapStage():saveStayCoord(self._refMainRole:getCoord())

		if self._refTalkTarget then
			self:getMapStage():talkTrigger(self._refTalkTarget)
			self:_setTalkTarget(nil)
		end
	end

	self:_checkFollowing(arg_31_1)
	self:_checkPageAnimChange(arg_31_1)
	self:_checkEntityInView()
end

function StormMiddleCityWorld:_checkFollowing(arg_32_1)
	if self._inChangePageAnim then
		return
	end

	if self._followCenter == nil then
		return
	end

	local var_32_0 = self:convertScreenCenter()
	local var_32_1 = KsMath.calculateDistance(self._followCenter, var_32_0)

	if var_32_1 < 50 then
		self._followCenter = nil

		return
	end

	local var_32_2, var_32_3 = self:movePA2PB(self._followCenter, (KsMath.walkDistance(self._followCenter, var_32_0, MapConst.MOVE_SPEED * (var_32_1 / 200) * arg_32_1)))

	if var_32_2 or var_32_3 then
		self._followCenter = nil
	end
end

function StormMiddleCityWorld:_checkEntityHit(arg_33_1)
	if self._inGetBoxAwarding then
		return nil
	end

	for iter_33_0, iter_33_1 in pairs(self._enemyBindDict or {}) do
		if iter_33_1 ~= self._refMainRole and iter_33_1:checkHit(arg_33_1) then
			return iter_33_1
		end
	end

	for iter_33_2, iter_33_3 in pairs(self._boxBindDict or {}) do
		if iter_33_3 ~= self._refMainRole and iter_33_3:checkHit(arg_33_1) then
			return iter_33_3
		end
	end

	return nil
end

function StormMiddleCityWorld:_doCreateGround()
	return require("app.view.module.storm.view.middleCity.StormMiddleCityGround").new(self)
end

function StormMiddleCityWorld:_doCreateTouch()
	return nil
end

function StormMiddleCityWorld:_doInitTouchMatch()
	self._mapTouch = require("app.view.module.storm.view.middleCity.StormMiddleCityTouch").new(self)
end

function StormMiddleCityWorld:_doAddEntity(arg_37_1)
	if arg_37_1:isMainRole() then
		self._refMainRole = arg_37_1

		self._refMainRole:setInView(true)
	end

	local var_37_0 = arg_37_1:getBindID()

	if var_37_0 > 0 then
		self._bindEntityDict[var_37_0] = arg_37_1
	end

	local var_37_1 = arg_37_1.getEntityName and arg_37_1:getEntityName()

	if not var_37_1 or var_37_1 == "" then
		return
	end

	local var_37_2 = string.split(var_37_1, "_")

	if var_37_2[1] == "left" or var_37_2[1] == "right" or var_37_2[1] == "bornpos" then
		local var_37_3 = tonumber(var_37_2[2]) or 0

		self._pagePos[var_37_3] = self._pagePos[var_37_3] or {}
		self._pagePos[var_37_3][var_37_2[1]] = arg_37_1:getCoord()
	end
end

function StormMiddleCityWorld:_doDelEntity(arg_38_1)
	local var_38_0 = arg_38_1:getBindID()

	if self._boxBindDict[var_38_0] then
		self._boxBindDict[var_38_0] = nil
	elseif self._enemyBindDict[var_38_0] then
		self._enemyBindDict[var_38_0] = nil
	end
end

function StormMiddleCityWorld:showBoxAwardProgress(arg_39_1, arg_39_2)
	local var_39_0 = arg_39_2

	if self._bindEntityDict[arg_39_1] then
		self._inGetBoxAwarding = true

		local var_39_1 = self:getMapGround()

		if var_39_1 then
			local var_39_2 = cc.Node:create()

			self._circleProgressNode = var_39_2

			local var_39_3 = cc.ProgressTimer:create((display.newSprite("ui_cocos/storm/pic_jindutiao.png")))

			var_39_3:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
			var_39_2:addChild((display.newSprite("ui_cocos/storm/pic_jindutiao_2.png")))
			var_39_2:addChild(var_39_3)
			var_39_2:addChild((display.newSprite("ui_cocos/storm/icon_shiquzhong.png")))
			var_39_3:runAction(cc.Sequence:create(cc.ProgressFromTo:create(2, 0, 100), cc.CallFunc:create(handler(self, function()
				if var_39_0 then
					var_39_0()
				end

				self:_onGetAwardFinish()
			end))))

			local var_39_4 = self._bindEntityDict[arg_39_1]:getCoord()

			var_39_1:addChild(var_39_2)

			local var_39_5, var_39_6 = self:getMapGround():coordToPixel(var_39_4.x, var_39_4.y)

			var_39_2:setPosition(var_39_5, var_39_6 + 70)
		end
	end
end

function StormMiddleCityWorld:_onGetAwardFinish()
	self._inGetBoxAwarding = false

	if self._circleProgressNode then
		self._circleProgressNode:removeFromParent()

		self._circleProgressNode = nil
	end
end

function StormMiddleCityWorld:getMainRole()
	return self._refMainRole
end

return StormMiddleCityWorld
