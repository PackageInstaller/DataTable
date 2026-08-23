local KnightAdvanceComp = class("KnightAdvanceComp", require("app.fairyGUI.knight.UI_KnightAdvanceComp"))
local var_0_1 = g.core.config.passive_skill_info
local var_0_2 = g.core.model.User.knightsData
local var_0_3 = g.core.config.knight_advance_info
local var_0_4 = g.core.config.talent_skill_info
local var_0_5 = g.core.const.ConstMgr.KNIGHT_CONST.TRAIN_MAX
local var_0_6 = g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_ADVANCE
local var_0_7 = g.core.model.User.shopData
local var_0_8 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_9 = g.core.common.Goods
local var_0_10 = g.core.module.ModuleManager
local ShowFactory = require("app.view.module.show.ShowFactory")
local var_0_12 = g.view.entrance.ModuleGotoProxy
local var_0_13 = g.core.model.User.dungeonData
local var_0_14 = g.core.model.User.bagData
local var_0_15 = g.core.const.ConstMgr.KNIGHT_CONST.ADVANCE_COMMON_CONVERT_ITEM_ID
local DayNotifyToolConst = require("app.view.common.const.DayNotifyToolConst")
local var_0_17 = g.core.model.User.dayNotifyTool

KnightAdvanceComp.MATNUM = 4
KnightAdvanceComp.btnState = {
	EQUIP = 1,
	ADVANCE = 2
}

function KnightAdvanceComp:ctor()
	self._knight = nil
	self._matData = nil
	self._promoteCode = nil
	self._promoteLevel = nil
	self._ownPrmtCount = nil
	self._btnState = nil
	self._advInfo = nil

	self:_addListener()
	self:_initList()
	self:addEventListener(fgui.UIEventType.ExitFinish, handler(self, self._onSelfExit))
end

function KnightAdvanceComp:_addListener()
	self.m_advBtn:addClickListener(handler(self, self._onAdvBtnClicked))
	self.m_newAdvBtn:addClickListener(handler(self, self._onAdvBtnClicked))
	self.m_oneKeyAdvance:addClickListener(handler(self, self._onOneKeyClicked))
	self.m_valueDescText:addClickListener(handler(self, self._onClickValueDesc))
	self.m_skillDescText:addClickListener(handler(self, self._onClickSkillDesc))
end

function KnightAdvanceComp:_initList()
	self.m_matList:setVirtual()
	self.m_matList:setItemRenderer(handler(self, self._onMatItemRenderer))
end

function KnightAdvanceComp:_onMatItemRenderer(arg_4_1, arg_4_2)
	if self._matData then
		local var_4_0, var_4_1 = self._knight:getAdvStageAndLevel()

		arg_4_2:updateCell(self._matData[arg_4_1 + 1], var_4_0)
	end
end

function KnightAdvanceComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_KNIGHT_ADVANCEUPGRADE, handler(self, self._onKnightAdvanceUp), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OP_OBJECT, handler(self, self._onRcvResourceFlush), self)
	self:updateView()
end

