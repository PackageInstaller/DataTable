local var_0_0 = g.core.const.ConstMgr.EquipConst
local var_0_1 = g.core.config.equipment_resonance_info
local var_0_2 = g.core.model.User.equipmentData
local var_0_3 = g.core.common.ModuleUnlock
local var_0_4 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_5 = g.core.const.ConstMgr.QUALITY_TYPE
local BagNewEquipAttrComp = class("BagNewEquipAttrComp", require("app.fairyGUI.bagNew.UI_BagNewEquipAttrComp"))

function BagNewEquipAttrComp:ctor()
	self._magicalAttrList = {}
	self._resonanceAttrData = {}

	self.m_infoBtn:addClickListener(handler(self, self._onClickInfoBtn))
	self.m_resonanceAttrList:setVirtual()
	self.m_resonanceAttrList:setItemRenderer(handler(self, self._onAttrItemRender))
	self.m_magicalAttrList:setVirtual()
	self.m_magicalAttrList:setItemRenderer(handler(self, self._onRenderMagicalAttr))
end

function BagNewEquipAttrComp:updateAttrComp(arg_2_1, arg_2_2)
	self._isShowStr = var_0_3:isModuleShow(var_0_4.EQUIP_STRENGTH)
	self._isShowRef = var_0_3:isModuleShow(var_0_4.EQUIP_REFINE)
	self._isShowGly = var_0_3:isModuleShow(var_0_4.EQUIP_GLYPH)
	self._isShowResonance = var_0_3:isModuleShow(var_0_4.EQUIP_RESONANCE)
	self._isShowMagical = var_0_3:isModuleShow(var_0_4.EQUIP_MAGICAL)

	if var_0_0.EQUIP_GLYPH_OFF then
		self._isShowGly = false
	end

	self._isFrag = arg_2_2
	self._info = arg_2_1

	if arg_2_2 then
		self:_initAdvanceAttrInfo(arg_2_1.good, true)
		self:_initRefineAttrInfo(arg_2_1.good, true)
		self:_initGlyphAttrInfo(arg_2_1.good, true)

		self._isShowMagical = self._isShowMagical and arg_2_1.good.quality >= var_0_5.UR
	else
		self:_initAdvanceAttrInfo(arg_2_1.strengthAttrs)
		self:_initRefineAttrInfo(arg_2_1.refineAttrs)
		self:_initGlyphAttrInfo(arg_2_1.equipData)

		self._isShowMagical = self._isShowMagical and arg_2_1.equipData:getQuality() >= var_0_5.UR
	end

	self._hasResonance = arg_2_2 and arg_2_1.good.info.resonance_id > 0 or arg_2_1.equipData:hasResonance()

	self:_initResonanceAttrInfo()
	self.m_magicalAttrGroup:setVisible(self._isShowMagical)

	if self._isShowMagical then
		self:_initMagicalAttrInfo(arg_2_1, arg_2_2)
	end
end

function BagNewEquipAttrComp:_initAdvanceAttrInfo(arg_3_1, arg_3_2)
	if not arg_3_2 then
		if not self._isShowStr then
			self.m_adAttrGroup:setVisible(false)

			return
		end

		if not next(arg_3_1) then
			return
		end

		local var_3_1 = arg_3_1[1]
		local var_3_2, var_3_3 = g.core.lang:getAttr(arg_3_1[1].attr, arg_3_1[1].value)

		self.m_adLv:setText(g.core.lang:get(200508) .. arg_3_1.level .. "/" .. g.core.model.User:getLevel() * 2)
		self.m_adAttr:updateAttr({
			type = var_3_1.attr,
			value = var_3_1.value
		})
	else
		self.m_adLv:setText(g.core.lang:get(200509))
		self.m_adLv:setVisible(true)
		self.m_adAttr:updateAttr(g.core.model.User.equipmentData:getEquipMaxStrengthAttr(arg_3_1)[1])
	end
end

