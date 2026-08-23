local var_0_0 = g.core.lang
local var_0_1 = g.core.model.User.equipmentData
local var_0_2 = g.core.const.ConstMgr.EquipConst
local InfoEquipFragAttrComp = class("InfoEquipFragAttrComp", require("app.fairyGUI.infoPop.UI_InfoEquipFragAttrComp"))

function InfoEquipFragAttrComp:ctor()
	self._equipId = 0
	self._id = 0
	self._knightPos = 0

	self:addListen(self.m_resonanceComp)
end

function InfoEquipFragAttrComp:updateShow(arg_2_1)
	self._baseId = arg_2_1.baseId

	local var_2_0 = g.core.config.equipment_info.get(self._baseId)

	self._equipConfigInfo = var_2_0

	self:_initCollectProgress()
	self:_showBaseStrengthAttrs()
	self:_showStrengthFullAttrs()
	self:_showRefineFullAttrs()
	self:_showGlyphFullAttrInfo()
	self:_showResonanceFullAttrs()
	self:_showMagicalFullAttrs()
	self.m_equipDescTxt:setText(var_2_0.description, true)
end

function InfoEquipFragAttrComp:_initCollectProgress()
	return
end

function InfoEquipFragAttrComp:_showBaseStrengthAttrs()
	local var_4_0, var_4_1 = var_0_0:getAttr(self._equipConfigInfo.strength_type, self._equipConfigInfo.strength_value)
	local var_4_2 = {}

	table.insert(var_4_2, {
		name = var_4_0,
		value = var_4_1,
		iconRes = self:_getIconResByAttrType(self._equipConfigInfo.strength_type)
	})
	self.m_basicAttrComp:updateAttrs({
		attrs = var_4_2
	})
end

function InfoEquipFragAttrComp:_showStrengthFullAttrs()
	local var_5_0 = var_0_1:getEquipMaxStrengthAttr({
		info = self._equipConfigInfo
	})
	local var_5_1, var_5_2 = var_0_0:getAttr(var_5_0[1].type, var_5_0[1].value)
	local var_5_3 = {}

	table.insert(var_5_3, {
		name = var_5_1,
		value = var_5_2,
		iconRes = self:_getIconResByAttrType(var_5_0[1].type)
	})
	self.m_strengthComp:updateAttrs({
		attrs = var_5_3,
		levelDesc = var_0_0:get(201561)
	})
end

function InfoEquipFragAttrComp:_showRefineFullAttrs()
	local var_6_0 = var_0_1:getEquipMaxRefineAttr({
		info = self._equipConfigInfo
	})
	local var_6_1 = {}

	for iter_6_0 = 1, 2 do
		if var_6_0[iter_6_0] then
			local var_6_2, var_6_3 = var_0_0:getAttr(var_6_0[iter_6_0].type, var_6_0[iter_6_0].value)

			table.insert(var_6_1, {
				name = var_6_2,
				value = var_6_3,
				iconRes = self:_getIconResByAttrType(var_6_0[iter_6_0].type)
			})
		end
	end

	self.m_refineComp:updateAttrs({
		attrs = var_6_1,
		levelDesc = var_0_0:get(201562)
	})
end

function InfoEquipFragAttrComp:_showGlyphFullAttrInfo()
	if var_0_2.EQUIP_GLYPH_OFF then
		self.m_glyphComp:setVisible(false)
	else
		local var_7_0 = var_0_1:getEquipMaxGlyAttr({
			info = self._equipConfigInfo
		})
		local var_7_1 = {}

		for iter_7_0 = 1, 2 do
			if var_7_0[iter_7_0] then
				local var_7_2, var_7_3 = var_0_0:getAttr(var_7_0[iter_7_0].type, var_7_0[iter_7_0].value)

				table.insert(var_7_1, {
					name = var_7_2,
					value = var_7_3,
					iconRes = self:_getIconResByAttrType(var_7_0[iter_7_0].type)
				})
			end
		end

		self.m_glyphComp:updateAttrs({
			attrs = var_7_1,
			levelDesc = var_0_0:get(201563)
		})
	end
end

function InfoEquipFragAttrComp:_getIconResByAttrType(arg_8_1)
	local var_8_0 = g.core.common.Path:getAttrIcon(arg_8_1)

	if var_8_0 and var_8_0 ~= "" then
		return var_8_0
	else
		return nil
	end
end

function InfoEquipFragAttrComp:_showResonanceFullAttrs()
	if self._equipConfigInfo.resonance_id > 0 then
		self.m_hasResonanceController:setSelectedIndex(1)
		self.m_resonanceComp:updateAttrs({
			isResonance = true,
			attrs = var_0_1:getAllResonanceAttr(self._equipConfigInfo.id),
			levelDesc = g.core.lang:get(201613, {
				level = var_0_1:getMaxResonanceInfo(self._equipConfigInfo.id).name
			})
		})
	else
		self.m_hasResonanceController:setSelectedIndex(0)
	end
end

function InfoEquipFragAttrComp:_showMagicalFullAttrs()
	if self._equipConfigInfo.quality >= g.core.const.ConstMgr.QUALITY_TYPE.UR then
		self.m_hasMagicalController:setSelectedIndex(1)

		local var_10_0 = {}

		for iter_10_0, iter_10_1 in pairs((g.core.model.User.equipmentData:getMagicalAttrMap(self._equipConfigInfo.advance_id, g.core.const.ConstMgr.EquipConst.MAGICAL_MAX_STAGE[self._equipConfigInfo.quality]))) do
			table.insert(var_10_0, {
				type = iter_10_0,
				value = iter_10_1
			})
		end

		self.m_magicalComp:updateAttrs({
			attrs = var_10_0,
			levelDesc = var_0_0:get(201620)
		})
	else
		self.m_hasMagicalController:setSelectedIndex(0)
	end
end

function InfoEquipFragAttrComp:receiveCompEvent(arg_11_1, arg_11_2)
	arg_11_2 = arg_11_2 or {}

	if arg_11_1 == "Click_InfoBtn" and arg_11_2.isResonance then
		g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.EquipResonanceSkillPop").new({
			equipId = self._equipConfigInfo.id,
			curLevel = var_0_1:getMaxResonanceInfo(self._equipConfigInfo.id).level
		})))
	end
end

return InfoEquipFragAttrComp
