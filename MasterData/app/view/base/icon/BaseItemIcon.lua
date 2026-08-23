local BaseIconComp = require("app.view.base.icon.BaseIconComp")
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_3 = g.core.common.Goods
local BaseItemIcon = class("BaseItemIcon", BaseIconComp)

function BaseItemIcon:ctor()
	BaseItemIcon._bindMethods(self)
	BaseIconComp.ctor(self)

	self._qualityEffectIcon = {}
	self._num = -1
	self._isBagNum = nil
	self._hideNum = nil
	self._type = var_0_3.TYPE_ITEM
end

function BaseItemIcon:_bindMethods()
	local var_2_0

	if self._bindAllUI then
		do return end

		var_2_0 = {}
	end

	for iter_2_0, iter_2_1 in ipairs((rawget(rawget(BaseItemIcon, "__index"), "__supers"))) do
		var_2_0 = BaseItemIcon._addClassMethodsToMethodList(self, iter_2_1, var_2_0)
	end

	for iter_2_2, iter_2_3 in pairs((BaseItemIcon._addClassMethodsToMethodList(self, BaseItemIcon, var_2_0))) do
		if not self[iter_2_2] then
			self[iter_2_2] = iter_2_3
		elseif type(iter_2_2) == "function" and type(self[iter_2_2]) == "function" then
			local var_2_1 = self
			local var_2_2 = self[iter_2_2]
			local var_2_3 = iter_2_3

			self[iter_2_2] = function()
				return var_2_2(var_2_1, ...), (var_2_3(var_2_1, ...))
			end
		end
	end
end

function BaseItemIcon:_addClassMethodsToMethodList(arg_4_1, arg_4_2)
	local var_4_0 = {
		super = true,
		ctor = true,
		__supers = true,
		__index = true,
		_bindMethods = true,
		_addClassMethodsToMethodList = true,
		__newindex = true,
		create = true,
		__cname = true,
		new = true
	}

	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		if not var_4_0[iter_4_0] then
			arg_4_2[iter_4_0] = iter_4_1
		end
	end

	return arg_4_2
end

function BaseItemIcon:_addTouchFunc()
	return
end

function BaseItemIcon:_onClickIcon()
	return
end

function BaseItemIcon:_bindAllUIAndControllers()
	self:_bindIconLoader(self.m_iconLoader)
	self:_bindUI(self.m_numText, "numText")
	self:_bindUI(self.m_nameTxt, "nameText")
	self:_bindUI(self.m_bgLoader, "bgLoader")
	self:_bindUI(self.m_grayGraph, "grayGraph")
	self:_bindUI(self.m_tipText, "tipText")
	self:_bindUI(self.m_weddingKnight, "weddingKnight")
	self:_bindController(self.m_isShowNumController, "m_isShowNumController")
	self:_bindController(self.m_nameTypeController, "m_nameTypeController")
	self:_bindController(self.m_isEnoughController, "m_isEnoughController")
	self:_bindController(self.m_showTipController, "m_showTipController")
end

function BaseItemIcon:_changeControllers()
	local var_8_0 = {}

	if self._params.size or self._params.isBagNum then
		local var_8_2 = 0

		if self._controllersInitIndexMap.m_isShowNumController and self._controllersInitIndexMap.m_isShowNumController ~= var_8_2 then
			var_8_0.m_isShowNumController = var_8_2
		end
	end

	if self._params.nameRow or self._otherInfo.nameRow then
		local var_8_4 = self._params.nameRow

		if self._controllersInitIndexMap.m_nameTypeController and self._controllersInitIndexMap.m_nameTypeController ~= var_8_4 then
			var_8_0.m_nameTypeController = var_8_4
		end
	end

	self:initControllers(var_8_0)
end

function BaseItemIcon:_updateDetailUI()
	local var_9_0 = self._params.size or 0
	local var_9_1 = self._params.min or var_9_0
	local var_9_2 = self._params.max or var_9_0
	local var_9_3 = self._params.numCost

	self._isBagNum = self._params.isBagNum or false
	self._hideNum = self._params.hideNum

	if self._isBagNum then
		var_9_0 = g.core.model.User.bagData:getCountById(var_0_3.TYPE_ITEM, self._params.value)
	end

	self:setNum(var_9_0, var_9_3, var_9_1, var_9_2)
	self:setNameRow(self._params.nameRow)
	self:setIconName(self._params.name)
	self:setQuality(self._params.quality, self._params.value)
	self:checkWeddingSpecialItem()

	if self._params.is_frag then
		if g.core.config.fragment_info.get(self._params.value).fragment_type == g.core.common.Goods.FRAGMENT.TYPE_KNIGHT then
			self.m_isFragController:setSelectedIndex(0)
		else
			self.m_isFragController:setSelectedIndex(1)
		end
	else
		self.m_isFragController:setSelectedIndex(0)
	end

	if self._params.iconScale then
		self.m_iconLoader:setScale(self._params.iconScale)
	end
