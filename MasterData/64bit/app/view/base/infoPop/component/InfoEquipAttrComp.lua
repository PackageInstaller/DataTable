local var_0_0 = g.core.model.User.equipmentData
local var_0_1 = g.core.const.ConstMgr.EquipConst
local var_0_2 = g.core.lang
local InfoEquipAttrComp = class("InfoEquipAttrComp", require("app.fairyGUI.infoPop.UI_InfoEquipAttrComp"))

function InfoEquipAttrComp:ctor()
	self._equipId = 0
	self._id = 0
	self._knightPos = 0

	self:addListen(self.m_resonanceComp)
end

function InfoEquipAttrComp:updateShow(arg_2_1)
	self._equipData = arg_2_1.equipData
	self._knightPos = arg_2_1.pos

	local var_2_0 = self._equipData:getCfg()
	local var_2_1 = self._equipData:getServerData()

	self._equipId = var_2_1.base_id
	self._id = var_2_1.id

	local var_2_2, var_2_3, var_2_4 = self._equipData:getEquipAttrAll()

	self:_initStrengthAttrs(var_2_2)
	self:_initRefineAttrs(var_2_3, var_2_0)
	self:_initGlyphAttrInfo()
	self:_initResonanceAttrs()
	self:_initMagicalAttrs()
	self.m_equipDescTxt:setText(var_2_0.description, true)
end

function InfoEquipAttrComp:_initStrengthAttrs(arg_3_1)
	local var_3_0 = {}
	local var_3_1 = ""

	if g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.EQUIP_STRENGTH) then
		local var_3_2 = arg_3_1.level

		if arg_3_1.level == g.core.model.User:getMaxLevel() * 2 then
			var_3_1 = var_0_2:get(201561)
		else
			local var_3_3 = {
				num1 = var_3_2
			}

			var_3_3.num2 = g.core.model.User:getLevel() * 2
			var_3_1 = var_0_2:get(201559, var_3_3)
		end

		for iter_3_0 = 1, #arg_3_1 do
			local var_3_4, var_3_5 = var_0_2:getAttr(arg_3_1[iter_3_0].attr, arg_3_1[iter_3_0].value)

			table.insert(var_3_0, {
				name = var_3_4,
				value = var_3_5,
				iconRes = self:_getIconResByAttrType(arg_3_1[iter_3_0].attr)
			})
		end

		self.m_strengthComp:updateAttrs({
			attrs = var_3_0,
			levelDesc = var_3_1
		})
	end
end

function InfoEquipAttrComp:_initRefineAttrs(arg_4_1, arg_4_2)
	local var_4_0 = {}
	local var_4_1 = ""

	if g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.EQUIP_REFINE) then
		local var_4_2 = arg_4_1.level

		if arg_4_1.level == arg_4_2.refine_level then
			var_4_1 = var_0_2:get(201562)
		else
			local var_4_3 = {
				num1 = var_4_2
			}

			var_4_3.num2 = arg_4_2.refine_level
			var_4_1 = var_0_2:get(201560, var_4_3)
		end

		for iter_4_0 = 1, #arg_4_1 do
			local var_4_4, var_4_5 = var_0_2:getAttr(arg_4_1[iter_4_0].attr, arg_4_1[iter_4_0].value)

			table.insert(var_4_0, {
				name = var_4_4,
				value = var_4_5,
				iconRes = self:_getIconResByAttrType(arg_4_1[iter_4_0].attr)
			})
		end

		self.m_refineComp:updateAttrs({
			attrs = var_4_0,
			levelDesc = var_4_1
		})
	end
end

function InfoEquipAttrComp:_initGlyphAttrInfo()
	if var_0_1.EQUIP_GLYPH_OFF then
		self.m_glyphComp:setVisible(false)
	else
		local var_5_0 = {}
		local var_5_1

		if g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.EQUIP_GLYPH) then
			local var_5_2 = self._equipData:getGlyphInfo()

			if self._equipData:isMaxGlyph() then
				var_5_1 = var_0_2:get(201563)
			end

			local var_5_3, var_5_4 = var_0_2:getAttr(var_5_2.affect_type1, var_5_2.affect_value1)

			table.insert(var_5_0, {
				name = var_5_3,
				value = var_5_4,
				iconRes = self:_getIconResByAttrType(var_5_2.affect_type1)
			})
			self.m_glyphComp:updateAttrs({
				isGlyph = true,
				attrs = var_5_0,
				levelDesc = var_5_1,
				glyphInfo = var_5_2
			})
		end
	end
end

function InfoEquipAttrComp:_getIconResByAttrType(arg_6_1)
	local var_6_0 = g.core.common.Path:getAttrIcon(arg_6_1)

	if var_6_0 and var_6_0 ~= "" then
		return var_6_0
	else
		return nil
	end
end

function InfoEquipAttrComp:_initResonanceAttrs()
	local var_7_0 = self._equipData:getCfg()

	if var_7_0.resonance_id > 0 then
		self.m_hasResonanceController:setSelectedIndex(1)
		self.m_resonanceComp:updateAttrs({
			isResonance = true,
			attrs = self._equipData:getCurResonanceAttrData(),
			levelDesc = g.core.lang:get(201614, {
				level1 = self._equipData:getCurResonanceInfo().name,
				level2 = var_0_0:getMaxResonanceInfo(var_7_0.id).name
			})
		})
	else
		self.m_hasResonanceController:setSelectedIndex(0)
	end
end

function InfoEquipAttrComp:_initMagicalAttrs()
	if self._equipData:hasMagical() then
		self.m_hasMagicalController:setSelectedIndex(1)

		local var_8_0 = {}

		for iter_8_0, iter_8_1 in pairs((self._equipData:getMagicalAttrMap())) do
			table.insert(var_8_0, {
				type = iter_8_0,
				value = iter_8_1
			})
		end

		self.m_magicalComp:updateAttrs({
			attrs = var_8_0,
			levelDesc = g.core.lang:get(201618, {
				level1 = self._equipData:getMagicalStage(),
				level2 = self._equipData:getMaxMagicalStage()
			}),
			emptyText = g.core.lang:get(201619)
		})
	else
		self.m_hasMagicalController:setSelectedIndex(0)
	end
end

function InfoEquipAttrComp:receiveCompEvent(arg_9_1, arg_9_2)
	arg_9_2 = arg_9_2 or {}

	if arg_9_1 == "Click_InfoBtn" and arg_9_2.isResonance then
		g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.EquipResonanceSkillPop").new({
			equipId = self._equipId,
			curLevel = self._equipData:getResonanceLevel()
		})))
	end
end

return InfoEquipAttrComp
