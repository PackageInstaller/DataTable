local BaseIconComp = require("app.view.base.icon.BaseIconComp")
local BaseEquipIcon = class("BaseEquipIcon", BaseIconComp)
local var_0_2 = g.core.common.Path
local var_0_3 = g.core.common.Goods
local var_0_4 = g.core.const.ConstMgr.QUALITY_TYPE
local TreasureConst = require("app.view.module.equipAndTreasure.const.TreasureConst")
local var_0_6 = g.core.const.ConstMgr.EquipConst

function BaseEquipIcon:ctor()
	BaseEquipIcon._bindMethods(self)
	BaseIconComp.ctor(self)

	self._level = -1
	self._qualityEffectEnable = false
	self._refineLevel = -1
	self._qualityEffectIcon = {}
	self._magicalComp = nil
	self._maxStage = 0
end

function BaseEquipIcon:_bindMethods()
	local var_2_0

	if self._bindAllUI then
		do return end

		var_2_0 = {}
	end

	for iter_2_0, iter_2_1 in ipairs((rawget(rawget(BaseEquipIcon, "__index"), "__supers"))) do
		var_2_0 = BaseEquipIcon._addClassMethodsToMethodList(self, iter_2_1, var_2_0)
	end

	for iter_2_2, iter_2_3 in pairs((BaseEquipIcon._addClassMethodsToMethodList(self, BaseEquipIcon, var_2_0))) do
		if not self[iter_2_2] then
			self[iter_2_2] = iter_2_3
		elseif type(iter_2_2) == "function" and type(self[iter_2_2]) == "function" then
			-- block empty
		end
	end
end

function BaseEquipIcon:_addClassMethodsToMethodList(arg_3_1, arg_3_2)
	local var_3_0 = {
		super = true,
		_bindMethods = true,
		create = true,
		__cname = true,
		ctor = true,
		_addClassMethodsToMethodList = true,
		new = true,
		__supers = true,
		__newindex = true,
		__index = true
	}

	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		if not var_3_0[iter_3_0] then
			arg_3_2[iter_3_0] = iter_3_1
		end
	end

	return arg_3_2
end

function BaseEquipIcon:_addTouchFunc()
	self:addClickListener(handler(self, self._onClickIcon))
end

function BaseEquipIcon:_onClickIcon()
	if self._touchFunc then
		self:_touchFunc()
	end
end

function BaseEquipIcon:_bindAllUIAndControllers()
	if self.m_iconLoader then
		self:_bindIconLoader(self.m_iconLoader)
	else
		self:_bindIconLoader(self.m_icon)
	end

	self:_bindUI(self.m_numText, "numText")
	self:_bindUI(self.m_bgLoader, "bgLoader")
	self:_bindUI(self.m_refineBg, "refineBg")
	self:_bindUI(self.m_refineText, "refineText")
	self:_bindUI(self.m_levelBg, "levelBg")
	self:_bindUI(self.m_levelText, "levelText")
	self:_bindUI(self.m_grayGraph, "grayGraph")
	self:_bindUI(self.m_nameTxt, "nameText")
	self:_bindUI(self.m_resonanceLevelComp, "resonanceLevelComp")
	self:_bindUI(self.m_itemSpecialUseLoader, "itemSpecialUseLoader")
	self:_bindUI(self.m_magicalHolder, "magicalHolder")
	self:_bindController(self.m_showLevelController, "m_showLevelController")
	self:_bindController(self.m_isShowRefineController, "m_isShowRefineController")
	self:_bindController(self.m_isShowNumController, "m_isShowNumController")
	self:_bindController(self.m_isDiamondController, "m_isDiamondController")
	self:_bindController(self.m_isGlyphController, "m_isGlyphController")
	self:_bindController(self.m_isEnoughController, "m_isEnoughController")
	self:_bindController(self.m_nameTypeController, "m_nameTypeController")
	self:_bindController(self.m_isLockController, "m_isLockController")
	self:_bindController(self.m_showResonanceController, "m_showResonanceController")
