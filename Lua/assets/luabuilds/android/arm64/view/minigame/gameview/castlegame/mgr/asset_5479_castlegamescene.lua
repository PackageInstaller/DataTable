local CastleGameScene = class("CastleGameScene")
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4

function CastleGameScene:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._event = arg_1_2
	self.sceneMask = findTF(self._tf, "sceneMask")
	self.tplContent = findTF(self._tf, "sceneMask/sceneContainer/scene/tpl")
	self.floorTpl = findTF(self._tf, "sceneMask/sceneContainer/scene/tpl/floorTpl")
	self.charTpl = findTF(self._tf, "sceneMask/sceneContainer/scene/tpl/charTpl")
	self.carriageTpl = findTF(self._tf, "sceneMask/sceneContainer/scene/tpl/carriageTpl")
	self.bubbleTpl = findTF(self._tf, "sceneMask/sceneContainer/scene/tpl/bubbleTpl")
	self.scoreTpl = findTF(self._tf, "sceneMask/sceneContainer/scene/tpl/scoreTpl")
	self.contentBack = findTF(self._tf, "sceneMask/sceneContainer/scene_background/content")
	self.contentMid = findTF(self._tf, "sceneMask/sceneContainer/scene/content")
	self.contentTop = findTF(self._tf, "sceneMask/sceneContainer/scene_front/content")
	self.contentEF = findTF(self._tf, "sceneMask/sceneContainer/scene/effect_front")

	local var_1_0 = CastleGameVo.GetRotationPosByWH(0, -1)

	self.gameFloor = CastleGameFloor.New(self.floorTpl, self._event)
	self.gameChar = CastleGameChar.New(self.charTpl, self._event)
	self.gameItem = CastleGameItem.New(self.tplContent, self._event)
	self.gameRemind = CastleGameRemind.New(self.tplContent, self._event)
	self.gameScore = CastleGameScore.New(self.scoreTpl, self._event)

	self.gameFloor:setContent(self:getContent(var_0_2))
	self.gameChar:setContent(self:getContent(var_0_3))
	self.gameItem:setContent(self:getContent(var_0_3))
	self.gameRemind:setContent(self:getContent(var_0_4))
	self.gameScore:setContent(self:getContent(var_0_3))
	self.gameFloor:setFloorFallCallback(function(arg_2_0)
		self:addRemindItems(arg_2_0)

		return
	end)
	self.gameChar:setOutLandPoint((self.gameFloor:getOutLandPoint()))

	self.floorItems = {}

	self:insertFloorItem(self.gameFloor:getFloors())

	self.items = {}

	table.insert(self.items, self.gameChar:getChar())
	self.gameItem:setItemRemindCallback(function(arg_3_0)
		self:addRemindItems(arg_3_0)

		return
	end)
	self.gameItem:setItemChange(function(arg_4_0, arg_4_1)
		self:itemChange(arg_4_0, arg_4_1)

		return
	end)
	self.gameItem:setFloorBroken(function(arg_5_0, arg_5_1)
		for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
			self.gameFloor:setBroken(iter_5_1, arg_5_1)
		end

		return
	end)
	self.gameScore:setItemChange(function(arg_6_0, arg_6_1)
		self:itemChange(arg_6_0, arg_6_1)

		return
	end)
	self.gameItem:setBubbleBroken(function(arg_7_0)
		if arg_7_0 and arg_7_0.char then
			self:returnPlayerBubble(arg_7_0, arg_7_0.char)
		end

		return
	end)
	self:sortItems(self.floorItems)

	return
end

function CastleGameScene:addRemindItems(arg_8_1)
	for iter_8_0 = 1, #arg_8_1 do
		self.gameRemind:addRemind(arg_8_1[iter_8_0].w, arg_8_1[iter_8_0].h, (arg_8_1[iter_8_0].type or nil) and (arg_8_1[iter_8_0].type or CastleGameRemind.remind_type_1))
	end

	return
end

function CastleGameScene:itemChange(arg_9_1, arg_9_2)
	if arg_9_2 then
		if table.contains(self.items, arg_9_1) then
			return
		end

		table.insert(self.items, arg_9_1)
	else
		for iter_9_0 = 1, #self.items do
			if self.items[iter_9_0] == arg_9_1 then
				table.remove(self.items, iter_9_0)

				return
			end
		end
	end

	return
end

function CastleGameScene:start()
	self:prepareScene()
	self.gameFloor:start()
	self.gameChar:start()
	self.gameItem:start()
	self.gameRemind:start()
	self.gameScore:start()

	return
end

function CastleGameScene:step()
	self.gameFloor:step()
	self.gameChar:step()
	self.gameItem:step()
	self.gameRemind:step()
	self.gameScore:step()
	self:sortItems(self.items)
	self:updateActiveFloor()
	self:checkPlayerInFloor()
	self:checkPlayerInBubble()
	self:checkPlayerCarriage()
	self:checkPlayerInScore()

	return
end