function KnightAdvanceComp:updateView(arg_6_1)
	local var_6_0

	if arg_6_1 then
		var_6_0 = arg_6_1.data.knight

		if arg_6_1.data.knight then
			self._knight = var_6_0
			self._knightId = var_6_0:getServerId()
		end
	else
		var_6_0 = self._knight
	end

	if not var_6_0 then
		return
	end

	local var_6_1 = var_6_0:getBaseInfo()
	local var_6_2 = var_6_1.promote_code
	local var_6_3 = math.max(var_6_0:getInfo().advance_level)
	local var_6_4, var_6_5 = var_6_0:getAdvStageAndLevel()

	if var_6_2 <= 0 or var_6_3 <= 0 then
		return
	end

	self.m_isOneKeyAdvanceController:setSelectedIndex(g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_ONEKEY_ADVANCE) and 1 or 0)

	self._advInfo = var_0_3.get(var_6_2, var_6_3)

	self.m_progBar:updateComp({
		maxValue = var_0_2:getTotalLevelByStage(var_6_2, var_6_4),
		value = var_6_5,
		title = var_6_4
	})

	local var_6_6 = math.min(var_0_5, self._advInfo.stage + 1)

	if self._advInfo.place_1 == 0 then
		var_6_6 = self._advInfo.stage

		self.m_isFullController:setSelectedIndex(1)
		self.m_valueDescText:setTitle(g.core.lang:get(201013))
		self.m_skillDescText:setTitle(g.core.lang:get(201014))
	else
		self.m_isFullController:setSelectedIndex(0)
		self.m_valueDescText:setTitle(g.core.lang:get(201012))

		local var_6_7 = ""

		if var_6_1["promote_talent_" .. var_6_6] ~= 0 then
			var_6_7 = g.core.lang:get(201004, {
				name = var_0_4.get(var_6_1["promote_talent_" .. var_6_6]).name
			})
		end

		if var_6_1["promote_passive_" .. var_6_6 .. "_1"] ~= 0 then
			local var_6_8 = var_0_1.get(var_6_1["promote_passive_" .. var_6_6 .. "_1"]).name

			var_6_7 = var_6_1.quality >= var_0_8.UR and var_6_7 .. " " .. g.core.lang:get(201035, {
				name = var_6_8
			}) or var_6_7 ~= "" and var_6_7 .. " " .. g.core.lang:get(201022, {
				name = var_6_8
			}) or g.core.lang:get(201004, {
				name = var_6_8
			})
		end

		self.m_skillDescText:setTitle(var_6_7)
	end

	local var_6_9 = self._advInfo.require_level

	if self._advInfo.require_level <= self._knight:getLevel() then
		self.m_isLevelEnoughController:setSelectedIndex(1)
	else
		self.m_isLevelEnoughController:setSelectedIndex(0)
		self.m_limitTxt:setText(g.core.lang:get(201025, {
			level = var_6_9
		}))
	end

	self:_updateRes()

	self._promoteCode = var_6_2
	self._promoteLevel = var_6_3

	self:checkShowSpeGuide()
end

function KnightAdvanceComp:_updateRes()
	if self._advInfo.place_1 == 0 then
		return
	end

	self._matData = {}
	self._isPropEnough = true

	for iter_7_0 = 1, KnightAdvanceComp.MATNUM do
		local var_7_0 = var_0_9:convert({
			type = var_0_9.TYPE_KNIGHT_ADVANCE,
			value = self._advInfo["place_" .. iter_7_0]
		})

		var_7_0.numCost = self._advInfo["num_" .. iter_7_0]

		if var_7_0.size < var_7_0.numCost then
			self._isPropEnough = false
		end

		table.insert(self._matData, var_7_0)
	end

	self.m_matList:setNumItems(#self._matData)
	self.m_resource1:updateByTVS({
		type = var_0_9.TYPE_RESOURCE,
		value = var_0_9.RESOURCE.TYPE_COIN,
		size = self._advInfo.cost_money
	})
	self.m_resource2:updateByTVS({
		type = self._advInfo.cost_type,
		value = self._advInfo.cost_value,
		size = self._advInfo.cost_size
	})

	self._ownPrmtCount = var_0_14:getCountById(self._advInfo.cost_type, self._advInfo.cost_value)
end

function KnightAdvanceComp:_onOneKeyClicked()
	if not self._ownPrmtCount or not self._knight then
		return
	end

	if self._isPropEnough then
		if self._knight:getLevel() >= self._advInfo.require_level then
			self:_onKnightAdv()

			return
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(201101))
		end
	else
		self:checkAllBlitzPop()
	end
end