end

function BaseEquipIcon:_changeControllers(arg_7_1, arg_7_2)
	local var_7_0 = {}

	if self._controllersInitIndexMap.m_isShowRefineController and (self._params.refineLevel or self._otherInfo.refineLevel) then
		if self._controllersInitIndexMap.m_isShowRefineController ~= 1 then
			var_7_0.m_isShowRefineController = 1
		end
	end

	if self._controllersInitIndexMap.m_showLevelController and (self._params.level or self._otherInfo.level) then
		if self._controllersInitIndexMap.m_showLevelController ~= 1 then
			var_7_0.m_showLevelController = 1
		end
	end

	if self._controllersInitIndexMap.m_isGlyphController and (self._params.glyphLevel or self._otherInfo.glyphLevel) then
		if self._controllersInitIndexMap.m_isGlyphController ~= 1 then
			var_7_0.m_isGlyphController = 1
		end
	end

	if self._controllersInitIndexMap.m_isShowNumController and self._params.size then
		if self._controllersInitIndexMap.m_isShowNumController ~= 0 then
			var_7_0.m_isShowNumController = 0
		end
	end

	if self._params.nameRow or self._otherInfo.nameRow then
		local var_7_6 = self._params.nameRow

		if self._controllersInitIndexMap.m_nameTypeController and self._controllersInitIndexMap.m_nameTypeController ~= var_7_6 then
			var_7_0.m_nameTypeController = var_7_6
		end
	end

	self:initControllers(var_7_0)
end

function BaseEquipIcon:_checkAndFixParams(arg_8_1, arg_8_2)
	if not arg_8_1.icon then
		local var_8_0 = var_0_3:convert({
			type = arg_8_1.type,
			value = arg_8_1.value,
			size = arg_8_1.size
		})

		for iter_8_0, iter_8_1 in pairs(arg_8_1) do
			var_8_0[iter_8_0] = var_8_0[iter_8_0] or iter_8_1
		end

		arg_8_1 = var_8_0
	end

	return arg_8_1
end

function BaseEquipIcon:_updateDetailUI()
	local var_9_0 = self._params.level or self._otherInfo.level
	local var_9_1 = self._params.refineLevel or self._otherInfo.refineLevel
	local var_9_2 = self._params.glyphLevel or self._otherInfo.glyphLevel
	local var_9_3 = self._params.magicalStage or 0

	if not self._params.forceFrag then
		-- block empty
	end

	local var_9_5 = self._params.resonanceState or 0

	if self._bindControllers.m_isDiamondController then
		self._bindControllers.m_isDiamondController:setSelectedIndex(self._params.isDiamond and 1 or 0)
	end

	self:setLevel(var_9_0)
	self:setRefineLevel(var_9_1)

	local var_9_6 = self._controllersInitIndexMap.m_isGlyphController
	local var_9_7 = self._bindControllers.m_isGlyphController

	if self._bindControllers.m_isGlyphController then
		if (var_9_2 or 0) > 0 and var_9_6 == 1 then
			if self._type == var_0_3.TYPE_TREASURE and not TreasureConst.IS_FORBID_GLYPH or self._type == var_0_3.TYPE_EQUIP and var_0_6.EQUIP_GLYPH_OFF then
				var_9_7:setSelectedIndex(0)
			else
				self.m_glyphQualityComp:updateView(self._params)
				var_9_7:setSelectedIndex(var_9_6)
			end
		else
			var_9_7:setSelectedIndex(0)
		end
	end

	self:setTouchable(true)
	self:setQuality(self._params.quality, self._params.isBlack, self._params.value)
	self:setNum(self._params.size, self._params.numCost, self._params.min, self._params.max)
	self:setNameRow(self._params.nameRow)
	self:setIconName(self._params.name)
	self:_setItemSpecialUseType()

	if self._type and self._type == g.core.common.Goods.TYPE_TREASURE then
		self:_setControllerIndex("m_showResonanceController", 0)
		self:_setTreasureLockState()
	else
		self:_setResonanceLevel(var_9_5)
	end

	local var_9_8 = self._params.info

	if self._type and self._type == g.core.common.Goods.TYPE_EQUIP and var_9_8 and var_9_8.quality >= 4 then
		self:_setMagicalStage(var_9_3)
	else
		self:_setMagicalStage(0)
	end
