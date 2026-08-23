local var_0_0 = g.core.const.ConstMgr.EquipConst
local var_0_1 = g.core.common.ModuleUnlock
local var_0_2 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_3 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_4 = g.core.model.User.equipmentData
local EquipInfoAttrComp = class("EquipInfoAttrComp", require("app.fairyGUI.equipAndTreasure.UI_EquipInfoAttrComp"))

function EquipInfoAttrComp:ctor()
	self._id = 0
	self._knightPos = 0
	self._isShowStr = false
	self._isShowRef = false
	self._isShowGly = false
	self._isShowMagical = false

	self:initView()
end

function EquipInfoAttrComp:initView()
	self.m_glyphComp:addClickListener(handler(self, self._onClickGlyAttrInfoComp))
	self.m_suitTitleComp:addClickListener(handler(self, self._onClickEquipSuitComp))
	self:addListen(self.m_resonanceComp)
end

function EquipInfoAttrComp:updateView(arg_3_1, arg_3_2, arg_3_3)
	self._equip = arg_3_1
	self._serverData = arg_3_1:getServerData()
	self._knightPos = arg_3_2
	self._id = self._serverData.id
	self._info = arg_3_1:getCfg()
	self._glyphInfo = arg_3_1:getGlyphInfo()
	self._isOther = arg_3_3

	local var_3_0, var_3_1, var_3_2 = arg_3_1:getEquipAttrAll()

	if not arg_3_3 then
		self._isShowStr = var_0_1:isModuleShow(var_0_2.EQUIP_STRENGTH)
		self._isShowRef = var_0_1:isModuleShow(var_0_2.EQUIP_REFINE)
		self._isShowGly = var_0_1:isModuleShow(var_0_2.EQUIP_GLYPH)
		self._isShowMagical = var_0_1:isModuleShow(var_0_2.EQUIP_MAGICAL) and self._equip:getQuality() >= var_0_3.UR
	else
		local var_3_3 = g.core.model.User.playerInfoData:getPlayerSnapShot()
		local var_3_4 = g.core.common.ModuleUnlock:getModuleUnlockLevel(var_0_2.EQUIP_REFINE)
		local var_3_5 = g.core.common.ModuleUnlock:getModuleUnlockLevel(var_0_2.EQUIP_GLYPH)
		local var_3_6 = g.core.common.ModuleUnlock:getModuleUnlockLevel(var_0_2.EQUIP_MAGICAL)

		self._isShowStr = g.core.common.ModuleUnlock:getModuleUnlockLevel(var_0_2.EQUIP_STRENGTH) <= g.core.model.User.playerInfoData:getPassDungeonChapter()
		self._isShowRef = var_3_4 <= var_3_3.level
		self._isShowGly = var_3_5 <= var_3_3.level
		self._isShowMagical = var_3_6 <= var_3_3.level and self._equip:getQuality() >= var_0_3.UR
	end

	self.m_showMagicalController:setSelectedIndex(self._isShowMagical and 1 or 0)
	self:_updateSuitInfo(arg_3_3)
	self.m_suitSkillComp:setVisible(self._isShowMagical)
	self.m_suitMagicalTalentComp:setVisible(self._isShowMagical)

	if self._isShowMagical then
		self:_updateMagicalSuitTalentInfo(arg_3_3)
		self:_updateMagicalSingleInfo()
	end

	self:_updateAttrInfo(var_3_0)
	self:_updateRefineAttrInfo(var_3_1)
	self:_updateGlyphAttrInfo(arg_3_1)
	self:_updateResonanceInfo(arg_3_1)
end

