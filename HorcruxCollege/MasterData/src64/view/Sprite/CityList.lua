local var_0_0 = math.abs
local var_0_1 = math.pow
local var_0_3 = math.min
local tween = require("fight.tween")
local CityList = class("CityList", function()
	return ccui.Layout:create()
end)
local var_0_6 = 130
local var_0_7 = 60
local var_0_8 = 100
local var_0_9 = 1000

function CityList:create()
	local var_2_0 = CityList.new()

	var_2_0:init()

	return var_2_0
end

function CityList:ctor()
	self:setContentSize(cc.size(528, 140))
	self:setPosition(cc.p(112, 64))
	self:setTouchEnabled(false)

	self._initposy = 0
	self._container = nil
	self._curselected = nil
	self._slidtime = 0
	self._pressed = false
	self._is_quick_slide = false
	self._autoscroll = false
	self._autoscrollaction = nil
	self._autoscrollpos = nil
	self._scrollEnabled = true
	self._cities = {}
	self._selectcityHandler = nil
end

function CityList:init()
	self:initInnerContainer()
	self:registerTouchEvent()
	self:registerUpdateEvent()
end

function CityList:setCityInitPosY(arg_5_1)
	self._initposy = arg_5_1
end

function CityList:initInnerContainer()
	self._container = cc.Node:create()

	self._container:setPosition(cc.p(0, 0))
	self:addChild(self._container, -1)
end

function CityList:registerUpdateEvent()
	self:scheduleUpdateWithPriorityLua(function(arg_8_0)
		self:autoScroll(arg_8_0)
		self:recordSlidTime(arg_8_0)
	end, 0)
end

local function var_0_10(arg_9_0)
	if not arg_9_0 then
		return true
	end

	local var_9_0 = arg_9_0:getParent()

	if var_9_0 and not var_9_0:isVisible() then
		return false
	end

	return var_0_10(var_9_0)
end