function KnightAdvanceComp:checkAllBlitzPop()
	local var_9_0 = var_0_14:getCountById(var_0_9.TYPE_RESOURCE, var_0_9.RESOURCE.TYPE_STAMINA)
	local var_9_1 = var_0_14:getCountById(var_0_9.TYPE_ITEM, var_0_15)
	local var_9_2 = {}
	local var_9_3 = 0
	local var_9_4 = 0
	local var_9_5 = 0
	local var_9_6 = 0
	local var_9_7 = 0

	for iter_9_0 = KnightAdvanceComp.MATNUM, 1, -1 do
		local var_9_8 = self._advInfo["place_" .. iter_9_0]
		local var_9_9 = self._advInfo["num_" .. iter_9_0] - var_0_14:getCountById(var_0_9.TYPE_KNIGHT_ADVANCE, self._advInfo["place_" .. iter_9_0])

		if var_9_9 > 0 then
			local var_9_10 = var_0_12:getSrcRoute({
				type = var_0_9.TYPE_KNIGHT_ADVANCE,
				value = var_9_8
			}).routes

			table.sort(var_9_10, function(arg_10_0, arg_10_1)
				local var_10_0 = arg_10_1.chapterId
				local var_10_1 = var_0_13:isStagePassed(arg_10_0.chapterId)

				if var_10_1 ~= var_0_13:isStagePassed(arg_10_1.chapterId) then
					return var_10_1
				end

				return var_10_0 < arg_10_0.chapterId
			end)

			if #var_9_10 > 0 then
				local var_9_11 = var_9_10[1].chapterId

				if var_0_13:isStagePassed(var_9_10[1].chapterId) then
					local var_9_12 = g.core.config.dungeon_stage_info.get(var_9_11).cost
					local var_9_13 = var_0_17:isTodayHasRecord(DayNotifyToolConst.KNIGHT_ADVANCE_ONE_KEY_USE, false)

					if not var_9_13 and (var_9_12 <= var_9_0 or var_9_1 > 0) then
						var_9_3 = 0
					else
						local var_9_14 = var_9_12 * var_9_9

						if var_9_0 < var_9_12 * var_9_9 then
							local var_9_15 = math.floor(var_9_0 / var_9_12)

							var_9_0 = var_9_13 and var_9_0 - var_9_15 * var_9_12 or 0

							local var_9_16 = var_9_9 - var_9_15

							if var_9_1 < var_9_9 - var_9_15 then
								var_9_16 = var_9_16 - var_9_1
								var_9_1 = 0
								var_9_3 = var_9_3 + var_9_16 * var_9_12
							else
								var_9_1 = var_9_1 - var_9_16
							end
						else
							var_9_0 = var_9_0 - var_9_14
						end
					end

					table.insert(var_9_2, {
						stageId = var_9_11,
						needMatSize = var_9_9,
						matId = var_9_8,
						oneMatCostStrength = var_9_12
					})

					var_9_7 = var_9_11
				else
					g.core.module.ModuleManager:tip(g.core.lang:get(2059))
					g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
						type = var_0_9.TYPE_KNIGHT_ADVANCE,
						value = var_9_8
					})

					return
				end
			end
		end
	end

	if var_9_3 > 0 then
		local var_9_17 = var_0_14:getOwnNum(var_0_9.TYPE_ITEM, var_0_9.ITEM.TYPE_STAMINA_PILL)
		local var_9_18 = math.ceil(var_9_3 / 25)

		if var_9_17 < var_9_18 then
			var_9_4 = var_9_17

			local var_9_19 = g.core.config.shop_score_info.get(g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.STAMINA_PILL)
			local var_9_20 = math.min(var_0_7:getBuyLimitLeft(var_9_19), var_9_18 - var_9_17)
			local var_9_21 = var_0_7:getBuyItemPrice(var_9_19, var_9_20)

			while var_0_14:getOwnNum(var_0_9.TYPE_RESOURCE, var_0_9.RESOURCE.TYPE_FREE_GOLD) < var_9_21 do
				var_9_20 = var_9_20 - 1
				var_9_21 = var_0_7:getBuyItemPrice(var_9_19, var_9_20)
			end

			var_9_5 = var_9_21
			var_9_6 = var_9_20
		else
			var_9_4 = var_9_18
		end

		if var_9_6 <= 0 and var_9_4 <= 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(201109))

			return
		end
	end

	self:showOneKeyAllBlitzPop(var_9_2, var_9_4, var_9_5, var_9_7, var_9_6)
