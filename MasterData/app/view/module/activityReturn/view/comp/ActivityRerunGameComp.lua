local PathInPolygon = require("app.core.utils.PathInPolygon")
local ActivityRerunGameComp = class("ActivityRerunGameComp", require("app.fairyGUI.activityReturn.UI_ActivityRerunGameComp"))
local var_0_2 = 600
local var_0_3 = 0.025

function ActivityRerunGameComp:ctor()
	self._obstacles = {}
	self._nearlyObstacles = {}
	self._pathInPolygon = PathInPolygon.new({
		mapId = 0
	})
	self._shootCompList = {}
	self._ballDir = 1
	self._speed = 0
	self._lastTime = 0
	self._isShooting = false
	self._shootingBallPos = nil
	self._originPos = self.m_spineRootNode:getPosition()
	self._timer = nil

	self:_createSpine()
end

function ActivityRerunGameComp:_createSpine()
	self.m_spineRootNode:initSpine({
		remove = false,
		name = "turn",
		isLoop = true,
		anim = "s_run",
		scale = 0.3
	})
end

function ActivityRerunGameComp:_updateBorderInfo(arg_3_1)
	self._areaInfo = {
		left = arg_3_1.area_left,
		right = arg_3_1.area_right
	}
	self._width = self:getWidth()
	self._height = self:getHeight()
	self._kuangList = {
		{
			isShoot = true,
			from = {
				y = 0,
				x = arg_3_1.area_left
			},
			to = {
				y = 0,
				x = self._width - arg_3_1.area_left - arg_3_1.area_right
			}
		},
		{
			from = {
				x = 0,
				y = 0
			},
			to = {
				x = 0,
				y = self._height
			}
		},
		{
			from = {
				y = 0,
				x = self._width
			},
			to = {
				x = self._width,
				y = self._height
			}
		},
		{
			isFinal = true,
			from = {
				x = 0,
				y = self._height - self.m_areaComp:getSize().height
			},
			to = {
				x = self._width,
				y = self._height - self.m_areaComp:getSize().height
			}
		}
	}
	self._speed = (self._width - arg_3_1.area_left - arg_3_1.area_right) / arg_3_1.move_time
	self._originPos.x = arg_3_1.area_left
end

