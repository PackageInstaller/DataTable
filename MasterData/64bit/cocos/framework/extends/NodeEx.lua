function cc.Node:add(arg_1_1, arg_1_2, arg_1_3)
	if arg_1_3 then
		self:addChild(arg_1_1, arg_1_2, arg_1_3)
	elseif arg_1_2 then
		self:addChild(arg_1_1, arg_1_2)
	else
		self:addChild(arg_1_1)
	end

	return self
end

function cc.Node.addTo(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_3 then
		arg_2_1:addChild(arg_2_0, arg_2_2, arg_2_3)
	elseif arg_2_2 then
		arg_2_1:addChild(arg_2_0, arg_2_2)
	else
		arg_2_1:addChild(arg_2_0)
	end

	return arg_2_0
end

function cc.Node:removeSelf()
	self:removeFromParent()

	return self
end

function cc.Node:align(arg_4_1, arg_4_2, arg_4_3)
	self:setAnchorPoint(arg_4_1)

	return self:move(arg_4_2, arg_4_3)
end

function cc.Node:show()
	self:setVisible(true)

	return self
end

function cc.Node:hide()
	self:setVisible(false)

	return self
end

function cc.Node:move(arg_7_1, arg_7_2)
	if arg_7_2 then
		self:setPosition(arg_7_1, arg_7_2)
	else
		self:setPosition(arg_7_1)
	end

	return self
end

function cc.Node.moveTo(arg_8_0, arg_8_1)
	transition.moveTo(arg_8_0, arg_8_1)

	return arg_8_0
end

function cc.Node.moveBy(arg_9_0, arg_9_1)
	transition.moveBy(arg_9_0, arg_9_1)

	return arg_9_0
end

function cc.Node.fadeIn(arg_10_0, arg_10_1)
	transition.fadeIn(arg_10_0, arg_10_1)

	return arg_10_0
end

function cc.Node.fadeOut(arg_11_0, arg_11_1)
	transition.fadeOut(arg_11_0, arg_11_1)

	return arg_11_0
end

function cc.Node.fadeTo(arg_12_0, arg_12_1)
	transition.fadeTo(arg_12_0, arg_12_1)

	return arg_12_0
end

function cc.Node:rotate(arg_13_1)
	self:setRotation(arg_13_1)

	return self
end

function cc.Node.rotateTo(arg_14_0, arg_14_1)
	transition.rotateTo(arg_14_0, arg_14_1)

	return arg_14_0
end

function cc.Node.rotateBy(arg_15_0, arg_15_1)
	transition.rotateBy(arg_15_0, arg_15_1)

	return arg_15_0
end

function cc.Node.scaleTo(arg_16_0, arg_16_1)
	transition.scaleTo(arg_16_0, arg_16_1)

	return arg_16_0
end

function cc.Node:onUpdate(arg_17_1)
	self:scheduleUpdateWithPriorityLua(arg_17_1, 0)

	return self
end

cc.Node.scheduleUpdate = cc.Node.onUpdate

function cc.Node:onNodeEvent(arg_18_1, arg_18_2)
	if arg_18_1 == "enter" then
		self.onEnterCallback_ = arg_18_2
	elseif arg_18_1 == "exit" then
		self.onExitCallback_ = arg_18_2
	elseif arg_18_1 == "enterTransitionFinish" then
		self.onEnterTransitionFinishCallback_ = arg_18_2
	elseif arg_18_1 == "exitTransitionStart" then
		self.onExitTransitionStartCallback_ = arg_18_2
	elseif arg_18_1 == "cleanup" then
		self.onCleanupCallback_ = arg_18_2
	end

	self:enableNodeEvents()
end

function cc.Node:enableNodeEvents()
	if self.isNodeEventEnabled_ then
		return self
	end

	self:registerScriptHandler(function(arg_20_0)
		if arg_20_0 == "enter" then
			self:onEnter_()
		elseif arg_20_0 == "exit" then
			self:onExit_()
		elseif arg_20_0 == "enterTransitionFinish" then
			self:onEnterTransitionFinish_()
		elseif arg_20_0 == "exitTransitionStart" then
			self:onExitTransitionStart_()
		elseif arg_20_0 == "cleanup" then
			self:onCleanup_()
		end
	end)

	self.isNodeEventEnabled_ = true

	return self
end

function cc.Node:disableNodeEvents()
	self:unregisterScriptHandler()

	self.isNodeEventEnabled_ = false

	return self
end

function cc.Node.onEnter(arg_22_0)
	return
end

function cc.Node.onExit(arg_23_0)
	return
end

function cc.Node.onEnterTransitionFinish(arg_24_0)
	return
end

function cc.Node.onExitTransitionStart(arg_25_0)
	return
end

function cc.Node.onCleanup(arg_26_0)
	return
end

function cc.Node:onEnter_()
	self:onEnterComp()
	self:onEnter()

	if not self.onEnterCallback_ then
		return
	end

	self:onEnterCallback_()
end

function cc.Node:onExit_()
	self:onExitComp()
	self:onExit()

	if not self.onExitCallback_ then
		return
	end

	self:onExitCallback_()
end

function cc.Node:onEnterTransitionFinish_()
	self:onEnterTransitionFinish()

	if not self.onEnterTransitionFinishCallback_ then
		return
	end

	self:onEnterTransitionFinishCallback_()
end

function cc.Node:onExitTransitionStart_()
	self:onExitTransitionStart()

	if not self.onExitTransitionStartCallback_ then
		return
	end

	self:onExitTransitionStartCallback_()
end

function cc.Node:onCleanup_()
	self:onCleanup()

	if not self.onCleanupCallback_ then
		return
	end

	self:onCleanupCallback_()
end

function cc.Node:onEnterComp()
	if not self.__components then
		return
	end

	for iter_32_0, iter_32_1 in ipairs(self.__components) do
		if iter_32_1.onEnter then
			iter_32_1:onEnter()
		end
	end
end

function cc.Node:onExitComp()
	if not self.__components then
		return
	end

	for iter_33_0, iter_33_1 in ipairs(self.__components) do
		if iter_33_1.onExit then
			iter_33_1:onExit()
		end
	end
end

function cc.Node:addComp(arg_34_1, arg_34_2)
	local var_34_0 = self.__components or {}

	self.__components = var_34_0

	if arg_34_2 then
		arg_34_1:setName(arg_34_2)
	end

	var_34_0[#var_34_0 + 1] = arg_34_1
end

function cc.Node:getComp(arg_35_1)
	if not self.__components then
		return
	end

	local var_35_0 = self.__components

	if not arg_35_1 then
		return var_35_0[1]
	end

	for iter_35_0, iter_35_1 in ipairs(var_35_0) do
		if iter_35_1:getName() == arg_35_1 then
			return iter_35_1
		end
	end
end

function cc.Node:removeComp(arg_36_1)
	if not self.__components then
		return
	end

	local var_36_0 = self.__components

	if not arg_36_1 then
		table.remove(var_36_0, 1)

		return
	end

	for iter_36_0, iter_36_1 in ipairs(var_36_0) do
		if iter_36_1:getName() == arg_36_1 then
			table.remove(var_36_0, iter_36_0)

			return
		end
	end
end

function cc.Node.getWidget(arg_37_0, arg_37_1)
	assert(type(arg_37_1) == "string", "Error: Widget name must be string !")

	local var_37_0 = ccui.Helper:seekNodeByName(arg_37_0, arg_37_1)

	assert(var_37_0, "Error: Widget for \"" .. arg_37_1 .. "\" is not exist!")

	return var_37_0
end

local var_0_0 = {
	BUTTON = "Button",
	RADIOBUTTONGROUP = "RadioButtonGroup",
	IMAGE = "ImageView",
	RICHTEXT = "RichText",
	LAYOUT = "Layout",
	SLIDER = "Slider",
	LABEL = "Label",
	WIDGET = "Widget",
	RADIOBUTTON = "RadioButton",
	SCROLLVIEW = "ScrollView",
	TEXTFIELD = "TextField",
	PAGEVIEW = "PageView",
	LOADINGBAR = "LoadingBar",
	CHECKBOX = "CheckBox"
}

local function var_0_1(arg_38_0, arg_38_1)
	if arg_38_0 ~= nil then
		assert(type(arg_38_0) == tostring(arg_38_1), "Error: Invalid params ! params must be \"" .. arg_38_1 .. "\" !")
	end
end

function cc.Node:setProperties(arg_39_1, arg_39_2)
	assert(type(arg_39_1) == "string", "Error: Widget name must be string !")
	var_0_1(arg_39_2, "table")

	local var_39_0 = ccui.Helper:seekNodeByName(self, arg_39_1)

	assert(var_39_0, "Error: Widget for \"" .. arg_39_1 .. "\" is not exist!")

	if table.nums(arg_39_2) > 0 then
		local var_39_1 = self:getWidgetTypeString(var_39_0)

		if var_39_1 == var_0_0.LABEL then
			self:setPropertyWithUpdateLabel(var_39_0, arg_39_2)
		elseif var_39_1 == var_0_0.LAYOUT then
			self:setPropertyWithUpdatePanel(var_39_0, arg_39_2)
		elseif var_39_1 == var_0_0.IMAGE then
			self:setPropertyWithUpdateImage(var_39_0, arg_39_2)
		elseif var_39_1 == var_0_0.BUTTON then
			self:setPropertyWithUpdateButton(var_39_0, arg_39_2)
		elseif var_39_1 == var_0_0.CHECKBOX then
			self:setPropertyWithUpdateCheckBox(var_39_0, arg_39_2)
		elseif var_39_1 == var_0_0.LOADINGBAR then
			self:setPropertyWithUpdateLoadingBar(var_39_0, arg_39_2)
		elseif var_39_1 == var_0_0.TEXTFIELD then
			self:setPropertyWithUpdateTextField(var_39_0, arg_39_2)
		elseif var_39_1 == var_0_0.RADIOBUTTON then
			self:setPropertyWithUpdateRadioButton(var_39_0, arg_39_2)
		elseif var_39_1 == var_0_0.RADIOBUTTONGROUP then
			self:setPropertyWithUpdateRadioButtonGroup(var_39_0, arg_39_2)
		elseif var_39_1 == var_0_0.RICHTEXT then
			self:setPropertyWithUpdateRichText(var_39_0, arg_39_2)
		elseif var_39_1 == var_0_0.SLIDER then
			self:setPropertyWithUpdateSlider(var_39_0, arg_39_2)
		elseif var_39_1 == var_0_0.WIDGET or var_39_1 == var_0_0.SCROLLVIEW or var_39_1 == var_0_0.PAGEVIEW then
			self:setPropertyWithUpdateWidget(var_39_0, arg_39_2)
		end
	end
end

function cc.Node.getWidgetTypeString(arg_40_0, arg_40_1)
	return (arg_40_1:getDescription())
end

function cc.Node.setPropertyWithUpdateWidget(arg_41_0, arg_41_1, arg_41_2)
	if arg_41_2.visible ~= nil then
		var_0_1(arg_41_2.visible, "boolean")
		arg_41_1:setVisible(arg_41_2.visible)
	end

	if arg_41_2.touchEnabled ~= nil then
		var_0_1(arg_41_2.touchEnabled, "boolean")
		arg_41_1:setTouchEnabled(arg_41_2.touchEnabled)
	end

	if arg_41_2.x ~= nil and arg_41_2.y ~= nil then
		var_0_1(arg_41_2.x, "number")
		var_0_1(arg_41_2.y, "number")
		arg_41_1:setPosition({
			x = arg_41_2.x,
			y = arg_41_2.y
		})
	elseif arg_41_2.x ~= nil then
		var_0_1(arg_41_2.x, "number")
		arg_41_1:setPositionX(arg_41_2.x)
	elseif arg_41_2.y ~= nil then
		var_0_1(arg_41_2.y, "number")
		arg_41_1:setPositionY(arg_41_2.y)
	end

	if arg_41_2.size ~= nil then
		var_0_1(arg_41_2.size, "table")
		arg_41_1:setSize(arg_41_2.size)
	end

	if arg_41_2.anchor ~= nil then
		var_0_1(arg_41_2.anchor, "table")
		arg_41_1:setAnchorPoint(arg_41_2.anchor)
	end

	if arg_41_2.scaleX ~= nil then
		var_0_1(arg_41_2.scaleX, "number")
		arg_41_1:setScaleX(arg_41_2.scaleX)
	end

	if arg_41_2.scaleY ~= nil then
		var_0_1(arg_41_2.scaleY, "number")
		arg_41_1:setScaleY(arg_41_2.scaleY)
	end

	if arg_41_2.scale ~= nil then
		var_0_1(arg_41_2.scale, "number")
		arg_41_1:setScale(arg_41_2.scale)
	end

	if arg_41_2.flipX ~= nil then
		var_0_1(arg_41_2.flipX, "boolean")
		arg_41_1:setFlippedX(arg_41_2.flipX)
	end

	if arg_41_2.flipY ~= nil then
		var_0_1(arg_41_2.flipY, "boolean")
		arg_41_1:setFlippedY(arg_41_2.flipY)
	end

	if arg_41_2.zOrder ~= nil then
		var_0_1(arg_41_2.zOrder, "number")
		arg_41_1:setLocalZOrder(arg_41_2.zOrder)
	end

	if arg_41_2.opacity ~= nil then
		var_0_1(arg_41_2.opacity, "number")
		arg_41_1:setOpacity(arg_41_2.opacity)
	end

	if arg_41_2.posPercent ~= nil then
		var_0_1(arg_41_2.posPercent, "table")
		arg_41_1:setPositionPercent(arg_41_2.posPercent)
	end

	if arg_41_2.ignoreContentAdapt ~= nil then
		var_0_1(arg_41_2.ignoreContentAdapt, "boolean")
		arg_41_1:ignoreContentAdaptWithSize(arg_41_2.ignoreContentAdapt)
	end
end

function cc.Node:setPropertyWithUpdateLabel(arg_42_1, arg_42_2)
	self:setPropertyWithUpdateWidget(arg_42_1, arg_42_2)

	if arg_42_2.text ~= nil then
		var_0_1(arg_42_2.text, "string")
		arg_42_1:setString(arg_42_2.text)
	end

	if arg_42_2.clr ~= nil then
		var_0_1(arg_42_2.clr, "table")
		arg_42_1:setTextColor(arg_42_2.clr)
	end
end

function cc.Node:setPropertyWithUpdatePanel(arg_43_1, arg_43_2)
	self:setPropertyWithUpdateWidget(arg_43_1, arg_43_2)

	local var_43_0 = arg_43_2.texType or ccui.TextureResType.localType

	if arg_43_2.doLayout ~= nil then
		var_0_1(arg_43_2.doLayout, "boolean")

		if arg_43_2.doLayout then
			arg_43_1:requestDoLayout()
		end
	end

	if arg_43_2.bg ~= nil then
		var_0_1(arg_43_2.bg, "string")
		arg_43_1:setBackGroundImage(arg_43_2.bg, var_43_0)
	end

	if arg_43_2.clr ~= nil then
		var_0_1(arg_43_2.clr, "table")
		arg_43_1:setBackGroundColor(arg_43_2.clr)
	end

	if arg_43_2.bgOpacity ~= nil then
		var_0_1(arg_43_2.bgOpacity, "number")
		arg_43_1:setBackGroundColorOpacity(arg_43_2.bgOpacity)
	end
end

function cc.Node:setPropertyWithUpdateImage(arg_44_1, arg_44_2)
	self:setPropertyWithUpdateWidget(arg_44_1, arg_44_2)

	if arg_44_2.texture ~= nil then
		var_0_1(arg_44_2.texture, "string")
		arg_44_1:loadTexture(arg_44_2.texture, arg_44_2.texType or ccui.TextureResType.localType)
	end
end

function cc.Node:setPropertyWithUpdateButton(arg_45_1, arg_45_2)
	self:setPropertyWithUpdateWidget(arg_45_1, arg_45_2)

	local var_45_0 = arg_45_2.texType or ccui.TextureResType.localType

	if arg_45_2.title ~= nil then
		var_0_1(arg_45_2.title, "string")
		arg_45_1:setTitleText(arg_45_2.title)
	end

	if arg_45_2.titleColor ~= nil then
		var_0_1(arg_45_2.titleColor, "table")
		arg_45_1:setTitleColor(arg_45_2.titleColor)
	end

	if arg_45_2.titleSize ~= nil then
		var_0_1(arg_45_2.titleSize, "number")
		arg_45_1:setTitleFontSize(arg_45_2.titleSize)
	end

	if arg_45_2.normal ~= nil then
		var_0_1(arg_45_2.normal, "string")
		arg_45_1:loadTextureNormal(arg_45_2.normal, var_45_0)
	end

	if arg_45_2.select ~= nil then
		var_0_1(arg_45_2.select, "string")
		arg_45_1:loadTexturePressed(arg_45_2.select, var_45_0)
	end

	if arg_45_2.disable ~= nil then
		var_0_1(arg_45_2.disable, "string")
		arg_45_1:loadTextureDisabled(arg_45_2.disable, var_45_0)
	end

	if arg_45_2.pressedActionEnabled ~= nil then
		var_0_1(arg_45_2.pressedActionEnabled, "boolean")
		arg_45_1:setPressedActionEnabled(arg_45_2.pressedActionEnabled)
	end
end

function cc.Node:setPropertyWithUpdateCheckBox(arg_46_1, arg_46_2)
	self:setPropertyWithUpdateWidget(arg_46_1, arg_46_2)
end

function cc.Node:setPropertyWithUpdateLoadingBar(arg_47_1, arg_47_2)
	self:setPropertyWithUpdateWidget(arg_47_1, arg_47_2)

	local var_47_0 = arg_47_2.texType or ccui.TextureResType.localType

	if arg_47_2.percent ~= nil then
		var_0_1(arg_47_2.percent, "number")
		arg_47_1:setPercent(arg_47_2.percent)
	end

	if arg_47_2.direction ~= nil then
		var_0_1(arg_47_2.direction, "number")
		arg_47_1:setDirection(arg_47_2.direction)
	end

	if arg_47_2.texture ~= nil then
		var_0_1(arg_47_2.texture, "string")
		arg_47_1:loadTexture(arg_47_2.texture, var_47_0)
	end

	if arg_47_2.blurTexture ~= nil then
		var_0_1(arg_47_2.blurTexture, "string")
		arg_47_1:loadModificationTexture(arg_47_2.blurTexture, 0, true)
	end

	if arg_47_2.blur ~= nil then
		if arg_47_2.action ~= nil then
			arg_47_1:setModificationVisible(arg_47_2.blur, arg_47_2.action)
		end
	end

	if arg_47_2.modifyPercent ~= nil then
		var_0_1(arg_47_2.modifyPercent, "number")
		arg_47_1:setModificationPercent(arg_47_2.modifyPercent)
	end
end

function cc.Node:setPropertyWithUpdateTextField(arg_48_1, arg_48_2)
	self:setPropertyWithUpdateWidget(arg_48_1, arg_48_2)

	if arg_48_2.text ~= nil then
		var_0_1(arg_48_2.text, "string")
		arg_48_1:setString(arg_48_2.text)
	end

	if arg_48_2.textColor ~= nil then
		var_0_1(arg_48_2.textColor, "table")
		arg_48_1:setTextColor(arg_48_2.textColor)
	end

	if arg_48_2.fontSize ~= nil then
		var_0_1(arg_48_2.fontSize, "number")
		arg_48_1:setFontSize(arg_48_2.fontSize)
	end

	if arg_48_2.maxLengthEnabled ~= nil then
		arg_48_1:setMaxLengthEnabled(checkbool(arg_48_2.maxLengthEnabled))

		if arg_48_2.maxLengthEnabled and arg_48_2.maxLength ~= nil then
			var_0_1(arg_48_2.maxLength, "number")
			arg_48_1:setMaxLength(arg_48_2.maxLength)
		end
	end

	if arg_48_2.placeHolder ~= nil then
		var_0_1(arg_48_2.placeHolder, "string")
		arg_48_1:setPlaceHolder(arg_48_2.placeHolder)
	end

	if arg_48_2.placeHolderColor ~= nil then
		var_0_1(arg_48_2.placeHolderColor, "table")
		arg_48_1:setPlaceHolderColor(arg_48_2.placeHolderColor)
	end
end

function cc.Node:setPropertyWithUpdateRadioButton(arg_49_1, arg_49_2)
	self:setPropertyWithUpdateWidget(arg_49_1, arg_49_2)
end

function cc.Node:setPropertyWithUpdateRadioButtonGroup(arg_50_1, arg_50_2)
	self:setPropertyWithUpdateWidget(arg_50_1, arg_50_2)
end

function cc.Node:setPropertyWithUpdateRichText(arg_51_1, arg_51_2)
	self:setPropertyWithUpdateWidget(arg_51_1, arg_51_2)
end

function cc.Node:setPropertyWithUpdateSlider(arg_52_1, arg_52_2)
	self:setPropertyWithUpdateWidget(arg_52_1, arg_52_2)

	local var_52_0 = arg_52_2.texType or ccui.TextureResType.localType

	if arg_52_2.bar ~= nil then
		var_0_1(arg_52_2.bar, "string")
		arg_52_1:loadBarTexture(arg_52_2.bar, var_52_0)
	end

	if arg_52_2.progressBar ~= nil then
		var_0_1(arg_52_2.progressBar, "string")
		arg_52_1:loadProgressBarTexture(arg_52_2.progressBar, var_52_0)
	end

	if arg_52_2.ballNormal ~= nil and arg_52_2.ballPress ~= nil and arg_52_2.ballDisable then
		var_0_1(arg_52_2.ballNormal, "string")
		var_0_1(arg_52_2.ballPress, "string")
		var_0_1(arg_52_2.ballDisable, "string")
		arg_52_1:loadSlidBallTextures(arg_52_2.ballNormal, arg_52_2.ballPress, arg_52_2.ballDisable, var_52_0)
	else
		if arg_52_2.ballNormal ~= nil then
			var_0_1(arg_52_2.ballNormal, "string")
			arg_52_1:loadSlidBallTextureNormal(arg_52_2.ballNormal, var_52_0)
		end

		if arg_52_2.ballPress ~= nil then
			var_0_1(arg_52_2.ballPress, "string")
			arg_52_1:loadSlidBallTexturePressed(arg_52_2.ballPress, var_52_0)
		end

		if arg_52_2.ballDisable ~= nil then
			var_0_1(arg_52_2.ballDisable, "string")
			arg_52_1:loadSlidBallTextureDisabled(arg_52_2.ballDisable, var_52_0)
		end
	end

	if arg_52_2.percent ~= nil then
		var_0_1(arg_52_2.percent, "number")
		arg_52_1:setPercent(arg_52_2.percent)
	end

	if arg_52_2.maxPercent ~= nil then
		var_0_1(arg_52_2.maxPercent, "number")
		arg_52_1:setMaxPercent(arg_52_2.maxPercent)
	end
end

function cc.Node:getWidgetComp(arg_53_1)
	return self:getWidget(arg_53_1):getComp()
end
