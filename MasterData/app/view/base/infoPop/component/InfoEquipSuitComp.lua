local var_0_0 = g.core.model.User.equipmentData
local var_0_1 = g.core.lang
local var_0_2 = g.core.const.ConstMgr.EquipConst
local InfoEquipSuitComp = class("InfoEquipSuitComp", require("app.fairyGUI.infoPop.UI_InfoEquipSuitComp"))

function InfoEquipSuitComp:ctor()
	self._equipId = 0
	self._suitId = nil
	self._glyphSuitComps = {}
	self.suitGlyInfoListData = {}
	self._glyTitlePosY = self.m_glyphSuitTitle:getY()

	self.m_skillList:setIniter()
	self.m_skillList:setItemRenderer(handler(self, self._onItemRender))
	self.m_skillList:doFairyBatching(false)

	self._skillData = {}
end

function InfoEquipSuitComp:updateShow(arg_2_1)
	self._equipId = arg_2_1.baseId
	self._knightPos = arg_2_1.pos

	local var_2_0 = g.core.config.equipment_info.get(self._equipId)

	self._info = var_2_0
	self._suitId = var_2_0.suit_id
	self._suitInfo = g.core.config.equipment_suit_info.get(self._suitId)

	self:_updateEquipIcons()
	self:_updateEquipSuitInfo()
	self:_updateGlyphSuitInfo()
	self:_updateEquipSuitPassiveInfo()
end

function InfoEquipSuitComp:_updateEquipIcons()
	for iter_3_0 = 1, 4 do
		if self["m_suit" .. iter_3_0].updateIcon then
			self["m_suit" .. iter_3_0]:updateIcon({
				isGetShow = true,
				type = g.core.common.Goods.TYPE_EQUIP,
				value = self._suitInfo["equipment_id_" .. iter_3_0]
			})
		end
	end
end

function InfoEquipSuitComp:_updateEquipSuitInfo()
	local var_4_0 = {}

	for iter_4_0 = 1, 3 do
		local var_4_1 = "two"

		if iter_4_0 == 2 then
			var_4_1 = "three"
		elseif iter_4_0 == 3 then
			var_4_1 = "four"
		end

		var_4_0[iter_4_0] = var_4_0[iter_4_0] or {}

		local var_4_2 = 0

		for iter_4_1 = 1, 2 do
			if self._suitInfo[var_4_1 .. "_suit_type_" .. iter_4_1] > 0 then
				var_4_2 = var_4_2 + 1

				local var_4_3, var_4_4 = g.core.lang:getAttr(self._suitInfo[var_4_1 .. "_suit_type_" .. iter_4_1], self._suitInfo[var_4_1 .. "_suit_value_" .. iter_4_1])

				var_4_0[iter_4_0]["attrName" .. var_4_2] = var_4_3
				var_4_0[iter_4_0]["value" .. var_4_2] = var_4_4
			end
		end
	end

	var_4_0.beginSuitId = 2

	self.m_equipSuitComp:updateSuitCompAttrs(var_4_0)
end

