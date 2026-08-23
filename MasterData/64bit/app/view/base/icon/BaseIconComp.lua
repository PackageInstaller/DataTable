local var_0_0 = {
	[0] = 1,
	0.9,
	0.8,
	0.7,
	0.6,
	0.5,
	0.55,
	0.3
}
local var_0_1 = g.core.common.Goods
local BaseIconComp = class("BaseIconComp")

function BaseIconComp:ctor()
	self._quality = -1
	self._type = nil
	self._controllersInitIndexMap = {}
	self._bindUINodes = {}
	self._bindControllers = {}
	self._touchFunc = nil
	self._params = nil
	self._otherInfo = nil
	self._isShowZeroNum = false
	self._effectSpineInfos = {}
	self._effectSpineNodes = {}

	self:_addTouchFunc()
	self:_bindAllUIAndControllers()
	self:_initUIControllers()
	self:addClickListener(handler(self, self._onClick))
end

function BaseIconComp:_bindAllUIAndControllers()
	return
end

function BaseIconComp:_addTouchFunc()
	return
end

function BaseIconComp:_initUIControllers()
	for iter_4_0, iter_4_1 in pairs(self._bindControllers) do
		self._controllersInitIndexMap[iter_4_0] = iter_4_1:getSelectedIndex()
	end
end