function CastleGameScene:clear()
	self.gameFloor:clear()
	self.gameChar:clear()
	self.gameItem:clear()
	self.gameRemind:clear()

	return
end

function CastleGameScene:stop()
	return
end

function CastleGameScene:resume()
	return
end

function CastleGameScene:dispose()
	return
end

function CastleGameScene:prepareScene()
	self:showContainer(true)
	self:sortItems(self.floorItems)
	self.gameChar:setContent(self:getContent(var_0_3))
	CastleGameVo.PointFootLine(Vector2(0, 0), Vector2(0, 100), Vector2(100, 0))

	return
end

function CastleGameScene:updateActiveFloor()
	self.gameItem:setFloorIndexs((self.gameFloor:getActiveIndexs()))
	self.gameScore:setFloor((self.gameFloor:getFloors()))

	return
end

function CastleGameScene:checkPlayerInScore()
	if self.gameChar:getActionAble() then
		local var_18_0 = self.gameChar:getChar()
		local var_18_1 = self.gameScore:getScores()

		for iter_18_0 = 1, #var_18_1 do
			if var_18_1[iter_18_0].ready == 0 then
				local var_18_2 = Vector2(var_18_1[iter_18_0].tf.anchoredPosition.x + var_18_1[iter_18_0].bmin.x, var_18_1[iter_18_0].tf.anchoredPosition.y + var_18_1[iter_18_0].bmin.y)
				local var_18_3 = Vector2(var_18_1[iter_18_0].tf.anchoredPosition.x + var_18_1[iter_18_0].bmax.x, var_18_1[iter_18_0].tf.anchoredPosition.y + var_18_1[iter_18_0].bmax.y)

				if var_18_0.tf.anchoredPosition.x >= var_18_2.x and var_18_0.tf.anchoredPosition.y >= var_18_2.y and var_18_0.tf.anchoredPosition.x <= var_18_3.x and var_18_0.tf.anchoredPosition.y <= var_18_3.y then
					self:setPlayerScore(var_18_1[iter_18_0], var_18_0)

					return
				end
			end
		end
	end

	return
end

function CastleGameScene:checkPlayerInBubble()
	if self.gameChar:getActionAble() then
		local var_19_0 = self.gameChar:getChar()
		local var_19_1 = self.gameItem:getBubbles()

		for iter_19_0 = 1, #var_19_1 do
			if var_19_1[iter_19_0].ready == 0 and not var_19_1[iter_19_0].broken and isActive(var_19_1[iter_19_0].tf) and var_19_1[iter_19_0].hit then
				local var_19_2 = Vector2(var_19_1[iter_19_0].tf.anchoredPosition.x + var_19_1[iter_19_0].bmin.x, var_19_1[iter_19_0].tf.anchoredPosition.y + var_19_1[iter_19_0].bmin.y)
				local var_19_3 = Vector2(var_19_1[iter_19_0].tf.anchoredPosition.x + var_19_1[iter_19_0].bmax.x, var_19_1[iter_19_0].tf.anchoredPosition.y + var_19_1[iter_19_0].bmax.y)

				if var_19_0.tf.anchoredPosition.x >= var_19_2.x and var_19_0.tf.anchoredPosition.y >= var_19_2.y and var_19_0.tf.anchoredPosition.x <= var_19_3.x and var_19_0.tf.anchoredPosition.y <= var_19_3.y then
					self:setPlayerBubble(var_19_1[iter_19_0], var_19_0)

					return
				end
			end
		end
	end

	return
end

function CastleGameScene:checkPlayerBoom()
	if self.gameChar:getActionAble() then
		local var_20_0 = self.gameChar:getChar().tf.anchoredPosition
		local var_20_1 = self.gameItem:getBooms()
		local var_20_2 = false

		for iter_20_0 = 1, #var_20_1 do
			if var_20_1[iter_20_0].ready and var_20_1[iter_20_0].ready == 0 and not var_20_1[iter_20_0].broken and var_20_1[iter_20_0].brokenTime < 1 then
				if not var_20_2 then
					local var_20_3 = CastleGameVo.PointInTriangle(var_20_0, var_20_1[iter_20_0].boundPoints[3], var_20_1[iter_20_0].boundPoints[4], var_20_1[iter_20_0].boundPoints[1])

					if CastleGameVo.PointInTriangle(var_20_0, var_20_1[iter_20_0].boundPoints[1], var_20_1[iter_20_0].boundPoints[2], var_20_1[iter_20_0].boundPoints[3]) then
						var_20_2 = true
					elseif var_20_3 then
						var_20_2 = true
					end
				end

				if var_20_2 then
					self.gameChar:setPlayerFail()

					return
				end
			end
		end
	end

	return
end

