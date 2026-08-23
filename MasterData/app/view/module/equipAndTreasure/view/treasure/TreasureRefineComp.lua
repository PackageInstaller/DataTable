local var_0_0 = g.core.model.User.treasureData
local TreasureRefineComp = class("TreasureRefineComp", require("app.fairyGUI.equipAndTreasure.UI_TreasureRefineComp"))
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.config.treasure_info
local var_0_4 = g.core.config.attribute_info
local TreasureConst = require("app.view.module.equipAndTreasure.const.TreasureConst")
local DayNotifyToolConst = require("app.view.common.const.DayNotifyToolConst")

function TreasureRefineComp:ctor()
	self._treasureOnlyId = 0
	self.selectRefineTreasId = {}
	self._costType = 0
	self._costValue = 0
	self._costNum = 0
	self._baseId = 0
	self._sameTreasureNum = 0
	self._costCoinNum = 0
	self._consumeMatiralIconList = {}

	self.m_refineBtn:addClickListener(handler(self, self._onClickRefine))
	self.m_refineTouchBtn:addClickListener(handler(self, self._onClickTipBtn))
	self.m_treasureIcon:setQualityEffectEnable(true)
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.TREASURE_REFINE)
end

function TreasureRefineComp:updateView(arg_2_1)
	self:dispatchCompEvent("close_material_view")
	self:dispatchCompEvent("close_knight_select_view")

	self._treasureOnlyId = arg_2_1.data.id
	self._baseId = arg_2_1.data.base_id

	self:setRefineAttr(arg_2_1.data.base_id, arg_2_1.data.id)
	self:setRefineCost(arg_2_1.data.base_id, arg_2_1.data.id)
	self:_setTreasureSpecialAttrs(arg_2_1.data.id)
	self:setTreasureTalent(arg_2_1.data.base_id, arg_2_1.data.id)
	self:switchResource()

	if g.core.model.User.treasureData:hasTalent(self._treasureOnlyId) then
		self.m_refineTipBtn:getChild("infoBtn"):setVisible(true)
		self.m_talentComp:setVisible(true)
	else
		self.m_refineTipBtn:getChild("infoBtn"):setVisible(false)
		self.m_talentComp:setVisible(false)
	end
end

function TreasureRefineComp:switchResource()
	self:dispatchCompEvent("treasure_switch_goods", {
		id = 54
	})
end

function TreasureRefineComp:updateAfterRefine(arg_4_1)
	self._treasureOnlyId = arg_4_1.data.onlyId
	self._baseId = arg_4_1.data.id

	self:setRefineAttr(arg_4_1.data.id, arg_4_1.data.onlyId)
	self:setRefineCost(arg_4_1.data.id, arg_4_1.data.onlyId)
	self:_setTreasureSpecialAttrs(arg_4_1.data.onlyId)
	self:setTreasureTalent(arg_4_1.data.id, arg_4_1.data.onlyId)
end

function TreasureRefineComp:_onClickRefine()
	local var_5_0, var_5_1, var_5_2, var_5_3 = g.core.model.User.treasureData:isTreasureCanRefine(self._treasureOnlyId)

	if var_5_0 then
		if g.core.model.User.treasureData:getCostRefineMoney(var_0_3.get(self._baseId).refine_cost, g.core.model.User.treasureData:getTreasureDataByOnlyId(self._treasureOnlyId).refining_level + 1)[1].cost_treasure > 0 and g.core.model.User.treasureData:isTreasureHasSpecialAttrs(self._treasureOnlyId) then
			local var_5_4 = false

			for iter_5_0, iter_5_1 in ipairs(self.selectRefineTreasId) do
				local var_5_5, var_5_6 = var_0_0:getTreasureFullPurifyScore(iter_5_1)

				if var_5_5 > 0 then
					var_5_4 = true
				end
			end

			local var_5_7

			if var_5_4 then
				var_5_7 = DayNotifyToolConst.TYPE_TREASURE_PURIFY_CONFIRM_REFINE or DayNotifyToolConst.TYPE_TREASURE_PURIFY_CONFIRM_REFINE_NORMAL

				if var_5_4 then
					local var_5_8 = g.core.lang:get(202072) or g.core.lang:get(202059)

					if not g.core.model.User.dayNotifyTool:isTodayHasRecord(var_5_7) then
						g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
							title = g.core.lang:get(202058),
							desc = var_5_8,
							onConfirm = function()
								self:sendToServer()
							end,
							onCheck = function(arg_7_0)
								g.core.model.User.dayNotifyTool:saveTodayRecord(var_5_7, arg_7_0)
							end,
							tip = {
								txt = g.core.lang:get(202060)
							}
						}))

						goto label_5_0
					end
				end
			end

			self:sendToServer()

			::label_5_0::
		else
			self:sendToServer()
		end
	else
		local var_5_9 = 0

		if var_5_1 == 999 then
			if var_5_2 == 0 then
				var_5_9 = g.core.model.User:getFreeGold()
			elseif var_5_1 == 1 then
				var_5_9 = g.core.model.User:getGold()
			end
		else
			var_5_9 = g.core.model.User.bagData:getOwnNum(var_5_1, var_5_2)
		end

		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = var_5_1,
			value = var_5_2,
			size = var_5_9
		})
	end
