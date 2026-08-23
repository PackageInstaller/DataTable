local var_0_0 = table.insert
local var_0_1 = table.remove

function fgui.GObject:bindLua(arg_1_1, arg_1_2)
	fgui.UIPackage.iterObject(self)
	fgui.UIPackage.bindUIComponent(self, arg_1_1, arg_1_2 or self:getParent())
end

function fgui.GObject:addNode(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = self:displayObject()

	if not arg_2_2 and self.numChildren then
		arg_2_2 = self:numChildren()
	end

	arg_2_2 = arg_2_2 or 0

	var_2_0:addChild(arg_2_1, arg_2_2)

	if arg_2_3 and arg_2_3 ~= "" then
		var_2_0:setName(arg_2_3)
	end
end

function fgui.GObject:getNode(arg_3_1)
	local var_3_0 = self:displayObject():getChildByName(arg_3_1)

	assert(var_3_0, "Could not find the node with name: " .. tostring(arg_3_1))

	return var_3_0
end

function fgui.GObject:removeNode(arg_4_1)
	self:displayObject():removeChildByName(arg_4_1)
end

function fgui.GObject:removeNodeByTag(arg_5_1)
	self:displayObject():removeChildByTag(arg_5_1)
end

function fgui.GObject:runAction(arg_6_1)
	self:displayObject():runAction(arg_6_1)
end

function fgui.GObject:stopAction(arg_7_1)
	self:displayObject():stopAction(arg_7_1)
end

function fgui.GObject:stopAllActions()
	self:displayObject():stopAllActions()
end

function fgui.GObject:stopActionByTag(arg_9_1)
	self:displayObject():stopActionByTag(arg_9_1)
end

function fgui.GObject:runFAction(arg_10_1)
	local var_10_0 = cc.Director:getInstance():getAnimationInterval()

	self.__factions = self.__factions or {}

	var_0_0(self.__factions, arg_10_1)
	arg_10_1:startWithTarget(self)
end

function fgui.GObject.stopFAction(arg_11_0, arg_11_1)
	arg_11_1:stop()
end

function fgui.GObject:stopAllFAction()
	if not self.__factions then
		return
	end

	for iter_12_0, iter_12_1 in ipairs(self.__factions) do
		iter_12_1:stop()
	end
end

function fgui.GObject:scheduleUpdate(arg_13_1)
	assert(not arg_13_1 or type(arg_13_1) == "number", "Invalid interval: " .. tostring(arg_13_1))
	assert(not self.__scheduleUpdated, "DO NOT repeat schedule update !")

	self.__interval = arg_13_1 or 0
	self.__scheduleUpdated = true

	self:displayObject():scheduleUpdateWithPriorityLua(handler(self, self._doScheduleUpdate), 0)
end

function fgui.GObject:unscheduleUpdate()
	if self.__scheduleUpdated then
		self:displayObject():unscheduleUpdate()

		self.__scheduleUpdated = false
	end
end

function fgui.GObject.onScheduleUpdate(arg_15_0, arg_15_1, arg_15_2)
	return
end

function fgui.GObject:newSchedule(arg_16_1, arg_16_2, arg_16_3)
	assert(type(arg_16_1) == "function", "Invalid callback: " .. tostring(arg_16_1))

	if not self.__scheduleHandlers then
		self:addEventListener(fgui.UIEventType.ExitFinish, function()
			self:cancelAllSchedule()
		end, 10000)
	end

	self.__scheduleHandlers = self.__scheduleHandlers or {}

	if not self.__scheduleUpdated then
		self.__scheduleUpdated = true

		self:displayObject():scheduleUpdateWithPriorityLua(handler(self, self._doScheduleUpdate), 0)
	end

	self.__scheduleIndex = self.__scheduleIndex or 0
	self.__scheduleIndex = self.__scheduleIndex + 1

	local var_16_0 = tostring(self.__scheduleIndex)

	if not self.__inSchedule then
		self.__scheduleHandlers[var_16_0] = {
			callback = arg_16_1,
			interval = arg_16_2 or 0,
			identity = arg_16_3
		}
	else
		self.__waitScheduleHandlers = self.__waitScheduleHandlers or {}
		self.__waitScheduleHandlers[var_16_0] = {
			callback = arg_16_1,
			interval = arg_16_2 or 0,
			identity = arg_16_3
		}
	end

	return var_16_0
end

function fgui.GObject:newScheduleOnce(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = self:newSchedule(arg_18_1, arg_18_2, arg_18_3)

	;(self.__scheduleHandlers[var_18_0] or self.__waitScheduleHandlers[var_18_0]).once = true

	return var_18_0
end

function fgui.GObject:newScheduleInterval(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = self:newSchedule(arg_19_1, arg_19_2, arg_19_4)
	local var_19_1 = self.__scheduleHandlers[var_19_0] or self.__waitScheduleHandlers[var_19_0]

	var_19_1.autorelease = true
	var_19_1.duration = arg_19_3

	return var_19_0
end

function fgui.GObject:cancelSchedule(arg_20_1)
	if self.__scheduleHandlers and self.__scheduleHandlers[arg_20_1] then
		self.__scheduleHandlers[arg_20_1] = nil
	end

	if self.__waitScheduleHandlers and self.__waitScheduleHandlers[arg_20_1] then
		self.__waitScheduleHandlers[arg_20_1] = nil
	end
end

function fgui.GObject:cancelAllSchedule()
	self.__scheduleHandlers = nil
	self.__waitScheduleHandlers = nil

	self:removeEventListener(fgui.UIEventType.ExitFinish, 10000)
end

function fgui.GObject:isScheduled(arg_22_1)
	assert(arg_22_1 and type(arg_22_1) ~= "boolean", "Invalid identity: " .. tostring(arg_22_1))

	for iter_22_0, iter_22_1 in ipairs(self.__scheduleHandlers) do
		if iter_22_1.identity == arg_22_1 then
			return true
		end
	end

	for iter_22_2, iter_22_3 in ipairs(self.__waitScheduleHandlers) do
		if iter_22_3.identity == arg_22_1 then
			return true
		end
	end

	return false
end

function fgui.GObject:addEffectSpine(arg_23_1)
	if arg_23_1 == nil then
		return
	end

	local var_23_0
	local var_23_1 = true

	if arg_23_1.isLoop ~= nil then
		var_23_1 = arg_23_1.isLoop
	end

	local var_23_2 = require("app.view.common.SpineBase").new
	local var_23_3 = {
		resId = arg_23_1.name,
		path = g.core.common.Path:getEffSpine(arg_23_1.name)
	}

	var_23_3.anim = arg_23_1.anim or "play"
	var_23_3.isLoop = var_23_1

	function var_23_3:listener()
		if arg_23_1.eventHandler then
			arg_23_1.eventHandler(self, var_23_0)
		end

		if self.type == "complete" and arg_23_1.remove and var_23_1 == false then
			var_23_0:removeFromParent(true)
		end
	end

	var_23_0 = require("app.view.common.SpineBase").new(var_23_3)

	var_23_0:setScale((arg_23_1.scale or nil) and arg_23_1.scale)

	local var_23_5 = arg_23_1.localX or arg_23_1.x
	local var_23_6 = arg_23_1.localY or arg_23_1.y

	if var_23_5 and var_23_6 then
		var_23_0:setPosition(var_23_5, var_23_6)
	elseif var_23_5 then
		var_23_0:setPositionX(var_23_5)
	elseif var_23_6 then
		var_23_0:setPositionY(var_23_6)
	end

	self:addNode(var_23_0, arg_23_1.zorder)

	self.__effectContainers = self.__effectContainers or {}

	var_0_0(self.__effectContainers, var_23_0)

	return var_23_0
end

function fgui.GObject.addEffectSpineAsync(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	g.core.resource.ResourceManager:loadSpineEffectAsync({
		arg_25_1.name
	}, function(arg_26_0, arg_26_1)
		if arg_26_1 ~= nil and arg_26_1 == arg_25_1.name and not tolua.isnull(arg_25_0) then
			local var_26_0 = arg_25_0:addEffectSpine(arg_25_1)

			if var_26_0 then
				var_26_0:setOpacity(0)
				var_26_0:runAction(cc.FadeTo:create(0.2, (var_26_0:getOpacity())))
			end

			if arg_25_2 ~= nil then
				arg_25_2(var_26_0, arg_25_1)
			end
		end
	end, arg_25_1.name, arg_25_3)
end

function fgui.GObject:addCriSprite(arg_27_1, arg_27_2)
	if arg_27_1 == nil or not arg_27_1.movieName or not arg_27_1.moduleName then
		return
	end

	if not arg_27_1.x and not arg_27_1.y then
		arg_27_1.x = display.width / 2
		arg_27_1.y = display.height / 2
	end

	local var_27_0 = require("app.view.common.CriSprite").new(arg_27_1)

	var_27_0:setScaleX(((arg_27_1.scale or nil) and arg_27_1.scale) * (arg_27_1.isReverse and -1 or 1))

	if not self:hasEventListener(fgui.UIEventType.ExitFinish) then
		local var_27_2 = self:getParent()

		if var_27_2 then
			var_27_2:addListen(self)
		else
			print("视频：" .. arg_27_1.movieName .. "/" .. arg_27_1.moduleName .. " 存在内存泄漏！！！")
		end
	end

	self:addNode(var_27_0, arg_27_1.zOrder)

	if arg_27_1.isLoop then
		self.CRI_CONTAINERS = self.CRI_CONTAINERS or {}

		var_0_0(self.CRI_CONTAINERS, var_27_0)
	end

	return var_27_0
end

function fgui.GObject:removeAllEffect()
	if self.__effectContainers then
		for iter_28_0, iter_28_1 in ipairs(self.__effectContainers) do
			if not tolua.isnull(iter_28_1) then
				iter_28_1:removeFromParent()
			end
		end

		self.__effectContainers = nil
	end
end

function fgui.GObject:removeAllCriSprite()
	if self.CRI_CONTAINERS then
		for iter_29_0, iter_29_1 in ipairs(self.CRI_CONTAINERS) do
			if iter_29_1 and iter_29_1.dispose then
				iter_29_1:dispose()
			end
		end

		self.CRI_CONTAINERS = {}
	end
end

function fgui.GObject:containPoint(arg_30_1)
	local var_30_0 = self:displayObject()

	return cc.rectContainsPoint(cc.rect(0, 0, var_30_0.width, self:getSize().height), (var_30_0:convertToNodeSpace(arg_30_1)))
end

function fgui.GObject:_doScheduleUpdate(arg_31_1)
	self.__inSchedule = true

	self:_doScheduleHandler(arg_31_1)

	self.__elapsed = self.__elapsed or 0
	self.__elapsed = self.__elapsed + arg_31_1

	if self.__interval and self.__elapsed >= self.__interval then
		local var_31_0 = self.__interval == 0 and 1 or math.floor(self.__elapsed / self.__interval)

		if self.__factions and #self.__factions > 0 then
			self:_doUpdateActions(var_31_0)
		end

		self:onScheduleUpdate(self.__elapsed, var_31_0)

		self.__elapsed = self.__interval == 0 and 0 or self.__elapsed - self.__interval * var_31_0
	end

	self.__inSchedule = false
end

function fgui.GObject:_doScheduleHandler(arg_32_1)
	if not self.__scheduleHandlers then
		return
	end

	local var_32_0 = self.__scheduleHandlers

	for iter_32_0, iter_32_1 in pairs(self.__scheduleHandlers) do
		if tolua.isnull(self) then
			return
		end

		local var_32_1 = math.min(arg_32_1, math.max(iter_32_1.interval, 0.03) * 2)

		iter_32_1.total = iter_32_1.total or 0
		iter_32_1.total = iter_32_1.total + var_32_1
		iter_32_1.elapsed = iter_32_1.elapsed or 0
		iter_32_1.elapsed = iter_32_1.elapsed + var_32_1

		if iter_32_1.elapsed >= iter_32_1.interval then
			local var_32_2 = iter_32_1.interval == 0 and 1 or math.floor(iter_32_1.elapsed / iter_32_1.interval)

			if iter_32_1.autorelease then
				local var_32_3 = iter_32_1.total >= iter_32_1.duration

				iter_32_1.callback(var_32_2, iter_32_1.elapsed, iter_32_1.total >= iter_32_1.duration, iter_32_1.total)

				if var_32_3 then
					var_32_0[iter_32_0] = nil
				end
			else
				iter_32_1.callback(var_32_2, iter_32_1.elapsed)
			end

			if iter_32_1.once then
				var_32_0[iter_32_0] = nil
			else
				iter_32_1.elapsed = iter_32_1.interval == 0 and 0 or iter_32_1.elapsed - iter_32_1.interval * var_32_2
			end
		end
	end

	if self.__waitScheduleHandlers then
		table.merge(self.__scheduleHandlers, self.__waitScheduleHandlers)

		self.__waitScheduleHandlers = nil
	end
end

function fgui.GObject:_doUpdateActions(arg_33_1)
	local var_33_0 = 1

	repeat
		if not self.__factions[var_33_0]:isRunning() or self.__factions[var_33_0]:isDone() then
			var_0_1(self.__factions, var_33_0)
		else
			self.__factions[var_33_0]:step(arg_33_1)

			if not self.__factions[var_33_0]:isRunning() then
				var_0_1(self.__factions, var_33_0)
			else
				var_33_0 = var_33_0 + 1
			end
		end
	until var_33_0 > #self.__factions
end

local var_0_2 = fgui.GObject.setTextBase

fgui.GObject.__autoChange = true
fgui.GObject.__autoScale = false
fgui.GObject.__maxWidth = 0

function fgui.GObject:setText(arg_34_1, arg_34_2, arg_34_3)
	if string.match(arg_34_1, "[/color]") and self.enableRich then
		self:enableRich()
	end

	local var_34_0 = self:getName()

	if string.match(var_34_0, "name") or string.match(var_34_0, "Name") then
		self:disableAutoChange()
	end

	if arg_34_3 then
		self:disableAutoChange()
	end

	if self.__autoChange then
		arg_34_1 = g.core.utils.Number.transTextNumFormation(arg_34_1)
	end

	arg_34_1 = string.gsub(arg_34_1, "\t", "    ")

	if arg_34_2 then
		arg_34_1 = g.core.lang:getRealRichTxt(arg_34_1)
	end

	var_0_2(self, arg_34_1)

	if self.__autoScale then
		self:setScaleX(1)

		local var_34_1 = self:getWidth()

		if var_34_1 > self.__maxWidth then
			self:setScaleX(self.__maxWidth / var_34_1)
		end
	end

	self.__text = arg_34_1
end

function fgui.GObject:setScaleText(arg_35_1)
	self.__autoScale = true

	if self.__autoScale then
		self.__maxWidth = arg_35_1 or 196
	end
end

function fgui.GObject.disableAutoChange(arg_36_0)
	arg_36_0.__autoChange = false
end

fgui.GRichTextField.setText = fgui.GObject.setText

function fgui.GObject:runChangeAni(arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	arg_37_3 = arg_37_3 ~= nil and checkbool(arg_37_3) or true

	local var_37_0 = arg_37_2 - arg_37_1

	if arg_37_2 - arg_37_1 == 0 then
		return
	end

	arg_37_4 = arg_37_4 or ""

	local var_37_1 = 0
	local var_37_2 = 0.5

	self:newScheduleInterval(function(arg_38_0, arg_38_1)
		var_37_1 = var_37_1 + arg_38_1

		self:setText(table.concat({
			arg_37_4,
			(math.ceil(arg_37_1 + var_37_0 * (var_37_1 >= var_37_2 and 1 or var_37_1 / var_37_2)))
		}))
	end, 0, 0.5)

	if arg_37_3 then
		local var_37_3 = fgui.UIPackage:createObject("base", "BaseValueChange")

		var_37_3:update(var_37_0)
		g.core.layer.LayerManager:getSysTipLayer():addChild(var_37_3)

		local var_37_4 = self:localToGlobal(cc.p(self:getSize().width, 0))

		var_37_3:setPosition(var_37_4.x, var_37_4.y)
		var_37_3:runAni()
	end
end

function fgui.GObject.resetChangeAni(arg_39_0)
	return
end

function fgui.GObject:getColor()
	return self:getDisplayColor()
end

function fgui.GObject:setColor(arg_41_1)
	return self:setDisplayColor(arg_41_1)
end

local var_0_3 = fgui.GObject.setIcon

function fgui.GObject.setIcon(arg_42_0, arg_42_1)
	local var_42_0, var_42_1 = g.core.utils.Tools.getPngTextureFormat(arg_42_1)

	if var_42_0 then
		cc.Texture2D:setDefaultAlphaPixelFormat(var_42_1)
	end

	var_0_3(arg_42_0, arg_42_1)

	if var_42_0 then
		cc.Texture2D:setDefaultAlphaPixelFormat(cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888)
	end
end