end

function KnightAdvanceComp:showOneKeyAllBlitzPop(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	local function var_11_0()
		var_0_10:pushPopup(require("app.view.module.knight.view.KnightOneKeyAllBlitzPop").new({
			needMatData = arg_11_1,
			costItemCount = arg_11_2,
			costGoldCount = arg_11_3,
			showStageId = arg_11_4,
			needBuyCount = arg_11_5
		}), {
			touchDisappear = false,
			ignoreTouch = true
		})
	end

	if not var_0_17:isTodayHasRecord(DayNotifyToolConst.KNIGHT_ADVANCE_ONE_KEY_USE, false) then
		local var_11_1 = ""

		if arg_11_2 > 0 and arg_11_3 > 0 then
			local var_11_2 = var_0_9:convert({
				type = var_0_9.TYPE_ITEM,
				value = var_0_9.ITEM.TYPE_STAMINA_PILL
			})
			local var_11_3 = var_0_9:convert({
				type = var_0_9.TYPE_RESOURCE,
				value = var_0_9.RESOURCE.TYPE_FREE_GOLD
			})

			var_11_1 = g.core.lang:get(201123, {
				res1Icon = var_11_2.icon,
				res1Name = var_11_2.name,
				res1Num = arg_11_2,
				res2Icon = var_11_3.icon,
				res2Name = var_11_3.name,
				res2Num = arg_11_3
			})
		elseif arg_11_2 > 0 then
			local var_11_4 = var_0_9:convert({
				type = var_0_9.TYPE_ITEM,
				value = var_0_9.ITEM.TYPE_STAMINA_PILL
			})

			var_11_1 = g.core.lang:get(201124, {
				resIcon = var_11_4.icon,
				resName = var_11_4.name,
				resNum = arg_11_2
			})
		elseif arg_11_3 > 0 then
			local var_11_5 = var_0_9:convert({
				type = var_0_9.TYPE_RESOURCE,
				value = var_0_9.RESOURCE.TYPE_FREE_GOLD
			})

			var_11_1 = g.core.lang:get(201124, {
				resIcon = var_11_5.icon,
				resName = var_11_5.name,
				resNum = arg_11_3
			})
		end

		if var_11_1 ~= "" then
			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(201099),
				desc = var_11_1,
				tip = {
					txt = g.core.lang:get(408110),
					isChecked = var_0_17:isTodayHasRecord(DayNotifyToolConst.KNIGHT_ADVANCE_ONE_KEY_USE, false)
				},
				onConfirm = var_11_0,
				onCheck = function(arg_13_0)
					var_0_17:isTodayHasRecord(DayNotifyToolConst.KNIGHT_ADVANCE_ONE_KEY_USE)
					var_0_17:saveTodayRecord(DayNotifyToolConst.KNIGHT_ADVANCE_ONE_KEY_USE, arg_13_0, false)
				end
			}), {
				touchDisappear = true
			})
		else
			var_11_0()
		end
	else
		var_11_0()
	end
end

function KnightAdvanceComp:_onAdvBtnClicked()
	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_6) then
		return
	end

	if not self._ownPrmtCount or not self._knight then
		return
	end

	if self._isPropEnough then
		if self._knight:getLevel() >= self._advInfo.require_level then
			self:_onKnightAdv()

			return
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(201101))
		end
	else
		self:openBlitzPop()
	end
end