function BagNewEquipAttrComp:_initRefineAttrInfo(arg_4_1, arg_4_2)
	if not arg_4_2 then
		local var_4_0 = arg_4_1

		if not self._isShowRef then
			self.m_rfAttrGroup:setVisible(false)

			return
		end

		if not next(var_4_0) then
			return
		end

		local var_4_1 = var_4_0.level

		self.m_rfLv:setText(g.core.lang:get(200510) .. var_4_0.level .. "/" .. var_4_0.good.info.refine_level)
		self.m_rfLv:setVisible(var_4_1 > 0)

		for iter_4_0 = 1, 2 do
			self["m_rfAttr" .. iter_4_0]:setVisible(false)
		end

		if var_4_1 <= 0 then
			self.m_rfNotUpgrade:setVisible(true)
		else
			self.m_rfNotUpgrade:setVisible(false)

			for iter_4_1 = 1, #var_4_0 do
				self["m_rfAttr" .. iter_4_1]:setVisible(true)
				self["m_rfAttr" .. iter_4_1]:updateAttr({
					type = var_4_0[iter_4_1].attr,
					value = var_4_0[iter_4_1].value
				})
			end
		end
	else
		self.m_rfLv:setText(g.core.lang:get(200509))
		self.m_rfLv:setVisible(true)
		self.m_rfNotUpgrade:setVisible(false)

		local var_4_2 = g.core.model.User.equipmentData:getEquipMaxRefineAttr(arg_4_1)

		for iter_4_2 = 1, 2 do
			if var_4_2[iter_4_2] then
				self["m_rfAttr" .. iter_4_2]:setVisible(true)
				self["m_rfAttr" .. iter_4_2]:updateAttr(var_4_2[iter_4_2])
			else
				self["m_rfAttr" .. iter_4_2]:setVisible(false)
			end
		end
	end
end

function BagNewEquipAttrComp:_initGlyphAttrInfo(arg_5_1, arg_5_2)
	if not arg_5_2 then
		if not self._isShowGly then
			self.m_glyAttrGroup:setVisible(false)

			return
		end

		if not next(arg_5_1) then
			return
		end

		local var_5_0 = arg_5_1:getGlyphInfo()

		for iter_5_0 = 1, 2 do
			self["m_glyAttr" .. iter_5_0]:setVisible(false)
		end

		if var_5_0.level == 0 then
			self.m_glyLevel:setVisible(false)
			self.m_glyNotUpgrade:setVisible(true)
		else
			self.m_glyNotUpgrade:setVisible(false)

			for iter_5_1 = 1, 2 do
				if var_5_0["affect_value" .. iter_5_1] ~= 0 then
					self["m_glyAttr" .. iter_5_1]:setVisible(true)
					self["m_glyAttr" .. iter_5_1]:updateAttr({
						type = var_5_0.affect_type1,
						value = var_5_0.affect_value1
					})
				end
			end

			self.m_glyLevel:setText(g.core.lang:get(200511) .. var_5_0.name)
			self.m_glyLevel:setVisible(true)
		end
	else
		self.m_glyLevel:setVisible(true)
		self.m_glyLevel:setText(g.core.lang:get(200509))
		self.m_glyNotUpgrade:setVisible(false)

		local var_5_1 = g.core.model.User.equipmentData:getEquipMaxGlyAttr(arg_5_1)

		for iter_5_2 = 1, 2 do
			if var_5_1[iter_5_2] then
				self["m_glyAttr" .. iter_5_2]:setVisible(true)
				self["m_glyAttr" .. iter_5_2]:updateAttr(var_5_1[iter_5_2])
			else
				self["m_glyAttr" .. iter_5_2]:setVisible(false)
			end
		end
	end
end

