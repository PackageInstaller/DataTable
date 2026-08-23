local var_0_1 = g.core.model.User.treasureData
local var_0_2 = g.core.config.treasure_info
local TreasureConst = require("app.view.module.equipAndTreasure.const.TreasureConst")
local var_0_4 = g.core.const.ConstMgr.QUALITY_TYPE
local BagNewTreasureRightAttrComp = class("BagNewTreasureRightAttrComp", require("app.fairyGUI.bagNew.UI_BagNewTreasureRightAttrComp"))

function BagNewTreasureRightAttrComp:ctor()
	self._compData = nil
	self._isFrag = false
	self._canCompose = false

	self.m_purifyComp:setVirtual()
	self.m_purifyComp:setItemRenderer(handler(self, self._renderPurifyAttrItem))
	self.m_purifyComp:setItemProvider(handler(self, self._onAttrListItemProvider))
	self.m_fragSpecialAttrTouch:addClickListener(handler(self, self._onFragSpecialAttrTouch))
end

function BagNewTreasureRightAttrComp:playEnterAnim()
	self.m_enterTransition:play()
end

function BagNewTreasureRightAttrComp:updateView(arg_3_1, arg_3_2)
	self._compData = arg_3_1
	self._isFrag = arg_3_2

	self.m_typeController:setSelectedIndex(arg_3_2 and 1 or 0)
	self.m_isHasSpecialAttrController:setSelectedIndex(0)
	self.m_isLockController:setSelectedIndex(0)
	self.m_refineScoreController:setSelectedIndex(0)

	if arg_3_2 then
		local var_3_1 = var_0_2.fetch(arg_3_1.id)

		if var_3_1.type <= 2 then
			self.m_normalController:setSelectedIndex(0)
			self:_updateTreasureFragAttr(arg_3_1)

			if var_3_1.quality >= var_0_4.SR and #var_0_1:getShowTreasureSpecialAttrsPool(arg_3_1.id) > 0 then
				self.m_isHasSpecialAttrController:setSelectedIndex(1)
			end
		end

		self._canCompose = not not (arg_3_1.canComposeNum and arg_3_1.canComposeNum > 0)
	else
		local var_3_2 = var_0_2.fetch(arg_3_1.base_id)

		if var_3_2.type <= 2 then
			self.m_normalController:setSelectedIndex(0)

			if var_3_2.quality >= var_0_4.SR then
				self.m_isHasSpecialAttrController:setSelectedIndex(1)
			end

			self.m_isLockController:setSelectedIndex(arg_3_1.lock and 2 or 1)
			self:_updateTreasureAttr(arg_3_1)
		end

		self:_showSpecialAttrsScore(arg_3_1.id)
	end
end

function BagNewTreasureRightAttrComp:_composeTreasure()
	local var_4_0, var_4_1, var_4_2 = self:_getComposeInfo()

	if not self._canCompose then
		g.core.module.ModuleManager:tip(g.core.lang:get(304006))

		return
	end

	if var_4_1 > 1 then
		local var_4_3 = fgui.UIPackage:createObject("bagNew", "BagOneKeyComposeComp")

		var_4_3:setItemView({
			id = var_4_2,
			fragmentId = var_4_0,
			num = var_4_1
		}, 2)
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			titleType = 1,
			title = g.core.lang:get(200504),
			childComp = var_4_3,
			onConfirm = function(self)
				g.core.network.GameNetProxy:send_C2S_Fragment_Compose({
					id = self.fragmentId,
					num = self.num
				})
			end
		}), {
			touchDisappear = true
		})
	else
		g.core.model.User.robTreasureData:recordComposeFlag()
		g.core.network.GameNetProxy:send_C2S_Fragment_Compose({
			num = 1,
			id = var_4_0
		})
	end
end

function BagNewTreasureRightAttrComp:_getComposeInfo()
	return self._compData.fragId, self._compData.canComposeNum, self._compData.id
end