function EquipInfoAttrComp:_updateAttrInfo(arg_4_1)
	self.m_strengthComp:setTitleAttrCtrl(self._isShowStr)

	local var_4_0 = {}

	for iter_4_0 = 1, #arg_4_1 do
		local var_4_1, var_4_2 = g.core.lang:getAttr(arg_4_1[iter_4_0].attr, arg_4_1[iter_4_0].value)

		table.insert(var_4_0, {
			type = arg_4_1[iter_4_0].attr,
			title = var_4_1,
			num = var_4_2
		})
	end

	local var_4_3 = self.m_strengthComp:getChild("list")

	if var_4_3 then
		var_4_3:setVirtual()
		var_4_3:setScrollLimit(true)
		var_4_3:setItemRenderer(function(arg_5_0, arg_5_1)
			local var_5_0 = arg_5_1:getChild("attrValueComp")

			if var_5_0 then
				var_5_0:updateAttr({
					name = var_4_0[arg_5_0 + 1].title,
					value = var_4_0[arg_5_0 + 1].num
				})
				var_5_0:setAttrIconByType(var_4_0[arg_5_0 + 1].type)
			end
		end)
		var_4_3:setNumItems(#arg_4_1)
	end
end

function EquipInfoAttrComp:_updateRefineAttrInfo(arg_6_1)
	self.m_refineComp:setTitleAttrCtrl(self._isShowRef)

	local var_6_0 = {}

	if arg_6_1.level > 0 then
		for iter_6_0 = 1, #arg_6_1 do
			local var_6_1, var_6_2 = g.core.lang:getAttr(arg_6_1[iter_6_0].attr, arg_6_1[iter_6_0].value)

			table.insert(var_6_0, {
				type = arg_6_1[iter_6_0].attr,
				title = var_6_1,
				num = var_6_2
			})
		end

		local var_6_3 = self.m_refineComp:getChild("list")

		if var_6_3 then
			var_6_3:setVirtual()
			var_6_3:setScrollLimit(true)
			var_6_3:setItemRenderer(function(arg_7_0, arg_7_1)
				local var_7_0 = arg_7_1:getChild("attrValueComp")

				if var_7_0 then
					var_7_0:updateAttr({
						name = var_6_0[arg_7_0 + 1].title,
						value = var_6_0[arg_7_0 + 1].num
					})
					var_7_0:setAttrIconByType(var_6_0[arg_7_0 + 1].type)
				end
			end)
			var_6_3:setNumItems(#arg_6_1)
		end
	else
		self.m_refineComp:setTitleAttrCtrl(false)
	end
end

function EquipInfoAttrComp:_updateGlyphAttrInfo(arg_8_1)
	self.m_showGlyphController:setSelectedIndex(var_0_0.EQUIP_GLYPH_OFF and 0 or 1)

	if var_0_0.EQUIP_GLYPH_OFF then
		return
	end

	self.m_glyphComp:setTitleAttrCtrl(self._isShowGly)

	local var_8_0 = {}
	local var_8_1 = arg_8_1:getGlyphInfo()

	if var_8_1.level > 0 then
		local var_8_2, var_8_3 = g.core.lang:getAttr(var_8_1.affect_type1, var_8_1.affect_value1, false)

		table.insert(var_8_0, {
			type = var_8_1.affect_type1,
			title = var_8_2,
			num = var_8_3
		})

		local var_8_4 = self.m_glyphComp:getChild("list")

		if var_8_4 then
			var_8_4:setVirtual()
			var_8_4:setScrollLimit(true)
			var_8_4:setItemRenderer(function(arg_9_0, arg_9_1)
				local var_9_0 = arg_9_1:getChild("attrValueComp")

				if var_9_0 then
					var_9_0:updateAttr({
						name = var_8_0[arg_9_0 + 1].title,
						value = var_8_0[arg_9_0 + 1].num
					})
					var_9_0:setAttrIconByType(var_8_0[arg_9_0 + 1].type)
				end
			end)
			var_8_4:setNumItems(1)
		end
	else
		self.m_glyphComp:setTitleAttrCtrl(false)
	end
end

function EquipInfoAttrComp:_updateResonanceInfo(arg_10_1)
	local var_10_0 = arg_10_1:hasResonance()

	self.m_showResonanceController:setSelectedIndex(var_10_0 and 1 or 0)

	if not var_10_0 then
		return
	end

	self.m_resonanceComp:setItemData(arg_10_1:getCurResonanceAttrData(false), true)
end

function EquipInfoAttrComp:_updateSuitInfo(arg_11_1)
	if self._info.suit_id <= 0 then
		self.m_suitTitleComp:setVisible(false)
	else
		self.m_suitTitleComp:updateView(self._info, self._serverData, self._knightPos, arg_11_1)
	end
end

function EquipInfoAttrComp:_updateMagicalSuitTalentInfo(arg_12_1)
	local var_12_1 = (not arg_12_1 and var_0_4:getSuitMagicalActiveMap(self._knightPos) or g.core.model.User.playerInfoData:getSuitMagicalActiveMap(self._knightPos))[self._equip:getSuitId()]

	self.m_suitMagicalTalentComp:updateSuitTalentComp(var_12_1, self._equip)
	self:_updateSuitSKillComp(var_12_1.minStage)
end

function EquipInfoAttrComp:_updateMagicalSingleInfo()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs((self._equip:getMagicalAttrMap())) do
		table.insert(var_13_0, {
			type = iter_13_0,
			value = iter_13_1
		})
	end

	self.m_magicalSingleComp:setTitleAttrCtrl(#var_13_0 > 0)

	local var_13_1 = self.m_magicalSingleComp:getChild("list")

	if var_13_1 then
		var_13_1:setVirtual()
		var_13_1:setScrollLimit(true)
		var_13_1:setItemRenderer(function(arg_14_0, arg_14_1)
			local var_14_0 = arg_14_1:getChild("attrValueComp")

			if var_14_0 then
				var_14_0:updateAttr(var_13_0[arg_14_0 + 1])
			end
		end)
		var_13_1:setNumItems(#var_13_0)
	end
end

function EquipInfoAttrComp:_updateSuitSKillComp(arg_15_1)
	local var_15_0 = math.clamp(arg_15_1, 0, self._equip:getMaxMagicalStage())
	local var_15_1 = var_0_4:getFourSuitSkillId(self._info.suit_id, var_15_0)

	self.m_suitSkillComp:setVisible(var_15_1 > 0)

	if var_15_1 > 0 then
		self.m_suitSkillComp:updateSuitSKill(var_15_1, self._info.suit_id, arg_15_1)
		self.m_suitSkillComp:getChild("skillIcon"):setGrayed(arg_15_1 < var_15_0)
	end
end

function EquipInfoAttrComp:_onClickGlyAttrInfoComp()
	if self._isShowGly then
		self:addPopup(require("app.view.module.equipAndTreasure.view.common.ETGlyphSuitInfoPop").new({
			glyphType = 1,
			knightIndex = self._knightPos,
			glyphGroupType = self._info.equipment_glyph
		}), {
			touchDisappear = true
		})
	end
end

function EquipInfoAttrComp:_onClickEquipSuitComp()
	if self._info.suit_id > 0 then
		self:addPopup(require("app.view.module.equipAndTreasure.view.equip.EquipSuitDetailPop").new({
			suitId = self._info.suit_id,
			data = self._serverData,
			knightPos = self._knightPos,
			isOther = self._isOther
		}), {
			touchDisappear = true,
			hideContinue = true
		})
	end
end

function EquipInfoAttrComp:receiveCompEvent(arg_18_1, arg_18_2)
	arg_18_2 = arg_18_2 or {}

	if arg_18_1 == "EquipTitleAttrComp_onClickTitle" then
		g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.EquipResonanceSkillPop").new({
			equipId = self._info.id,
			curLevel = self._equip:getResonanceLevel()
		})))
	end
end

return EquipInfoAttrComp