end

function BaseEquipIcon:setIconName(arg_10_1)
	if not self._bindUINodes.nameText then
		return
	end

	if self._bindUINodes.nameText:getText() == arg_10_1 then
		return
	end

	arg_10_1 = arg_10_1 or ""

	self._bindUINodes.nameText:setText(arg_10_1)
end

function BaseEquipIcon:setNameRow(arg_11_1)
	if not arg_11_1 or not self._bindControllers.m_nameTypeController then
		return
	end

	if arg_11_1 < 0 then
		arg_11_1 = 0
	elseif arg_11_1 > 2 then
		arg_11_1 = 2
	end

	self._bindControllers.m_nameTypeController:setSelectedIndex(arg_11_1)
end

function BaseEquipIcon:setQuality(arg_12_1, arg_12_2, arg_12_3)
	self:updateEquipQualityEffect(arg_12_1, arg_12_3)

	if arg_12_1 ~= var_0_4.NONE and self._quality == arg_12_1 then
		return
	end

	self._quality = arg_12_1

	if self._bindControllers.m_isDiamondController and self._bindControllers.m_isDiamondController:getSelectedIndex() == 1 then
		self._bindUINodes.bgLoader:setURL(var_0_2:getEquipIconQualityDiamondBg(arg_12_1))
	elseif arg_12_2 then
		self._bindUINodes.bgLoader:setURL(var_0_2:getEquipIconQualityBlackBg(arg_12_1))
	else
		self._bindUINodes.bgLoader:setURL(var_0_2:getBaseIconQualityBg(arg_12_1))
	end
end

function BaseEquipIcon:hideQualityEffect()
	for iter_13_0, iter_13_1 in pairs(self._qualityEffectIcon) do
		self._qualityEffectIcon[iter_13_0]:setVisible(false)
	end
end

function BaseEquipIcon:updateEquipQualityEffect(arg_14_1, arg_14_2)
	self:hideQualityEffect()

	if self._type == var_0_3.TYPE_EQUIP then
		self:updateEquipmentQualityEffect(arg_14_1, arg_14_2)
	elseif self._type == var_0_3.TYPE_TREASURE then
		self:updateTreasureQualityEffect(arg_14_1, arg_14_2)
	end
end

function BaseEquipIcon:setQualityEffectEnable(arg_15_1)
	self._qualityEffectEnable = arg_15_1
end

function BaseEquipIcon:updateEquipmentQualityEffect(arg_16_1, arg_16_2)
	if arg_16_1 >= var_0_4.UR and arg_16_2 > 0 then
		self._qualityEffectIcon["eff_ui_equipment_128_" .. arg_16_2] = self._qualityEffectIcon["eff_ui_equipment_128_" .. arg_16_2] or self.m_effectIcon:addEffectSpine({
			isLoop = true,
			anim = "play",
			scale = 0.25,
			name = "eff_ui_equipment_128_" .. arg_16_2
		})

		self._qualityEffectIcon["eff_ui_equipment_128_" .. arg_16_2]:setVisible(true)
	end
end

