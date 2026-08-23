local var_0_0 = {
	playBlinkAction = function(self, arg_1_1, arg_1_2)
		arg_1_1 = arg_1_1 or 0.5
		arg_1_2 = arg_1_2 or 1.2

		self:stopAllFGActions()
		self:runFGAction((fgui.FRepeatForever:create((fgui.FSequence:create(fgui.FFadeTo:create(0, 100), fgui.FFadeTo:create(arg_1_1, 255), fgui.FDelayTime:create(arg_1_2), (fgui.FFadeTo:create(arg_1_1, 100)))))))
	end,
	playFloatAction = function(self, arg_2_1, arg_2_2, arg_2_3)
		arg_2_1 = arg_2_1 or 3.5
		arg_2_2 = arg_2_2 or 1.5
		arg_2_3 = arg_2_3 or self:getPosition()

		local var_2_0 = fgui.FRepeatForever:create((fgui.FSequence:create(fgui.FMoveTo:create(arg_2_2 / 2, {
			x = arg_2_3.x,
			y = arg_2_3.y - arg_2_1
		}), fgui.FMoveTo:create(arg_2_2 / 2, {
			x = arg_2_3.x,
			y = arg_2_3.y + arg_2_1
		}))))

		self:stopAllFGActions()
		self:runFGAction(var_2_0)
	end,
	playResChangeAction = function(self)
		local var_3_1 = self.title
		local var_3_2 = self.isGreen
		local var_3_3 = g.core.model.User.bagData:getDifCountById(self.type, self.value)

		if self.difNum then
			var_3_3 = tonumber(self.difNum)
		end

		if var_3_3 == 0 then
			return
		end

		if self.func then
			self.func()
		end

		var_3_1:stopAllFGActions()

		if var_3_3 > 0 then
			var_3_1:setColor(g.core.common.Color.top.GREEN)
		else
			var_3_1:setColor(g.core.common.Color.top.RED)
		end

		var_3_1:runFGAction(fgui.FSequence:create({
			fgui.FScaleTo:create(0.17, 1.3),
			fgui.FScaleTo:create(0.17, 1),
			fgui.FCallFunc:create(function()
				if var_3_2 then
					var_3_1:setColor(g.core.common.Color.top.GREEN)
				else
					var_3_1:setColor(g.core.common.Color.dark.DESC)
				end
			end)
		}))
	end,
	playNumAddAction = function(self)
		local var_5_0 = self.func

		if self.addNum <= 0 then
			return
		end

		local var_5_1 = cc.p(0, -self.target:getSize().height)
		local var_5_2 = fgui.GBasicTextField:create()

		if self.addNum > 0 then
			var_5_2:setColor(g.core.common.Color.top.GREEN)
			var_5_2:setText(self.name .. "+" .. self.addNum)
		end

		var_5_2:setPivot(0.5, 0)
		var_5_2:setFontSize(22)
		var_5_2:setVisible(false)
		var_5_2:setPosition(var_5_1.x, var_5_1.y)
		self.target:addChild(var_5_2)
		var_5_2:runFGAction((fgui.FSequence:create({
			fgui.FSpawn:create({
				fgui.FShow:create(),
				fgui.FMoveBy:create(0.5, {
					x = 0,
					y = -20
				}),
				fgui.FFadeOut:create(0.5),
				fgui.FCallFunc:create(function()
					if var_5_0 then
						var_5_0()
					end
				end)
			}),
			fgui.FRemoveSelf:create()
		})))
	end,
	playScaleAction = function(self, arg_7_1)
		arg_7_1 = arg_7_1 or 1

		self:runFGAction(fgui.FSequence:create({
			fgui.FScaleTo:create(0.2, 1.2 * arg_7_1),
			fgui.FScaleTo:create(0.2, arg_7_1)
		}))
	end
}