function KnightAdvanceComp:openBlitzPop()
	local var_15_0 = 0
	local var_15_1 = 0
	local var_15_2 = 0

	for iter_15_0 = KnightAdvanceComp.MATNUM, 1, -1 do
		local var_15_3 = var_0_12:getSrcRoute({
			type = var_0_9.TYPE_KNIGHT_ADVANCE,
			value = self._advInfo["place_" .. iter_15_0]
		}).routes

		table.sort(var_15_3, function(arg_16_0, arg_16_1)
			return arg_16_0.chapterId < arg_16_1.chapterId
		end)

		local var_15_5

		if #var_15_3 > 0 then
			local var_15_4 = var_0_9:convert({
				type = var_0_9.TYPE_KNIGHT_ADVANCE,
				value = self._advInfo["place_" .. iter_15_0]
			})

			if self._advInfo["num_" .. iter_15_0] > var_15_4.size and (0 == 0 or var_15_3[1].chapterId < 0) then
				var_15_5 = var_15_3[1].chapterId
				var_15_0 = self._advInfo["place_" .. iter_15_0]
				var_15_1 = self._advInfo["num_" .. iter_15_0] - var_15_4.size
				var_15_2 = self._advInfo["num_" .. iter_15_0]
			end
		end
	end

	if var_15_0 > 0 then
		local var_15_6 = var_0_14:getCountById(var_0_9.TYPE_ITEM, var_0_15)
		local var_15_7, var_15_8 = self._knight:getAdvStageAndLevel()

		self:addPopup(require("app.view.module.knight.view.KnightShortcutBlitzPop").new({
			matId = var_15_0,
			needNum = var_15_1,
			stage = var_15_7,
			cost = var_15_2,
			isShowConvert = var_15_6 > 0
		}))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(201102))
	end
end

function KnightAdvanceComp:_onKnightAdv()
	local var_17_0 = g.core.model.User.resourceData:getCoin()
	local var_17_1 = var_0_3.get(self._promoteCode, self._promoteLevel)

	if self._ownPrmtCount < var_17_1.cost_size then
		var_0_12:gotoModuleBySource({
			type = var_0_9.TYPE_ITEM,
			value = var_0_9.ITEM.TYPE_ADV_PILL,
			size = self._ownPrmtCount,
			needNum = var_17_1.cost_size - self._ownPrmtCount
		})

		return
	end

	if var_17_0 < var_17_1.cost_money then
		var_0_12:gotoModuleBySource({
			type = var_0_9.TYPE_RESOURCE,
			value = var_0_9.RESOURCE.TYPE_COIN,
			size = var_17_0,
			needNum = var_17_1.cost_money - var_17_0
		})

		return
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._guideWaitCount = self._guideWaitCount or 0
	self._guideWaitCount = self._guideWaitCount + 1

	g.core.network.GameNetProxy:send_C2S_Knight_AdvanceUpgrade({
		id = self._knightId
	})
	self:dispatchCompEvent("lock_switch", {
		isLock = true
	})
end

function KnightAdvanceComp:_onClickValueDesc()
	if not self._knight then
		return
	end

	local KnightBaseAttrUpTip = require("app.view.module.tip.view.KnightBaseAttrUpTip")

	var_0_10:pushPopup(KnightBaseAttrUpTip.new({
		knightSid = self._knight:getServerId(),
		type = KnightBaseAttrUpTip.ATTR_UP_STATE.ADVANCE_UP
	}), {
		touchDisappear = true
	})
end

function KnightAdvanceComp:_onClickSkillDesc()
	if not self._knight then
		return
	end

	var_0_10:pushPopup(require("app.view.module.tip.view.KnightTalentTip").new({
		knightSid = self._knight:getServerId(),
		type = g.core.const.ConstMgr.TipConst.KnightTipType.RANK
	}), {
		touchDisappear = true
	})
end