end

function TreasureRefineComp:_onNotifyCheck(arg_8_1)
	g.core.model.User.dayNotifyTool:saveTodayRecord(DayNotifyToolConst.TYPE_TREASURE_PURIFY_CONFIRM_REFINE, arg_8_1)
end

function TreasureRefineComp:sendToServer()
	self.m_refineBtn:setTouchable(false)
	g.core.network.GameNetProxy:send_C2S_Treasure_Refining({
		id = self._treasureOnlyId,
		consume_list = self.selectRefineTreasId
	})
end

function TreasureRefineComp:_onClickTipBtn()
	if g.core.model.User.treasureData:hasTalent(self._treasureOnlyId) then
		self:addPopup(require("app.view.module.equipAndTreasure.view.treasure.TreasureRefineTalentPop").new({
			id = self._treasureOnlyId
		}), {
			touchDisappear = true
		})
	end
end

function TreasureRefineComp:setRefineAttr(arg_11_1, arg_11_2)
	local var_11_0 = var_0_3.get(arg_11_1)
	local var_11_1 = var_0_4.get(var_11_0.refine_type_1).name
	local var_11_2 = var_0_4.get(var_11_0.refine_type_2).name
	local var_11_3 = g.core.model.User.treasureData:getTreasureDataByOnlyId(arg_11_2)

	if not var_11_3 then
		return
	end

	local var_11_4 = var_11_3.refining_level

	self.m_curLevelText:setText(var_11_3.refining_level)
	self.m_nextLevelText:setText(var_11_0.refine_limit)

	local var_11_5 = self:getRefineAttrByType(1, var_11_4, arg_11_1)
	local var_11_6 = self:getRefineAttrByType(2, var_11_4, arg_11_1)

	if var_11_4 < var_11_0.refine_limit then
		self.m_ctrlController:setSelectedIndex(0)

		if not TreasureConst.IS_FORBID_REFINE_ATTR and self.m_attrComp1 then
			self.m_attrComp1:updateAttr({
				withoutPlus1 = false,
				type = var_11_0.refine_type_1,
				value = var_11_5,
				name = var_11_1,
				value2 = self:getRefineAttrByType(1, var_11_4 + 1, arg_11_1)
			})
			self.m_attrComp2:updateAttr({
				withoutPlus1 = false,
				type = var_11_0.refine_type_2,
				value = var_11_6,
				name = var_11_2,
				value2 = self:getRefineAttrByType(2, var_11_4 + 1, arg_11_1)
			})
		end
	else
		self.m_ctrlController:setSelectedIndex(1)

		if not TreasureConst.IS_FORBID_REFINE_ATTR and self.m_attrComp1 then
			self.m_attrComp1:updateAttr({
				withoutPlus1 = false,
				type = var_11_0.refine_type_1,
				value = var_11_5,
				name = var_11_1
			})
			self.m_attrComp2:updateAttr({
				withoutPlus1 = false,
				type = var_11_0.refine_type_2,
				value = var_11_6,
				name = var_11_2
			})
		end
	end
end