function BagNewEquipAttrComp:_initResonanceAttrInfo()
	if self._isShowResonance then
		self.m_resonanceAttrGroup:setVisible(true)
	else
		self.m_resonanceAttrGroup:setVisible(false)

		return
	end

	if self._hasResonance then
		self.m_resonanceAttrGroup:setVisible(true)

		local var_6_2
		local var_6_3
		local var_6_4 = {}

		if self._isFrag then
			var_6_3 = var_0_2:getMaxResonanceInfo(self._info.good.info.id)
			var_6_2 = var_0_1.get(self._info.good.info.resonance_id, (var_6_3 or nil) and var_6_3.level)
			var_6_4 = var_0_2:getAllResonanceAttr(self._info.good.info.id)
		else
			local var_6_5 = self._info.equipData
			local var_6_6 = self._info.equipData:getResonanceLevel()
			local var_6_7 = self._info.equipData:getCfg()

			var_6_3 = var_0_2:getMaxResonanceInfo(var_6_7.id)

			if var_6_3 then
				-- block empty
			end

			if var_6_6 == 0 then
				var_6_6 = 1
			end

			var_6_2 = var_0_1.get(var_6_7.resonance_id, var_6_6)
			var_6_4 = var_6_5:getCurResonanceAttrData()
		end

		self.m_resonLevelTxt:setText(g.core.lang:get(201602, {
			level1 = var_6_2.name,
			level2 = var_6_3.name
		}))

		if next(var_6_4) then
			self.m_resonanceAttrList:setVisible(true)
			self.m_resonanceNotUpgrade:setVisible(false)

			self._resonanceAttrData = var_6_4

			self.m_resonanceAttrList:setNumItems(#var_6_4)
		else
			self.m_resonanceAttrList:setVisible(false)
			self.m_resonanceNotUpgrade:setVisible(true)
		end
	else
		self.m_resonanceAttrGroup:setVisible(false)
	end
end

function BagNewEquipAttrComp:_initMagicalAttrInfo(arg_7_1, arg_7_2)
	if arg_7_2 then
		self.m_magicalLv:setText(g.core.lang:get(200529))

		self._magicalAttrList = {}

		for iter_7_0, iter_7_1 in pairs((var_0_2:getMagicalAttrMap(arg_7_1.good.value, var_0_0.MAGICAL_MAX_STAGE[arg_7_1.good.quality]))) do
			table.insert(self._magicalAttrList, {
				type = iter_7_0,
				value = iter_7_1
			})
		end
	else
		local var_7_0 = arg_7_1.equipData

		self.m_magicalLv:setText(g.core.lang:get(200530, {
			level = arg_7_1.equipData:getMagicalStage(),
			maxLevel = arg_7_1.equipData:getMaxMagicalStage()
		}))

		self._magicalAttrList = {}

		for iter_7_2, iter_7_3 in pairs((var_7_0:getMagicalAttrMap())) do
			table.insert(self._magicalAttrList, {
				type = iter_7_2,
				value = iter_7_3
			})
		end
	end

	self.m_magicalAttrList:setNumItems(#self._magicalAttrList)
	self.m_magicalNotUpgrade:setVisible(#self._magicalAttrList == 0)
end

function BagNewEquipAttrComp:_onClickInfoBtn()
	local var_8_0
	local var_8_1

	if self._isFrag then
		var_8_0 = self._info.good.info.id

		local var_8_2 = var_0_2:getMaxResonanceInfo(self._info.good.info.id)

		if var_8_2 then
			var_8_1 = var_8_2.level
		end
	else
		var_8_0 = self._info.equipData:getCfg().id
		var_8_1 = self._info.equipData:getResonanceLevel()
	end

	g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.EquipResonanceSkillPop").new({
		equipId = var_8_0,
		curLevel = var_8_1
	})))
end

function BagNewEquipAttrComp:_onAttrItemRender(arg_9_1, arg_9_2)
	if self._resonanceAttrData[arg_9_1 + 1] then
		arg_9_2:updateAttr(self._resonanceAttrData[arg_9_1 + 1])
		arg_9_2:setWidth(185)
	end
end

function BagNewEquipAttrComp:_onRenderMagicalAttr(arg_10_1, arg_10_2)
	if self._magicalAttrList[arg_10_1 + 1] then
		arg_10_2:updateAttr(self._magicalAttrList[arg_10_1 + 1])
		arg_10_2:setWidth(185)
	end
end

return BagNewEquipAttrComp
