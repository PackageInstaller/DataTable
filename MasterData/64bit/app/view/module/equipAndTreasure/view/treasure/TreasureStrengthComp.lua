local TreasureSelectMaterialComp = require("app.view.module.equipAndTreasure.view.treasure.TreasureSelectMaterialComp")
local TreasureQuickStrengthComp = require("app.view.module.equipAndTreasure.view.treasure.TreasureQuickStrengthComp")
local var_0_2 = g.core.config.treasure_info
local var_0_3 = g.core.config.attribute_info
local TreasureStrengthComp = class("TreasureStrengthComp", require("app.fairyGUI.equipAndTreasure.UI_TreasureStrengthComp"))

function TreasureStrengthComp:ctor()
	self._treasureId = 0
	self._selectStrenTreasId = {}
	self._treasureOnlyId = 0
	self._selectMatiralIconList = {}
	self._addExp = 0
	self._isClick = true
	self._previewPercent = 0
	self.m_selectMaterialComp = nil
	self._isShowSelectMaterialComp = false

	self.m_oneKeyBtn:addClickListener(handler(self, self._onClickOneKeyAdd))
	self.m_strengthBtn:addClickListener(handler(self, self._onClickStrength))
	self.m_touchBg:addClickListener(handler(self, self._onTouchBg))

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.TREASURE_ONEKEY_LVUP) then
		self.m_showBtnController:setSelectedIndex(0)
	else
		self.m_showBtnController:setSelectedIndex(1)
	end
end

function TreasureStrengthComp:_onTouchBg()
	self:dispatchCompEvent("close_material_view")
	self:dispatchCompEvent("close_knight_select_view")
end

function TreasureStrengthComp:_onClickSelectTreasure()
	self:dispatchCompEvent("close_knight_select_view")

	local var_3_0 = var_0_2.get(self._treasureId).quality

	if self:_isHaveTreasureToStrength(var_3_0, self._treasureOnlyId, false) then
		self:_updateMaterialList({
			selectTreasId = self._selectStrenTreasId,
			quality = var_3_0,
			id = self._treasureOnlyId
		})
		self:showSelectMaterialView(true)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(202019))
	end
end

function TreasureStrengthComp:_resetMaterialList()
	if self._isShowSelectMaterialComp then
		self:_updateMaterialList({
			selectTreasId = self._selectStrenTreasId,
			quality = var_0_2.get(self._treasureId).quality,
			id = self._treasureOnlyId
		})
	end
end

function TreasureStrengthComp:_updateMaterialList(arg_5_1)
	if not self.m_selectMaterialComp then
		self.m_selectMaterialComp = TreasureSelectMaterialComp.new()

		self.m_materialListPlaceHolder:addChild(self.m_selectMaterialComp)
	end

	self.m_selectMaterialComp:updateView(arg_5_1)
end

function TreasureStrengthComp:updateSelectMaterial(arg_6_1)
	self._selectStrenTreasId = arg_6_1
	self._addExp = self:getAddExp()

	self:_updateAddLevel((g.core.model.User.treasureData:isCanUpToLevel(self._addExp, self._treasureOnlyId)))
	self:_setStrengthAttr(self._treasureId, self._treasureOnlyId)
	self:_setTreasureExp(self._treasureId, self._treasureOnlyId)
	self:_setProgress(self._treasureId, self._treasureOnlyId)
end

function TreasureStrengthComp:_updateAddLevel(arg_7_1)
	if not arg_7_1 then
		return
	end

	if arg_7_1 == 0 then
		self.m_addLevelText:setText("")
	else
		self.m_addLevelText:setText(g.core.lang:get(202048, {
			level = arg_7_1
		}))
	end

	self:_setStrengthAttr(self._treasureId, self._treasureOnlyId, arg_7_1)
end

function TreasureStrengthComp:updateLevel(arg_8_1)
	self._addExp = arg_8_1.exp or 0

	self:_updateAddLevel(arg_8_1.level or 1)
	self:_setTreasureExp(self._treasureId, self._treasureOnlyId)
end

