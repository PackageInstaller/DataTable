local var_0_0 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.const.ConstMgr.EquipConst
local LineUpEquipIcon = class("LineUpEquipIcon", require("app.fairyGUI.lineUp.UI_LineUpEquipIcon"))

function LineUpEquipIcon:ctor()
	self._qualityEffectIcon = {}
	self._equip = nil
	self._maxStage = 0
	self._magicalComp = nil
end

function LineUpEquipIcon:updateEquipIcon(arg_2_1, arg_2_2)
	self._equip = arg_2_1

	if arg_2_1 then
		local var_2_0 = arg_2_1:hasResonance()

		self.m_resonanceLevel:setVisible(var_2_0)

		if var_2_0 then
			self.m_resonanceLevel:setResonanceLevel((arg_2_1:getResonanceLevel()))
		end

		local var_2_1 = arg_2_1:getServerData()
		local var_2_2 = var_0_2:convert({
			type = var_0_2.TYPE_EQUIP,
			value = var_2_1.base_id
		})

		self:setIcon(var_2_2.icon)
		self.m_equipLevel:setVisible(true)
		self.m_equipLevel:updateLevel(true, var_2_1.level, var_2_1.refining_level)
		self:updateEquipQualityEffect(var_2_2.quality, var_2_1.base_id)

		if arg_2_1:hasMagical() and arg_2_1:getMagicalStage() > 0 then
			self.m_magicalHolder:setVisible(true)
			self:_updateEquipMagical()
		else
			self.m_magicalHolder:setVisible(false)
		end
	else
		self.m_magicalHolder:setVisible(false)
		self:setScale(1)
		self:setIcon((var_0_1:getEmptyEquipPicIconByPos(arg_2_2)))
		self.m_equipLevel:setVisible(false)
		self.m_resonanceLevel:setVisible(false)
		self:updateEquipQualityEffect(0)
	end
end

function LineUpEquipIcon:updateOtherEquipIcon(arg_3_1, arg_3_2)
	self._equip = arg_3_1

	if arg_3_1 then
		local var_3_0 = g.core.common.ModuleUnlock:getModuleUnlockLevel(g.core.const.ConstMgr.FUNCTION_TYPE.EQUIP_RESONANCE) <= g.core.model.User.playerInfoData:getPlayerSnapShot().level and arg_3_1:getCfg().resonance_id > 0

		self.m_resonanceLevel:setVisible(var_3_0)

		if var_3_0 then
			self.m_resonanceLevel:setResonanceLevel((arg_3_1:getResonanceLevel()))
		end

		local var_3_1 = arg_3_1:getServerData()
		local var_3_2 = var_0_2:convert({
			type = var_0_2.TYPE_EQUIP,
			value = var_3_1.base_id
		})

		self:setIcon(var_3_2.icon)
		self.m_equipLevel:setVisible(true)
		self.m_equipLevel:updateLevel(true, var_3_1.level, var_3_1.refining_level)
		self:updateEquipQualityEffect(var_3_2.quality, var_3_1.base_id)

		if arg_3_1:hasMagical() and arg_3_1:getMagicalStage() > 0 then
			self.m_magicalHolder:setVisible(true)
			self:_updateEquipMagical()
		else
			self.m_magicalHolder:setVisible(false)
		end
	else
		self.m_magicalHolder:setVisible(false)
		self:setScale(1)
		self:setIcon((var_0_1:getEmptyEquipPicIconByPos(arg_3_2)))
		self.m_equipLevel:setVisible(false)
		self.m_resonanceLevel:setVisible(false)
		self:updateEquipQualityEffect(0)
	end
end

function LineUpEquipIcon:updateEquipQualityEffect(arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in pairs(self._qualityEffectIcon) do
		self._qualityEffectIcon[iter_4_0]:setVisible(false)
	end

	if arg_4_1 >= var_0_0.UR and arg_4_2 > 0 then
		self._qualityEffectIcon["eff_ui_equipment_128_" .. arg_4_2] = self._qualityEffectIcon["eff_ui_equipment_128_" .. arg_4_2] or self.m_effectIcon:addEffectSpine({
			scale = 0.25,
			isLoop = true,
			anim = "play",
			name = "eff_ui_equipment_128_" .. arg_4_2
		})

		self._qualityEffectIcon["eff_ui_equipment_128_" .. arg_4_2]:setVisible(true)
	end
end

function LineUpEquipIcon:_updateEquipMagical()
	local var_5_0 = var_0_3.MAGICAL_MAX_STAGE[self._equip:getQuality()]

	if not self._magicalComp or var_5_0 ~= self._maxStage then
		self._maxStage = var_5_0

		self.m_magicalHolder:removeChildren()

		self._magicalComp = fgui.UIPackage:createObject("base_new", "BaseEquipMagicalComp" .. var_5_0)

		self.m_magicalHolder:addChild(self._magicalComp)
		self._magicalComp:setPivot(0.5, 0.5, true)
		self._magicalComp:setPosition(0, 0)
		self._magicalComp:setScale(0.2)
	end

	self._magicalComp:updateTypeAndStage(self._equip:getEquipmentType(), self._equip:getMagicalStage(), var_5_0, nil, self._equip:getQuality())
end

return LineUpEquipIcon
