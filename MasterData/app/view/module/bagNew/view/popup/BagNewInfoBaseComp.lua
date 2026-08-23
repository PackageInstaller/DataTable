local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.const.ConstMgr.QUALITY_TYPE
local BagNewInfoBaseComp = class("BagNewInfoBaseComp", require("app.fairyGUI.bagNew.UI_BagNewInfoBaseComp"))

function BagNewInfoBaseComp:ctor()
	self.m_bgDiLoader:setURL("pic/base_new/bg_yht_hz_right.png")
	self.m_iconLoader:addClickListener(handler(self, self._onIconClick))

	self._qualityEffectIcon = {}
	self._qualityEffectBg = nil
	self._magicalComp = nil
	self._maxStage = 0
end

function BagNewInfoBaseComp:setData(arg_2_1, arg_2_2)
	self._goodInfo = arg_2_1

	self.m_picBgLoader:setURL(arg_2_1.loaderUrl)
	self.m_iconLoader:setURL(arg_2_1.bigIcon or arg_2_1.icon)
	self.m_weddingKnight:setVisible(false)

	if arg_2_1.type == var_0_0.TYPE_ITEM and arg_2_1.value then
		local var_2_0 = g.core.model.User.weddingData:getWeddingSpRingAdvId(arg_2_1.value)

		if var_2_0 > 0 then
			self.m_weddingKnight:updateIconComp(var_2_0)
			self.m_weddingKnight:setVisible(true)
		end
	end

	self.m_titleTxt:setText(arg_2_1.title or arg_2_1.name)

	if arg_2_1.iconScale then
		self.m_iconLoader:setScale(arg_2_1.iconScale)
	end

	local var_2_1 = arg_2_1.bgUrl or ""

	self.m_bgLoader:setScale(arg_2_1.bgScale or 1)
	self.m_bgLoader:setAlpha(arg_2_1.bgOpacity or 1)
	self.m_bgLoader:setURL(var_2_1)
	self.m_effHolder:removeAllEffect()

	if arg_2_1.iconEffect then
		self.m_effHolder:addEffectSpine(arg_2_1.iconEffect)
	end

	local var_2_2 = 0
	local var_2_3 = 0

	self.m_magicalHolder:setVisible(false)

	if arg_2_2 then
		if arg_2_1.good.type == var_0_0.TYPE_EQUIP then
			var_2_2 = arg_2_1.good.quality
			var_2_3 = arg_2_1.good.value
		end
	else
		local var_2_4 = arg_2_1.equipData

		if arg_2_1.equipData then
			var_2_2 = var_2_4:getCfg().quality
			var_2_3 = var_2_4:getCfg().advance_id

			if var_2_4:hasMagical() and var_2_4:getMagicalStage() > 0 then
				self.m_magicalHolder:setVisible(true)

				local var_2_5 = var_2_4:getMaxMagicalStage()

				if not self._magicalComp or var_2_5 ~= self._maxStage then
					self._maxStage = var_2_5

					self.m_magicalHolder:removeChildren()

					self._magicalComp = fgui.UIPackage:createObject("base_new", "BaseEquipMagicalComp" .. var_2_5)

					self.m_magicalHolder:addChild(self._magicalComp)
					self._magicalComp:setPivot(0.5, 0.5, true)
					self._magicalComp:setPosition(0, 0)
					self._magicalComp:setScale(0.5)
				end

				self._magicalComp:updateTypeAndStage(var_2_4:getEquipmentType(), var_2_4:getMagicalStage(), var_2_5, nil, var_2_4:getQuality())
			end
		end
	end

	self:updateEquipQualityEffect(var_2_2, var_2_3)
end

function BagNewInfoBaseComp:updateEquipQualityEffect(arg_3_1, arg_3_2)
	for iter_3_0, iter_3_1 in pairs(self._qualityEffectIcon) do
		self._qualityEffectIcon[iter_3_0]:setVisible(false)
	end

	if arg_3_1 >= var_0_1.UR and arg_3_2 > 0 then
		if not self._qualityEffectBg then
			self.m_effectBg:removeAllEffect()

			self._qualityEffectBg = self.m_effectBg:addEffectSpine({
				anim = "play",
				scale = 0.5,
				name = "eff_ui_equipment_bg"
			})
		end

		self._qualityEffectBg:setVisible(true)

		self._qualityEffectIcon["eff_ui_equipment_" .. arg_3_2] = self._qualityEffectIcon["eff_ui_equipment_" .. arg_3_2] or self.m_effectIcon:addEffectSpine({
			anim = "play",
			scale = 0.5,
			isLoop = true,
			name = "eff_ui_equipment_" .. arg_3_2
		})

		self._qualityEffectIcon["eff_ui_equipment_" .. arg_3_2]:setVisible(true)
	elseif self._qualityEffectBg then
		self._qualityEffectBg:setVisible(false)
	end
end

function BagNewInfoBaseComp:_onIconClick()
	if self._goodInfo then
		g.core.common.GlobalFunc.pushInfoPop(self._goodInfo)
	end
end

return BagNewInfoBaseComp