function TreasureStrengthComp:_onClickClearTreasure(arg_9_1)
	if self._isClick then
		local var_9_0 = arg_9_1:getSender():getName()

		table.remove(self._selectStrenTreasId, (tonumber(string.sub(var_9_0, #var_9_0))))
		self:_setStrengthAttr(self._treasureId, self._treasureOnlyId)
		self:_setTreasureExp(self._treasureId, self._treasureOnlyId)
		self:_setProgress(self._treasureId, self._treasureOnlyId)

		if self._isShowSelectMaterialComp and self.m_materialPanelController:getSelectedIndex() == 0 then
			self:_updateMaterialList({
				selectTreasId = self._selectStrenTreasId,
				quality = var_0_2.get(self._treasureId).quality,
				id = self._treasureOnlyId
			})
		end
	end

	self:dispatchCompEvent("close_knight_select_view")
end

function TreasureStrengthComp:updateView(arg_10_1)
	self._treasureId = arg_10_1.data.base_id
	self._treasureOnlyId = arg_10_1.data.id

	self:_setStrengthAttr(arg_10_1.data.base_id, arg_10_1.data.id)
	self:_setTreasureExp(arg_10_1.data.base_id, arg_10_1.data.id)
	self:_setProgress(arg_10_1.data.base_id, arg_10_1.data.id, arg_10_1.data.init)
	self:_updateOnekeyLvupStatus()
	self:_resetStrengthBtnState()
	self:_resetMaterialList()
	self:dispatchCompEvent("close_material_view")
	self:dispatchCompEvent("close_knight_select_view")
	self:switchResource()
end

function TreasureStrengthComp:switchResource()
	self:dispatchCompEvent("treasure_switch_goods", {
		id = 55
	})
end

function TreasureStrengthComp:_setStrengthAttr(arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = var_0_2.get(arg_12_1)
	local var_12_1 = var_12_0.basic_type_1
	local var_12_2 = var_12_0.basic_type_2
	local var_12_3 = var_0_3.get(var_12_0.basic_type_1).name
	local var_12_4 = var_0_3.get(var_12_0.basic_type_2).name
	local var_12_5 = 1

	if arg_12_3 and arg_12_3 > 0 then
		var_12_5 = arg_12_3
	end

	local var_12_6 = g.core.model.User.treasureData:getTreasureDataByOnlyId(arg_12_2)

	if not var_12_6 then
		return
	end

	local var_12_7 = var_12_6.level
	local var_12_8 = var_12_0.strength_limit

	self.m_curLevelText:setText(var_12_6.level)
	self.m_totalLevelText:setText("Max")

	local var_12_9 = ""

	if var_12_7 < 10 then
		var_12_9 = "00"
	elseif var_12_7 < 100 then
		var_12_9 = "0"
	end

	self.m_subLevel:setText(var_12_9)

	local var_12_10 = self:_getAttrValueByType(1, var_12_7, arg_12_1)
	local var_12_11 = self:_getAttrValueByType(2, var_12_7, arg_12_1)

	if var_12_7 < var_12_8 then
		self.m_ctrlController:setSelectedIndex(0)
		self.m_attrComp1:updateAttr({
			withoutPlus1 = false,
			type = var_12_1,
			value = var_12_10,
			name = var_12_3,
			value2 = self:_getAttrValueByType(1, var_12_7 + var_12_5, arg_12_1)
		})
		self.m_attrComp2:updateAttr({
			withoutPlus1 = false,
			type = var_12_2,
			value = var_12_11,
			name = var_12_4,
			value2 = self:_getAttrValueByType(2, var_12_7 + var_12_5, arg_12_1)
		})
	else
		self.m_attrComp1:updateAttr({
			withoutPlus1 = false,
			type = var_12_1,
			value = var_12_10,
			name = var_12_3
		})
		self.m_attrComp2:updateAttr({
			withoutPlus1 = false,
			type = var_12_2,
			value = var_12_11,
			name = var_12_4
		})
		self.m_ctrlController:setSelectedIndex(1)
	end
end

function TreasureStrengthComp:_getAttrValueByType(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = var_0_2.get(arg_13_3)

	return arg_13_1 == 1 and (arg_13_2 - 1) * var_13_0.basic_growth_1 + var_13_0.basic_value_1 or (arg_13_2 - 1) * var_13_0.basic_growth_2 + var_13_0.basic_value_2
end

function TreasureStrengthComp:_setTreasureExp(arg_14_1, arg_14_2)
	local var_14_0 = g.core.model.User.treasureData:getTreasureDataByOnlyId(arg_14_2)

	if not var_14_0 then
		return
	end

	local var_14_1 = g.core.model.User.treasureData:getNeedExpUpToNextLv(arg_14_1, var_14_0.level)

	if self._addExp > 0 then
		self._addExp = self._addExp

		self.m_expText:setText(g.core.lang:get(202021, {
			num1 = var_14_0.exp,
			num2 = var_14_1,
			num3 = self._addExp
		}))
	else
		self.m_expText:setText(g.core.lang:get(202022, {
			num1 = var_14_0.exp,
			num2 = var_14_1
		}))
	end
end

function TreasureStrengthComp:getAddExp()
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in ipairs(self._selectStrenTreasId) do
		local var_15_1 = g.core.model.User.treasureData:getTreasureDataByOnlyId(iter_15_1)

		for iter_15_2 = 1, var_15_1.level - 1 do
			var_15_0 = var_15_0 + g.core.model.User.treasureData:getNeedExpUpToNextLv(var_15_1.base_id, iter_15_2)
		end

		local var_15_2 = var_0_2.get(var_15_1.base_id)

		if var_15_2 then
			var_15_0 = var_15_0 + var_15_2.treasure_exp + var_15_1.exp
		end
	end

	return var_15_0
end

function TreasureStrengthComp:_setProgress(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = g.core.model.User.treasureData:getTreasureDataByOnlyId(arg_16_2)

	if not var_16_0 then
		return
	end

	local var_16_1 = g.core.model.User.treasureData:getNeedExpUpToNextLv(arg_16_1, var_16_0.level)

	self.m_progress:setPercent({
		value = var_16_0.exp,
		max = var_16_1
	})
	self.m_progress:setPreviewEnable(true)

	if self._addExp == 0 then
		self.m_progress:setPreviewEnable(false)
	end

	local var_16_2 = (var_16_0.exp + self._addExp) / var_16_1 * 100

	if self._addExp == 0 then
		var_16_2 = 0
	end

	self._previewPercent = var_16_2

	if var_16_2 > 100 then
		var_16_2 = 100
	end

	self.m_progress:setPreviewPercent(var_16_2)
end

function TreasureStrengthComp:_isHaveTreasureToStrength(arg_17_1, arg_17_2, arg_17_3)
	for iter_17_0, iter_17_1 in pairs((g.core.model.User.treasureData:getTreasureData())) do
		local var_17_0 = var_0_2.get(iter_17_1.base_id)

		if var_17_0 then
			if var_17_0.type == 3 then
				if iter_17_1.refining_level < 1 and not math.uint64_equal(iter_17_1.id, arg_17_2) and iter_17_1.position == 0 then
					return true
				end
			elseif var_17_0.type ~= 4 then
				if arg_17_3 then
					if var_17_0.quality < arg_17_1 and var_17_0.quality < 6 and iter_17_1.refining_level < 1 and not math.uint64_equal(iter_17_1.id, arg_17_2) and iter_17_1.position == 0 then
						return true
					end
				elseif iter_17_1.refining_level < 1 and not math.uint64_equal(iter_17_1.id, arg_17_2) and iter_17_1.position == 0 then
					return true
				end
			end
		end
	end

	return false
end

function TreasureStrengthComp:addStrengthEffect()
	for iter_18_0 = 1, 4 do
		if self._selectStrenTreasId[iter_18_0] then
			-- block empty
		end
	end
end

function TreasureStrengthComp:_onClickOneKeyAdd()
	if not self.m_selectMaterialComp then
		self.m_selectMaterialComp = TreasureSelectMaterialComp.new()

		self.m_materialListPlaceHolder:addChild(self.m_selectMaterialComp)
	end

	self.m_selectMaterialComp:updateView({
		id = self._treasureOnlyId
	})
	self:showSelectMaterialView(true)
end

function TreasureStrengthComp:_onClickStrength()
	self:closeQuickStrength()
	self.m_quickStrengthPlaceHolder:addChild((TreasureQuickStrengthComp.new({
		serverData = g.core.model.User.treasureData:getTreasureDataByOnlyId(self._treasureOnlyId),
		baseInfo = var_0_2.get(self._treasureId)
	})))
end

function TreasureStrengthComp:_resetStrengthBtnState()
	self.m_strengthBtn:setTouchable(true)
	self.m_oneKeyBtn:setTouchable(true)

	self._isClick = true
end

function TreasureStrengthComp:playScaleAction()
	g.core.utils.Action.playScaleAction(self.m_curLevelText)
	g.core.utils.Action.playScaleAction(self.m_nextLevelText)
end

function TreasureStrengthComp:_updateOnekeyLvupStatus()
	local var_23_0 = g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.TREASURE_ONEKEY_LVUP)
	local var_23_1 = g.core.model.User.treasureData:getTreasureDataByOnlyId(self._treasureOnlyId)

	self.m_isOnekeyUnlockController:setSelectedIndex(var_23_0 and not ((var_23_1 or nil) and var_23_1.level >= var_0_2.get(self._treasureId).strength_limit) and 1 or 0)
end

function TreasureStrengthComp:showSelectMaterialView(arg_24_1)
	if arg_24_1 then
		self.m_materialPanelController:setSelectedIndex(0)

		self._isShowSelectMaterialComp = true
	else
		self.m_materialPanelController:setSelectedIndex(1)

		self._isShowSelectMaterialComp = false

		self:updateSelectMaterial({})
	end
end

function TreasureStrengthComp:closeQuickStrength()
	self.m_quickStrengthPlaceHolder:removeChildren()
	self:updateLevel({
		exp = 0,
		level = 0
	})
end

return TreasureStrengthComp