function KnightAdvanceComp:_onKnightAdvanceUp(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	if not arg_20_4 or not arg_20_4.id then
		return
	end

	local var_20_0 = var_0_2:getKnight({
		id = arg_20_4.id
	}):getBaseInfo().promote_code
	local var_20_1 = var_0_2:getKnightAdvLevelBySid(arg_20_4.id)

	if var_20_0 <= 0 or var_20_1 <= 0 then
		return nil
	end

	if g.core.config.knight_advance_info.get(var_20_0, var_20_1).node == 0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

		self._guideWaitCount = self._guideWaitCount + 1

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_WAIT)
		self.m_progBar:showAddEffect((handler(self, function()
			self.m_progBar:showAdvanceEffect(handler(self, self._updateViewAndShowPop))
		end)))
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_WAIT)
		self.m_progBar:showAddEffect(handler(self, function()
			self:updateView()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
				baseShowPop = {
					type = g.core.const.ConstMgr.BaseShowTypeConst.KNIGHT_ADVANCE
				}
			})
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHECK_FIGHT_VALUE_CHANGE)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_READY)
			self:dispatchCompEvent("lock_switch", {
				isLock = false
			})
		end))
	end

	if self._guideWaitCount and self._guideWaitCount > 0 then
		self._guideWaitCount = self._guideWaitCount - 1

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end
end

function KnightAdvanceComp:_updateViewAndShowPop(arg_23_1, arg_23_2)
	if arg_23_1.type == "complete" then
		self:updateView()
		self:dispatchCompEvent("lock_switch", {
			isLock = false
		})

		if not self._knight then
			return
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_READY)

		local var_23_0 = self._knight:getServerId()

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
			showNow = true,
			frontShow = {
				{
					flag = "knightAdvance",
					func = function()
						return ShowFactory:showFeedBackTipsPop({
							title = g.core.lang:get(201010),
							knightSid = var_23_0,
							showComp = fgui.UIPackage:createObject("knight", "KnightAdvanceSuccessComp")
						}, {
							hideContinue = true
						})
					end
				}
			}
		})

		if self._guideWaitCount and self._guideWaitCount > 0 then
			self._guideWaitCount = self._guideWaitCount - 1

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		end
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_READY)
	end
end

function KnightAdvanceComp:_onRcvResourceFlush()
	self:_updateRes()
end

function KnightAdvanceComp:checkResIsEnough()
	local function var_26_0(arg_27_0)
		for iter_27_0, iter_27_1 in ipairs(var_0_12:getSrcRoute({
			type = var_0_9.TYPE_KNIGHT_ADVANCE,
			value = arg_27_0
		}).routes) do
			if var_0_13:isStagePassed(iter_27_1.chapterId) then
				return true
			end
		end

		return false
	end

	for iter_26_0 = KnightAdvanceComp.MATNUM, 1, -1 do
		local var_26_1 = var_0_9:convert({
			type = var_0_9.TYPE_KNIGHT_ADVANCE,
			value = self._advInfo["place_" .. iter_26_0]
		})

		var_26_1.numCost = self._advInfo["num_" .. iter_26_0]

		if var_26_1.size < var_26_1.numCost and var_26_0(self._advInfo["place_" .. iter_26_0]) then
			return iter_26_0
		end

		table.insert(self._matData, var_26_1)
	end

	return nil
end

function KnightAdvanceComp:checkShowSpeGuide()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)

	local var_28_0, var_28_1 = self._knight:getAdvStageAndLevel()

	if var_28_0 and var_28_0 < 2 then
		local var_28_2 = self:checkResIsEnough()

		if var_28_2 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
				key = "GUILD_CHECK_KNIGHT_ADVANCE_1",
				targetBtn = self.m_matList:getChildAt(var_28_2 - 1)
			})
		end
	end
end

function KnightAdvanceComp:_onSelfExit()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_READY)

	if self._guideWaitCount and self._guideWaitCount > 0 then
		for iter_29_0 = 1, self._guideWaitCount do
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		end
	end
end

function KnightAdvanceComp:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

return KnightAdvanceComp
