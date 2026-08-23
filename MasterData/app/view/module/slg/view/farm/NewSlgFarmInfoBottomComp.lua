local NewSlgFarmInfoBottomComp = class("NewSlgFarmInfoBottomComp", require("app.fairyGUI.newSlg.UI_NewSlgFarmInfoBottomComp"))

function NewSlgFarmInfoBottomComp:ctor()
	self._txtTime = self:getChild("Txt_time")
	self._txtTime2 = self:getChild("Txt_time2")
	self._btnHelp = self:getChild("Btn_help")

	self._btnHelp:addClickListener(handler(self, self._onClickBtnHelp))

	self._btnAtk = self:getChild("Btn_atk")

	self._btnAtk:addClickListener(handler(self, self._onClickBtnAtk))

	self._btnFarm = self:getChild("Btn_farm")

	self._btnFarm:addClickListener(handler(self, self._onClickBtnFarm))

	self._btnCancel = self:getChild("Btn_cancel")

	self._btnCancel:addClickListener(handler(self, self._onClickBtnCancel))

	self._compDecrease = self:getChild("Comp_decrease")

	self._compDecrease:addClickListener(handler(self, self.onTipsClick))

	self._btnDecreaseHelp = self._compDecrease:getChild("Btn_help")

	self._btnDecreaseHelp:addClickListener(handler(self, self._onClickBtnDecreaseHelp))

	self._listFarmAwards = self:getChild("List_farmAwards")

	self._listFarmAwards:setVirtual(self)
	self._listFarmAwards:setItemRenderer(handler(self, self._onRenderListFarmAwardsCell))

	self._stateCtrl = self:getController("state")
	self._txtDesc = self:getChild("Txt_desc")

	self._txtDesc:setText(g.core.lang:get(429686, {
		num = g.core.model.User.newSlgData:getNewSlgParamsValueById(186) / 10
	}))
	self.m_genDescTxt:setText(g.core.lang:get(429709, {
		num = g.core.model.User.newSlgData:getNewSlgParamsValueById(195) / 60
	}))
end

function NewSlgFarmInfoBottomComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETFARMDEFINFO, handler(self, self.onGetFarmTeamInfo), self)
end

function NewSlgFarmInfoBottomComp:updateView(arg_3_1)
	if not arg_3_1 then
		return
	end

	self._farmId = arg_3_1.farmId
	self._info = g.core.model.User.newSlgData:getFarmInfoById(self._farmId)
	self._data = g.core.model.User.newSlgData:getFarmDataById(self._farmId)

	self:_updateState()
	self:updateTime()
	self:_updateDecrease()
	self:_updateFarmAwards()
	self._btnFarm:updateCost(g.core.common.Goods:convert({
		value = 60013,
		type = g.core.common.Goods.TYPE_ITEM
	}), 1, g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_ITEM, 60013))
end