function BaseEquipIcon:updateTreasureQualityEffect(arg_17_1, arg_17_2)
	if not self._qualityEffectEnable then
		return
	end

	if arg_17_1 >= var_0_4.UR and arg_17_2 > 0 then
		local var_17_0 = arg_17_1 == var_0_4.UR and "eff_ui_treasure128_down" or "eff_ui_treasure128_downMR"
		local var_17_1 = self._qualityEffectIcon[arg_17_1 == var_0_4.UR and "eff_ui_treasure128_down" or "eff_ui_treasure128_downMR"]

		if not self._qualityEffectIcon[arg_17_1 == var_0_4.UR and "eff_ui_treasure128_down" or "eff_ui_treasure128_downMR"] then
			var_17_1 = self.m_effectIconDown:addEffectSpine({
				isLoop = true,
				anim = "play",
				scale = 0.8,
				name = var_17_0
			})
			self._qualityEffectIcon[var_17_0] = var_17_1
		end

		var_17_1:setVisible(true)

		self._qualityEffectIcon["eff_ui_treasure128_" .. arg_17_2] = self._qualityEffectIcon["eff_ui_treasure128_" .. arg_17_2] or self.m_effectIcon:addEffectSpine({
			isLoop = true,
			anim = "play",
			scale = 0.8,
			name = "eff_ui_treasure128_" .. arg_17_2
		})

		self._qualityEffectIcon["eff_ui_treasure128_" .. arg_17_2]:setVisible(true)
	end
end

function BaseEquipIcon:setLevel(arg_18_1)
	arg_18_1 = arg_18_1 or 0

	local var_18_0 = self._controllersInitIndexMap.m_showLevelController

	if self._controllersInitIndexMap.m_showLevelController == 0 or self._level == arg_18_1 then
		return
	end

	self._bindUINodes.levelText:setText(g.core.lang:get(2052, {
		level = arg_18_1
	}))

	if arg_18_1 < 1 then
		self:_setControllerIndex("m_showLevelController", 0)
	else
		self:_setControllerIndex("m_showLevelController", var_18_0)
	end

	self._level = arg_18_1
end

function BaseEquipIcon:setRefineLevel(arg_19_1)
	arg_19_1 = arg_19_1 or 0

	local var_19_0 = self._controllersInitIndexMap.m_isShowRefineController

	if self._controllersInitIndexMap.m_isShowRefineController == 0 or self._refineLevel == arg_19_1 then
		return
	end

	local var_19_1 = self._bindUINodes.refineText

	if arg_19_1 < 1 then
		self:_setControllerIndex("m_isShowRefineController", 0)
	else
		self:_setControllerIndex("m_isShowRefineController", var_19_0)
		var_19_1:setText(g.core.lang:get(2050, {
			level = arg_19_1
		}))
	end

	self._refineLevel = arg_19_1
end

function BaseEquipIcon:setEquipEmpty()
	self:setEmpty()
end

function BaseEquipIcon:setEmpty()
	if self._bindControllers.m_isDiamondController then
		self._bindControllers.m_isDiamondController:setSelectedIndex(self._params.isDiamond and 1 or 0)
	end

	self:setQuality(var_0_4.NONE, self._params.isBlack)
	self:setRefineLevel(-1)
	self:setLevel(0)
	self:setTouchable(false)
	self:_setIcon("", false)
	self:setNum(-1)
	self:_setControllerIndex("m_isGlyphController", 0)
	self:_setResonanceLevel(0)
	self.m_magicalHolder:setVisible(false)
end