function CastleGameScene:checkPlayerCarriage()
	if self.gameChar:getActionAble() then
		local var_21_0 = self.gameChar:getChar().tf.anchoredPosition
		local var_21_1 = self.gameItem:getCarriages()

		for iter_21_0 = 1, #var_21_1 do
			local var_21_2 = Vector2(var_21_1[iter_21_0].tf.anchoredPosition.x + var_21_1[iter_21_0].bmin.x, var_21_1[iter_21_0].tf.anchoredPosition.y + var_21_1[iter_21_0].bmin.y)
			local var_21_3 = Vector2(var_21_1[iter_21_0].tf.anchoredPosition.x + var_21_1[iter_21_0].bmax.x, var_21_1[iter_21_0].tf.anchoredPosition.y + var_21_1[iter_21_0].bmax.y)

			if var_21_0.x >= var_21_2.x and var_21_0.y >= var_21_2.y and var_21_0.x <= var_21_3.x and var_21_0.y <= var_21_3.y then
				self.gameChar:setPlayerFail()

				return
			end
		end
	end

	return
end

function CastleGameScene:setPlayerScore(arg_22_1, arg_22_2)
	self.gameChar:setScore(arg_22_1)
	self.gameScore:hitScore(arg_22_1)
	self._event:emit(CastleGameView.ADD_SCORE, {
		num = arg_22_1.data.score,
		pos = self.gameChar:getChar().tf.position,
		id = arg_22_1.id
	})

	return
end

function CastleGameScene:returnPlayerBubble(arg_23_1, arg_23_2)
	self.gameChar:setContent(self.contentTop)
	self.gameChar:setInBubble(false)

	arg_23_1.char = nil

	return
end

function CastleGameScene:setPlayerBubble(arg_24_1, arg_24_2)
	self.gameChar:setInBubble(true)
	self.gameChar:setContent(arg_24_1.pos, Vector3(0, 0, 0))

	arg_24_1.char = arg_24_2

	self.gameItem:playerInBubble(arg_24_1, arg_24_2)

	return
end

function CastleGameScene:checkPlayerInFloor()
	if self.gameChar:getActionAble() then
		local var_25_0 = self.gameChar:getChar()
		local var_25_1 = self.gameFloor:getFloors()
		local var_25_2 = false

		for iter_25_0 = 1, #var_25_1 do
			if not var_25_2 then
				local var_25_3 = CastleGameVo.PointInTriangle(var_25_0.tf.anchoredPosition, var_25_1[iter_25_0].bound[3], var_25_1[iter_25_0].bound[4], var_25_1[iter_25_0].bound[1])

				if CastleGameVo.PointInTriangle(var_25_0.tf.anchoredPosition, var_25_1[iter_25_0].bound[1], var_25_1[iter_25_0].bound[2], var_25_1[iter_25_0].bound[3]) then
					var_25_2 = true
				elseif var_25_3 then
					var_25_2 = true
				end
			end

			if var_25_2 then
				var_25_0.floor = var_25_1[iter_25_0]

				if var_25_1[iter_25_0].fall == true then
					self:setCharFall()
				end

				return
			end
		end
	end

	return
end

function CastleGameScene:setCharFall()
	self.gameChar:setInGround(false)

	return
end

function CastleGameScene:insertFloorItem(arg_27_1)
	for iter_27_0 = 1, #arg_27_1 do
		table.insert(self.floorItems, arg_27_1[iter_27_0])
	end

	return
end

function CastleGameScene:getContent(arg_28_1)
	local var_28_0

	if arg_28_1 == var_0_1 then
		var_28_0 = self.contentBack
	elseif arg_28_1 == var_0_2 then
		var_28_0 = self.contentMid
	elseif arg_28_1 == var_0_3 then
		var_28_0 = self.contentTop
	elseif arg_28_1 == var_0_4 then
		var_28_0 = self.contentEF
	end

	return var_28_0
end

function CastleGameScene:sortItems(arg_29_1)
	table.sort(arg_29_1, function(arg_30_0, arg_30_1)
		if arg_30_0.tf.anchoredPosition.y > arg_30_1.tf.anchoredPosition.y then
			return false
		elseif arg_30_0.tf.anchoredPosition.y < arg_30_1.tf.anchoredPosition.y then
			return true
		end

		if arg_30_0.tf.anchoredPosition.x > arg_30_1.tf.anchoredPosition.x then
			return false
		elseif arg_30_0.tf.anchoredPosition.x < arg_30_1.tf.anchoredPosition.x then
			return true
		end

		return false
	end)

	for iter_29_0 = 1, #arg_29_1 do
		arg_29_1[iter_29_0].tf:SetSiblingIndex(0)
	end

	return
end

function CastleGameScene:compareByPosition(arg_31_1, arg_31_2)
	return
end

function CastleGameScene:compareWithPosBound(arg_32_1, arg_32_2)
	return CastleGameVo.PointLeftLine(arg_32_1, arg_32_2[1], arg_32_2[4])
end

function CastleGameScene:showContainer(arg_33_1)
	setActive(self.sceneMask, arg_33_1)

	return
end

function CastleGameScene:press(arg_34_1)
	self.gameFloor:press(arg_34_1)
	self:sortItems(self.floorItems)

	return
end

return CastleGameScene
