local var_0_0 = g.core.model.User.treasureData
local var_0_1 = g.core.config.treasure_info
local TreasureConst = require("app.view.module.equipAndTreasure.const.TreasureConst")
local TreasureDetailAttrComp = class("TreasureDetailAttrComp", require("app.fairyGUI.equipAndTreasure.UI_TreasureDetailAttrComp"))

function TreasureDetailAttrComp:ctor()
	self._treasureData = nil
	self._treasureId = nil
	self._strenLevel = nil
	self._refineLevel = nil
	self._glyphLevel = nil
	self._strengthAttrData = nil
	self._refineAttrData = nil
	self._glyphAttrData = nil
	self._purifyAttrData = {}

	self:_initData()
	self:_initView()
end

function TreasureDetailAttrComp:updateView(arg_2_1, arg_2_2)
	self._treasureData = arg_2_1 or {}
	self._treasureId = self._treasureData.id
	self._strenLevel = self._treasureData.level
	self._refineLevel = self._treasureData.refining_level
	self._glyphLevel = self._treasureData.glyph_level

	if not arg_2_2 then
		self._isShowRef = g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.TREASURE_REFINE)
		self._isShowGly = g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.TREASURE_GLYPH)
		self._isShowPur = g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_CAST)

		if var_0_0:hasTalent(self._treasureId) then
			self.m_refineTitleComp:getChild("infoBtn"):setVisible(true)
		else
			self.m_refineTitleComp:getChild("infoBtn"):setVisible(false)
		end
	else
		self._isOther = arg_2_2

		local var_2_0 = g.core.model.User.playerInfoData:getPlayerSnapShot()
		local var_2_1 = g.core.model.User.playerInfoData:getBioMaxCampaign()
		local var_2_2 = g.core.common.ModuleUnlock:getModuleUnlockLevel(g.core.const.ConstMgr.FUNCTION_TYPE.TREASURE_GLYPH)
		local var_2_3 = g.core.common.ModuleUnlock:getModuleUnlockLevel(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_CAST)

		self._isShowRef = g.core.common.ModuleUnlock:getModuleUnlockLevel(g.core.const.ConstMgr.FUNCTION_TYPE.TREASURE_REFINE) <= var_2_0.level
		self._isShowGly = var_2_2 <= var_2_0.level
		self._isShowPur = var_2_3 <= var_2_1
	end

	self:_updateAttrInfo(arg_2_2)
	self:_updateRefineAttrInfo(arg_2_2)
	self:_updateGlyphAttrInfo(arg_2_2)
	self:_updatePurifyAttrInfo(arg_2_2)
	self:_showSpecialAttrsScore(arg_2_2)
end

function TreasureDetailAttrComp:_initData()
	return
end

function TreasureDetailAttrComp:_initView()
	self.m_strengthComp:setVirtual()
	self.m_strengthComp:setItemRenderer(handler(self, self._renderStrengthAttrItem))
	self.m_refineComp:setVirtual()
	self.m_refineComp:setItemRenderer(handler(self, self._renderRefineAttrItem))
	self.m_glyphComp:setVirtual()
	self.m_glyphComp:setItemRenderer(handler(self, self._renderGlyphAttrItem))
	self.m_purifyComp:setVirtual()
	self.m_purifyComp:setItemRenderer(handler(self, self._renderPurifyAttrItem))
	self.m_purifyComp:setItemProvider(handler(self, self._onAttrListItemProvider))
	self.m_refineTouch:addClickListener(handler(self, self.onClickRefineTitle))
	self.m_glyphTouch:addClickListener(handler(self, self.onClickGlyphTitle))
end

function TreasureDetailAttrComp:_renderStrengthAttrItem(arg_5_1, arg_5_2)
	self._strengthAttrData[arg_5_1 + 1].withoutPlus1 = false

	arg_5_2:updateAttr(self._strengthAttrData[arg_5_1 + 1])
end

function TreasureDetailAttrComp:_renderRefineAttrItem(arg_6_1, arg_6_2)
	self._refineAttrData[arg_6_1 + 1].withoutPlus1 = false
	self._refineAttrData[arg_6_1 + 1].customBg = g.core.common.Path:getAttrQualityBgByQuality(self._refineAttrData[arg_6_1 + 1].attrPoolInfo.quality or 1)

	arg_6_2:updateAttr(self._refineAttrData[arg_6_1 + 1])
