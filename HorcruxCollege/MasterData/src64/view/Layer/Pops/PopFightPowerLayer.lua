PopFightPowerLayer = class("PopFightPowerLayer", function()
	return PopBaseLayer:create()
end)

function PopFightPowerLayer.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = PopFightPowerLayer.new()

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function PopFightPowerLayer:init(arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1.msg1 or arg_3_1

	self.timescale = arg_3_2 or 1
	self.finishCallback = arg_3_1.finishCallback

	local var_3_1 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopChangeEquip.json" or "PopChangeEquip.ExportJson")

	self:addChild(var_3_1, 999)
	var_3_1:setLocalZOrder(999)

	local var_3_2 = ccui.Helper:seekWidgetByName(var_3_1, "Panel_back")
	local var_3_3 = ccui.Helper:seekWidgetByName(var_3_1, "Label_plus")
	local var_3_4 = ccui.Helper:seekWidgetByName(var_3_1, "Label_minus")
	local var_3_5 = ccui.Helper:seekWidgetByName(var_3_1, "Panel_content")

	self.rootpanel = ccui.Helper:seekWidgetByName(var_3_1, "Panel_bottom")

	self.rootpanel:setOpacity(0)
	self.rootpanel:runAction(cc.FadeIn:create(1 * self.timescale))
	self:initBg()

	local var_3_6 = {}
	local var_3_7 = {}
	local var_3_8 = {}
	local var_3_9 = {}

	print("msg1==", dump(var_3_0))

	for iter_3_0 = 1, #var_3_0 do
		if string.find(var_3_0[iter_3_0], L_FIGHT_CAPACITY) and string.find(var_3_0[iter_3_0], "+") then
			var_3_8[1] = string_split(var_3_0[iter_3_0], ":")
		elseif string.find(var_3_0[iter_3_0], L_FIGHT_CAPACITY) and string.find(var_3_0[iter_3_0], "-") then
			var_3_9[1] = string_split(var_3_0[iter_3_0], ":")
		else
			local var_3_10

			if string.find(var_3_0[iter_3_0], "+") then
				var_3_6[1] = string_split(var_3_0[iter_3_0], ":")
				var_3_10 = 1 + 1
			elseif string.find(var_3_0[iter_3_0], "-") then
				var_3_7[1] = string_split(var_3_0[iter_3_0], ":")
			end
		end
	end

	local var_3_12 = math.floor(#var_3_6 / 2 + #var_3_6 % 2)
	local var_3_13 = math.floor(#var_3_7 / 2 + #var_3_7 % 2)
	local var_3_14 = -180
	local var_3_15 = 205
	local var_3_16
	local var_3_17 = math.floor((var_3_12 + var_3_13 + 1) / 2)
	local var_3_18 = {}

	local function var_3_19(arg_4_0)
		arg_4_0.labelObj:setString("")
		arg_4_0.labelObj:setVisible(true)
		require("controller.l2utils"):showStrPerChar(arg_4_0.labelObj, arg_4_0.str, nil, 0.03 * self.timescale)
	end

	local function var_3_20(arg_5_0)
		for iter_5_0 = 1, #arg_5_0 do
			arg_5_0[iter_5_0]:setVisible(false)
			var_3_5:addChild(arg_5_0[iter_5_0], 999)
			arg_5_0[iter_5_0]:runAction(cc.Sequence:create(cc.DelayTime:create(iter_5_0 * 0.3 * self.timescale), cc.CallFunc:create(function()
				local var_6_0 = {
					[iter_5_0] = {}
				}

				var_6_0[iter_5_0].labelObj = arg_5_0[iter_5_0]
				var_6_0[iter_5_0].str = arg_5_0[iter_5_0]:getString()

				var_3_19(var_6_0[iter_5_0])
			end), cc.CallFunc:create(function()
				local var_7_0 = {
					[iter_5_0] = {}
				}

				var_7_0[iter_5_0].labelObj = arg_5_0[iter_5_0]:getChildByName("Label_num")
				var_7_0[iter_5_0].str = arg_5_0[iter_5_0]:getChildByName("Label_num"):getString()

				var_3_19(var_7_0[iter_5_0])
			end)))
		end
	end

	local function var_3_21(arg_8_0)
		if #var_3_8 + #var_3_9 ~= 0 then
			if #var_3_8 ~= 0 then
				var_3_16 = var_3_3:clone()

				var_3_16:setString(var_3_8[1][1] .. ":")
				var_3_16:getChildByName("Label_num"):setString(var_3_8[1][2])
				var_3_16:setPosition(cc.p(var_3_14, var_3_17 * 40 - arg_8_0))

				var_3_17 = var_3_17 - 1
			else
				var_3_16 = var_3_4:clone()

				var_3_16:setString(var_3_9[1][1] .. ":")
				var_3_16:getChildByName("Label_num"):setString(var_3_9[1][2])
				var_3_16:setPosition(cc.p(var_3_14, var_3_17 * 40 - arg_8_0))

				var_3_17 = var_3_17 - 1
			end

			var_3_18[#var_3_18 + 1] = var_3_16

			for iter_8_0 = 1, #var_3_6 do
				local var_8_0 = var_3_3:clone()

				var_8_0:setString(var_3_6[iter_8_0][1] .. ":")
				var_8_0:getChildByName("Label_num"):setString(var_3_6[iter_8_0][2])
				var_8_0:getChildByName("Label_num"):setPositionX(var_8_0:getContentSize().width)
				var_8_0:setPosition(cc.p(var_3_14, var_3_17 * 40 - arg_8_0))

				var_3_14 = var_8_0:getContentSize().width + var_8_0:getChildByName("Label_num"):getContentSize().width > var_3_15 and var_3_14 + var_3_15 + 50 or var_3_14 + var_3_15

				if iter_8_0 % 2 == 0 then
					var_3_14 = -180
					var_3_17 = var_3_17 - 1
				end

				var_3_18[#var_3_18 + 1] = var_8_0
			end

			if #var_3_6 % 2 == 1 then
				var_3_17 = var_3_17 - 1
			end

			var_3_14 = -180

			for iter_8_1 = 1, #var_3_7 do
				local var_8_1 = var_3_4:clone()

				var_8_1:setString(var_3_7[iter_8_1][1] .. ":")
				var_8_1:getChildByName("Label_num"):setString(var_3_7[iter_8_1][2])
				var_8_1:getChildByName("Label_num"):setPositionX(var_8_1:getContentSize().width)
				var_8_1:setPosition(cc.p(var_3_14, var_3_17 * 40 - arg_8_0))

				var_3_14 = var_8_1:getContentSize().width + var_8_1:getChildByName("Label_num"):getContentSize().width > var_3_15 and var_3_14 + var_3_15 + 50 or var_3_14 + var_3_15

				if iter_8_1 % 2 == 0 then
					var_3_14 = -180
					var_3_17 = var_3_17 - 1
				end

				var_3_18[#var_3_18 + 1] = var_8_1
			end

			var_3_20(var_3_18)
		end
	end

	if #var_3_6 == 1 and #var_3_7 == 1 then
		if #var_3_8 + #var_3_9 ~= 0 then
			if #var_3_8 ~= 0 then
				var_3_16 = var_3_3:clone()

				var_3_16:setString(var_3_8[1][1] .. ":")
				var_3_16:getChildByName("Label_num"):setString(var_3_8[1][2])
			else
				var_3_16 = var_3_4:clone()

				var_3_16:setString(var_3_9[1][1] .. ":")
				var_3_16:getChildByName("Label_num"):setString(var_3_9[1][2])
			end

			var_3_16:setPosition(cc.p(-80, 40))

			var_3_18[#var_3_18 + 1] = var_3_16
		end

		labelA = var_3_3:clone()

		labelA:setString(var_3_6[1][1] .. ":")
		labelA:getChildByName("Label_num"):setString(var_3_6[1][2])
		labelA:getChildByName("Label_num"):setPositionX(labelA:getContentSize().width)
		labelA:setPosition(cc.p(-80, 0))

		var_3_18[#var_3_18 + 1] = labelA
		labelD = var_3_4:clone()

		labelD:setString(var_3_7[1][1] .. ":")
		labelD:getChildByName("Label_num"):setString(var_3_7[1][2])
		labelD:getChildByName("Label_num"):setPositionX(labelD:getContentSize().width)
		labelD:setPosition(cc.p(-80, -40))

		var_3_18[#var_3_18 + 1] = labelD

		var_3_20(var_3_18)
	elseif #var_3_6 == 1 and #var_3_7 == 0 or #var_3_6 == 0 and #var_3_7 == 1 then
		if #var_3_8 + #var_3_9 ~= 0 then
			if #var_3_8 ~= 0 then
				var_3_16 = var_3_3:clone()

				var_3_16:setString(var_3_8[1][1] .. ":")
				var_3_16:getChildByName("Label_num"):setString(var_3_8[1][2])
			else
				var_3_16 = var_3_4:clone()

				var_3_16:setString(var_3_9[1][1] .. ":")
				var_3_16:getChildByName("Label_num"):setString(var_3_9[1][2])
			end

			var_3_16:setPosition(cc.p(-80, 20))

			var_3_18[#var_3_18 + 1] = var_3_16
		end

		if #var_3_6 == 1 then
			labelA = var_3_3:clone()

			labelA:setString(var_3_6[1][1] .. ":")
			labelA:getChildByName("Label_num"):setString(var_3_6[1][2])
			labelA:getChildByName("Label_num"):setPositionX(labelA:getContentSize().width)

			if #var_3_8 + #var_3_9 ~= 0 then
				labelA:setPosition(cc.p(-80, -20))
			else
				labelA:setPosition(cc.p(-80, 0))
			end

			var_3_18[#var_3_18 + 1] = labelA
		end

		if #var_3_7 == 1 then
			labelD = var_3_4:clone()

			labelD:setString(var_3_7[1][1] .. ":")
			labelD:getChildByName("Label_num"):setString(var_3_7[1][2])
			labelD:getChildByName("Label_num"):setPositionX(labelD:getContentSize().width)

			if #var_3_8 + #var_3_9 ~= 0 then
				labelD:setPosition(cc.p(-80, -20))
			else
				labelD:setPosition(cc.p(-80, 0))
			end

			var_3_18[#var_3_18 + 1] = labelD
		end

		var_3_20(var_3_18)
	elseif var_3_12 + var_3_13 + 1 == 1 then
		if #var_3_8 + #var_3_9 ~= 0 then
			if #var_3_8 ~= 0 then
				var_3_16 = var_3_3:clone()

				var_3_16:setString(var_3_8[1][1] .. ":")
				var_3_16:getChildByName("Label_num"):setString(var_3_8[1][2])
			else
				var_3_16 = var_3_4:clone()

				var_3_16:setString(var_3_9[1][1] .. ":")
				var_3_16:getChildByName("Label_num"):setString(var_3_9[1][2])
			end

			var_3_16:setPosition(cc.p(-80, 0))

			var_3_18[#var_3_18 + 1] = var_3_16
		end

		var_3_20(var_3_18)
	elseif (var_3_12 + var_3_13 + 1) % 2 == 0 then
		var_3_21(20)
	else
		var_3_21(0)
	end

	local var_3_22 = ccui.Helper:seekWidgetByName(var_3_1, "Panel_back")

	var_3_22:setTouchEnabled(false)
	var_3_22:runAction(cc.Sequence:create(cc.DelayTime:create(4 * self.timescale), cc.CallFunc:create(function()
		self.rootpanel:runAction(cc.Sequence:create(cc.FadeOut:create(0.5 * self.timescale), cc.CallFunc:create(function()
			if self.finishCallback then
				self.finishCallback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)))
	end)))
end

function PopFightPowerLayer:initBg()
	local var_11_0 = ccui.Layout:create()

	var_11_0:setTouchEnabled(true)
	var_11_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_11_0:setAnchorPoint(cc.p(0, 0))
	var_11_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_11_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_11_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_11_0:setOpacity(0)
	self:addChild(var_11_0, -1)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.2 * self.timescale), cc.CallFunc:create(function()
		var_11_0:addTouchEventListener(function(arg_13_0, arg_13_1)
			if arg_13_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.finishCallback then
				self.finishCallback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)))
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_14_0)
		self:addChild(arg_14_0, -2)
		arg_14_0:setPositionY(arg_14_0:getPositionY() - GameDisplay.fix_y)

		self.mask = ccui.ImageView:create("mainScenebg/blur_mask.png")

		self.mask:setAnchorPoint(cc.p(0, 0))
		self.mask:setPositionY(-GameDisplay.fix_y)
		self.mask:setOpacity(0)
		self.mask:runAction(cc.FadeIn:create(1 * self.timescale))
		self:addChild(self.mask, -1)
		var_11_0:setOpacity(102)
		var_11_0:setTouchEnabled(true)
	end)
end

function PopFightPowerLayer:exit()
	if self.finishCallback then
		self.finishCallback()
	end

	LayerManager:removePopLayer(self.__queueindex)
end
