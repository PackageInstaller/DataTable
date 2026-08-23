local var_0_0 = g.core.model.User
local TreasureConst = require("app.view.module.equipAndTreasure.const.TreasureConst")
local TreasureInfoTalentComp = class("TreasureInfoTalentComp", require("app.fairyGUI.infoPop.UI_TreasureInfoTalentComp"))

function TreasureInfoTalentComp:ctor()
	self._treasureData = nil
	self._treasureInfo = nil
	self._isGlyphActive = false
	self._refineTalent = {}
	self._glyphTalent = {}

	self:_initList()
end

function TreasureInfoTalentComp:_initList()
	self.m_refineTalentList:setIniter()
	self.m_refineTalentList:setItemRendererAsync1(handler(self, self._onRendererRefine), nil, true)

	if not TreasureConst.IS_FORBID_GLYPH then
		self.m_glyphSuitTalentList:setIniter()
		self.m_glyphSuitTalentList:setItemRendererAsync1(handler(self, self._onRendererGlyph), nil, true)
	end
end

function TreasureInfoTalentComp:_onRendererRefine(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._refineTalent[arg_3_1 + 1])
end

function TreasureInfoTalentComp:_onRendererGlyph(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._glyphTalent[arg_4_1 + 1], self._isGlyphActive)
end

function TreasureInfoTalentComp:updateShow(arg_5_1)
	self._treasureData = arg_5_1.treasureData
	self._treasureInfo = arg_5_1.treasureInfo

	self:_updateRefineTalent()

	if not TreasureConst.IS_FORBID_GLYPH then
		if self.m_glyphSuitTitle then
			self.m_glyphSuitTitle:setVisible(false)
			self.m_glyphSuitNameTxt:setVisible(false)
			self.m_glyphSuitTalentList:setVisible(false)
		end
	else
		self:_updateGlyphTalent()
	end
end

function TreasureInfoTalentComp:_updateRefineTalent()
	local var_6_0

	if self._treasureData then
		var_6_0 = self._treasureData.refining_level or 0
	end

	self._refineTalent = {}

	for iter_6_0 = 1, 10 do
		if self._treasureInfo["talent_skill_" .. iter_6_0] > 0 then
			local var_6_1 = g.core.config.talent_skill_info.get(self._treasureInfo["talent_skill_" .. iter_6_0])

			table.insert(self._refineTalent, {
				name = g.core.lang:get(202051, {
					name = var_6_1.name
				}),
				desc = var_6_1.description,
				unLockText = g.core.lang:get(202049, {
					level = var_6_1.open_value
				}),
				isUnLock = var_6_0 >= var_6_1.open_value
			})
		end
	end

	local var_6_2 = #self._refineTalent

	self.m_hasRefineTalentController:setSelectedIndex(#self._refineTalent > 0 and 1 or 0)
	self.m_refineTalentList:setNumItems1(var_6_2)
end

function TreasureInfoTalentComp:_updateGlyphTalent()
	self._glyphTalent = {}

	local var_7_0

	if self._treasureData then
		var_7_0 = self._treasureData.glyph_level or 1
	end

	local var_7_1 = g.core.config.glyph_info.get(self._treasureInfo.treasure_glyph, var_7_0)
	local var_7_2

	for iter_7_0, iter_7_1 in g.core.config.glyph_suit_info.ipairs() do
		if iter_7_1.type == var_7_1.type and iter_7_1.level == var_7_0 and iter_7_1.suit_num == 2 then
			var_7_2 = iter_7_1

			break
		end
	end

	if var_7_2 then
		for iter_7_2 = 1, 4 do
			if var_7_2["affect_type" .. iter_7_2] > 0 then
				table.insert(self._glyphTalent, {
					type = var_7_2["affect_type" .. iter_7_2],
					value = var_7_2["affect_value" .. iter_7_2]
				})
			end
		end
	end

	local var_7_3 = 0

	if self._treasureData then
		if self._treasureData.position > 0 then
			var_7_3 = (var_0_0.formationData:getActiveTreasureGlyphSuit((var_0_0.treasureData:getKnightPosBySid(self._treasureData.id)))[1] or {}).num or 0
		elseif self._treasureData.glyph_level > 0 then
			var_7_3 = 1
		end
	end

	self._isGlyphActive = var_7_3 >= 2

	if var_7_2 then
		self.m_glyphSuitNameTxt:setText(g.core.lang:get(202050, {
			maxNum = 2,
			name = var_7_2.name,
			num = var_7_3
		}))
	end

	self.m_isGlyphActiveController:setSelectedIndex(self._isGlyphActive and 1 or 0)
	self.m_glyphSuitTalentList:setNumItems1(#self._glyphTalent)
end

return TreasureInfoTalentComp
