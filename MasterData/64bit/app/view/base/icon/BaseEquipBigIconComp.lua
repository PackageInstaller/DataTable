local var_0_0 = g.core.const.ConstMgr.EquipConst
local BaseEquipBigIconComp = class("BaseEquipBigIconComp", require("app.fairyGUI.equipAndTreasure.UI_BaseEquipBigIconComp"))

function BaseEquipBigIconComp:ctor()
	self._bgEffect = nil
	self._iconEffect = nil
	self._equip = nil
	self._magicalComp = nil
	self._maxStage = 0
end

function BaseEquipBigIconComp:updateIcon(arg_2_1)
	self._equip = arg_2_1.equip

	if arg_2_1.icon then
		self:setIcon(arg_2_1.icon)
	else
		self:setIcon(g.core.common.Goods:convert({
			type = g.core.common.Goods.TYPE_EQUIP,
			value = arg_2_1.equip:getCfg().id
		}).pic)
	end

	self.m_effectBg:setVisible(false)
	self.m_effectIcon:setVisible(false)

	if arg_2_1.id and g.core.config.equipment_info.get(arg_2_1.id).quality >= g.core.const.ConstMgr.QUALITY_TYPE.UR then
		self._bgEffect = self._bgEffect or self.m_effectBg:addEffectSpine({
			anim = "play",
			name = "eff_ui_equipment_bg"
		})

		if not self._iconEffect then
			self._iconEffect = self.m_effectIcon:addEffectSpine({
				isLoop = true,
				anim = "play",
				name = "eff_ui_equipment_" .. arg_2_1.id
			})
		elseif self._iconEffect:getResId() ~= "eff_ui_equipment_" .. arg_2_1.id then
			self.m_effectIcon:removeAllEffect()

			self._iconEffect = self.m_effectIcon:addEffectSpine({
				isLoop = true,
				anim = "play",
				name = "eff_ui_equipment_" .. arg_2_1.id
			})
		end

		self.m_effectBg:setVisible(true)
		self.m_effectIcon:setVisible(true)
	end

	if self._equip and self._equip:hasMagical() and self._equip:getMagicalStage() > 0 then
		self.m_magicalHolder:setVisible(true)

		local var_2_0 = var_0_0.MAGICAL_MAX_STAGE[self._equip:getQuality()]

		if not self._magicalComp or var_2_0 ~= self._maxStage then
			self._maxStage = var_2_0

			self.m_magicalHolder:removeChildren()

			self._magicalComp = fgui.UIPackage:createObject("base_new", "BaseEquipMagicalComp" .. var_2_0)

			self.m_magicalHolder:addChild(self._magicalComp)
			self._magicalComp:setPivot(0.5, 0.5, true)
			self._magicalComp:setPosition(0, 0)
		end

		self._magicalComp:updateTypeAndStage(self._equip:getEquipmentType(), self._equip:getMagicalStage(), var_2_0, arg_2_1.nextStage, self._equip:getQuality())
	else
		self.m_magicalHolder:setVisible(false)
	end
end

function BaseEquipBigIconComp:playEquipMagicalStageUpEff(arg_3_1)
	if self._magicalComp then
		self._magicalComp:playStageUpEff(arg_3_1)
	end
end

return BaseEquipBigIconComp