end

function BaseItemIcon:setIconName(arg_10_1)
	if self._bindUINodes.nameText:getText() == arg_10_1 then
		return
	end

	arg_10_1 = arg_10_1 or ""

	self._bindUINodes.nameText:setText(arg_10_1)
end

function BaseItemIcon:setNum(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if self._hideNum or not arg_11_2 and (self._controllersInitIndexMap.m_isShowNumController or 0) == 1 then
		self:_setControllerIndex("m_isShowNumController", 1)

		return
	end

	if arg_11_2 then
		self._bindUINodes.numText:setText(g.core.lang:get(102512, {
			num = arg_11_1,
			max = arg_11_2
		}))

		if arg_11_1 < arg_11_2 then
			self:_setControllerIndex("m_isEnoughController", 0)
		else
			self:_setControllerIndex("m_isEnoughController", 1)
		end

		self:_setControllerIndex("m_isShowNumController", 0)
	else
		local var_11_1 = false

		if arg_11_3 and arg_11_4 and arg_11_3 ~= arg_11_4 then
			self._bindUINodes.numText:setText(g.core.lang:get(2072, {
				num1 = arg_11_3,
				num2 = arg_11_4
			}))

			var_11_1 = true
		else
			self._bindUINodes.numText:setText(arg_11_1)
		end

		self:_setControllerIndex("m_isShowNumController", (((self._isShowZeroNum or nil) and -1) < arg_11_1 or var_11_1) and 0 or 1)
		self:_setControllerIndex("m_isEnoughController", 1)
	end
end

function BaseItemIcon:setNameRow(arg_12_1)
	if arg_12_1 and self._bindControllers.m_nameTypeController then
		arg_12_1 = math.clamp(arg_12_1, 0, 2)

		self._bindControllers.m_nameTypeController:setSelectedIndex(arg_12_1)
	end
end

function BaseItemIcon:setQuality(arg_13_1, arg_13_2)
	if self._quality == arg_13_1 then
		return
	end

	self._quality = arg_13_1

	self._bindUINodes.bgLoader:setURL(var_0_1:getBaseItemIconQualityBg(arg_13_1))

	if not self._params then
		return
	end

	if (self._params.type == var_0_3.TYPE_FRAGMENT or nil) and self._params.info.fragment_type == var_0_3.TYPE_EQUIP then
		self:updateEquipQualityEffect(arg_13_1, arg_13_2)
	else
		self:updateEquipQualityEffect(0)
	end
end

function BaseItemIcon:updateEquipQualityEffect(arg_14_1, arg_14_2)
	for iter_14_0, iter_14_1 in pairs(self._qualityEffectIcon) do
		self._qualityEffectIcon[iter_14_0]:setVisible(false)
	end

	if arg_14_1 >= var_0_2.UR and arg_14_2 > 0 then
		self._qualityEffectIcon["eff_ui_equipment_128_" .. arg_14_2] = self._qualityEffectIcon["eff_ui_equipment_128_" .. arg_14_2] or self.m_effectIcon:addEffectSpine({
			anim = "play",
			scale = 0.25,
			isLoop = true,
			name = "eff_ui_equipment_128_" .. arg_14_2
		})

		self._qualityEffectIcon["eff_ui_equipment_128_" .. arg_14_2]:setVisible(true)
	end
end

function BaseItemIcon:setEmpty()
	self:setQuality(var_0_2.NONE)
	self:_setIcon("", false)
	self:setIconName("")
	self:setNum(-1)
end

function BaseItemIcon:checkWeddingSpecialItem()
	if self._params.type == var_0_3.TYPE_ITEM then
		local var_16_0 = g.core.model.User.weddingData:getWeddingSpRingAdvId(self._params.value)

		if var_16_0 > 0 then
			self.m_weddingKnight:setVisible(true)
			self.m_weddingKnight:updateIconComp(var_16_0)
		else
			self.m_weddingKnight:setVisible(false)
		end
	else
		self.m_weddingKnight:setVisible(false)
	end
end

return BaseItemIcon