function NewSlgFarmInfoBottomComp:_updateFarmAwards()
	local var_4_0 = {
		type = self._info.reward_type,
		value = self._info.reward_value,
		size = self._info.reward_size
	}

	g.core.model.User.newSlgData:getAndUpdateItemNumAfterAddition(var_4_0, false, g.core.const.ConstMgr.NewSlgConst.ATTR_MODULE.FARM)

	self._awards = {
		var_4_0
	}

	self._listFarmAwards:setNumItems(#self._awards)
end

function NewSlgFarmInfoBottomComp:_updateDecrease()
	if self._state == 6 or self._state == 7 or self._state == 8 then
		self._compDecrease:setVisible(false)

		return
	end

	local var_5_0 = g.core.model.User.newSlgData:getAuthorityDecreaseNum(self._info.belong)

	if var_5_0 == 0 then
		self._compDecrease:setVisible(false)
	else
		self._compDecrease:setVisible(true)
		self._compDecrease:setTitle("-" .. g.core.lang:get(429685, {
			num = var_5_0
		}))
	end
end

function NewSlgFarmInfoBottomComp:_updateState()
	local var_6_0, var_6_1, var_6_2 = g.core.model.User.newSlgData:isFarmPeriod()

	if var_6_2 == g.core.const.ConstMgr.NewSlgConst.FARM_PERIOD.UNLOCK then
		self._state = 6

		self._stateCtrl:setSelectedIndex(self._state)

		return
	end

	if not g.core.model.User.newSlgData:isFarmLandOpen(self._data.farmId) then
		self._state = 8

		self._stateCtrl:setSelectedIndex(self._state)

		return
	end

	self._state = 0
	self._state = var_6_2 == g.core.const.ConstMgr.NewSlgConst.FARM_PERIOD.OPEN and (not self._data.isOccupying and 0 or self._data.isSelf and 2 or 5) or not self._data.isOccupying and 6 or self._data.isSelf and 9 or 6

	self._stateCtrl:setSelectedIndex(self._state)
end

function NewSlgFarmInfoBottomComp:updateTime()
	if self._data and self._data.isOccupying then
		local var_7_0 = g.core.common.ServerTime:getTime() - self._data.startTime

		self.m_curOccuTime:setText(g.core.common.ServerTime:secondToHMSString(var_7_0))

		local var_7_1 = {
			type = self._info.reward_type,
			value = self._info.reward_value,
			size = self._info.reward_size
		}

		g.core.model.User.newSlgData:getAndUpdateItemNumAfterAddition(var_7_1, false, g.core.const.ConstMgr.NewSlgConst.ATTR_MODULE.FARM)
		self.m_curRewardNum:setText(var_7_1.size * math.floor(var_7_0 / g.core.model.User.newSlgData:getNewSlgParamsValueById(195)))
	end

	if self._state ~= 6 and self._state ~= 8 then
		-- block empty
	elseif self._state == 6 then
		local var_7_2, var_7_3 = g.core.model.User.newSlgData:isFarmPeriod()

		if var_7_3 > 0 then
			self._txtTime:setVisible(true)
			self._txtTime:setText((g.core.common.ServerTime:secondToHMSString(var_7_3)))
		else
			self._txtTime:setVisible(false)
		end
	elseif self._state == 8 then
		local var_7_4, var_7_5 = g.core.model.User.newSlgData:isFarmLandOpen(self._data.farmId)

		if var_7_5 and var_7_5 > 0 then
			self._txtTime2:setVisible(true)
			self._txtTime2:setText((g.core.common.ServerTime:getActivityLeftTime(var_7_5)))
		else
			self._txtTime2:setVisible(false)
		end
	end
end

function NewSlgFarmInfoBottomComp:_onClickBtnHelp()
	self:dispatchCompEvent("NewSlgFarmInfoComp_click_help2", {
		desc = g.core.model.User:getNoticeText(782)
	})
end

function NewSlgFarmInfoBottomComp:_onClickBtnDecreaseHelp()
	return
end

function NewSlgFarmInfoBottomComp:onGetFarmTeamInfo(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self._serverData = arg_10_4
end

function NewSlgFarmInfoBottomComp:_onClickBtnAtk()
	if self._data then
		if not g.core.model.User.newSlgData:isCanAttackFarm(self._farmId) then
			g.core.module.ModuleManager:tip(g.core.lang:get(429725))

			return
		end

		local var_11_0 = self._data.protectTime

		if self._data.protectTime > 0 then
			local var_11_1 = g.core.model.User.newSlgData:getNewSlgParamsValueById(192) + var_11_0

			if var_11_1 > g.core.common.ServerTime:getTime() then
				g.core.module.ModuleManager:tip(g.core.lang:get(429711, {
					time = g.core.common.ServerTime:getTimeStringHMS(var_11_1)
				}))

				return
			end
		end

		local var_11_2 = g.core.model.User.newSlgData:getFarmComponentById(self._farmId)

		self:dispatchCompEvent("NewSlg_Farm_Gather", {
			buildType = g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.FARM,
			info = self._info,
			x = var_11_2.anchor_x,
			y = var_11_2.anchor_y,
			marchTp = g.core.const.ConstMgr.NewSlgConst.FARM_SERVER_TYPE.ATK,
			serverData = self._serverData,
			isFarmHasOwner = var_11_0 > 0,
			decrease = g.core.model.User.newSlgData:getAuthorityDecreaseNum(self._info.belong)
		})
	end
end

function NewSlgFarmInfoBottomComp:_onClickBtnFarm()
	local var_12_0 = g.core.model.User.newSlgDevelopData:getSupplyStorageLimit()
	local var_12_1 = g.core.model.User.newSlgDevelopData:getSupplyProductionItem()
	local var_12_2 = g.core.model.User.bagData:getOwnNum(var_12_1.type, var_12_1.value)
	local var_12_3 = g.core.model.User.newSlgData:getFarmInfoById(self._farmId)
	local var_12_4 = {
		type = var_12_3.reward_type,
		value = var_12_3.reward_value,
		size = var_12_3.reward_size
	}

	g.core.model.User.newSlgData:getAndUpdateItemNumAfterAddition(var_12_4, false, g.core.const.ConstMgr.NewSlgConst.ATTR_MODULE.FARM)

	if var_12_2 == var_12_0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(429718))

		return
	end

	local var_12_5, var_12_6 = g.core.model.User.newSlgData:getCurDayFarmRewardCount()

	if var_12_5 == var_12_6 then
		g.core.module.ModuleManager:tip(g.core.lang:get(429726))

		return
	end

	if var_12_0 >= var_12_4.size * math.floor(g.core.config.item_info.get(g.core.model.User.newSlgDevelopData:getFarmItem().value).item_value / g.core.model.User.newSlgData:getNewSlgParamsValueById(195)) + var_12_2 then
		if var_12_6 < var_12_4.size * math.floor(g.core.config.item_info.get(g.core.model.User.newSlgDevelopData:getFarmItem().value).item_value / g.core.model.User.newSlgData:getNewSlgParamsValueById(195)) + var_12_5 then
			local var_12_7 = require("app.view.base.pop.BaseConfirmPop").new

			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(429717),
				desc = g.core.lang:get(429716),
				onConfirm = handler(self, self._confirmFarm)
			}), {
				touchDisappear = false,
				ignoreTouch = false
			})

			return
		end
	end

	self:_confirmFarm()
end

function NewSlgFarmInfoBottomComp:_confirmFarm()
	g.core.network.GameNetProxy:send_C2S_NewSlg_UseFarmToken({
		farm_id = self._farmId
	})
end

function NewSlgFarmInfoBottomComp:onTipsClick()
	self:dispatchCompEvent("CLICK_TIPS_SLG_FARM")
end

function NewSlgFarmInfoBottomComp:_onClickBtnCancel()
	local var_15_0 = self._farmId

	g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(407915),
		desc = g.core.lang:get(429684),
		onConfirm = handler(self, function()
			g.core.network.GameNetProxy:send_C2S_NewSlg_FarmGiveUp({
				farm_id = var_15_0
			})
		end)
	})))
end

function NewSlgFarmInfoBottomComp:_onRenderListFarmAwardsCell(arg_17_1, arg_17_2)
	arg_17_2:updateIcon(self._awards[arg_17_1 + 1])
end

return NewSlgFarmInfoBottomComp
