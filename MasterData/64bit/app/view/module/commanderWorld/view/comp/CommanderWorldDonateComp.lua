local var_0_0 = g.core.model.User.commanderWorldData
local var_0_1 = g.core.const.ConstMgr.CommanderWorldConst
local var_0_2 = g.core.model.User.bagData
local PressComp = require("app.view.module.recruit.view.comp.PressComp")
local var_0_4 = g.core.common.ServerTime
local CommanderWorldDonateComp = class("CommanderWorldDonateComp", require("app.fairyGUI.commanderWorld.UI_CommanderWorldDonateComp"))

function CommanderWorldDonateComp:ctor()
	PressComp.bindComp(self)
	self:setClickListener(handler(self, self._onClickSelf))
	self:setIgnoreMove(false)
	self:setPressTime(0.2)
	self:setPressInterval(var_0_1.PRESS_INTERVAL)
	self:addPressListener(handler(self, self._onPress))

	self._startDonateTime = 0
	self._sendMsgNeedTimes = math.floor(1 / var_0_1.PRESS_INTERVAL)
	self._hasPop = false
	self._typeIndex = self.m_typeController:getSelectedIndex()
	self._itemId = var_0_1.DONATE_ITEM_ID[self._typeIndex + 1]
	self._itemType = var_0_1.DONATE_ITEM_TYPE
	self._guildId = 0
	self._stage = 0
	self._clickNum = 0

	self:_initDonateComp()
end

function CommanderWorldDonateComp:_initDonateComp()
	self._scoreInfo = var_0_0:getItemAddScoreByItemId(self._itemId)

	self.m_addScoreTxt:setText("+" .. self._scoreInfo.rewardSize)
	self.m_tokenIcon:setURL(g.core.common.Goods:convert({
		type = self._scoreInfo.rewardType,
		value = self._scoreInfo.rewardValue
	}).icon)
	self.m_progTxt:setText("+" .. self._scoreInfo.guildScore)

	self._itemValue = g.core.config.item_info.fetch(self._itemId).item_value

	self:setIcon(g.core.common.Goods:convert({
		type = self._itemType,
		value = self._itemId
	}).icon)
	self:updateDonateComp()
end

function CommanderWorldDonateComp:updateDonateComp()
	local var_3_0 = var_0_2:getOwnNum(self._itemType, self._itemId)

	self.m_numTxt:setText(var_3_0)
	self.m_isEmptyController:setSelectedIndex(var_3_0 > 0 and 0 or 1)
end

function CommanderWorldDonateComp:_onClickSelf()
	if not self._scoreInfo then
		return
	end

	if self.m_isEmptyController:getSelectedIndex() == 1 then
		return
	elseif var_0_0:isNeedPopTip() then
		local var_4_0 = var_0_0:getActivityStageAndRemainTime()
		local var_4_1 = g.core.model.User:getGuildId()
		local var_4_2 = {
			title = g.core.lang:get(1257),
			onConfirm = handler(self, function()
				var_0_0:savePopStatus()
			end),
			confirmText = g.core.lang:get(1160),
			cancelText = g.core.lang:get(1037)
		}

		if var_4_1 == 0 and var_4_0 == var_0_1.STAGE.REWARDDAY then
			var_4_2.desc = g.core.lang:get(410318)

			g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new(var_4_2)))

			return
		elseif var_4_1 == 0 then
			var_4_2.desc = g.core.lang:get(410319)

			g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new(var_4_2)))

			return
		elseif var_4_0 == var_0_1.STAGE.REWARDDAY then
			var_4_2.desc = g.core.lang:get(410315)

			g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new(var_4_2)))

			return
		end
	end

	self:dispatchCompEvent("Add_Item_1", {
		num = 1,
		itemId = self._itemId,
		itemIndex = self._typeIndex + 1
	})
end

function CommanderWorldDonateComp:_onPress(arg_6_1, arg_6_2, arg_6_3)
	if not self._scoreInfo then
		return
	end

	if self.m_isEmptyController:getSelectedIndex() == 1 then
		return
	end

	local var_6_0 = var_0_2:getOwnNum(self._itemType, self._itemId)
	local var_6_1 = var_0_0:getActivityStageAndRemainTime()

	if var_6_0 - self._clickNum <= 0 then
		self.m_isEmptyController:setSelectedIndex(1)
		g.core.module.ModuleManager:tip(g.core.lang:get(410320))
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			size = 0,
			type = g.core.common.Goods.TYPE_ITEM,
			value = self._itemId
		})

		return
	elseif var_0_0:isNeedPopTip() then
		if not self._hasPop then
			local var_6_2 = g.core.model.User:getGuildId()
			local var_6_3 = {
				title = g.core.lang:get(1257),
				onConfirm = handler(self, function()
					self._hasPop = false

					var_0_0:savePopStatus()
				end),
				onCancel = handler(self, function()
					self._hasPop = false
				end),
				confirmText = g.core.lang:get(1160),
				cancelText = g.core.lang:get(1037)
			}

			if var_6_2 == 0 and var_6_1 == var_0_1.STAGE.REWARDDAY then
				self._hasPop = true
				var_6_3.desc = g.core.lang:get(410318)

				g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new(var_6_3)))

				return
			elseif var_6_2 == 0 then
				self._hasPop = true
				var_6_3.desc = g.core.lang:get(410319)

				g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new(var_6_3)))

				return
			elseif var_6_1 == var_0_1.STAGE.REWARDDAY then
				self._hasPop = true
				var_6_3.desc = g.core.lang:get(410315)

				g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new(var_6_3)))

				return
			end
		end

		return
	end

	local var_6_4 = self:_getDonateSpeed(arg_6_3)

	self._clickNum = math.min(var_6_0, self._clickNum + var_6_4)

	local var_6_5 = var_0_4:getTime()

	self:dispatchCompEvent("Press_Add", {
		itemId = self._itemId,
		num = var_6_4,
		itemIndex = self._typeIndex + 1
	})
	self.m_numTxt:setText(var_6_0 - self._clickNum)
end

function CommanderWorldDonateComp:_additionalTouchEnd(arg_9_1, arg_9_2)
	if self._clickNum > 0 then
		self:dispatchCompEvent("Press_Add_Item", {
			itemId = self._itemId,
			num = self._clickNum,
			itemIndex = self._typeIndex + 1
		})

		self._clickNum = 0
	end
end

function CommanderWorldDonateComp:_additionalTouchBegin(arg_10_1, arg_10_2)
	self._startDonateTime = var_0_4:getTime()

	if var_0_2:getOwnNum(self._itemType, self._itemId) - self._clickNum <= 0 then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = self._itemType,
			value = self._itemId
		})
	end
end

function CommanderWorldDonateComp:_getDonateSpeed(arg_11_1)
	local var_11_0 = var_0_2:getOwnNum(self._itemType, self._itemId)

	if var_11_0 < 100 then
		return 1
	end

	local var_11_1 = 1

	if var_11_0 * 0.1 > self._clickNum then
		return math.ceil(var_11_0 * 0.1 * arg_11_1)
	elseif var_11_0 * 0.3 > self._clickNum then
		return math.ceil(var_11_0 * 0.2 * arg_11_1)
	elseif var_11_0 * 0.6 > self._clickNum then
		return math.ceil(var_11_0 * 0.3 * arg_11_1)
	elseif var_11_0 * 1 > self._clickNum then
		return math.ceil(var_11_0 * 0.4 * arg_11_1)
	end

	return var_11_1
end

return CommanderWorldDonateComp