function CityList:registerTouchEvent()
	local var_10_0 = cc.EventListenerTouchOneByOne:create()

	var_10_0:setSwallowTouches(false)
	var_10_0:registerScriptHandler(function(arg_11_0, arg_11_1)
		if not self:checkTouchEnabled() then
			return false
		end

		if not var_0_10(self) then
			return false
		end

		if cc.rectContainsPoint(cc.rect(0, 64, 640, 140), (arg_11_0:getLocation())) then
			self:handlePressLogic(arg_11_0)

			return true
		else
			return false
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_10_0:registerScriptHandler(function(arg_12_0, arg_12_1)
		if not self:checkTouchEnabled() then
			return
		end

		self:handleMoveLogic(arg_12_0)
	end, cc.Handler.EVENT_TOUCH_MOVED)
	var_10_0:registerScriptHandler(function(arg_13_0, arg_13_1)
		if not self:checkTouchEnabled() then
			return
		end

		self:handleReleaseLogic(arg_13_0)
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_10_0:registerScriptHandler(function(arg_14_0, arg_14_1)
		self:handleReleaseLogic(arg_14_0)
	end, cc.Handler.EVENT_TOUCH_CANCELLED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_10_0, self)
end

function CityList:checkTouchEnabled()
	if not self._container then
		return false
	end

	if not self._curselected then
		return false
	end

	if not self._scrollEnabled then
		return false
	end

	if self._autoscroll then
		return false
	end

	return true
end

function CityList:handlePressLogic(arg_16_1)
	self:startRecordSlidAction()

	self._pressed = true
end

function CityList:handleMoveLogic(arg_17_1)
	local var_17_0 = arg_17_1:getLocation().x - arg_17_1:getPreviousLocation().x

	if self._is_quick_slide == false then
		self:scrollChildren(var_17_0)
	else
		self:endRecordSlidAction(var_17_0)
	end
end

function CityList:handleReleaseLogic(arg_18_1)
	if self._is_quick_slide == false then
		self:endRecordSlidAction(arg_18_1:getLocation().x - arg_18_1:getStartLocation().x)
	end

	self._pressed = false
end

function CityList:startRecordSlidAction()
	self._slidtime = 0
end

function CityList:endRecordSlidAction(arg_20_1)
	if self._slidtime <= 0.016 then
		self._slidtime = 0

		self:scrollToIndex(self._curselected)

		return
	end

	local var_20_0

	if arg_20_1 > 0 then
		var_20_0 = 1
	elseif arg_20_1 < 0 then
		var_20_0 = -1
	end

	if not var_20_0 then
		self._slidtime = 0

		self:scrollToIndex(self._curselected)

		return
	end

	if var_0_0(arg_20_1 + var_20_0 * (var_0_1(var_0_3(var_0_0(arg_20_1) / self._slidtime, var_0_9), 2) / 2000)) >= var_0_6 / 2 then
		self._slidtime = 0

		local var_20_1 = self._curselected - var_20_0

		if self._curselected - var_20_0 < 1 then
			var_20_1 = 1
		end

		if var_20_1 > #self._cities then
			var_20_1 = #self._cities
		end

		self:scrollToIndex(var_20_1)
	else
		self._slidtime = 0

		self:scrollToIndex(self._curselected)
	end
end

function CityList:recordSlidTime(arg_21_1)
	if self._pressed then
		self._slidtime = self._slidtime + arg_21_1
	end
end

function CityList:scrollChildren(arg_22_1)
	local var_22_0 = arg_22_1
	local var_22_1 = self._container:getPositionX()
	local var_22_2 = self:getScrollLeftBound()

	if var_22_2 < var_22_1 + arg_22_1 then
		var_22_0 = var_22_2 - var_22_1
	end

	local var_22_3 = self:getScrollRightBound()

	self:moveChildren((var_22_3 > var_22_1 + arg_22_1 or nil) and var_22_3 - var_22_1)
end

function CityList:moveChildren(arg_23_1)
	if self._is_quick_slide == true then
		return
	end

	self._container:setPositionX(self._container:getPositionX() + arg_23_1)
	self:updateCitiesYZ()
end

function CityList:getScrollLeftBound()
	return (1 - ((self._curselected - 1 > 0 or nil) and (self._curselected - 1 or 1))) * var_0_6
end

function CityList:getScrollRightBound()
	return (1 - ((self._curselected + 1 <= #self._cities or nil) and (self._curselected + 1 or #self._cities))) * var_0_6
end

local var_0_11 = 22 / math.pow(130, 2)

local function var_0_12(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:getPositionX() + arg_26_0:getParent():getPositionX()

	if var_26_0 <= -30 or var_26_0 >= 230 then
		if var_26_0 <= -30 then
			arg_26_0:setLocalZOrder(arg_26_1)
		else
			arg_26_0:setLocalZOrder(100 - arg_26_1)
		end

		arg_26_0:setPositionY(var_0_7)
	else
		if var_26_0 < 165 and var_26_0 > 35 then
			arg_26_0:setLocalZOrder(100)
		elseif var_26_0 >= 165 then
			arg_26_0:setLocalZOrder(100 - arg_26_1)
		elseif var_26_0 <= 35 then
			arg_26_0:setLocalZOrder(arg_26_1)
		end

		arg_26_0:setPositionY(var_0_7 + (var_26_0 <= 100 and 11 * var_26_0 / 65 - 5.076923076923077 or -11 * var_26_0 / 65 + 38.92307692307692))
	end
end

function CityList:updateCitiesYZ()
	if self._is_quick_slide == false then
		for iter_27_0, iter_27_1 in ipairs(self._cities) do
			var_0_12(iter_27_1, iter_27_0)
		end
	else
		for iter_27_2, iter_27_3 in ipairs(self._cities) do
			var_0_12(iter_27_3, iter_27_2)
			iter_27_3:setPositionY(var_0_7 + self._initposy)
			iter_27_3:setLocalZOrder(100 - math.abs(self._curselected - iter_27_2))
		end
	end
end

function CityList:pushInCity(arg_28_1)
	arg_28_1:setPositionX(var_0_8 + (#self._cities + 1 - 1) * var_0_6)
	self._container:addChild(arg_28_1, 100 - (#self._cities + 1))
	var_0_12(arg_28_1, #self._cities + 1)

	if self._is_quick_slide == true then
		arg_28_1:setPositionY(var_0_7 + self._initposy)
	end

	self._cities[#self._cities + 1] = arg_28_1

	arg_28_1:setTag(#self._cities + 1)

	self._curselected = self._curselected or #self._cities + 1
end

function CityList:scrollToIndex(arg_29_1)
	local var_29_0 = (1 - arg_29_1) * var_0_6

	if self._is_quick_slide == true then
		var_29_0 = (1 - arg_29_1) * var_0_6 - 100
	end

	if var_0_0(var_29_0 - self._container:getPositionX()) <= var_0_6 / 10 then
		self._container:setPositionX(var_29_0)
		self:updateCitiesYZ()
	else
		self:startAutoScrollChildren(var_29_0)
	end

	self._curselected = arg_29_1

	if self._is_quick_slide == true then
		self:updateCitiesProperties()
	end

	if self._selectcityHandler then
		self._selectcityHandler(arg_29_1)
	end
end

function CityList:scrollToIndexManual(arg_30_1)
	if arg_30_1 == self._curselected then
		return
	end

	if not self:checkTouchEnabled() then
		return
	end

	self:scrollToIndex(arg_30_1)
end

function CityList:jumpToIndex(arg_31_1)
	self._container:setPositionX((self._is_quick_slide == true or nil) and (1 - arg_31_1) * var_0_6 - 100)
	self:updateCitiesYZ()

	self._curselected = arg_31_1

	if self._is_quick_slide == true then
		self:updateCitiesProperties()

		if self._selectcityHandler then
			self._selectcityHandler(arg_31_1)
		end
	end
end

function CityList:updateCitiesProperties()
	for iter_32_0 = 1, #self._cities do
		local var_32_0 = self._cities[iter_32_0]

		if math.abs(self._curselected - iter_32_0) == 2 then
			var_32_0:setScale(0.65)
			var_32_0:setOpacity(153)
		elseif math.abs(self._curselected - iter_32_0) == 1 then
			var_32_0:setScale(0.8)
			var_32_0:setOpacity(153)
		elseif self._curselected == iter_32_0 then
			var_32_0:setScale(1)
			var_32_0:setOpacity(255)
		else
			var_32_0:setScale(0.65)
			var_32_0:setOpacity(153)
		end

		var_32_0:setLocalZOrder(100 - math.abs(self._curselected - iter_32_0))
	end
end

function CityList:autoScroll(arg_33_1)
	if self._autoscroll then
		if self._autoscrollaction:update(arg_33_1) then
			self:endAutoScrollChildren()
		end

		self._container:setPositionX(self._autoscrollpos.pos)
		self:updateCitiesYZ()
	end
end

function CityList:startAutoScrollChildren(arg_34_1)
	self._autoscroll = true
	self._autoscrollpos = {
		pos = self._container:getPositionX()
	}
	self._autoscrollaction = tween.new(0.1, self._autoscrollpos, {
		pos = arg_34_1
	}, "outQuad")
end

function CityList:endAutoScrollChildren()
	self._autoscroll = false
	self._autoscrollaction = nil
end

function CityList:setScrollEnabled(arg_36_1)
	self._scrollEnabled = arg_36_1
end

function CityList:registerSelectCityHandler(arg_37_1)
	self._selectcityHandler = arg_37_1
end

function CityList:getCityBtnDirection(arg_38_1)
	if arg_38_1 < self._curselected - 1 then
		return 1
	elseif arg_38_1 > self._curselected + 2 then
		return 2
	else
		return 3
	end
end

function CityList:openSlideMode(arg_39_1)
	self._is_quick_slide = arg_39_1
end

function CityList:getCityNumber()
	return #self._cities
end

return CityList
