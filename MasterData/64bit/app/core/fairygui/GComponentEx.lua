local UITransitionMgr = import(".UITransitionMgr")
local var_0_1 = unpack
local var_0_2 = ipairs
local var_0_3 = table
local var_0_4 = table.insert
local var_0_5 = table.remove
local var_0_6 = handler(fgui.GComponent, fgui.GComponent.createBase)
local var_0_7 = fgui.GComponent.getBaseChild
local var_0_8 = fgui.GComponent.getBaseController
local var_0_9 = fgui.GComponent.addChildBase
local var_0_10 = fgui.GComponent.getTransition

function fgui.GComponent.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_6()

	var_1_0:setParams(arg_1_1, ...)

	if arg_1_1 then
		if arg_1_1.isFullScreen then
			var_1_0:setSize(display.width, display.height)
		end

		if arg_1_1.pkgPath then
			fgui.UIPackage:addPackage(arg_1_1.pkgPath)
		elseif arg_1_1.pkgName then
			fgui.UIPackage:addPackage(string.format("ui/%s/%s", arg_1_1.pkgName, arg_1_1.pkgName))
		end

		if arg_1_1.pkgName and arg_1_1.resName then
			local var_1_1 = fgui.UIPackage:createObject(arg_1_1.pkgName, arg_1_1.resName, var_1_0)

			var_1_0:addChild(var_1_1)

			if arg_1_1.isFullScreen then
				var_1_1:setSize(display.width, display.height)
			end

			var_1_0:setView(var_1_1)
			var_1_0:setName(arg_1_1.resName)
			var_1_1:setName("__view")
		end
	end

	return var_1_0
end

function fgui.GComponent.setParams(arg_2_0)
	arg_2_0.__params = {
		...
	}
end

function fgui.GComponent:getParams()
	return self.__params
end

function fgui.GComponent:onEnterFinish()
	local var_4_0 = 0

	if self.__classIndex then
		var_4_0 = self.__classIndex
		self.__classIndex = 0
	end

	if self.__onLoaded then
		return
	end

	self.__onLoaded = true

	if self.__classIndex then
		self.__classIndex = var_4_0
	end

	if self.__params then
		self:onLoad(var_0_1(self.__params))
	else
		self:onLoad()
	end
end

function fgui.GComponent:onExitFinish()
	g.core.event.EventManager:removeListenerWithTarget(self)
	self:removeAllCriSprite()
	self:onUnload()

	local var_5_0 = 0

	if self.__classIndex then
		var_5_0 = self.__classIndex
		self.__classIndex = 0
	end

	self.__onLoaded = false

	if self.__classIndex then
		self.__classIndex = var_5_0
	end
end

function fgui.GComponent.onLoad(arg_6_0)
	return
end

function fgui.GComponent.onUnload(arg_7_0)
	return
end

function fgui.GComponent.onRemoved(arg_8_0)
	return
end

function fgui.GComponent.setView(arg_9_0, arg_9_1)
	arg_9_0._view = arg_9_1
end

function fgui.GComponent:getView(arg_10_1)
	if not self._view then
		return
	end

	if not arg_10_1 then
		return self._view
	end

	return (self._view:getChild(arg_10_1))
end

function fgui.GComponent:removeSelf()
	if self:getParent() then
		self:removeFromParent()
	else
		self._removed = true
	end
end

function fgui.GComponent:isRemoved()
	return self._removed
end

function fgui.GComponent:getChild(arg_13_1)
	if self._view then
		return self:getView(arg_13_1)
	end

	return var_0_7(self, arg_13_1)
end

function fgui.GComponent.getRootChild(arg_14_0, arg_14_1)
	return var_0_7(arg_14_0, arg_14_1)
end

function fgui.GComponent:getTransition(arg_15_1)
	if self._view then
		return self._view:getTransition(arg_15_1)
	end

	return var_0_10(self, arg_15_1)
end

function fgui.GComponent:getController(arg_16_1)
	if self._view then
		return self._view:getController(arg_16_1)
	end

	return var_0_8(self, arg_16_1)
end

function fgui.GComponent:setSelectedIndex(arg_17_1, arg_17_2)
	local var_17_0 = self:getController(arg_17_1)

	assert(var_17_0, "Could not find the controller with name: " .. tostring(arg_17_1))
	var_17_0:setSelectedIndex(arg_17_2)
end

function fgui.GComponent:setSelectedPage(arg_18_1, arg_18_2)
	local var_18_0 = self:getController(arg_18_1)

	assert(var_18_0, "Could not find the controller with name: " .. tostring(arg_18_1))
	var_18_0:setSelectedPage(arg_18_2)
end