function BaseIconComp:initControllers(arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		if self[iter_5_0] then
			self[iter_5_0]:setSelectedIndex(iter_5_1)

			self._controllersInitIndexMap[iter_5_0] = iter_5_1
		end
	end
end

function BaseIconComp:_removeEffectSpine(arg_6_1, arg_6_2)
	if self._effectSpineNodes[arg_6_1] then
		self._effectSpineInfos[self._effectSpineNodes[arg_6_1]] = nil

		self._effectSpineNodes[arg_6_1]:stop()

		if arg_6_2 or not self._effectSpineInfos[self._effectSpineNodes[arg_6_1]].remove then
			self._effectSpineNodes[arg_6_1]:removeFromParent()
		end
	end

	self._effectSpineNodes[arg_6_1] = nil
end

function BaseIconComp:_onEffectEventBack(arg_7_1, arg_7_2)
	if not self._effectSpineInfos[arg_7_2] then
		return
	end

	if self._effectSpineInfos[arg_7_2].listener then
		self._effectSpineInfos[arg_7_2].listener(arg_7_1, arg_7_2)
	end

	if arg_7_1.type == "complete" and not self._effectSpineInfos[arg_7_2].isLoop then
		self:_removeEffectSpine(self._effectSpineInfos[arg_7_2].name)
	end
end

function BaseIconComp:playIconEffect(arg_8_1, arg_8_2)
	arg_8_1 = arg_8_1 or {
		isLoop = false,
		name = "eff_ui_common_icon"
	}

	self:_removeEffectSpine(arg_8_1.name, true)

	if arg_8_2 then
		self.m_contentGroup:setVisible(false)
		self:stopAllFGActions()
		self:runFGAction(fgui.FSequence:create(fgui.FDelayTime:create(arg_8_2), fgui.FCallFunc:create(handler(self, self._showAllChildren))))
	end

	local var_8_0 = clone(arg_8_1)
	local var_8_1 = self:getSize()
	local var_8_2 = self:getScale()

	var_8_1.width = var_8_1.width * var_8_2.x
	var_8_1.height = var_8_1.height * var_8_2.y

	if not arg_8_1.localX and not arg_8_1.localY then
		arg_8_1.localX = var_8_1.width / 2
		arg_8_1.localY = -var_8_1.height / 2
	end

	arg_8_1.listener = handler(self, self._onEffectEventBack)

	local var_8_3 = self.m_effectNode:addEffectSpine(arg_8_1)

	self._effectSpineNodes[arg_8_1.name] = var_8_3
	self._effectSpineInfos[var_8_3] = var_8_0
end

function BaseIconComp:_showAllChildren()
	self.m_contentGroup:setVisible(true)
end

function BaseIconComp:_changeControllers()
	return
end

function BaseIconComp:_resumeControllers()
	for iter_11_0, iter_11_1 in pairs(self._controllersInitIndexMap) do
		if self[iter_11_0] then
			self[iter_11_0]:setSelectedIndex(iter_11_1)
		end
	end
end

function BaseIconComp:_checkAndFixParams(arg_12_1, arg_12_2)
	if not arg_12_1.iconCompName then
		local var_12_0 = var_0_1:convert({
			type = arg_12_1.type,
			value = arg_12_1.value,
			size = arg_12_1.size
		})

		for iter_12_0, iter_12_1 in pairs(arg_12_1) do
			var_12_0[iter_12_0] = var_12_0[iter_12_0] or iter_12_1
		end

		arg_12_1 = var_12_0
	end

	return arg_12_1
end

function BaseIconComp:getRealSize()
	local var_13_0 = self:getSize()
	local var_13_1 = self:getScale()

	var_13_0.width = var_13_0.width * var_13_1.x
	var_13_0.height = var_13_0.height * var_13_1.y

	return var_13_0
end

function BaseIconComp:getBindUINode(arg_14_1)
	return self._bindUINodes[arg_14_1]
end

function BaseIconComp:updateIcon(arg_15_1, arg_15_2)
	if not arg_15_1 then
		return
	end

	if arg_15_1.scaleIndex and tonumber(arg_15_1.scaleIndex) then
		self:setScale(var_0_0[arg_15_1.scaleIndex])
	end

	if arg_15_1.empty then
		self._params = arg_15_1
		self._otherInfo = nil

		self:setEmpty()

		return
	elseif self._params and self._params.empty then
		self:_resumeControllers()
	end

	arg_15_1 = self:_checkAndFixParams(arg_15_1, arg_15_2)
	self._params = arg_15_1
	self._otherInfo = arg_15_2 or {}

	if arg_15_1.changeControllers then
		self:_changeControllers()
	end

	self._type = arg_15_1.type or self._type

	self:setTouchFunc(arg_15_1.touchFunc)
	self:_setIcon(self:_getIconUrl(arg_15_1), false)
	self:_updateDetailUI()
end

function BaseIconComp:_updateDetailUI()
	return
end

function BaseIconComp:setEmpty()
	return
end

function BaseIconComp:setTouchFunc(arg_18_1)
	self._touchFunc = arg_18_1
end

function BaseIconComp:_bindIconLoader(arg_19_1)
	self._bindUINodes.iconLoader = arg_19_1
end

function BaseIconComp:_getIconUrl(arg_20_1)
	return arg_20_1.icon
end

function BaseIconComp:setIconByUrl(arg_21_1, arg_21_2)
	self:_setIcon(arg_21_1, arg_21_2)
end

function BaseIconComp:_setIcon(arg_22_1, arg_22_2)
	if self._bindUINodes.iconLoader:getURL() == arg_22_1 then
		return
	end

	arg_22_1 = arg_22_1 or ""

	self._bindUINodes.iconLoader:setURL(arg_22_1, arg_22_2)
end

function BaseIconComp:setIconGray(arg_23_1)
	self._bindUINodes.iconLoader:setGrayed(arg_23_1)
end

function BaseIconComp:setIconQualityBgVisible(arg_24_1)
	if self._bindUINodes.bgLoader then
		self._bindUINodes.bgLoader:setVisible(arg_24_1)
	end
end

function BaseIconComp:_bindUI(arg_25_1, arg_25_2)
	self._bindUINodes[arg_25_2] = arg_25_1
end

function BaseIconComp:_bindController(arg_26_1, arg_26_2)
	self._bindControllers[arg_26_2] = arg_26_1
end

function BaseIconComp:_setControllerIndex(arg_27_1, arg_27_2)
	if self._bindControllers[arg_27_1] then
		self._bindControllers[arg_27_1]:setSelectedIndex(arg_27_2)
	end
end

function BaseIconComp:setIconName()
	return
end

function BaseIconComp:setShowZeroNum(arg_29_1)
	self._isShowZeroNum = arg_29_1

	if self._params and (self._params.size or self._params.min and self._params.max) then
		self:setNum(self._params.size, self._params.numCost, self._params.min, self._params.max)
	end
end

function BaseIconComp:setCompGray(arg_30_1)
	if self._bindUINodes.grayGraph then
		self._bindUINodes.grayGraph:setVisible(arg_30_1)
	end
end

function BaseIconComp:_onClick()
	if not self._params then
		return
	end

	if self._params.overrideClick then
		if self._touchFunc then
			self:_touchFunc()
		end
	else
		local var_31_0 = clone(self._params)

		var_31_0.type = var_31_0.type or self._type

		if not var_31_0.value or not var_31_0.type then
			return
		end

		var_31_0.component = self

		g.core.common.GlobalFunc.pushInfoPop(var_31_0)
	end
end

return BaseIconComp