function BaseEquipIcon:setNum(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	if not arg_22_2 and (self._controllersInitIndexMap.m_isShowNumController or 0) == 1 then
		self:_setControllerIndex("m_isShowNumController", 1)

		return
	end

	if arg_22_2 then
		self._bindUINodes.numText:setText(g.core.lang:get(102512, {
			num = arg_22_1,
			max = arg_22_2
		}))

		if arg_22_1 < arg_22_2 then
			self:_setControllerIndex("m_isEnoughController", 0)
		else
			self:_setControllerIndex("m_isEnoughController", 1)
		end

		self:_setControllerIndex("m_isShowNumController", 0)
	else
		local var_22_1 = false

		if arg_22_3 and arg_22_4 and arg_22_3 ~= arg_22_4 then
			self._bindUINodes.numText:setText(g.core.lang:get(2072, {
				num1 = arg_22_3,
				num2 = arg_22_4
			}))

			var_22_1 = true
		else
			self._bindUINodes.numText:setText(arg_22_1)
		end

		self:_setControllerIndex("m_isEnoughController", 1)
		self:_setControllerIndex("m_isShowNumController", (((self._isShowZeroNum or nil) and -1) < arg_22_1 or var_22_1) and 0 or 1)
	end
end

function BaseEquipIcon:_setTreasureLockState()
	if not self._bindControllers.m_isLockController then
		return
	end

	self._bindControllers.m_isLockController:setSelectedIndex(0)

	if not self._params.numCost then
		if self._params.treasureOnlyId then
			local var_23_0 = g.core.model.User.treasureData:getTreasureDataByOnlyId(self._params.treasureOnlyId)

			if var_23_0 and var_23_0.lock then
				self._bindControllers.m_isLockController:setSelectedIndex(1)
			end
		end
	end
end

function BaseEquipIcon:_setResonanceLevel(arg_24_1)
	arg_24_1 = math.clamp(arg_24_1, 0, 2)

	if self._type == var_0_3.TYPE_EQUIP and self._params.info and self._params.info.resonance_id > 0 then
		self:_setControllerIndex("m_showResonanceController", arg_24_1)

		if self._params.resonanceLevel then
			self.m_resonanceLevelComp:setResonanceLevel(self._params.resonanceLevel)
		end
	else
		self:_setControllerIndex("m_showResonanceController", 0)
	end
end

function BaseEquipIcon:_setMagicalStage(arg_25_1)
	local var_25_0 = self._params.info
	local var_25_1 = self:_getMagicalMaxStage(self._params.info.quality)

	if var_25_1 == 0 or arg_25_1 == 0 then
		self.m_magicalHolder:setVisible(false)

		return
	end

	self.m_magicalHolder:setVisible(true)

	if not self._magicalComp or var_25_1 ~= self._maxStage then
		self._maxStage = var_25_1

		self.m_magicalHolder:removeChildren()

		self._magicalComp = fgui.UIPackage:createObject("base_new", "BaseEquipMagicalComp" .. var_25_1)

		self.m_magicalHolder:addChild(self._magicalComp)
		self._magicalComp:setPivot(0.5, 0.5, true)
		self._magicalComp:setPosition(0, 0)
	end

	self._magicalComp:setScale(self._params.magicalScale or 0.2)
	self._magicalComp:updateTypeAndStage(var_25_0.equipment_type, arg_25_1, var_25_1, self._params.nextStage, var_25_0.quality)
end

function BaseEquipIcon:_getMagicalType(arg_26_1)
	if (self._params.magicalStage or 0) > 0 and arg_26_1 == g.core.const.ConstMgr.QUALITY_TYPE.UR then
		return g.core.const.ConstMgr.EquipConst.MAGICAL_SHOW_TYPE.SHOW_5
	end

	return g.core.const.ConstMgr.EquipConst.MAGICAL_SHOW_TYPE.NOT_SHOW
end

function BaseEquipIcon:_getMagicalMaxStage(arg_27_1)
	return g.core.const.ConstMgr.EquipConst.MAGICAL_MAX_STAGE[arg_27_1]
end

function BaseEquipIcon:_setItemSpecialUseType()
	if not self.m_itemSpecialUseLoader then
		return
	end

	self.m_itemSpecialUseLoader:setVisible(false)

	if self._type and self._type == var_0_3.TYPE_TREASURE and g.core.config.treasure_info.get(self._params.value).type == 3 then
		self.m_itemSpecialUseLoader:setVisible(true)
		self.m_itemSpecialUseLoader:setURL(g.core.const.ConstMgr.BASE_CONST.ICON_SPECIAL_USE_TYPE[2])
	end
end

return BaseEquipIcon