function BagNewTreasureRightAttrComp:_updateTreasureAttr(arg_7_1)
	local var_7_0 = var_0_1:getAllAttrData(arg_7_1)
	local var_7_1

	if not TreasureConst.IS_FORBID_REFINE_ATTR then
		var_7_1 = #var_7_0.refineAttr > 0
	end

	local var_7_2 = #(var_7_0.glyphAttr or {}) > 0
	local var_7_3 = #var_7_0.specialAttrs > 0

	if self.m_glyNotUpgrade then
		self.m_glyNotUpgrade:setVisible(false)

		if not TreasureConst.IS_FORBID_GLYPH and not var_7_2 then
			self.m_glyNotUpgrade:setVisible(true)
		end
	end

	if not TreasureConst.IS_FORBID_REFINE_ATTR and self.m_rfNotUpgrade then
		if var_7_1 then
			self.m_rfNotUpgrade:setVisible(false)
		else
			self.m_rfNotUpgrade:setVisible(true)
		end
	end

	for iter_7_0 = 1, 2 do
		if var_7_0.baseAttrs[iter_7_0] then
			self["m_adAttr" .. iter_7_0]:setVisible(true)
			self["m_adAttr" .. iter_7_0]:updateAttr(var_7_0.baseAttrs[iter_7_0])
		else
			self["m_adAttr" .. iter_7_0]:setVisible(false)
		end

		if not TreasureConst.IS_FORBID_REFINE_ATTR and self["m_rfAttr" .. iter_7_0] then
			if var_7_1 then
				if var_7_0.refineAttr[iter_7_0] then
					self["m_rfAttr" .. iter_7_0]:setVisible(true)
					self["m_rfAttr" .. iter_7_0]:updateAttr(var_7_0.refineAttr[iter_7_0])
				else
					self["m_rfAttr" .. iter_7_0]:setVisible(false)
				end
			else
				self["m_rfAttr" .. iter_7_0]:setVisible(false)
			end
		end

		if self.m_glyAttrGroup then
			if not TreasureConst.IS_FORBID_GLYPH then
				self.m_glyAttrGroup:setVisible(false)
			else
				self.m_glyAttrGroup:setVisible(true)

				if var_7_2 then
					if var_7_0.glyphAttr[iter_7_0] then
						self["m_glyAttr" .. iter_7_0]:setVisible(true)
						self["m_glyAttr" .. iter_7_0]:updateAttr(var_7_0.glyphAttr[iter_7_0])
					else
						self["m_glyAttr" .. iter_7_0]:setVisible(false)
					end
				else
					self["m_glyAttr" .. iter_7_0]:setVisible(false)
				end
			end
		end

		if var_7_3 then
			if self["m_specialAttr" .. iter_7_0] then
				if var_7_0.specialAttrs[iter_7_0] then
					var_7_0.specialAttrs[iter_7_0].customBg = g.core.common.Path:getAttrQualityBgByQuality(var_7_0.specialAttrs[iter_7_0].attrPoolInfo.quality or 1)

					self["m_specialAttr" .. iter_7_0]:setVisible(true)
					self["m_specialAttr" .. iter_7_0]:updateAttr(var_7_0.specialAttrs[iter_7_0])
				else
					self["m_specialAttr" .. iter_7_0]:setVisible(false)
				end
			end
		else
			self.m_isHasSpecialAttrController:setSelectedIndex(0)
		end
	end

	self.m_purifyGroup:setVisible(true)
	self:_updatePurifyAttrInfo()
end

function BagNewTreasureRightAttrComp:_updateTreasureFragAttr(arg_8_1)
	local var_8_0 = var_0_1:getMaxStrengthAttr(arg_8_1.id)
	local var_8_1 = var_0_1:getMaxRefineAttr(arg_8_1.id)
	local var_8_2 = var_0_1:getMaxGlyphAttr(arg_8_1.id)

	for iter_8_0 = 1, 2 do
		if var_8_0[iter_8_0] then
			self["m_adAttr" .. iter_8_0]:setVisible(true)
			self["m_adAttr" .. iter_8_0]:updateAttr(var_8_0[iter_8_0])
		else
			self["m_adAttr" .. iter_8_0]:setVisible(false)
		end

		if not TreasureConst.IS_FORBID_REFINE_ATTR and self["m_rfAttr" .. iter_8_0] then
			if var_8_1[iter_8_0] then
				self["m_rfAttr" .. iter_8_0]:setVisible(true)
				self["m_rfAttr" .. iter_8_0]:updateAttr(var_8_1[iter_8_0])
			else
				self["m_rfAttr" .. iter_8_0]:setVisible(false)
			end
		end

		if self.m_glyAttrGroup then
			if not TreasureConst.IS_FORBID_GLYPH then
				self.m_glyAttrGroup:setVisible(false)
			else
				self.m_glyAttrGroup:setVisible(true)

				if var_8_2[iter_8_0] then
					self["m_glyAttr" .. iter_8_0]:setVisible(true)
					self["m_glyAttr" .. iter_8_0]:updateAttr(var_8_2[iter_8_0])
				else
					self["m_glyAttr" .. iter_8_0]:setVisible(false)
				end
			end
		end
	end

	if not TreasureConst.IS_FORBID_GLYPH and self.m_glyNotUpgrade then
		self.m_glyNotUpgrade:setVisible(false)
	end

	if not TreasureConst.IS_FORBID_REFINE_ATTR and self.m_rfNotUpgrade then
		self.m_rfNotUpgrade:setVisible(false)
	end

	self:getScrollPane():setPercY(0)
	self.m_purifyGroup:setVisible(false)