function TreasureRefineComp:getRefineAttrByType(arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = var_0_3.get(arg_12_3)

	return arg_12_1 == 1 and arg_12_2 * var_12_0.refine_growth_1 or arg_12_2 * var_12_0.refine_growth_2
end

function TreasureRefineComp:setRefineCost(arg_13_1, arg_13_2)
	local var_13_0 = var_0_3.get(arg_13_1)
	local var_13_1 = g.core.model.User.treasureData:getTreasureDataByOnlyId(arg_13_2)

	if not var_13_1 then
		return
	end

	local var_13_2 = g.core.model.User.treasureData:getCostRefineMoney(var_13_0.refine_cost, var_13_1.refining_level + 1)

	self._consumeMatiralIconList = {}

	if var_13_2 and #var_13_2 ~= 0 then
		self.m_resNumComp:updateByTVS({
			type = var_0_2.TYPE_RESOURCE,
			value = var_0_2.RESOURCE.TYPE_COIN,
			size = var_13_2[1].cost_money
		})

		self._costCoinNum = var_13_2[1].cost_money

		local var_13_3 = g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_ITEM, var_13_2[1].cost_value)

		self.m_icon:updateIcon({
			type = var_13_2[1].cost_type,
			value = var_13_2[1].cost_value,
			size = var_13_3,
			numCost = var_13_2[1].cost_num
		})

		self._costType = var_13_2[1].cost_type
		self._costValue = var_13_2[1].cost_value
		self._costNum = var_13_3

		table.insert(self._consumeMatiralIconList, g.core.common.Goods:convert({
			size = 1,
			type = var_13_2[1].cost_type,
			value = var_13_2[1].cost_value
		}).icon)

		local var_13_6, var_13_7

		var_13_6, self.selectRefineTreasId, var_13_7, self.lockNum = self:_getConsumeSameNameTreasureIdList(var_13_2[1].cost_treasure, var_13_0.advance_id, arg_13_2, var_13_0.quality)

		if var_13_2[1].cost_treasure > 0 then
			self.m_treasureIcon:setVisible(true)
			self.m_treasureIcon:updateIcon({
				type = g.core.common.Goods.TYPE_TREASURE,
				value = var_13_0.advance_id,
				size = var_13_7 - self.lockNum,
				numCost = var_13_2[1].cost_treasure
			})
			table.insert(self._consumeMatiralIconList, g.core.common.Goods:convert({
				size = 1,
				type = g.core.common.Goods.TYPE_TREASURE,
				value = var_13_0.advance_id
			}).icon)
		else
			self.m_treasureIcon:setVisible(false)
		end
	end
end

function TreasureRefineComp:setTreasureTalent(arg_14_1, arg_14_2)
	local var_14_0 = g.core.model.User.treasureData:getTreasureDataByOnlyId(arg_14_2)

	if not var_14_0 then
		return
	end

	local var_14_1 = var_14_0.refining_level
	local var_14_2 = g.core.model.User.treasureData:getAbleToActiveTalent(arg_14_1, var_14_0.refining_level)

	if #var_14_2 ~= 0 then
		self.m_talentName:setText(g.core.lang:get(202012, {
			name = var_14_2[#var_14_2].name
		}))

		if var_14_1 >= var_14_2[#var_14_2].lv then
			self.m_descText:setText(var_14_2[#var_14_2].description)
		else
			self.m_descText:setText(var_14_2[#var_14_2].description .. g.core.lang:get(202011, {
				num = var_14_2[#var_14_2].lv
			}))
		end
	else
		self.m_descText:setText("")
	end
end

function TreasureRefineComp:_getConsumeSameNameTreasureIdList(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = {}
	local var_15_1 = 0
	local var_15_2 = 0

	for iter_15_0, iter_15_1 in pairs((var_0_0:getTreasureData())) do
		if iter_15_1.base_id == arg_15_2 and iter_15_1.position == 0 and not math.uint64_equal(iter_15_1.id, arg_15_3) and iter_15_1.level <= 1 and iter_15_1.refining_level < 1 then
			if arg_15_1 > #var_15_0 and not iter_15_1.lock then
				table.insert(var_15_0, iter_15_1.id)
			end

			if iter_15_1.lock then
				var_15_2 = var_15_2 + 1
			end

			var_15_1 = var_15_1 + 1
		end
	end

	if arg_15_1 <= #var_15_0 then
		return true, var_15_0, var_15_1, var_15_2
	else
		return false, var_15_0, var_15_1, var_15_2
	end
end

function TreasureRefineComp:resetRefineBtnState()
	self.m_refineBtn:setTouchable(true)
end

function TreasureRefineComp:playScaleAction()
	g.core.utils.Action.playScaleAction(self.m_curLevelText)
	g.core.utils.Action.playScaleAction(self.m_nextLevelText)
end

function TreasureRefineComp:_setTreasureSpecialAttrs(arg_18_1)
	if var_0_3.fetch(self._baseId).type <= 2 then
		local var_18_0 = g.core.model.User.treasureData:getTreasureSpecialAttrsList(arg_18_1, true)

		self.m_specialValueNumController:setSelectedIndex(#var_18_0 >= 2 and 2 or #var_18_0)

		for iter_18_0, iter_18_1 in ipairs(var_18_0) do
			if self["m_specialAttrComp" .. iter_18_0] and iter_18_1 then
				iter_18_1.customBg = g.core.common.Path:getAttrQualityBgByQuality(iter_18_1.attrPoolInfo.quality or 1)

				self["m_specialAttrComp" .. iter_18_0]:updateAttr(iter_18_1)
			end
		end
	else
		self.m_specialValueNumController:setSelectedIndex(0)
	end
end

return TreasureRefineComp
