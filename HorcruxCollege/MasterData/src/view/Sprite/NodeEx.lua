local NodeEx = class("NodeEx", function()
	return cc.Node:create()
end)

NodeEx.Click = 0
NodeEx.Press = 1

local var_0_1 = tonumber
local var_0_2 = math.random
local var_0_4 = math.abs
local var_0_5 = {
	Button = "Button",
	ScrollView = "ScrollView",
	Layout = "Layout",
	ListView = "ListView",
	Label = "Label",
	ImageView = "ImageView",
	Sprite = "Sprite"
}

function NodeEx:extend(arg_2_1)
	local var_2_0

	if arg_2_1.getDescription then
		var_2_0 = arg_2_1:getDescription()
	end

	function arg_2_1:size()
		local var_3_0 = self:getContentSize()

		var_3_0.w = var_3_0.width
		var_3_0.h = var_3_0.height

		return var_3_0
	end

	function arg_2_1:move(arg_4_1, arg_4_2)
		if arg_4_2 then
			self:setPosition(arg_4_1, arg_4_2)
		else
			self:setPosition(arg_4_1)
		end
	end

	function arg_2_1:removeSelf()
		self:removeFromParent()

		return self
	end

	function arg_2_1:align(arg_6_1, arg_6_2, arg_6_3)
		self:setAnchorPoint(arg_6_1)

		return self:move(arg_6_2, arg_6_3)
	end

	function arg_2_1:show()
		self:setVisible(true)

		return self
	end

	function arg_2_1:hide()
		self:setVisible(false)

		return self
	end

	function arg_2_1:onUpdate(arg_9_1)
		self:scheduleUpdateWithPriorityLua(arg_9_1, 0)

		return self
	end

	arg_2_1.scheduleUpdate = arg_2_1.onUpdate

	function arg_2_1:onNodeEvent(arg_10_1, arg_10_2)
		if arg_10_1 == "enter" then
			self.onEnterCallback_ = arg_10_2
		elseif arg_10_1 == "exit" then
			self.onExitCallback_ = arg_10_2
		elseif arg_10_1 == "enterTransitionFinish" then
			self.onEnterTransitionFinishCallback_ = arg_10_2
		elseif arg_10_1 == "exitTransitionStart" then
			self.onExitTransitionStartCallback_ = arg_10_2
		elseif arg_10_1 == "cleanup" then
			self.onCleanupCallback_ = arg_10_2
		end

		self:enableNodeEvents()
	end

	function arg_2_1:enableNodeEvents()
		if self.isNodeEventEnabled_ then
			return self
		end

		self:registerScriptHandler(function(arg_12_0)
			if arg_12_0 == "enter" then
				self:onEnter_()
			elseif arg_12_0 == "exit" then
				self:onExit_()
			elseif arg_12_0 == "enterTransitionFinish" then
				self:onEnterTransitionFinish_()
			elseif arg_12_0 == "exitTransitionStart" then
				self:onExitTransitionStart_()
			elseif arg_12_0 == "cleanup" then
				self:onCleanup_()
			end
		end)

		self.isNodeEventEnabled_ = true

		return self
	end

	function arg_2_1:disableNodeEvents()
		self:unregisterScriptHandler()

		self.isNodeEventEnabled_ = false

		return self
	end

	function arg_2_1.onEnter(arg_14_0)
		return
	end

	function arg_2_1.onExit(arg_15_0)
		return
	end

	function arg_2_1.onEnterTransitionFinish(arg_16_0)
		return
	end

	function arg_2_1.onExitTransitionStart(arg_17_0)
		return
	end

	function arg_2_1.onCleanup(arg_18_0)
		return
	end

	function arg_2_1:onEnter_()
		self:onEnter()

		if not self.onEnterCallback_ then
			return
		end

		self:onEnterCallback_()
	end

	function arg_2_1:onExit_()
		self:onExit()

		if not self.onExitCallback_ then
			return
		end

		self:onExitCallback_()
	end

	function arg_2_1:onEnterTransitionFinish_()
		self:onEnterTransitionFinish()

		if not self.onEnterTransitionFinishCallback_ then
			return
		end

		self:onEnterTransitionFinishCallback_()
	end

	function arg_2_1:onExitTransitionStart_()
		self:onExitTransitionStart()

		if not self.onExitTransitionStartCallback_ then
			return
		end

		self:onExitTransitionStartCallback_()
	end

	function arg_2_1:onCleanup_()
		self:onCleanup()

		if not self.onCleanupCallback_ then
			return
		end

		self:onCleanupCallback_()
	end

	function arg_2_1:moveRight(arg_24_1, arg_24_2, arg_24_3)
		if arg_24_1 then
			arg_24_2 = var_0_1(arg_24_2) or 0
			arg_24_3 = var_0_1(arg_24_3) or 0

			local var_24_0 = arg_24_1:getAnchorPoint()

			self:align(cc.p(var_24_0.x, var_24_0.y), arg_24_1:getPositionX() + (1 - var_24_0.x) * arg_24_1:size().w + arg_24_2, arg_24_1:getPositionY() + arg_24_3)
		end
	end

	function arg_2_1:center()
		local var_25_0 = self:getParent()

		if var_25_0 then
			self:setPosition(cc.p(var_25_0:getContentSize().width / 2, var_25_0:getContentSize().height / 2))
		end
	end

	function arg_2_1:_addEvent(arg_26_1, arg_26_2)
		if var_0_5.Layout == var_2_0 then
			self:setTouchEnabled(true)
		elseif var_0_5.ImageView == var_2_0 then
			self:setTouchEnabled(true)
		elseif var_0_5.Button == var_2_0 then
			-- block empty
		end

		if var_0_5.Layout == var_2_0 or var_0_5.ImageView == var_2_0 or var_0_5.Button == var_2_0 then
			arg_2_1:addTouchEventListener(function(arg_27_0, arg_27_1)
				if arg_27_1 == ccui.TouchEventType.ended then
					if var_0_4(arg_27_0:getTouchBeganPosition().x - arg_27_0:getTouchEndPosition().x) >= 25 then
						return
					end

					if var_0_4(arg_27_0:getTouchBeganPosition().y - arg_27_0:getTouchEndPosition().y) >= 25 then
						return
					end

					arg_26_1(arg_27_0, arg_27_1)

					if arg_26_2 and arg_26_2.touchDelay then
						self:removeChildByName("_touchDelayNode")
						self:setTouchEnabled(false)

						local var_27_0 = var_0_1(arg_26_2.touchDelay) or 1
						local var_27_1 = cc.Node:create()

						var_27_1:setName("_touchDelayNode")
						self:addChild(var_27_1)
						performWithDelay(var_27_1, function()
							self:setTouchEnabled(true)
						end, var_27_0)
					end
				end
			end)
		end
	end

	function arg_2_1:_addSuperEvent(arg_29_1, arg_29_2)
		if var_0_5.Button == var_2_0 then
			local var_29_0 = 0.016666666666666666
			local var_29_1 = 0.5
			local var_29_2 = true
			local var_29_3 = true

			if arg_29_2 then
				var_29_0 = arg_29_2.addTime or var_29_0
				var_29_1 = arg_29_2.longPressTime or var_29_1

				if not arg_29_2.bAutoStop then
					var_29_2 = false
				end
			end

			self:addTouchEventListener(function(arg_30_0, arg_30_1)
				if arg_30_1 == ccui.TouchEventType.began then
					local var_30_0 = 0

					schedule(arg_30_0, function()
						var_30_0 = var_30_0 + var_29_0

						if var_30_0 >= var_29_1 then
							arg_30_0.longPress = true

							if var_29_2 then
								arg_30_0:stopAllActions()
							end

							if not arg_29_1 or var_29_3 and arg_30_0.moveMore then
								-- block empty
							else
								arg_29_1(NodeEx.Press, arg_30_0, arg_30_1)
							end
						end
					end, var_29_0)
				elseif arg_30_1 == ccui.TouchEventType.moved then
					local var_30_2 = arg_30_0:getTouchBeganPosition()
					local var_30_3 = arg_30_0:getTouchMovePosition()

					if var_0_4(var_30_2.x - var_30_3.x) > 20 or var_0_4(var_30_2.y - var_30_3.y) > 20 then
						arg_30_0.moveMore = true
					end
				elseif arg_30_1 == ccui.TouchEventType.ended then
					arg_30_0:stopAllActions()

					arg_30_0.longPress = false
					arg_30_0.moveMore = false

					if var_0_4(arg_30_0:getTouchBeganPosition().x - arg_30_0:getTouchEndPosition().x) >= 25 then
						return
					end

					if var_0_4(arg_30_0:getTouchBeganPosition().y - arg_30_0:getTouchEndPosition().y) >= 25 then
						return
					end

					if not arg_30_0.longPress and arg_29_1 then
						arg_29_1(NodeEx.Click, arg_30_0, arg_30_1)
					end
				elseif arg_30_1 == ccui.TouchEventType.canceled then
					arg_30_0:stopAllActions()

					arg_30_0.longPress = false
					arg_30_0.moveMore = false
				end
			end)
		end
	end

	function arg_2_1:_setColor(arg_32_1)
		if string.find(var_2_0, var_0_5.Label) then
			local var_32_0 = string.len(arg_32_1)
			local var_32_1
			local var_32_2 = 255

			if var_32_0 == 6 then
				var_32_1 = 1
			elseif var_32_0 == 7 then
				var_32_1 = 2
			else
				var_32_2 = (var_32_0 == 8 or var_32_0 == 9) and var_0_1(string.sub(arg_32_1, var_32_0 - 1, var_32_0), 16) or var_32_2
			end

			if var_32_1 then
				self:setTextColor((cc.c4b(var_0_1(string.sub(arg_32_1, var_32_1, var_32_1 + 1), 16) or 0, var_0_1(string.sub(arg_32_1, var_32_1 + 2, var_32_1 + 3), 16) or 0, var_0_1(string.sub(arg_32_1, var_32_1 + 4, var_32_1 + 5), 16) or 0, var_32_2)))
			end
		end
	end

	function arg_2_1:_setBack()
		if var_0_5.Layout == var_2_0 or var_0_5.ListView == var_2_0 or var_0_5.ScrollView == var_2_0 then
			self:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
			self:setBackGroundColor(cc.c3b(var_0_2(50, 200), var_0_2(50, 200), var_0_2(50, 200)))
		end
	end

	function arg_2_1:pos()
		return (cc.p(self:getPosition()))
	end

	function arg_2_1:property()
		local var_35_0 = self:getContentSize()
		local var_35_1 = {
			size = {
				width = var_35_0.width,
				height = var_35_0.height
			}
		}

		var_35_1.width = var_35_1.size.width
		var_35_1.height = var_35_1.size.height
		var_35_1.cx = var_35_1.width / 2
		var_35_1.cy = var_35_1.height / 2
		var_35_1.c_left = -var_35_1.width / 2
		var_35_1.c_right = var_35_1.width / 2
		var_35_1.c_top = var_35_1.height / 2
		var_35_1.c_bottom = -var_35_1.height / 2
		var_35_1.left = 0
		var_35_1.right = var_35_1.width
		var_35_1.top = var_35_1.height
		var_35_1.bottom = 0
		var_35_1.center = cc.p(var_35_1.cx, var_35_1.cy)
		var_35_1.left_top = cc.p(var_35_1.left, var_35_1.top)
		var_35_1.left_bottom = cc.p(var_35_1.left, var_35_1.bottom)
		var_35_1.left_center = cc.p(var_35_1.left, var_35_1.cy)
		var_35_1.right_top = cc.p(var_35_1.right, var_35_1.top)
		var_35_1.right_bottom = cc.p(var_35_1.right, var_35_1.bottom)
		var_35_1.right_center = cc.p(var_35_1.right, var_35_1.cy)
		var_35_1.top_center = cc.p(var_35_1.cx, var_35_1.top)
		var_35_1.top_bottom = cc.p(var_35_1.cx, var_35_1.bottom)

		return var_35_1
	end

	if var_0_5.ListView == var_2_0 then
		function arg_2_1:jumpToIndex(arg_36_1, arg_36_2, arg_36_3)
			if self:getChildren()[arg_36_1] then
				local var_36_0 = self:getContentSize()
				local var_36_1 = self:getInnerContainerSize()
				local var_36_2 = self:getDirection()

				if var_36_2 == ccui.ListViewDirection.vertical then
					if var_36_1.height > var_36_0.height then
						self:jumpToPercentVertical((self:getPercentByIndex(arg_36_1, arg_36_2, arg_36_3)))
					end
				elseif var_36_2 == ccui.ListViewDirection.horizontal and var_36_1.width > var_36_0.width then
					self:jumpToPercentHorizontal((self:getPercentByIndex(arg_36_1, arg_36_2, arg_36_3)))
				end
			end
		end

		function arg_2_1:getPercentByIndex(arg_37_1, arg_37_2, arg_37_3)
			local var_37_0 = 0
			local var_37_1 = self:getChildren()

			if var_37_1[arg_37_1] then
				local var_37_2 = self:getContentSize()
				local var_37_3 = self:getInnerContainerSize()
				local var_37_4 = self:getDirection()

				if var_37_4 == ccui.ListViewDirection.vertical then
					if var_37_3.height > var_37_2.height then
						arg_37_2 = arg_37_2 or cc.p(0, 0)
						arg_37_3 = arg_37_3 or cc.p(0, 0)

						local var_37_5 = var_37_3.height - var_37_2.height
						local var_37_6 = 0

						for iter_37_0 = 1, arg_37_1 do
							var_37_6 = var_37_6 + var_37_1[iter_37_0]:getContentSize().height
						end

						local var_37_7 = var_37_6 - var_37_2.height + arg_37_2.y * var_37_2.height + -arg_37_3.y * var_37_1[arg_37_1]:getContentSize().height

						var_37_0 = var_37_5 <= var_37_7 and 100 or var_37_7 <= 0 and 0 or var_37_7 / var_37_5 * 100
					end
				elseif var_37_4 == ccui.ListViewDirection.horizontal and var_37_3.width > var_37_2.width then
					arg_37_2 = arg_37_2 or cc.p(0, 0)
					arg_37_3 = arg_37_3 or cc.p(0, 0)

					local var_37_8 = var_37_3.width - var_37_2.width
					local var_37_9 = 0

					for iter_37_1 = 1, arg_37_1 do
						var_37_9 = var_37_9 + var_37_1[iter_37_1]:getContentSize().width
					end

					local var_37_10 = var_37_9 - var_37_2.width + arg_37_2.x * var_37_2.width + -arg_37_3.x * var_37_1[arg_37_1]:getContentSize().width

					var_37_0 = var_37_8 <= var_37_10 and 100 or var_37_10 <= 0 and 0 or var_37_10 / var_37_8 * 100
				end
			end

			return var_37_0
		end

		function arg_2_1:getPercent()
			local var_38_0 = 100
			local var_38_1 = self:getDirection()

			if var_38_1 == ccui.ListViewDirection.vertical then
				local var_38_2 = self:getInnerContainerSize()
				local var_38_3 = self:getContentSize()

				if var_38_2.height - var_38_3.height > 0 then
					var_38_0 = 100 - var_0_4(cc.p(self:getInnerContainer():getPosition()).y / (var_38_2.height - var_38_3.height) * 100)
				end
			elseif var_38_1 == ccui.ListViewDirection.horizontal then
				local var_38_4 = self:getInnerContainerSize()
				local var_38_5 = self:getContentSize()

				if var_38_4.width - var_38_5.width > 0 then
					var_38_0 = 100 - var_0_4(cc.p(self:getInnerContainer():getPosition()).x / (var_38_4.width - var_38_5.width) * 100)
				end
			end

			return var_38_0
		end

		function arg_2_1:getInnerContainerPosition()
			return (cc.p(self:getInnerContainer():getPosition()))
		end
	end
end

return NodeEx