end

function BagNewTreasureRightAttrComp:onRcvTreasureLock()
	local var_9_0 = g.core.model.User.treasureData:getTreasureDataByOnlyId(self._compData.id)

	self.m_isLockController:setSelectedIndex(var_9_0.lock and 2 or 1)
	g.core.module.ModuleManager:tip(g.core.lang:get((var_9_0.lock or nil) and 202056))
end

function BagNewTreasureRightAttrComp:_onFragSpecialAttrTouch()
	if self._isFrag and self.m_isHasSpecialAttrController:getSelectedIndex() == 1 then
		g.core.sound.SoundManager:playSound("UI_Click_Middle")
		g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.TreasureSpecialAttrPoolPop").new({
			baseId = self._compData.id
		})))
	end
end

function BagNewTreasureRightAttrComp:_showSpecialAttrsScore(arg_11_1)
	if arg_11_1 and arg_11_1 > 0 then
		local var_11_0 = g.core.model.User.treasureData:getTreasureSpecialAttrsScore(arg_11_1)

		if var_11_0 and var_11_0 ~= 0 then
			self.m_refineScoreController:setSelectedIndex(1)
			self.m_scoreTxt:setText(g.core.lang:get(202057, {
				num = var_11_0
			}))
		end
	end
end

function BagNewTreasureRightAttrComp:_renderPurifyAttrItem(arg_12_1, arg_12_2)
	if next(self._purifyAttrData[arg_12_1 + 1]) then
		local var_12_0 = {
			type = self._purifyAttrData[arg_12_1 + 1].id,
			value = self._purifyAttrData[arg_12_1 + 1].init_value
		}

		var_12_0.withoutPlus1 = false
		var_12_0.customBg = g.core.common.Path:getAttrQualityBgByQuality(var_0_1:getAttrQuality(self._purifyAttrData[arg_12_1 + 1].id, self._purifyAttrData[arg_12_1 + 1].init_value, self._purifyAttrData[arg_12_1 + 1].group))

		arg_12_2:updateAttr(var_12_0)
	else
		arg_12_2:setHeight(32)
	end
end

function BagNewTreasureRightAttrComp:_onAttrListItemProvider(arg_13_1)
	if next(self._purifyAttrData[arg_13_1 + 1]) then
		return "ui://base_new/BaseAttrValueComp1"
	else
		return "ui://bagNew/BagNewTreasurePurifyNullCell"
	end
end

function BagNewTreasureRightAttrComp:_updatePurifyAttrInfo()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_CAST) then
		self.m_purifyGroup:setVisible(false)
		self:getScrollPane():setPercY(0)

		return
	end

	local var_14_0 = var_0_1:getTreasureDataByOnlyId(self._compData.id).holes or {}
	local var_14_1 = {}
	local var_14_2 = var_0_1:getPurifyCfg(self._compData.id)[1]

	if not var_14_2 then
		self.m_purifyGroup:setVisible(false)
		self:getScrollPane():setPercY(0)

		return
	end

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if iter_14_1.cur and iter_14_1.cur.id > 0 then
			table.insert(var_14_1, iter_14_1.cur)
		else
			table.insert(var_14_1, {})
		end
	end

	for iter_14_2 = #var_14_1 + 1, var_14_2.hole_num do
		table.insert(var_14_1, {})
	end

	self._purifyAttrData = var_14_1

	self.m_purifyComp:setNumItems(#var_14_1)
	self.m_purifyComp:resizeToFit(#var_14_1)

	local var_14_3, var_14_4 = var_0_1:getTreasureFullPurifyScore(self._compData.id)

	self.m_scoreTxt2:setText(g.core.lang:get(202067, {
		score = var_14_3
	}))
end

return BagNewTreasureRightAttrComp