function ActivityRerunGameComp:updateComp(arg_4_1)
	self:_updateBorderInfo(arg_4_1.cfg)

	local var_4_0 = math.floor(math.floor(self:getSize().width / (arg_4_1.dotInfoList[1].dot_radius * 2)) / 3)
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.dotInfoList) do
		local var_4_2 = self:_createObstacles(iter_4_1)

		self._obstacles[#self._obstacles + 1] = var_4_2
		var_4_1[#var_4_1 + 1] = var_4_2
	end

	table.sort(var_4_1, function(arg_5_0, arg_5_1)
		return arg_5_0.y < arg_5_1.y
	end)

	for iter_4_2 = 1, 4 do
		self._nearlyObstacles[iter_4_2] = var_4_1[iter_4_2]
	end

	self.m_areaComp:updateComp(arg_4_1.cfg)
end

function ActivityRerunGameComp:_createObstacles(arg_6_1)
	local var_6_0 = cc.p(arg_6_1.dot_x, arg_6_1.dot_y)
	local var_6_1 = fgui.GLoader:create()

	var_6_1:setAutoSize(true)
	var_6_1:setPivot(0.5, 0.5, true)
	var_6_1:setTouchable(false)
	var_6_1:setPosition(var_6_0)
	var_6_1:setURL(g.core.common.Path:getRerunObstacleRes(arg_6_1.dot_pic))
	self:addChild(var_6_1)

	return {
		x = var_6_0.x,
		y = var_6_0.y,
		radius = arg_6_1.dot_radius,
		comp = var_6_1
	}
end

function ActivityRerunGameComp:setSSREffectNode(arg_7_1)
	self._effectSSRNode = arg_7_1
end

function ActivityRerunGameComp:onLoad()
	self:_startTimer()
end

function ActivityRerunGameComp:onUnload()
	self:_stopTimer()
end

function ActivityRerunGameComp:_startTimer()
	if not self._timer then
		self._lastTime = os.clock()
		self._timer = self:newSchedule(handler(self, self._onSpineMovie), var_0_3)
	end
end

function ActivityRerunGameComp:_stopTimer()
	if self._timer then
		self:cancelSchedule(self._timer)
	end

	self._timer = nil
end

function ActivityRerunGameComp:_onSpineMovie(arg_12_1, arg_12_2)
	self:_onBallWaitMovie(var_0_3)

	if self._isShooting then
		self:_onBallShooting(var_0_3)
	end

	self._lastTime = os.clock()
end

function ActivityRerunGameComp:_onBallTurn()
	self._ballDir = self._ballDir * -1

	self.m_spineRootNode:setScaleX(self._ballDir)
end

function ActivityRerunGameComp:_onBallWaitMovie(arg_14_1)
	local var_14_0 = self.m_spineRootNode:getPosition()
	local var_14_1 = var_14_0.x

	var_14_0.x = var_14_0.x + self._speed * arg_14_1 * self._ballDir

	local var_14_2
	local var_14_3

	for iter_14_0, iter_14_1 in ipairs(self._shootCompList) do
		if not iter_14_1.isShoot then
			var_14_2 = iter_14_1
			var_14_3 = iter_14_1.pathList[#iter_14_1.pathList]

			break
		end
	end

	local var_14_4 = self:getSize().width - self._areaInfo.left - self._areaInfo.right
	local var_14_5

	if var_14_0.x <= self._areaInfo.left or var_14_0.x >= self._areaInfo.left + var_14_4 then
		self:_onBallTurn()

		var_14_0.x = math.max(self._areaInfo.left, var_14_0.x)
		var_14_0.x = math.min(self._areaInfo.left + var_14_4, var_14_0.x)

		self.m_spineRootNode:setPosition(var_14_0)

		var_14_5 = {}
	end

	var_14_5.frame = tonumber((string.format("%0.2f", (var_14_0.x - self._areaInfo.left) / var_14_4 * 4)))

	self:dispatchCompEvent("updatePointEffectFrame", var_14_5)
	self.m_spineRootNode:setPosition(var_14_0)

	if var_14_3 then
		if (var_14_3.x - var_14_1) * (self._speed * self._ballDir) >= 0 and (var_14_3.x - var_14_0.x) / self._speed * self._ballDir <= 0 then
			local var_14_6 = var_14_2.comp

			var_14_2.comp:setAnim(0, "in", false, function()
				var_14_6:setAnim(0, "roll", true)
			end)
			table.remove(var_14_2.pathList, #var_14_2.pathList)
			self:_shootingBall(var_14_2)

			self._isShooting = true
		end
	end
end

function ActivityRerunGameComp:_getAddPos(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = cc.pSub(arg_16_4, arg_16_1)
	local var_16_1 = cc.pMul(arg_16_2, arg_16_3)
	local var_16_2 = cc.p(math.abs(var_16_1.x), math.abs(var_16_1.y))
	local var_16_3 = 0.001

	if arg_16_2.x ~= 0 and var_16_3 > var_16_2.x then
		var_16_2.x = var_16_3
	end

	var_16_1.x = var_16_1.x > 0 and math.min(var_16_0.x, var_16_2.x) or math.max(var_16_0.x, -var_16_2.x)

	if arg_16_2.y ~= 0 and var_16_3 > var_16_2.y then
		var_16_2.y = var_16_3
	end

	var_16_1.y = var_16_1.y > 0 and math.min(var_16_0.y, var_16_2.y) or math.max(var_16_0.y, -var_16_2.y)

	return var_16_1
end

function ActivityRerunGameComp:_onBallShooting(arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(self._shootCompList) do
		if iter_17_1.isShoot then
			local var_17_0 = iter_17_1.comp
			local var_17_1 = iter_17_1.pathList
			local var_17_2 = iter_17_1.comp:getPosition()
			local var_17_3 = iter_17_1.pathList[#iter_17_1.pathList]
			local var_17_4 = cc.p(var_17_2.x, var_17_2.y)
			local var_17_5 = iter_17_1.speed
			local var_17_6 = self:_getAddPos(var_17_2, iter_17_1.speed, arg_17_1, iter_17_1.pathList[#iter_17_1.pathList])

			iter_17_1.addPos = var_17_6

			local var_17_7 = cc.pAdd(var_17_2, var_17_6)
			local var_17_8 = cc.pSub(var_17_3, var_17_7)

			var_17_0:setPosition(var_17_7)

			if (var_17_5.x == 0 or var_17_8.x / var_17_5.x <= 0.001) and (var_17_5.y == 0 or var_17_8.y / var_17_5.y <= 0.001) then
				var_17_0:setPosition(var_17_3)
				table.remove(var_17_1, #var_17_1)

				if #var_17_1 == 0 then
					self:_onBallShootingEnd(iter_17_1, var_17_3)
				else
					iter_17_1.speed = nil

					g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_BOUNCE_BALL)
					self:_shootingBall(iter_17_1)
				end
			end
		end
	end

	while 1 <= #self._shootCompList do
		local var_17_10

		if self._shootCompList[1].isEnd then
			table.remove(self._shootCompList, 1)
		else
			var_17_10 = 1 + 1
		end
	end
end

function ActivityRerunGameComp:_onBallShootingEnd(arg_18_1, arg_18_2)
	arg_18_1.isEnd = true

	arg_18_1.comp:removeFromParent()

	local var_18_0

	for iter_18_0, iter_18_1 in ipairs(self._shootCompList) do
		if arg_18_1 == iter_18_1 then
			var_18_0 = arg_18_1.quality

			table.remove(self._shootCompList, iter_18_0)

			break
		end
	end

	self:_onShowContactEffectEnd(arg_18_2, var_18_0)
end

function ActivityRerunGameComp:_shootingBall(arg_19_1)
	arg_19_1.isShoot = true

	if not arg_19_1.speed then
		local var_19_0 = arg_19_1.comp:getPosition()

		arg_19_1.speed = cc.pMul(cc.pSub(arg_19_1.pathList[#arg_19_1.pathList], var_19_0), 1 / (cc.pGetDistance(arg_19_1.pathList[#arg_19_1.pathList], var_19_0) / var_0_2))

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_BOUNCE_BALL)
	end

	arg_19_1.comp:setVisible(true)
end

function ActivityRerunGameComp:playBallGame(arg_20_1)
	self._shootIdx = 1
	self._awards = arg_20_1
	self._effectFinishNum = 0

	self:_playOneBall()
end

function ActivityRerunGameComp:_playOneBall()
	self._shootIdx = self._shootIdx + 1

	self:_onAddBall(self._awards[self._shootIdx].quality)

	if self._shootIdx <= #self._awards then
		self:newScheduleOnce(handler(self, self._playOneBall), 0.5)
	end
end

function ActivityRerunGameComp:_getRoundPosByAngle(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = cc.p(0, 0)
	local var_22_1 = math.rad(arg_22_2)

	var_22_0.x = arg_22_1.x + arg_22_3 * math.cos(var_22_1)
	var_22_0.y = arg_22_1.y + arg_22_3 * math.sin(var_22_1)

	return var_22_0
end

function ActivityRerunGameComp:_createBallComp(arg_23_1)
	local var_23_0 = fgui.UIPackage:createObject("activityReturn", "ActivityRerunBallComp")

	var_23_0:initSpine({
		remove = false,
		name = "turn",
		isLoop = true,
		anim = "s_run",
		scale = 0.3
	})
	var_23_0:setVisible(false)
	var_23_0:setPosition(arg_23_1.pathList[#arg_23_1.pathList])
	self:addChild(var_23_0)

	arg_23_1.comp = var_23_0
	self._shootCompList[#self._shootCompList + 1] = arg_23_1
	self._debugCompList = self._debugCompList or {}
	self._debugCompList[#self._debugCompList + 1] = clone(arg_23_1)
end

function ActivityRerunGameComp:_onShowContactEffectEnd(arg_24_1, arg_24_2)
	self._effectFinishNum = self._effectFinishNum + 1

	self.m_areaComp:onContactBall(arg_24_1, arg_24_2, (self._effectFinishNum == #self._awards or nil) and handler(self, self._onShowAwards))

	if arg_24_2 == 3 then
		self._effectSSRNode:addEffectSpine({
			anim = "ssr",
			name = "eff_ui_activityReturn_ssrBg",
			remove = true,
			isLoop = false
		})
	end
end

function ActivityRerunGameComp:_onShowAwards()
	self:dispatchCompEvent("showDrawAward", {
		awards = self._awards
	})
end

function ActivityRerunGameComp:_getRandomInterNumber(arg_26_1, arg_26_2)
	local var_26_0 = math.random(arg_26_1, arg_26_2)
	local var_26_1 = 1

	if var_26_0 < 0 then
		var_26_1 = -1
	end

	local var_26_2 = math.abs(var_26_0)

	var_26_2 = var_26_2 % 1 >= 0.5 and math.ceil(var_26_2) or math.floor(var_26_2)

	return var_26_2 * var_26_1
end

function ActivityRerunGameComp:onDebugShowList()
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in pairs(self._shootCompList) do
		for iter_27_2, iter_27_3 in pairs(self._debugCompList) do
			if iter_27_3.comp == iter_27_1.comp then
				var_27_0[#var_27_0 + 1] = iter_27_3

				break
			end
		end
	end
end

function ActivityRerunGameComp:_onAddBall(arg_28_1)
	local var_28_0 = {
		isShoot = false,
		isEnd = false,
		quality = arg_28_1
	}
	local var_28_1 = self.m_spineRootNode:getPosition()
	local var_28_2 = {}

	for iter_28_0 = 1, #self._nearlyObstacles do
		local var_28_4 = cc.p(self._nearlyObstacles[iter_28_0].x, self._nearlyObstacles[iter_28_0].y)
		local var_28_5 = cc.pSub(var_28_4, var_28_1)
		local var_28_6 = math.deg((math.asin(var_28_5.x / cc.pGetLength(var_28_5))))
		local var_28_7 = {
			var_28_6,
			var_28_6 + 10
		}
		local var_28_8 = self:_getRandomInterNumber(var_28_7[1], var_28_7[2])

		while not var_28_2[iter_28_0] and 360 >= 0 do
			local var_28_9 = {}
			local var_28_10 = self:_getRoundPosByAngle(var_28_4, var_28_8, self._nearlyObstacles[iter_28_0].radius)

			if self:_checkCanMatch(var_28_1, var_28_10) then
				var_28_9[1] = var_28_1

				self:_onBallCross(var_28_1, var_28_10, var_28_9, arg_28_1)

				if type(var_28_9[#var_28_9]) ~= "string" then
					var_28_2[iter_28_0] = var_28_9
				end
			end

			var_28_8 = var_28_8 + 1
		end
	end

	if not next(var_28_2) then
		for iter_28_1 = 2, 3 do
			local var_28_12
			local var_28_13 = self._kuangList[iter_28_1].from.y

			while not var_28_12 and var_28_13 <= self._kuangList[iter_28_1].to.y do
				var_28_13 = var_28_13 + 30

				local var_28_14 = cc.p(self._kuangList[iter_28_1].from.x, var_28_13)

				if not self:_checkCanMatch(var_28_1, var_28_14) then
					var_28_12 = {
						var_28_1
					}

					self:_onBallCross(var_28_1, var_28_14, var_28_12, arg_28_1)

					if type(var_28_12[#var_28_12]) ~= "string" then
						var_28_2[iter_28_1] = var_28_12
					else
						var_28_12 = nil
					end
				end
			end
		end
	end

	local var_28_15 = 0
	local var_28_16 = {}

	for iter_28_2, iter_28_3 in pairs(var_28_2) do
		var_28_16[#var_28_16 + 1] = iter_28_3
		var_28_15 = var_28_15 + 1
	end

	if var_28_15 > 0 then
		var_28_0.pathList = var_28_16[self:_getRandomInterNumber(1, var_28_15)]
	end

	if var_28_0.pathList then
		var_28_0.pathList[#var_28_0.pathList].y = self.m_spineRootNode:getPosition().y
		var_28_0.pathList[#var_28_0.pathList].x = math.max(self._areaInfo.left, var_28_0.pathList[#var_28_0.pathList].x)
		var_28_0.pathList[#var_28_0.pathList].x = math.min(self._width - self._areaInfo.right, var_28_0.pathList[#var_28_0.pathList].x)

		self:_createBallComp(var_28_0)
	end
end

function ActivityRerunGameComp:_checkCanMatch(arg_29_1, arg_29_2)
	local var_29_0 = {}

	for iter_29_0 = 1, #self._obstacles do
		local var_29_1, var_29_2 = self._pathInPolygon:getPointToRayCross(arg_29_1, arg_29_2, self._obstacles[iter_29_0])

		if var_29_1 then
			table.insert(var_29_0, var_29_2)
		end
	end

	if #var_29_0 == 0 then
		return false
	end

	table.sort(var_29_0, function(arg_30_0, arg_30_1)
		return arg_30_0.crossLen < arg_30_1.crossLen
	end)

	return math.abs(var_29_0[1].crossPoint.x - arg_29_2.x) < 0.01 and math.abs(var_29_0[1].crossPoint.y - arg_29_2.y) < 0.01
end

function ActivityRerunGameComp:_onStoneCreate(arg_31_1)
	self.m_stoneHold:displayObject():removeAllChildren()

	if self._stoneList then
		for iter_31_0, iter_31_1 in ipairs(self._stoneList) do
			iter_31_1:removeFromParent()
		end
	end

	local var_31_0 = self:getSize()

	self._stoneList = {}

	for iter_31_2, iter_31_3 in ipairs(arg_31_1) do
		local var_31_1 = cc.Sprite:create("ui_cocos/hyres/stone.png")

		var_31_1:setScale(0.3)
		var_31_1:setPosition((cc.p(iter_31_3.x, var_31_0.height - iter_31_3.y)))
		self:addNode(var_31_1)
		table.insert(self._stoneList, var_31_1)
	end
end

function ActivityRerunGameComp:_onBallCross(arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	if not arg_32_1 or not arg_32_2 then
		return false
	end

	if #arg_32_3 > 100 then
		arg_32_3[#arg_32_3 + 1] = "error2"

		return
	end

	local var_32_0 = {}

	for iter_32_0 = 1, #self._obstacles do
		local var_32_1, var_32_2 = self._pathInPolygon:getPointToRayCross(arg_32_1, arg_32_2, self._obstacles[iter_32_0])

		if var_32_1 then
			table.insert(var_32_0, var_32_2)
		end
	end

	for iter_32_1 = 1, #self._kuangList do
		local var_32_3, var_32_4 = self._pathInPolygon:getLineToRayCross(arg_32_1, arg_32_2, self._kuangList[iter_32_1])

		if var_32_3 then
			table.insert(var_32_0, var_32_4)
		end
	end

	if #var_32_0 == 0 then
		arg_32_3[#arg_32_3 + 1] = "error0"

		return false
	end

	table.sort(var_32_0, function(arg_33_0, arg_33_1)
		return arg_33_0.crossLen < arg_33_1.crossLen
	end)
	table.insert(arg_32_3, 1, var_32_0[1].crossPoint)

	if self.m_areaComp:getPosition().y + self.m_areaComp:getSize().height - var_32_0[1].crossPoint.y < 0.01 then
		if self.m_areaComp:isEnterQualityArea(var_32_0[1].crossPoint, arg_32_4) then
			return false
		else
			arg_32_3[#arg_32_3 + 1] = "error01"
		end

		return
	end

	if var_32_0[1].circlePoint then
		local var_32_5, var_32_6 = self._pathInPolygon:getReflectToByCircle(arg_32_1, var_32_0[1].crossPoint, var_32_0[1].circlePoint)

		return self:_onBallCross(var_32_5, var_32_6, arg_32_3, arg_32_4)
	elseif var_32_0[1].line then
		if var_32_0[1].line.isFinal then
			if self.m_areaComp:isEnterQualityArea(var_32_0[1].crossPoint, arg_32_4) then
				return false
			else
				arg_32_3[#arg_32_3 + 1] = "error0"

				return false
			end
		else
			local var_32_7, var_32_8 = self._pathInPolygon:getReflectToByLine(arg_32_1, var_32_0[1].crossPoint, var_32_0[1].line)

			return self:_onBallCross(var_32_7, var_32_8, arg_32_3, arg_32_4)
		end
	end
end

return ActivityRerunGameComp