local function var_0_1(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	if not arg_8_0 then
		return
	end

	if arg_8_3 <= 0 and arg_8_5 then
		arg_8_5()
	end

	arg_8_4 = arg_8_4 or 30

	if arg_8_1 < 0 then
		arg_8_4 = -arg_8_4
	end

	local var_8_0 = CCEaseIn:create(CCMoveBy:create(arg_8_3, ccp(arg_8_2 and 0 or arg_8_1 + arg_8_4, (arg_8_2 or nil) and (arg_8_1 + arg_8_4 or 0))), arg_8_3)
	local var_8_1 = CCEaseIn:create(CCMoveBy:create(0.1, ccp(arg_8_2 and 0 or -arg_8_4, (arg_8_2 or nil) and (-arg_8_4 or 0))), 0.1)
	local var_8_2 = CCArray:create()

	var_8_2:addObject(var_8_0)
	var_8_2:addObject(var_8_1)

	if arg_8_5 then
		var_8_2:addObject(CCCallFunc:create(function()
			arg_8_5()
		end))
	end

	arg_8_0:runAction(CCSequence:create(var_8_2))
end

local function var_0_2(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)
	if not arg_10_0 then
		return
	end

	if arg_10_1 <= 0 and arg_10_6 then
		arg_10_6()
	end

	if arg_10_2 < 0 then
		arg_10_4 = -arg_10_4
	end

	local var_10_0

	if arg_10_3 < 0 then
		arg_10_5 = -arg_10_5
		var_10_0 = CCArray:create()
	end

	var_10_0:addObject((CCEaseIn:create(CCMoveBy:create(arg_10_1, ccp(arg_10_2 + arg_10_4, arg_10_3 + arg_10_5)), arg_10_1)))
	var_10_0:addObject((CCEaseIn:create(CCMoveBy:create(0.1, ccp(-arg_10_4, -arg_10_5)), 0.1)))
	var_10_0:addObject(CCCallFunc:create(function()
		if arg_10_6 then
			arg_10_6()
		end
	end))
	arg_10_0:runAction(CCSequence:create(var_10_0))
end

function var_0_0:sayAction(arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6)
	local var_12_0 = 0

	self:stopAllActions()

	arg_12_1 = arg_12_1 or false
	arg_12_3 = arg_12_3 or false
	arg_12_4 = arg_12_4 or 2.1
	arg_12_5 = arg_12_5 or 1
	arg_12_6 = arg_12_6 or false

	local var_12_1 = CCScaleTo:create(0.5, arg_12_5)

	self:setScale(0.1)
	self:setVisible(true)

	if arg_12_3 then
		local var_12_2 = ccp(self:getPosition())

		self:setPosition((ccp(var_12_2.x, var_12_2.y + self:getContentSize().height / 2)))

		var_12_1 = CCSpawn:createWithTwoActions(var_12_1, (CCMoveTo:create(0.5, var_12_2)))
	end

	local var_12_3 = CCEaseBounceOut:create(var_12_1)

	if not arg_12_1 then
		self:runAction(var_12_3)
	else
		local var_12_4 = CCArray:create()

		var_12_4:addObject(var_12_3)
		var_12_4:addObject((CCDelayTime:create(arg_12_4)))
		var_12_4:addObject(CCCallFunc:create(function()
			if arg_12_6 then
				self:setScale(0.1)
			else
				self:setVisible(false)
			end

			if arg_12_2 then
				var_12_0 = var_12_0 + 1

				arg_12_2(var_12_0)
			end
		end))

		local var_12_5 = CCSequence:create(var_12_4)

		if arg_12_6 then
			var_12_5 = CCRepeatForever:create(var_12_5)
		end

		self:runAction(var_12_5)
	end
end

function var_0_0:sayAction2(arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6)
	self:stopAllActions()

	arg_14_1 = arg_14_1 or false
	arg_14_3 = arg_14_3 or false
	arg_14_4 = arg_14_4 or 2.1
	arg_14_5 = arg_14_5 or 1
	arg_14_6 = arg_14_6 or 1

	local var_14_0 = CCScaleTo:create(0.5, arg_14_5, arg_14_6)

	self:setScale(0.1)
	self:setVisible(true)

	if arg_14_3 then
		local var_14_1 = ccp(self:getPosition())

		self:setPosition((ccp(var_14_1.x, var_14_1.y + self:getContentSize().height / 2)))

		var_14_0 = CCSpawn:createWithTwoActions(var_14_0, (CCMoveTo:create(0.5, var_14_1)))
	end

	local var_14_2 = CCEaseBounceOut:create(var_14_0)

	if not arg_14_1 then
		self:runAction(var_14_2)
	else
		local var_14_3 = CCArray:create()

		var_14_3:addObject(var_14_2)
		var_14_3:addObject((CCDelayTime:create(arg_14_4)))
		var_14_3:addObject(CCCallFunc:create(function()
			self:setVisible(false)

			if arg_14_2 then
				arg_14_2()
			end
		end))
		self:runAction((CCSequence:create(var_14_3)))
	end
end

function var_0_0:shakeAction(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = ccp(self:getPosition())
	local var_16_1 = ccp(var_16_0.x - 5, var_16_0.y)
	local var_16_2 = ccp(var_16_0.x + 5, var_16_0.y)

	if arg_16_2 then
		var_16_1 = ccp(var_16_0.x, var_16_0.y - 5)
		var_16_2 = ccp(var_16_0.x, var_16_0.y + 5)
	end

	local var_16_3 = CCMoveTo:create(0.03, var_16_1)
	local var_16_4 = CCMoveTo:create(0.03, var_16_2)

	if arg_16_3 then
		var_16_3 = CCMoveTo:create(arg_16_3, var_16_1)
		var_16_4 = CCMoveTo:create(arg_16_3, var_16_2)
	end

	self:runAction((CCRepeatForever:create((CCSequence:createWithTwoActions(var_16_3, var_16_4)))))

	if arg_16_1 > 0 then
		self:runAction((CCSequence:createWithTwoActions(CCDelayTime:create(arg_16_1), CCCallFunc:create(function()
			self:stopAllActions()
			self:setPosition(var_16_0)

			if arg_16_4 then
				arg_16_4()
			end
		end))))
	end
end

function var_0_0.flyFromWidget(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if not arg_18_0 or type(arg_18_0) ~= "table" or not arg_18_1 then
		return false
	end

	if arg_18_2 < 0 then
		return false
	end

	arg_18_3 = arg_18_3 or 0

	if arg_18_3 < 0 then
		arg_18_3 = -arg_18_3
	end

	local var_18_0, var_18_1 = arg_18_1:convertToWorldSpaceXY(0, 0)

	for iter_18_0, iter_18_1 in pairs(arg_18_0) do
		local var_18_2, var_18_3 = iter_18_1:getPosition()
		local var_18_4, var_18_5 = iter_18_1:getAnchorPointXY()
		local var_18_6 = iter_18_1:getSize()
		local var_18_7, var_18_8 = iter_18_1:convertToNodeSpaceXY(var_18_0, var_18_1)

		iter_18_1:setPositionXY(var_18_2 + var_18_7 + (var_18_4 - 0.5) * var_18_6.width, var_18_3 + var_18_8 + (var_18_5 - 0.5) * var_18_6.height)

		local var_18_9 = math.sqrt(var_18_8 * var_18_8 + var_18_7 * var_18_7)

		var_0_2(iter_18_1, arg_18_2, -var_18_7 - (var_18_4 - 0.5) * var_18_6.width, -var_18_8 - (var_18_5 - 0.5) * var_18_6.height, arg_18_3 * math.abs(var_18_7) / var_18_9, arg_18_3 * math.abs(var_18_8) / var_18_9, iter_18_0 == #arg_18_0 and arg_18_4 or nil)
	end
end

function var_0_0.flyIntoScreenLR(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	if not arg_19_0 or type(arg_19_0) ~= "table" then
		return false
	end

	if arg_19_2 < 0 then
		return false
	end

	arg_19_3 = arg_19_3 or 1

	if arg_19_3 < 0 then
		arg_19_3 = -arg_19_3
	end

	local var_19_0 = CCDirector:sharedDirector():getWinSize()

	for iter_19_0, iter_19_1 in pairs(arg_19_0) do
		local var_19_1, var_19_2 = iter_19_1:convertToWorldSpaceXY(0, 0)
		local var_19_3, var_19_4 = iter_19_1:getPosition()
		local var_19_5 = iter_19_1:getSize()
		local var_19_6

		if arg_19_1 then
			var_19_6 = -var_19_5.width or var_19_0.width + var_19_5.width

			if arg_19_1 then
				iter_19_1:setPosition(ccp(var_19_3 - arg_19_3 * (var_19_1 - var_19_6), var_19_4))
				var_0_1(iter_19_1, arg_19_3 * (var_19_1 - var_19_6), false, arg_19_2 + 0.1 * (iter_19_0 - 1), arg_19_4, iter_19_0 == #arg_19_0 and arg_19_5 or nil)

				goto label_19_0
			end
		end

		iter_19_1:setPosition(ccp(var_19_3 + arg_19_3 * (var_19_6 - var_19_1), var_19_4))
		var_0_1(iter_19_1, -arg_19_3 * (var_19_6 - var_19_1), false, arg_19_2 + 0.1 * (iter_19_0 - 1), arg_19_4, iter_19_0 == #arg_19_0 and arg_19_5 or nil)

		::label_19_0::
	end
end

function var_0_0.flyOutScreenLR(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	if not arg_20_0 or type(arg_20_0) ~= "table" then
		return false
	end

	if arg_20_2 < 0 then
		return false
	end

	arg_20_3 = arg_20_3 or 1

	if arg_20_3 < 0 then
		arg_20_3 = -arg_20_3
	end

	local var_20_0 = CCDirector:sharedDirector():getWinSize()

	for iter_20_0, iter_20_1 in pairs(arg_20_0) do
		local var_20_1, var_20_2 = iter_20_1:convertToWorldSpaceXY(0, 0)
		local var_20_3 = iter_20_1:getSize()
		local var_20_4

		if arg_20_1 then
			var_20_4 = -var_20_3.width or var_20_0.width + var_20_3.width

			if arg_20_1 then
				var_0_1(iter_20_1, -arg_20_3 * (var_20_1 - var_20_4), false, arg_20_2 + 0.1 * (iter_20_0 - 1), arg_20_4, iter_20_0 == #arg_20_0 and arg_20_5 or nil)

				goto label_20_0
			end
		end

		var_0_1(iter_20_1, arg_20_3 * (var_20_4 - var_20_1), false, arg_20_2 + 0.1 * (iter_20_0 - 1), arg_20_4, iter_20_0 == #arg_20_0 and arg_20_5 or nil)

		::label_20_0::
	end
end

function var_0_0.flyIntoScreenTB(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
	if not arg_21_0 or type(arg_21_0) ~= "table" then
		return false
	end

	if arg_21_2 < 0 then
		return false
	end

	arg_21_3 = arg_21_3 or 1

	if arg_21_3 < 0 then
		arg_21_3 = -arg_21_3
	end

	local var_21_0 = CCDirector:sharedDirector():getWinSize()

	for iter_21_0, iter_21_1 in pairs(arg_21_0) do
		local var_21_1, var_21_2 = iter_21_1:convertToWorldSpaceXY(0, 0)
		local var_21_3, var_21_4 = iter_21_1:getPosition()
		local var_21_5 = iter_21_1:getSize()
		local var_21_6

		if arg_21_1 then
			var_21_6 = var_21_0.height + var_21_5.height or -var_21_5.height

			if arg_21_1 then
				iter_21_1:setPosition(ccp(var_21_3, var_21_4 + arg_21_3 * (var_21_6 - var_21_2)))
				var_0_1(iter_21_1, -arg_21_3 * (var_21_6 - var_21_2), true, arg_21_2 + 0.1 * (iter_21_0 - 1), arg_21_4, iter_21_0 == #arg_21_0 and arg_21_5 or nil)

				goto label_21_0
			end
		end

		iter_21_1:setPosition(ccp(var_21_3, var_21_4 - arg_21_3 * (var_21_2 - var_21_6)))
		var_0_1(iter_21_1, arg_21_3 * (var_21_2 - var_21_6), true, arg_21_2 + 0.1 * (iter_21_0 - 1), arg_21_4, iter_21_0 == #arg_21_0 and arg_21_5 or nil)

		::label_21_0::
	end
end

function var_0_0.flyOutScreenTB(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
	if not arg_22_0 or type(arg_22_0) ~= "table" then
		return false
	end

	if arg_22_2 < 0 then
		return false
	end

	arg_22_3 = arg_22_3 or 1

	if arg_22_3 < 0 then
		arg_22_3 = -arg_22_3
	end

	local var_22_0 = CCDirector:sharedDirector():getWinSize()

	for iter_22_0, iter_22_1 in pairs(arg_22_0) do
		local var_22_1, var_22_2 = iter_22_1:convertToWorldSpaceXY(0, 0)
		local var_22_3, var_22_4 = iter_22_1:getPosition()
		local var_22_5 = iter_22_1:getSize()
		local var_22_6

		if arg_22_1 then
			var_22_6 = var_22_0.height + var_22_5.height or -var_22_5.height

			if arg_22_1 then
				var_0_1(iter_22_1, arg_22_3 * (var_22_6 - var_22_2), true, arg_22_2 + 0.1 * (iter_22_0 - 1), arg_22_4, iter_22_0 == #arg_22_0 and arg_22_5 or nil)

				goto label_22_0
			end
		end

		var_0_1(iter_22_1, -arg_22_3 * (var_22_2 - var_22_6), true, arg_22_2 + 0.1 * (iter_22_0 - 1), arg_22_4, iter_22_0 == #arg_22_0 and arg_22_5 or nil)

		::label_22_0::
	end
end

function var_0_0:flyFromMiddleToSize(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if not self then
		return
	end

	if arg_23_1 < 0 then
		arg_23_1 = 0
	end

	if arg_23_1 <= 0 then
		if arg_23_3 then
			arg_23_3()
		end

		if arg_23_4 then
			arg_23_4()
		end
	end

	local var_23_0 = self:getSize()
	local var_23_1 = CCSizeMake(var_23_0.width, var_23_0.height)

	self:setSize(CCSizeMake(var_23_0.width * 0.2, var_23_0.height))

	local function var_23_2(arg_24_0)
		self:setSize(CCSizeMake(arg_24_0, var_23_1.height))
	end

	local var_23_3 = var_23_1.width
	local var_23_4

	if arg_23_2 and arg_23_2 > 0 then
		var_23_3 = var_23_1.width * 1.2
		var_23_4 = CCArray:create()
	end

	var_23_4:addObject((CCEaseIn:create(CCNumberGrowupAction:create(var_23_0.width * 0.2, var_23_3, arg_23_1, function(arg_25_0)
		var_23_2(arg_25_0)
	end), arg_23_1)))
	var_23_4:addObject(CCCallFunc:create(function()
		if arg_23_3 then
			arg_23_3()
		end
	end))

	if arg_23_2 and arg_23_2 > 0 then
		var_23_4:addObject((CCEaseOut:create(CCNumberGrowupAction:create(var_23_3, var_23_1.width, arg_23_2, function(arg_26_0)
			var_23_2(arg_26_0)
		end), arg_23_2)))
		var_23_4:addObject(CCCallFunc:create(function()
			if arg_23_4 then
				arg_23_4()
			end
		end))
	end

	self:runAction(CCSequence:create(var_23_4))
end

function var_0_0.flyDown(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	if not arg_29_0 then
		return
	end

	if arg_29_1 < 0 then
		arg_29_1 = 0
	end

	if arg_29_1 == 0 and arg_29_4 then
		arg_29_4()
	end

	local function var_29_0(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4)
		if not arg_30_0 then
			return
		end

		arg_30_3 = arg_30_3 or 2
		arg_30_2 = arg_30_2 or 0

		arg_30_0:setVisible(false)
		arg_30_0:setScale(arg_30_3)

		local var_30_0 = CCArray:create()

		var_30_0:addObject(CCDelayTime:create(arg_30_2))
		var_30_0:addObject(CCCallFunc:create(function()
			arg_30_0:setVisible(true)
		end))
		var_30_0:addObject(CCEaseIn:create(CCSequence:createWithTwoActions(CCScaleTo:create(arg_30_1, 0.8), (CCScaleTo:create(0.1, 1))), arg_30_1 + 0.1))
		var_30_0:addObject(CCCallFunc:create(function()
			if arg_30_4 then
				arg_30_4()
			end
		end))
		arg_30_0:runAction(CCSequence:create(var_30_0))
	end

	local var_29_1 = #arg_29_0

	for iter_29_0, iter_29_1 in pairs(arg_29_0) do
		var_29_0(iter_29_1, arg_29_1, arg_29_2 * (iter_29_0 - 1), arg_29_3, iter_29_0 == var_29_1 and arg_29_4 or nil)
	end
end

function var_0_0:_moveUpAndDown()
	if not self then
		return
	end

	local var_33_0 = 1

	self:stopAllActions()
	self:runAction((CCRepeatForever:create((CCSequence:createWithTwoActions(CCMoveBy:create(var_33_0, ccp(0, 10)), (CCMoveBy:create(var_33_0, ccp(0, -10))))))))
end

function var_0_0:showTipsAnimation(arg_34_1)
	local var_34_0 = self:getWidgetByName(arg_34_1)
	local var_34_1

	if var_34_0 == nil then
		do return end

		var_34_1 = CCArray:create()
	end

	var_34_1:addObject((CCScaleTo:create(1.2, 1.2)))
	var_34_1:addObject((CCScaleBy:create(0.8, 0.8)))
	var_34_0:runAction(CCRepeatForever:create(CCSequence:create(var_34_1)))
end

function var_0_0:arrowAnimation(arg_35_1, arg_35_2, arg_35_3)
	if not arg_35_1 then
		return
	end

	local var_35_0 = self:getImageViewByName(arg_35_1)

	if not var_35_0 then
		return
	end

	local var_35_1, var_35_2 = var_35_0:getPosition()
	local var_35_3 = var_35_0:getSize()

	if arg_35_2 then
		local var_35_4 = self:getWidgetByName(arg_35_2)

		if var_35_4 then
			local var_35_5, var_35_6 = var_35_4:getPosition()

			var_35_2 = var_35_6
		end
	end

	arg_35_3 = arg_35_3 or false

	var_35_0:stopAllActions()
	var_35_0:setVisible(arg_35_3)

	if arg_35_3 then
		var_35_0:setVisible(true)
		var_35_0:setOpacity(255)

		local var_35_7 = CCArray:create()

		var_35_7:addObject(CCResetPosition:create(var_35_0, ccp(var_35_1, var_35_2 - 10 / 2)))
		var_35_7:addObject(CCResetOpacity:create(var_35_0, 255))
		var_35_7:addObject(CCEaseIn:create(CCMoveBy:create(0.8, ccp(0, 10)), 0.3))
		var_35_7:addObject(CCFadeOut:create(0.2))
		var_35_0:runAction(CCRepeatForever:create(CCSequence:create(var_35_7)))
	end
end

function var_0_0:tipMove(arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	local var_36_0 = self:getWidgetByName(arg_36_2)

	if not var_36_0 then
		return
	end

	arg_36_3 = arg_36_3 or var_36_0:isVisible()
	arg_36_4 = arg_36_4 or 1

	var_36_0:stopAllActions()
	var_36_0:setPositionXY(arg_36_1.x, arg_36_1.y)

	if arg_36_3 then
		var_0_0.doTipMove(var_36_0, arg_36_4)
	end
end

function var_0_0:doTipMove(arg_37_1)
	if not self then
		return
	end

	arg_37_1 = arg_37_1 or 1

	self:setScale(0.38)
	self:runAction(CCSequence:createWithTwoActions(CCEaseBounceOut:create(CCScaleTo:create(0.5, arg_37_1)), CCCallFunc:create(function()
		self:runAction(CCRepeatForever:create(CCSequence:createWithTwoActions(CCMoveBy:create(0.4, ccp(0, 5)), CCMoveBy:create(0.4, ccp(0, -5)))))
	end)))
end

function var_0_0:tipMoveWithTimes(arg_39_1, arg_39_2, arg_39_3, arg_39_4, arg_39_5, arg_39_6)
	local var_39_0 = self:getWidgetByName(arg_39_2)

	arg_39_3 = arg_39_3 or var_39_0:isVisible()
	arg_39_4 = arg_39_4 or 1

	var_39_0:stopAllActions()
	var_39_0:setPositionXY(arg_39_1.x, arg_39_1.y)

	arg_39_5 = arg_39_5 or 10

	if arg_39_3 then
		var_39_0:setScale(0.38)
		var_39_0:runAction(CCSequence:createWithTwoActions(CCEaseBounceOut:create(CCScaleTo:create(0.5, arg_39_4)), CCCallFunc:create(function()
			var_39_0:runAction(CCSequence:createWithTwoActions(CCRepeat:create(CCSequence:createWithTwoActions(CCMoveBy:create(0.4, ccp(0, 5)), CCMoveBy:create(0.4, ccp(0, -5))), arg_39_5), (CCCallFunc:create(function()
				if arg_39_6 then
					arg_39_6()
				end
			end))))
		end)))
	end
end

function var_0_0:blurWidget(arg_42_1, arg_42_2, arg_42_3)
	if not arg_42_1 then
		return
	end

	local var_42_0 = self:getWidgetByName(arg_42_1)

	if not var_42_0 then
		return
	end

	arg_42_2 = arg_42_2 or false
	arg_42_3 = arg_42_3 or 0.1

	if arg_42_2 then
		var_42_0:stopAllActions()
		var_42_0:runAction((CCRepeatForever:create((CCSequence:createWithTwoActions(CCFadeIn:create(arg_42_3), (CCFadeOut:create(arg_42_3)))))))
	else
		var_42_0:stopAllActions()
		var_42_0:setOpacity(255)
	end
end

function var_0_0:blurWidget2(arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	if not self then
		return
	end

	arg_43_1 = arg_43_1 or 0.5
	arg_43_2 = arg_43_2 or 1

	local var_43_0

	if not arg_43_3 then
		arg_43_3 = 5
		var_43_0 = CCArray:create()
	end

	var_43_0:addObject((CCFadeOut:create(arg_43_1)))
	var_43_0:addObject((CCFadeIn:create(arg_43_1)))
	var_43_0:addObject((CCDelayTime:create(arg_43_2)))
	self:runAction(CCSequence:createWithTwoActions(CCRepeat:create(CCSequence:create(var_43_0), arg_43_3), (CCCallFunc:create(function()
		if arg_43_4 then
			arg_43_4()
		end
	end))))
end

function var_0_0:moveToUpdate(arg_45_1, arg_45_2, arg_45_3, arg_45_4)
	local function var_45_0()
		if arg_45_4 then
			arg_45_4()
		end
	end

	local var_45_1 = self:getLabelByName(arg_45_1)
	local var_45_2 = self:getLabelByName(arg_45_2)

	if not var_45_1 or not var_45_2 then
		var_45_0()

		return
	end

	local var_45_3, var_45_4 = var_45_2:getPosition()
	local var_45_5, var_45_6 = var_45_1:getPosition()
	local var_45_7 = CCArray:create()

	var_45_7:addObject((CCMoveTo:create(arg_45_3, ccp(var_45_5, var_45_6))))
	var_45_7:addObject((CCCallFunc:create(function()
		var_45_2:setPositionXY(var_45_3, var_45_4)
		var_45_0()
	end)))
	var_45_2:runAction((CCSequence:create(var_45_7)))
end

function var_0_0.listviewRunFlyInAni(arg_48_0, arg_48_1)
	arg_48_1 = arg_48_1 or {}

	local var_48_0 = rawget(arg_48_1, "widget")
	local var_48_1 = rawget(arg_48_1, "originX")
	local var_48_2 = rawget(arg_48_1, "originY")
	local var_48_3 = rawget(arg_48_1, "index")
	local var_48_4 = rawget(arg_48_1, "callBack")
	local var_48_5 = rawget(arg_48_1, "height")

	if not var_48_0 then
		return
	end

	var_48_0:stopAllActions()
	var_48_0:setPositionXY(var_48_1, var_48_2 + (math.fmod(var_48_3, 2) == 0 and var_48_5 or -var_48_5))

	local var_48_6 = math.fmod(var_48_3, 2) == 0 and 30 or -30
	local var_48_7 = CCArray:create()

	var_48_7:addObject((CCEaseIn:create(CCMoveTo:create(0.3, ccp(var_48_1, var_48_2 - var_48_6)), 0.3)))
	var_48_7:addObject((CCEaseIn:create(CCMoveBy:create(0.1, ccp(0, var_48_6)), 0.1)))
	var_48_7:addObject(CCCallFunc:create(function()
		if var_48_4 then
			var_48_4()
		end
	end))
	var_48_0:runAction(CCSequence:create(var_48_7))
end

function var_0_0.showDetail(arg_50_0)
	local var_50_0 = rawget(arg_50_0, "widget")
	local var_50_1 = rawget(arg_50_0, "posX") or 0
	local var_50_2 = rawget(arg_50_0, "posY") or 0
	local var_50_3 = rawget(arg_50_0, "duration") or 0.2
	local var_50_4 = rawget(arg_50_0, "fnCallBack")

	if var_50_0 then
		var_50_0:stopAllActions()

		if rawget(arg_50_0, "show") then
			var_50_0:setPositionXY(var_50_1, var_50_2)
			var_50_0:setVisible(true)
			var_50_0:setScale(0)
			var_50_0:runAction(CCSequence:createWithTwoActions(CCScaleTo:create(var_50_3, 1), (CCCallFunc:create(function()
				if var_50_4 then
					var_50_4()
				end
			end))))
		else
			var_50_0:setScale(1)
			var_50_0:runAction(CCSequence:createWithTwoActions(CCScaleTo:create(var_50_3, 0.01), (CCCallFunc:create(function()
				var_50_0:setVisible(false)

				if var_50_4 then
					var_50_4()
				end
			end))))
		end
	end
end

function var_0_0:actionShowWidget(arg_53_1)
	self:stopAllActions()

	if self:isVisible() then
		self:runAction(CCSequence:createWithTwoActions(CCScaleTo:create(0.2, 0), CCCallFunc:create(function()
			self:setVisible(false)
		end)))
	else
		self:setScale(0)
		self:setVisible(true)

		local var_53_0 = CCArray:create()

		var_53_0:addObject(CCScaleTo:create(0.2, 1))
		var_53_0:addObject(CCDelayTime:create(5))
		var_53_0:addObject(CCCallFunc:create(function()
			if arg_53_1 then
				arg_53_1()
			end
		end))
		self:runAction(CCSequence:create(var_53_0))
	end
end

function var_0_0.flyLabelUp(arg_56_0)
	arg_56_0 = arg_56_0 or {}

	local var_56_0 = rawget(arg_56_0, "label")
	local var_56_1 = rawget(arg_56_0, "callFunc")
	local var_56_2 = rawget(arg_56_0, "deltaX") or 0
	local var_56_3 = rawget(arg_56_0, "deltaY") or 50
	local var_56_4 = rawget(arg_56_0, "flyTime") or 1
	local var_56_5 = rawget(arg_56_0, "delayTime") or 1
	local var_56_6 = rawget(arg_56_0, "fadeTime") or 1

	if not var_56_0 then
		return
	end

	local var_56_7 = CCArray:create()

	var_56_7:addObject((CCMoveBy:create(var_56_4, ccp(var_56_2, var_56_3))))
	var_56_7:addObject((CCDelayTime:create(var_56_5)))
	var_56_7:addObject((CCFadeOut:create(var_56_6)))
	var_56_7:addObject((CCCallFunc:create(function()
		if var_56_1 then
			var_56_1()
		end
	end)))
	var_56_0:runAction((CCSequence:create(var_56_7)))
end

function var_0_0.showExpression(arg_58_0)
	arg_58_0 = arg_58_0 or {}

	local var_58_0 = rawget(arg_58_0, "widget")
	local var_58_1 = rawget(arg_58_0, "delayTime") or 1
	local var_58_2 = rawget(arg_58_0, "fnCallBack")
	local var_58_3

	if not var_58_0 then
		do return end

		var_58_3 = CCArray:create()
	end

	var_58_3:addObject((CCShow:create()))
	var_58_3:addObject((CCDelayTime:create(var_58_1)))
	var_58_3:addObject((CCHide:create()))

	if var_58_2 then
		var_58_3:addObject((CCCallFunc:create(var_58_2)))
	end

	var_58_0:runAction(CCSequence:create(var_58_3))
end

return var_0_0