function fgui.GComponent:setCtrlState(arg_19_1, arg_19_2)
	local var_19_0 = self:getController(arg_19_1)

	assert(var_19_0, "Could not find the controller with name: " .. tostring(arg_19_1))

	if arg_19_2.index then
		var_19_0:setSelectedIndex(arg_19_2.index)
	elseif arg_19_2.name then
		var_19_0:setSelectedPage(arg_19_2.name)
	elseif arg_19_2.id then
		var_19_0:setSelectedPageId(arg_19_2.id)
	end
end

function fgui.GComponent:dispatchCompEvent(arg_20_1)
	if not self._compEventListeners then
		return
	end

	for iter_20_0, iter_20_1 in var_0_2(self._compEventListeners) do
		iter_20_1.listener(iter_20_1.target, arg_20_1, ...)
	end
end

function fgui.GComponent:addCompEventListener(arg_21_1, arg_21_2, arg_21_3)
	assert(arg_21_1, "The target must be non-nil !")
	assert(arg_21_2, "The listener must be non-nil !")

	self._compEventListeners = self._compEventListeners or {}

	local var_21_0 = false

	for iter_21_0, iter_21_1 in var_0_2(self._compEventListeners) do
		if iter_21_1.target == arg_21_1 then
			var_21_0 = true
			iter_21_1.listener = arg_21_2

			break
		end
	end

	if not var_21_0 then
		if arg_21_3 then
			var_0_4(self._compEventListeners, #self._compEventListeners + 1, {
				target = arg_21_1,
				listener = arg_21_2,
				isComp = arg_21_3
			})
		else
			local var_21_1 = self._compEventListeners[#self._compEventListeners]

			if not self._compEventListeners[#self._compEventListeners] then
				var_0_4(self._compEventListeners, {
					target = arg_21_1,
					listener = arg_21_2
				})
			elseif var_21_1.isComp then
				var_0_4(self._compEventListeners, #self._compEventListeners, {
					target = arg_21_1,
					listener = arg_21_2
				})
			else
				var_0_4(self._compEventListeners, {
					target = arg_21_1,
					listener = arg_21_2
				})
			end
		end
	end
end

function fgui.GComponent:removeCompEventListener(arg_22_1)
	if not self._compEventListeners then
		return
	end

	local var_22_0 = self._compEventListeners

	for iter_22_0, iter_22_1 in var_0_2(self._compEventListeners) do
		if iter_22_1.target == arg_22_1 then
			var_0_5(var_22_0, iter_22_0)

			break
		end
	end
end

function fgui.GComponent.receiveCompEvent(arg_23_0, arg_23_1)
	return false
end

function fgui.GComponent:doReceiveCompEvent(arg_24_1)
	if arg_24_1 == "messagebox_confirm" then
		if self._callback1 then
			self._callback1(...)

			self._callback1 = nil
		end
	elseif arg_24_1 == "messagebox_cancel" then
		if self._callback2 then
			self._callback2(...)

			self._callback2 = nil
		end
	elseif self:receiveCompEvent(arg_24_1, ...) == false then
		self:dispatchCompEvent(arg_24_1, ...)
	end
end

function fgui.GComponent:addChild(arg_25_1)
	if arg_25_1.numChildren then
		self:addChildWithListen(arg_25_1)
	else
		var_0_9(self, arg_25_1)
	end
end

function fgui.GComponent:addChildAt(arg_26_1, arg_26_2)
	if arg_26_1.numChildren then
		self:addChildWithListen(arg_26_1)
	else
		var_0_9(self, arg_26_1)
	end

	self:setChildIndex(arg_26_1, arg_26_2)
end

function fgui.GComponent:addChildWithListen(arg_27_1)
	self:addListen(arg_27_1)
	var_0_9(self, arg_27_1)
end

function fgui.GComponent:addListen(arg_28_1)
	self.__compListeners = self.__compListeners or {}

	if not self.__compListeners[arg_28_1] then
		arg_28_1:addEventListener(fgui.UIEventType.EnterFinish, handler(self, self.onCompEnter))
		arg_28_1:addEventListener(fgui.UIEventType.ExitFinish, handler(self, self.onCompExit))

		self.__compListeners[arg_28_1] = true
	end

	arg_28_1.__compListener = self
end

function fgui.GComponent:onCompEnter(arg_29_1)
	local var_29_0 = arg_29_1:getSender()

	if var_29_0.__compListener ~= self then
		return
	end

	var_29_0:addCompEventListener(self, self.doReceiveCompEvent, true)
	var_29_0:onEnterFinish()
end

function fgui.GComponent.onCompExit(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1:getSender()

	if var_30_0.__compListener ~= arg_30_0 then
		return
	end

	var_30_0:onExitFinish()
	var_30_0:removeCompEventListener(arg_30_0)
end

function fgui.GComponent:onUICompEnter(arg_31_1)
	local var_31_0 = arg_31_1:getSender()

	var_31_0:addCompEventListener(self, self.doReceiveCompEvent, true)
	var_31_0:onEnterFinish()
end

function fgui.GComponent.onUICompExit(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_1:getSender()

	var_32_0:onExitFinish()
	var_32_0:removeCompEventListener(arg_32_0)
end

function fgui.GComponent.addFullComp(arg_33_0, arg_33_1)
	g.core.module.ModuleManager:pushFullComp(arg_33_1)
end

function fgui.GComponent.addPopup(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_2 then
		arg_34_0._callback1 = arg_34_2.callback1
		arg_34_0._callback2 = arg_34_2.callback2

		if arg_34_2.startComp then
			arg_34_2.startPos = arg_34_2.startComp:localToGlobal(cc.p(0, 0))
		end
	end

	g.core.module.ModuleManager:pushPopup(arg_34_1, arg_34_2)
end

function fgui.GComponent.replacePopup(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_2 then
		arg_35_0._callback1 = arg_35_2.callback1
		arg_35_0._callback2 = arg_35_2.callback2

		if arg_35_2.startComp then
			arg_35_2.startPos = arg_35_2.startComp:localToGlobal(cc.p(0, 0))
		end
	end

	g.core.module.ModuleManager:replaceModule({
		modType = g.view.entrance.POPUP,
		params = arg_35_2,
		create = function()
			return arg_35_1
		end
	})
end

function fgui.GComponent:addBg(arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	arg_37_3 = {
		width = display.width,
		height = display.height
	}

	local var_37_0 = fgui.GLoader:create()

	var_37_0:setLoadAsync(arg_37_2)
	var_37_0:setURL(arg_37_1)
	var_37_0:setSize(arg_37_3.width, arg_37_3.height)
	var_37_0:setFill(5)
	var_37_0:setAlign(1)
	var_37_0:setVerticalAlign(1)
	self:addChildAt(var_37_0, 0)
	var_37_0:setPivot(0.5, 0.5, true)
	var_37_0:setPosition(display.width / 2, display.height / 2)

	if arg_37_4 and arg_37_4 == 1 then
		local var_37_1 = var_37_0:getContentSize()

		if math.max(display.width / var_37_1.width, display.height / var_37_1.height) < 1 then
			var_37_0:setSize(var_37_1.width, var_37_1.height)
		end
	end

	self._commonBg = var_37_0

	return var_37_0
end

function fgui.GComponent:playEnterAnim()
	self:_playCommonEnterAnim()
end

function fgui.GComponent:_playCommonEnterAnim()
	if self._commonBg then
		if self.getView and self:getView() then
			self:getView():setVisible(false)
		end

		self:getSharedTrans("enter", "CommonBgAnim", self._commonBg):play()
		g.core.common.Scheduler:newScheduleOnce(handler(self, self._onElemEnterAnim), 0.2)
	end
end

function fgui.GComponent:_onElemEnterAnim()
	if self.getView and self:getView() then
		self:getView():setVisible(true)
	end

	if self.playSelfEnterAnim then
		self:playSelfEnterAnim()
	end
end

function fgui.GComponent:isHasBgComp()
	return self._commonBg
end

function fgui.GComponent.playAnimExit(arg_42_0)
	g.core.module.ModuleManager:popModule()
end

function fgui.GComponent:_onExitAnimEnd()
	if self._commonBg then
		self:getSharedTrans("exit", "CommonBgAnim", self._commonBg):play(function()
			g.core.module.ModuleManager:popModule()
		end)
	else
		g.core.module.ModuleManager:popModule()
	end
end

function fgui.GComponent:addBgMovie(arg_45_1)
	arg_45_1 = arg_45_1 or {}
	arg_45_1.moduleName = arg_45_1.moduleName or "lineUp"
	arg_45_1.movieName = arg_45_1.movieName or "bgzhenrong_1334x750_30000"
	arg_45_1.x = display.width / 2
	arg_45_1.y = display.height / 2
	arg_45_1.isLoop = true
	arg_45_1.zOrder = -1

	return self:addCriSprite(arg_45_1, true)
end

function fgui.GComponent:showAtCenter()
	self:getView():setPosition(display.width / 2, display.height / 2)
end

function fgui.GComponent.getDeepChild(arg_47_0, arg_47_1)
	local var_47_0 = string.split(arg_47_1, ".")

	if not var_47_0 then
		return nil
	end

	local var_47_1 = arg_47_0
	local var_47_2

	for iter_47_0, iter_47_1 in var_0_2(var_47_0) do
		if string.sub(iter_47_1, 1, 1) == "#" then
			local var_47_3 = tonumber(string.sub(iter_47_1, 2))

			if not var_47_3 then
				return nil
			end

			if var_47_1.itemIndexToChildIndex then
				var_47_2 = var_47_1:getChildAt((var_47_1:itemIndexToChildIndex(var_47_3)))
			else
				return nil
			end
		else
			var_47_2 = var_47_1:getRootChild(iter_47_1)
		end

		if var_47_2 then
			if iter_47_0 == #var_47_0 then
				return var_47_2
			elseif var_47_2.getBaseChild then
				var_47_1 = var_47_2
			else
				return nil
			end
		else
			return nil
		end
	end

	return var_47_2
end

function fgui.GComponent:playLayerEnterAnime(arg_48_1)
	if not arg_48_1 then
		return
	end

	local var_48_0 = arg_48_1.callback

	if g.core.utils.Quality.needCloseUIAnime() then
		if var_48_0 then
			var_48_0()
		end

		return
	end

	if self._enterAniPlayed and not arg_48_1.always then
		return
	end

	local var_48_1 = 0.4
	local var_48_2 = 200
	local var_48_3 = 50
	local var_48_4 = arg_48_1.callback
	local var_48_5 = 1

	local function var_48_6(arg_49_0)
		local var_49_0 = 0
		local var_49_1

		if type(arg_49_0) == "table" then
			if arg_49_0.index and arg_49_0.index > 1 then
				var_49_0 = var_48_1 * (arg_49_0.index - 1)
				var_48_5 = math.max(var_48_5, arg_49_0.index)
			end

			var_49_1 = arg_49_0.widget and arg_49_0.widget or self:getChild(arg_49_0.name)
		else
			var_49_1 = type(arg_49_0) == "userdata" and arg_49_0 or self:getChild(arg_49_0)
		end

		if not var_49_1 then
			return
		end

		local var_49_2 = arg_49_0.type

		if not arg_49_0.type then
			local var_49_3 = var_49_1:getPosition()
			local var_49_4 = var_49_3.x + var_49_1:getSize().width / 2

			var_49_2 = var_49_4 > display.width * 0.4 and var_49_4 < display.width * 0.6 and (var_49_3.y <= 10 and "top" or "bottom") or var_49_4 > display.cx and "right" or "left"
		end

		local var_49_5
		local var_49_6 = false

		if var_49_2 == "left" then
			var_49_5 = cc.p(-var_48_2, 0)
		elseif var_49_2 == "right" then
			var_49_5 = cc.p(var_48_2, 0)
		elseif var_49_2 == "top" then
			var_49_5 = cc.p(0, -var_48_3)
		elseif var_49_2 == "bottom" then
			var_49_5 = cc.p(0, var_48_3)
		elseif var_49_2 == "fade" then
			var_49_6 = true
		end

		if var_49_5 or var_49_6 then
			local var_49_7

			if var_49_5 then
				local var_49_8 = var_49_1:getPosition()

				var_49_1:setPosition(var_49_8.x + var_49_5.x, var_49_8.y + var_49_5.y)

				var_49_7 = var_49_2 == "bottom" and fgui.FEaseOut:create(fgui.FMoveBy:create(var_48_1 / 3, cc.p(-var_49_5.x, -var_49_5.y)), 2) or fgui.FEaseBackOut:create(fgui.FMoveBy:create(var_48_1, cc.p(-var_49_5.x, -var_49_5.y)))
			end

			if var_49_6 then
				var_49_1:setOpacity(0)

				var_49_7 = fgui.FFadeTo:create(var_48_1, 255)
			end

			if var_49_7 then
				if var_49_0 > 0 then
					var_49_1:runFGAction((fgui.FSequence:create({
						fgui.FDelayTime:create(var_49_0),
						var_49_7
					})))
				else
					var_49_1:runFGAction(var_49_7)
				end
			end
		end
	end

	for iter_48_0, iter_48_1 in var_0_2(arg_48_1) do
		var_48_6(iter_48_1)
	end

	self:runFGAction((fgui.FSequence:create({
		fgui.FDelayTime:create(1 * var_48_1),
		fgui.FCallFunc:create(function()
			if var_48_4 then
				var_48_4()
			end
		end)
	})))

	self._enterAniPlayed = true
end

function fgui.GComponent:playBtnsEnterAnime(arg_51_1)
	if g.core.utils.Quality.needCloseUIAnime() then
		return
	end

	if self._btnsEnterAniPlayed and not arg_51_1.always then
		return
	end

	local var_51_0 = 0

	local function var_51_1(arg_52_0)
		local var_52_0 = self:getChild(arg_52_0)

		if not var_52_0 or not var_52_0:isVisibleActually() then
			return
		end

		local var_52_1 = var_52_0:getPosition()

		var_52_0:setPosition(var_52_1.x - 200, var_52_1.y)

		local var_52_2 = fgui.FEaseBackOut:create(fgui.FMoveBy:create(0.2, cc.p(200, 0)))

		if var_51_0 > 0 then
			var_52_0:runFGAction((fgui.FSequence:create({
				fgui.FDelayTime:create(var_51_0),
				var_52_2
			})))
		else
			var_52_0:runFGAction(var_52_2)
		end

		var_51_0 = var_51_0 + 0.05
	end

	for iter_51_0, iter_51_1 in var_0_2(arg_51_1) do
		var_51_1(iter_51_1)
	end

	self._btnsEnterAniPlayed = true
end

function fgui.GComponent:callFuncsFramesByFrames(arg_53_1)
	local var_53_0 = {}
	local var_53_1 = 1 / cc.Director:getInstance():getFrameRate()

	for iter_53_0, iter_53_1 in var_0_2(arg_53_1) do
		local var_53_2, var_53_3, var_53_4 = var_0_1(iter_53_1)

		if var_53_2 ~= nil and type(var_53_2) == "function" then
			var_0_3.insert(var_53_0, fgui.FDelayTime:create((var_53_4 or 1) * var_53_1))
			var_0_3.insert(var_53_0, fgui.FCallFunc:create(function()
				var_53_2(var_0_1(var_53_3 or {}))
			end))
		end
	end

	self:runFGAction(fgui.FSequence:create(var_53_0))
end

local var_0_11 = {
	GRICHTEXTFIELD = "GRichTextField",
	GTEXTINPUT = "GTextInput",
	GBASICTEXTFIELD = "GBasicTextField",
	GTEXTFIELD = "GTextField",
	GSLIDER = "GSlider",
	GSCROLLBAR = "GScrollBar",
	GPROGRESSBAR = "GProgressBar",
	GLOADER = "GLoader",
	GLIST = "GList",
	GLABEL = "GLabel",
	GIMAGE = "GImage",
	GGROUP = "GGroup",
	GGRAPH = "GGraph",
	GCOMBOBOX = "GComboBox",
	GBUTTON = "GButton",
	GCOMPONENT = "GComponent",
	GOBJECT = "GObject"
}

function fgui.GComponent:setProperties(arg_55_1, arg_55_2)
	assert(type(arg_55_1) == "string", "Error: Component name must be string !")
	assert(type(arg_55_2) == "table", "Error: Invalid params ! params must be table !")

	local var_55_0 = self:getChild(arg_55_1)

	assert(var_55_0, "Error: Component for \"" .. arg_55_1 .. "\" is not exist!")

	if var_0_3.nums(arg_55_2) > 0 then
		local var_55_1 = string.sub(tolua.type(var_55_0), 6)

		if var_55_1 == var_0_11.GBUTTON then
			self:setGButtonProperty(var_55_0, arg_55_2)
		elseif var_55_1 == var_0_11.GCOMBOBOX then
			self:setGComboBoxProperty(var_55_0, arg_55_2)
		elseif var_55_1 == var_0_11.GGRAPH then
			self:setGGraphProperty(var_55_0, arg_55_2)
		elseif var_55_1 == var_0_11.GGROUP then
			self:setGGroupProperty(var_55_0, arg_55_2)
		elseif var_55_1 == var_0_11.GIMAGE then
			self:setGImageProperty(var_55_0, arg_55_2)
		elseif var_55_1 == var_0_11.GLABEL then
			self:setGLabelProperty(var_55_0, arg_55_2)
		elseif var_55_1 == var_0_11.GLIST then
			self:setGListProperty(var_55_0, arg_55_2)
		elseif var_55_1 == var_0_11.GLOADER then
			self:setGLoaderProperty(var_55_0, arg_55_2)
		elseif var_55_1 == var_0_11.GPROGRESSBAR then
			self:setGProgressBarProperty(var_55_0, arg_55_2)
		elseif var_55_1 == var_0_11.GSCROLLBAR then
			self:setGScrollBarProperty(var_55_0, arg_55_2)
		elseif var_55_1 == var_0_11.GSLIDER then
			self:setGSliderProperty(var_55_0, arg_55_2)
		elseif var_55_1 == var_0_11.GTEXTFIELD or var_55_1 == var_0_11.GBASICTEXTFIELD then
			self:setGTextFieldProperty(var_55_0, arg_55_2)
		elseif var_55_1 == var_0_11.GTEXTINPUT then
			self:setGTextInputProperty(var_55_0, arg_55_2)
		elseif var_55_1 == var_0_11.GRICHTEXTFIELD then
			self:setGRichTextFieldProperty(var_55_0, arg_55_2)
		elseif var_55_1 == var_0_11.GCOMPONENT then
			self:setGComponentProperty(var_55_0, arg_55_2)
		elseif var_55_1 == var_0_11.GOBJECT then
			self:setGObjectProperty(var_55_0, arg_55_2)
		end
	end
end

function fgui.GComponent.setGObjectProperty(arg_56_0, arg_56_1, arg_56_2)
	if arg_56_2.visible ~= nil then
		checkbool(arg_56_2.visible)
		arg_56_1:setVisible(arg_56_2.visible)
	end

	if arg_56_2.touchEnabled ~= nil then
		checkbool(arg_56_2.touchEnabled)
		arg_56_1:setTouchable(arg_56_2.touchEnabled)
	end

	if arg_56_2.x ~= nil and arg_56_2.y ~= nil then
		checknumber(arg_56_2.x)
		checknumber(arg_56_2.y)
		arg_56_1:setPosition(arg_56_2.x, arg_56_2.y)
	elseif arg_56_2.x ~= nil then
		checknumber(arg_56_2.x)
		arg_56_1:setX(arg_56_2.x)
	elseif arg_56_2.y ~= nil then
		checknumber(arg_56_2.y)
		arg_56_1:setY(arg_56_2.y)
	end

	if arg_56_2.width ~= nil and arg_56_2.height ~= nil then
		checknumber(arg_56_2.width)
		checknumber(arg_56_2.height)
		arg_56_1:setSize(arg_56_2.width, arg_56_2.height, arg_56_2.ignorePivot or false)
	elseif arg_56_2.width ~= nil then
		checknumber(arg_56_2.width)
		arg_56_1:setWidth(arg_56_2.width)
	elseif arg_56_2.height ~= nil then
		checknumber(arg_56_2.height)
		arg_56_1:setHeight(arg_56_2.height)
	end

	if arg_56_2.pivotX ~= nil and arg_56_2.pivotY ~= nil then
		checknumber(arg_56_2.pivotX)
		checknumber(arg_56_2.pivotY)
		arg_56_1:setPivot(arg_56_2.pivotX, arg_56_2.pivotY, arg_56_2.asAnchor or false)
	end

	if arg_56_2.scaleX ~= nil and arg_56_2.scaleY ~= nil then
		checknumber(arg_56_2.scaleX)
		checknumber(arg_56_2.scaleY)
		arg_56_1:setScale(arg_56_2.scaleX, arg_56_2.scaleY)
	elseif arg_56_2.scaleX ~= nil then
		checknumber(arg_56_2.scaleX)
		arg_56_1:setScaleX(arg_56_2.scaleX)
	elseif arg_56_2.scaleY ~= nil then
		checknumber(arg_56_2.scaleY)
		arg_56_1:setScaleX(arg_56_2.scaleY)
	end

	if arg_56_2.alpha ~= nil then
		checknumber(arg_56_2.alpha)
		arg_56_1:setAlpha(arg_56_2.alpha)
	end

	if arg_56_2.rotation ~= nil then
		checknumber(arg_56_2.rotation)
		arg_56_1:setRotation(arg_56_2.rotation)
	end

	if arg_56_2.isGray ~= nil then
		checkbool(arg_56_2.isGray)
		arg_56_1:setGrayed(arg_56_2.isGray)
	end

	if arg_56_2.text ~= nil then
		checkstring(arg_56_2.text)
		arg_56_1:setText(arg_56_2.text)
	end

	if arg_56_2.icon ~= nil then
		checkstring(arg_56_2.icon)
		arg_56_1:setIcon(arg_56_2.icon)
	end

	if arg_56_2.canDrag ~= nil then
		checkbool(arg_56_2.canDrag)
		arg_56_1:setDraggable(arg_56_2.canDrag)
	end
end

function fgui.GComponent:setGComponentProperty(arg_57_1, arg_57_2)
	self:setGObjectProperty(arg_57_1, arg_57_2)

	if arg_57_2.opaque ~= nil then
		checkbool(arg_57_2.opaque)
		arg_57_1:setOpaque(arg_57_2.opaque)
	end

	if arg_57_2.ctrl then
		checkstring(arg_57_2.ctrl)

		if arg_57_2.ctrlIdx ~= nil then
			checknumber(arg_57_2.ctrlIdx)
			arg_57_1:setCtrlState(arg_57_2.ctrl, {
				index = arg_57_2.ctrlIdx
			})
		elseif arg_57_2.ctrlPageName ~= nil then
			checkstring(arg_57_2.ctrlPageName)
			arg_57_1:setCtrlState(arg_57_2.ctrl, {
				name = arg_57_2.ctrlPageName
			})
		end
	end
end

function fgui.GComponent:setGButtonProperty(arg_58_1, arg_58_2)
	self:setGComponentProperty(arg_58_1, arg_58_2)

	if arg_58_2.selectedText ~= nil then
		checkstring(arg_58_2.selectedText)
		arg_58_1:setSelectedTitle(arg_58_2.selectedText)
	end

	if arg_58_2.selectedIcon ~= nil then
		checkstring(arg_58_2.selectedIcon)
		arg_58_1:setSelectedIcon(arg_58_2.selectedIcon)
	end

	if arg_58_2.textColor ~= nil then
		checktable(arg_58_2.textColor)
		arg_58_1:setTitleColor(arg_58_2.textColor)
	end

	if arg_58_2.isSelected ~= nil then
		checkbool(arg_58_2.isSelected)
		arg_58_1:setSelected(arg_58_2.isSelected)
	end
end

function fgui.GComponent:setGComboBoxProperty(arg_59_1, arg_59_2)
	self:setGComponentProperty(arg_59_1, arg_59_2)

	if arg_59_2.selectedIndex ~= nil then
		checknumber(arg_59_2.selectedIndex)
		arg_59_1:setSelectedIndex(arg_59_2.selectedIndex)
	end
end

function fgui.GComponent:setGGraphProperty(arg_60_1, arg_60_2)
	self:setGComponentProperty(arg_60_1, arg_60_2)
end

function fgui.GComponent:setGGroupProperty(arg_61_1, arg_61_2)
	self:setGComponentProperty(arg_61_1, arg_61_2)

	if arg_61_2.columnGap ~= nil then
		checknumber(arg_61_2.columnGap)
		arg_61_1:setColumnGap(arg_61_2.columnGap)
	end

	if arg_61_2.lineGap ~= nil then
		checknumber(arg_61_2.lineGap)
		arg_61_1:setLineGap(arg_61_2.lineGap)
	end
end

function fgui.GComponent:setGImageProperty(arg_62_1, arg_62_2)
	self:setGComponentProperty(arg_62_1, arg_62_2)

	if arg_62_2.flip ~= nil then
		checknumber(arg_62_2.flip)
		arg_62_1:setFlip(arg_62_2.flip)
	end

	if arg_62_2.imgColor ~= nil then
		checktable(arg_62_2.imgColor)
		arg_62_1:setColor(arg_62_2.imgColor)
	end
end

function fgui.GComponent:setGLabelProperty(arg_63_1, arg_63_2)
	self:setGComponentProperty(arg_63_1, arg_63_2)

	if arg_63_2.txtColor ~= nil then
		checktable(arg_63_2.txtColor)
		arg_63_1:setTitleColor(arg_63_2.txtColor)
	end

	if arg_63_2.fontSize ~= nil then
		checknumber(arg_63_2.fontSize)
		arg_63_1:setTitleFontSize(arg_63_2.fontSize)
	end
end

function fgui.GComponent:setGListProperty(arg_64_1, arg_64_2)
	self:setGComponentProperty(arg_64_1, arg_64_2)

	if arg_64_2.columnGap ~= nil then
		checknumber(arg_64_2.columnGap)
		arg_64_1:setColumnGap(arg_64_2.columnGap)
	end

	if arg_64_2.lineGap ~= nil then
		checknumber(arg_64_2.lineGap)
		arg_64_1:setLineGap(arg_64_2.lineGap)
	end

	if arg_64_2.columnCount ~= nil then
		checknumber(arg_64_2.columnCount)
		arg_64_1:setColumnCount(arg_64_2.columnCount)
	end

	if arg_64_2.lineCount ~= nil then
		checknumber(arg_64_2.lineCount)
		arg_64_1:setLineCount(arg_64_2.lineCount)
	end

	if arg_64_2.selectedIndex ~= nil then
		checknumber(arg_64_2.selectedIndex)
		arg_64_1:setSelectedIndex(arg_64_2.selectedIndex)
	end
end

function fgui.GComponent:setGLoaderProperty(arg_65_1, arg_65_2)
	self:setGComponentProperty(arg_65_1, arg_65_2)

	if arg_65_2.url ~= nil then
		checkstring(arg_65_2.url)
		arg_65_1:setURL(arg_65_2.url)
	end

	if arg_65_2.autoSize ~= nil then
		checkbool(arg_65_2.autoSize)
		arg_65_1:setAutoSize(arg_65_2.autoSize)
	end

	if arg_65_2.color ~= nil then
		checktable(arg_65_2.color)
		arg_65_1:setColor(arg_65_2.color)
	end
end

function fgui.GComponent:setGProgressBarProperty(arg_66_1, arg_66_2)
	self:setGComponentProperty(arg_66_1, arg_66_2)

	if arg_66_2.value ~= nil then
		checknumber(arg_66_2.value)
		arg_66_1:setValue(arg_66_2.value)
	end

	if arg_66_2.max ~= nil then
		checknumber(arg_66_2.max)
		arg_66_1:setMax(arg_66_2.max)
	end

	if arg_66_2.titleType ~= nil then
		checknumber(arg_66_2.titleType)
		arg_66_1:setTitleType(arg_66_2.titleType)
	end
end

function fgui.GComponent:setGScrollBarProperty(arg_67_1, arg_67_2)
	self:setGComponentProperty(arg_67_1, arg_67_2)

	if arg_67_2.displayPerc ~= nil then
		checknumber(arg_67_2.displayPerc)
		arg_67_1:setDisplayPerc(arg_67_2.displayPerc)
	end

	if arg_67_2.scrollPerc ~= nil then
		checknumber(arg_67_2.scrollPerc)
		arg_67_1:setScrollPerc(arg_67_2.scrollPerc)
	end
end

function fgui.GComponent:setGSliderProperty(arg_68_1, arg_68_2)
	self:setGComponentProperty(arg_68_1, arg_68_2)

	if arg_68_2.value ~= nil then
		checknumber(arg_68_2.value)
		arg_68_1:setValue(arg_68_2.value)
	end

	if arg_68_2.max ~= nil then
		checknumber(arg_68_2.max)
		arg_68_1:setMax(arg_68_2.max)
	end
end

function fgui.GComponent:setGTextFieldProperty(arg_69_1, arg_69_2)
	self:setGComponentProperty(arg_69_1, arg_69_2)

	if arg_69_2.autoSize ~= nil then
		checkbool(arg_69_2.autoSize)
		arg_69_1:setAutoSize(arg_69_2.autoSize)
	end

	if arg_69_2.singleLine ~= nil then
		checkbool(arg_69_2.singleLine)
		arg_69_1:setSingleLine(arg_69_2.singleLine)
	end

	if arg_69_2.color ~= nil then
		checktable(arg_69_2.color)
		arg_69_1:setColor(arg_69_2.color)
	end

	if arg_69_2.fontSize ~= nil then
		checknumber(arg_69_2.fontSize)
		arg_69_1:setFontSize(arg_69_2.fontSize)
	end

	if arg_69_2.ubbEnabled ~= nil then
		checkbool(arg_69_2.ubbEnabled)
		arg_69_1:setUBBEnabled(arg_69_2.ubbEnabled)
	end

	if arg_69_2.letterSpacing ~= nil then
		checknumber(arg_69_2.letterSpacing)
		arg_69_1:setAdditionalKerning(arg_69_2.letterSpacing)
	end
end

function fgui.GComponent:setGTextInputProperty(arg_70_1, arg_70_2)
	self:setGComponentProperty(arg_70_1, arg_70_2)

	if arg_70_2.singleLine ~= nil then
		checkbool(arg_70_2.singleLine)
		arg_70_1:setSingleLine(arg_70_2.singleLine)
	end

	if arg_70_2.placeHolder ~= nil then
		checkstring(arg_70_2.placeHolder)
		arg_70_1:setPrompt(arg_70_2.placeHolder)
	end

	if arg_70_2.maxLength ~= nil then
		checknumber(arg_70_2.maxLength)
		arg_70_1:setMaxLength(arg_70_2.maxLength)
	end
end

function fgui.GComponent:setGRichTextFieldProperty(arg_71_1, arg_71_2)
	self:setGComponentProperty(arg_71_1, arg_71_2)

	if arg_71_2.singleLine ~= nil then
		arg_71_1:setSingleLine(arg_71_2.singleLine)
	end

	if arg_71_2.autoSize ~= nil then
		arg_71_1:setAutoSize(arg_71_2.autoSize)
	end
end

function fgui.GComponent:getSharedTrans(arg_72_1, arg_72_2, arg_72_3)
	local var_72_0 = arg_72_1

	if arg_72_3 then
		var_72_0 = var_0_3.concat({
			var_72_0,
			arg_72_3:getName()
		})
	end

	local var_72_1 = self:getTransition(var_72_0)

	if var_72_1 then
		return var_72_1
	end

	local var_72_2 = UITransitionMgr:getShareTransition(arg_72_1, arg_72_2)

	if arg_72_3 then
		var_72_1 = self:copyTransition(var_72_2, var_72_0)

		if var_72_1 then
			var_72_1:forceTarget(arg_72_3)
		end
	else
		var_72_1 = self:copyTransition(var_72_2)
	end

	return var_72_1
end

function fgui.GComponent:getGScrollBar(arg_73_1)
	return self:getChild(arg_73_1)
end

function fgui.GComponent:getGButton(arg_74_1)
	return self:getChild(arg_74_1)
end

function fgui.GComponent:getGGraph(arg_75_1)
	return self:getChild(arg_75_1)
end

function fgui.GComponent:getGImage(arg_76_1)
	return self:getChild(arg_76_1)
end

function fgui.GComponent:getGList(arg_77_1)
	return self:getChild(arg_77_1)
end

function fgui.GComponent:getGComboBox(arg_78_1)
	return self:getChild(arg_78_1)
end

function fgui.GComponent:getGGroup(arg_79_1)
	return self:getChild(arg_79_1)
end

function fgui.GComponent:getGLabel(arg_80_1)
	return self:getChild(arg_80_1)
end

function fgui.GComponent:getGTextField(arg_81_1)
	return self:getChild(arg_81_1)
end

function fgui.GComponent:getGTree(arg_82_1)
	return self:getChild(arg_82_1)
end

function fgui.GComponent:getGTextInput(arg_83_1)
	return self:getChild(arg_83_1)
end

function fgui.GComponent:getGSlider(arg_84_1)
	return self:getChild(arg_84_1)
end

function fgui.GComponent:getGProgressBar(arg_85_1)
	return self:getChild(arg_85_1)
end

function fgui.GComponent:getGLoader(arg_86_1)
	return self:getChild(arg_86_1)
end

function fgui.GComponent:getGComponent(arg_87_1)
	return self:getChild(arg_87_1)
end