function InfoEquipSuitComp:_updateGlyphSuitInfo()
	if var_0_2.EQUIP_GLYPH_OFF then
		self.m_glyphSuitTitle:setVisible(false)

		return
	end

	local var_5_0 = 2

	if #self.suitGlyInfoListData < 1 then
		local var_5_1 = var_0_0:getEquipMaxGlyGroupNum(1, self._info.equipment_glyph)
		local var_5_2 = {}

		for iter_5_0 = 1, var_5_1 do
			table.insert(var_5_2, {
				num = 0,
				level = iter_5_0
			})

			if not self._glyphSuitComps[iter_5_0] then
				local var_5_3 = fgui.UIPackage:createObject("infoPop", "InfoEquipSuitAttrComp")

				self._glyphSuitComps[iter_5_0] = var_5_3

				self:addChild(var_5_3)
			end
		end

		for iter_5_1 = 1, #var_5_2 do
			local var_5_4 = {}

			for iter_5_2, iter_5_3 in pairs((var_0_0:getGlyphSuitInfoByLevel(var_5_2[iter_5_1].level, 1))) do
				table.insert(var_5_4, {
					info = iter_5_3
				})
			end

			table.sort(var_5_4, function(arg_6_0, arg_6_1)
				return (arg_6_0.info.suit_num or 0) < (arg_6_1.info.suit_num or 0)
			end)

			local var_5_5 = {
				[iter_5_1] = {}
			}

			for iter_5_4, iter_5_5 in ipairs(var_5_4) do
				var_5_5[iter_5_1].title = var_5_4[iter_5_4].info.name
				var_5_5[iter_5_1].beginSuitId = var_5_0

				local var_5_6 = 0

				var_5_5[iter_5_1][iter_5_4] = {}

				for iter_5_6 = 1, 4 do
					if var_5_4[iter_5_4].info["affect_type" .. iter_5_6] and var_5_4[iter_5_4].info["affect_type" .. iter_5_6] > 0 then
						var_5_6 = var_5_6 + 1

						local var_5_7, var_5_8 = var_0_1:getAttr(var_5_4[iter_5_4].info["affect_type" .. iter_5_6], var_5_4[iter_5_4].info["affect_value" .. iter_5_6])

						var_5_5[iter_5_1][iter_5_4]["attrName" .. var_5_6] = var_5_7
						var_5_5[iter_5_1][iter_5_4]["value" .. var_5_6] = var_5_8
					end
				end
			end

			table.insert(self.suitGlyInfoListData, var_5_5[iter_5_1])
		end

		for iter_5_7, iter_5_8 in ipairs(self._glyphSuitComps) do
			iter_5_8:updateSuitCompAttrs(self.suitGlyInfoListData[iter_5_7])
		end

		for iter_5_9 = 1, var_5_1 do
			self._glyphSuitComps[iter_5_9]:setX(5)
			self._glyphSuitComps[iter_5_9]:setY(self._glyTitlePosY + 100 * (iter_5_9 - 1) + 50 * iter_5_9)
		end
	end
end

function InfoEquipSuitComp:_updateEquipSuitPassiveInfo()
	local var_7_0 = false
	local var_7_1 = {}

	for iter_7_0, iter_7_1, iter_7_2 in self._suitInfo.gmatch({
		"passive_skill_%d+"
	}, true) do
		if iter_7_2[1] > 0 then
			var_7_1[#var_7_1 + 1] = {
				skillId = iter_7_2[1],
				targetSuitNum = iter_7_1 + 1
			}
			var_7_0 = true
		end
	end

	self.m_hasPassiveSkillController:setSelectedIndex(var_7_0 and 1 or 0)

	if var_7_0 then
		local var_7_2 = g.core.config.passive_skill_info
		local var_7_3 = {}
		local var_7_4

		if self._knightPos then
			var_7_4 = g.core.model.User.formationData:getEquipSuitByKnightPos(self._knightPos)[self._suitId]
		end

		for iter_7_3 = 1, #var_7_1 do
			local var_7_5 = var_7_1[iter_7_3].targetSuitNum

			var_7_3[#var_7_3 + 1] = {
				skillInfo = var_7_2.get(var_7_1[iter_7_3].skillId),
				curSuitNum = var_7_4 and var_7_4 or var_7_5,
				targetSuitNum = var_7_1[iter_7_3].targetSuitNum
			}
		end

		self._skillData = var_7_3

		self.m_skillList:setNumItems(#var_7_3)
		self.m_skillList:resizeToFit(#var_7_3)
		self.m_equipSuitComp:setY(173 + self.m_skillList:getSize().height)
	else
		self.m_equipSuitComp:setY(173)
	end
end

function InfoEquipSuitComp:_onItemRender(arg_8_1, arg_8_2)
	if self._skillData[arg_8_1 + 1] then
		arg_8_2:update(self._skillData[arg_8_1 + 1])
	end
end

return InfoEquipSuitComp