end

function TreasureDetailAttrComp:_renderGlyphAttrItem(arg_7_1, arg_7_2)
	self._glyphAttrData[arg_7_1 + 1].withoutPlus1 = false

	arg_7_2:updateAttr(self._glyphAttrData[arg_7_1 + 1])
end

function TreasureDetailAttrComp:_updateAttrInfo(arg_8_1)
	self._strengthAttrData = not arg_8_1 and var_0_0:getStrenAttr(self._treasureId, self._strenLevel) or g.core.model.User.playerInfoData:getStrenAttr(self._treasureId, self._strenLevel) or {}

	self.m_strengthComp:setNumItems(#self._strengthAttrData)
end

function TreasureDetailAttrComp:_updateRefineAttrInfo(arg_9_1)
	if not self._isShowRef then
		self.m_showRefineController:setSelectedIndex(1)

		return
	end

	local var_9_0

	if not arg_9_1 then
		var_9_0 = var_0_0:getTreasureSpecialAttrsList(self._treasureId)
	else
		_, var_9_0 = g.core.model.User.playerInfoData:getTreasureSpecialAttrsScoreAndList(self._treasureId)
	end

	if #var_9_0 <= 0 then
		self.m_showRefineController:setSelectedIndex(1)

		return
	end

	self.m_showRefineController:setSelectedIndex(0)

	self._refineAttrData = {}

	if #var_9_0 > 0 then
		self.m_refineEmptyController:setSelectedIndex(0)

		self._refineAttrData = var_9_0

		self.m_refineComp:setNumItems(#self._refineAttrData)
	end
end

function TreasureDetailAttrComp:_updateGlyphAttrInfo(arg_10_1)
	if not self._isShowGly or not TreasureConst.IS_FORBID_GLYPH then
		self.m_showGlyphController:setSelectedIndex(1)

		return
	end

	self.m_showGlyphController:setSelectedIndex(0)
	g.core.model.User.formationData:getActiveTreasureGlyphSuit(1)

	self._glyphAttrData = {}

	local var_10_0 = not arg_10_1 and var_0_0:getTreasureGlyphInfo(self._treasureId) or g.core.model.User.playerInfoData:getTreasureGlyphInfo(self._treasureId)

	if var_10_0.level == 0 then
		-- block empty
	else
		local var_10_1, var_10_2 = g.core.lang:getAttr(var_10_0.affect_type1, var_10_0.affect_value1, true)

		table.insert(self._glyphAttrData, {
			name = var_10_1,
			value = var_10_0.affect_value1,
			type = var_10_0.affect_type1
		})

		local var_10_3, var_10_4 = g.core.lang:getAttr(var_10_0.affect_type2, var_10_0.affect_value2, true)

		table.insert(self._glyphAttrData, {
			name = var_10_3,
			value = var_10_0.affect_value2,
			type = var_10_0.affect_type2
		})
	end

	if #self._glyphAttrData == 0 then
		self.m_glyphEmptyController:setSelectedIndex(1)
		self.m_glyphEmptyComp:updateView({
			text1 = g.core.lang:get(202016),
			text2 = g.core.lang:get(202017)
		})
	else
		self.m_glyphEmptyController:setSelectedIndex(0)
	end

	self.m_glyphComp:setNumItems(#self._glyphAttrData)
end

function TreasureDetailAttrComp:onClickRefineTitle()
	if not self._isOther and var_0_0:hasTalent(self._treasureId) or self._isOther and g.core.model.User.playerInfoData:hasTalent(self._treasureId) then
		self:addPopup(require("app.view.module.equipAndTreasure.view.treasure.TreasureRefineTalentPop").new({
			id = self._treasureId,
			isOther = self._isOther
		}), {
			touchDisappear = true
		})
	end
end

function TreasureDetailAttrComp:onClickGlyphTitle()
	local var_12_0 = math.ceil(self._treasureData.position / 2)
	local var_12_1 = not self._isOther and var_0_0:getTreasureData()[self._treasureId] or g.core.model.User.playerInfoData:getTreasureBySid(self._treasureId)
	local var_12_2, var_12_3, var_12_4

	if var_12_1 then
		var_12_2 = var_12_1.base_id

		if not var_12_1.base_id then
			var_12_2 = 0
			var_12_3 = require("app.view.module.equipAndTreasure.view.common.ETGlyphSuitInfoPop").new
			var_12_4 = {
				glyphType = 2,
				knightIndex = var_12_0
			}
		end
	end

	var_12_4.glyphGroupType = var_0_1.get(var_12_2).treasure_glyph

	self:addPopup(require("app.view.module.equipAndTreasure.view.common.ETGlyphSuitInfoPop").new(var_12_4), {
		touchDisappear = true
	})
end

function TreasureDetailAttrComp:_showSpecialAttrsScore(arg_13_1)
	self.m_refineScoreController:setSelectedIndex(0)

	local var_13_0 = not arg_13_1 and var_0_0:getTreasureSpecialAttrsScore(self._treasureId) or g.core.model.User.playerInfoData:getTreasureSpecialAttrsScoreAndList(self._treasureId)

	if var_13_0 and var_13_0 ~= 0 then
		self.m_refineScoreController:setSelectedIndex(1)
		self.m_scoreTxt:setText(g.core.lang:get(202057, {
			num = var_13_0
		}))
	end
end

function TreasureDetailAttrComp:_renderPurifyAttrItem(arg_14_1, arg_14_2)
	if next(self._purifyAttrData[arg_14_1 + 1]) then
		local var_14_0 = {
			type = self._purifyAttrData[arg_14_1 + 1].id,
			value = self._purifyAttrData[arg_14_1 + 1].init_value
		}

		var_14_0.withoutPlus1 = false
		var_14_0.customBg = g.core.common.Path:getAttrQualityBgByQuality(var_0_0:getAttrQuality(self._purifyAttrData[arg_14_1 + 1].id, self._purifyAttrData[arg_14_1 + 1].init_value, self._purifyAttrData[arg_14_1 + 1].group))

		arg_14_2:updateAttr(var_14_0)
		arg_14_2.m_hideIconController:setSelectedIndex(1)
	else
		arg_14_2:setHeight(32)
	end
end

function TreasureDetailAttrComp:_onAttrListItemProvider(arg_15_1)
	if next(self._purifyAttrData[arg_15_1 + 1]) then
		return "ui://base_new/BaseAttrValueComp1"
	else
		return "ui://equipAndTreasure/TreasurePurifyAttrComp"
	end
end

function TreasureDetailAttrComp:_updatePurifyAttrInfo(arg_16_1)
	if not self._isShowPur then
		self.m_purifyGroup:setVisible(false)

		return
	end

	local var_16_1 = (not arg_16_1 and var_0_0:getTreasureDataByOnlyId(self._treasureId) or g.core.model.User.playerInfoData:getTreasureBySid(self._treasureId)).holes or {}
	local var_16_2 = {}
	local var_16_3 = not arg_16_1 and var_0_0:getPurifyCfg(self._treasureId) or g.core.model.User.playerInfoData:getPurifyCfg(self._treasureId)
	local var_16_4 = var_16_3[1]

	if not var_16_3[1] then
		self.m_purifyGroup:setVisible(false)

		return
	end

	self.m_purifyGroup:setVisible(true)

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		if iter_16_1.cur and iter_16_1.cur.id > 0 then
			table.insert(var_16_2, iter_16_1.cur)
		else
			table.insert(var_16_2, {})
		end
	end

	for iter_16_2 = #var_16_2 + 1, var_16_4.hole_num do
		table.insert(var_16_2, {})
	end

	self._purifyAttrData = var_16_2

	self.m_purifyComp:setNumItems(#var_16_2)
	self.m_purifyComp:resizeToFit(#var_16_2)

	local var_16_5

	if not arg_16_1 then
		var_16_5, _ = var_0_0:getTreasureFullPurifyScore(self._treasureId)
	else
		var_16_5, _ = g.core.model.User.playerInfoData:getTreasureFullPurifyScore(self._treasureId)
	end

	self.m_scoreTxt2:setText(g.core.lang:get(202067, {
		score = var_16_5
	}))
end

return TreasureDetailAttrComp
