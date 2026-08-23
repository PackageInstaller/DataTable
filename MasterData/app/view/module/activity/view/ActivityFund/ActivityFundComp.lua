local var_0_0 = g.core.const.ConstMgr.ActivityConst
local var_0_1 = g.core.common.Goods
local var_0_2 = 60
local ActivityFundComp = class("ActivityFundComp", require("app.fairyGUI.activity.UI_ActivityFundComp"))

function ActivityFundComp:ctor()
	self._stageNum = 0
	self._fundData = {}
	self._firstRefresh = true

	self.m_rechargeBtn:addClickListener(handler(self, self._onClickBuy))
	self.m_buySBtn:addClickListener(handler(self, self._onClickBuy))
	self.m_oneKeyLBtn:addClickListener(handler(self, self._onOneKeyAward))
	self.m_oneKeySBtn:addClickListener(handler(self, self._onOneKeyAward))
	self.m_allBuyAwardBtn:addClickListener(handler(self, self._onClickWelfare))
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._updateAwardCell))
	self.m_stageList:setIniter()
	self.m_stageList:setItemRenderer(handler(self, self._onStageListRenderer))
	self.m_stageList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickStageItem))

	self._curNum = 0
	self._curStage = 1
	self._fundType = 0
	self._stageId = 0
	self._isFirstEnter = true

	self.m_bugBtnGroup:setVisible(false)
end

function ActivityFundComp:onLoad()
	if not self._defaultRightX then
		self._defaultRightX = self.m_rightGroup:getX()
		self._defaultRightY = self.m_rightGroup:getY()
	end

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_NOTIFYSUCCESS, handler(self, self._onRcvRechargeSuccess), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGE, handler(self, self._onRcvGetFundRecharge), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGEAWARD, handler(self, self._onRcvFundReward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFUNDRECHARGEAWARDONEKEY, handler(self, self._onRcvFundRewardOneKey), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_FUNDBUYNOTIFY, handler(self, self._onRcvFundNotify), self)
	g.core.network.GameNetProxy:send_C2S_Recharge_GetFundRecharge({})
end

function ActivityFundComp:_onRcvRechargeSuccess(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	g.core.network.GameNetProxy:send_C2S_Recharge_GetFundRecharge({})
end

function ActivityFundComp:_onRcvGetFundRecharge(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self:updateRightList()
	self:_updateView()
end

function ActivityFundComp:_onRcvFundNotify(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self:_updateView()
end

function ActivityFundComp:_onRcvFundReward(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_4.id then
		local var_6_0 = g.core.config.fund_info.get(arg_6_4.id)

		if var_6_0.fund_type ~= self._fundType then
			return
		end

		g.core.module.ModuleManager:awardSummary(arg_6_4.awards)
		self:_updateList(true)
		self:_updateView()

		if var_6_0.type == g.core.const.ConstMgr.RechargeConst.FUND_TYPE.WELFARE then
			-- block empty
		end
	end
end

function ActivityFundComp:_onRcvFundRewardOneKey(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = {}
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_4.awards) do
		if var_7_1[iter_7_1.value .. "_" .. iter_7_1.type] then
			var_7_0[var_7_1[iter_7_1.value .. "_" .. iter_7_1.type]].size = var_7_0[var_7_1[iter_7_1.value .. "_" .. iter_7_1.type]].size + iter_7_1.size
		else
			var_7_1[iter_7_1.value .. "_" .. iter_7_1.type] = #var_7_0 + 1

			table.insert(var_7_0, clone(iter_7_1))
		end
	end

	g.core.module.ModuleManager:awardSummary(var_7_0)
	self:_updateList(true)
	self:_updateView()
end

function ActivityFundComp:_updateList(arg_8_1)
	local var_8_0, var_8_1 = g.core.model.User.activityFundData:getFundData(self._stageId)

	self._fundData = var_8_0

	self.m_awardList:setNumItems(#self._fundData)

	if not arg_8_1 then
		self.m_awardList:addSelection(math.max(0, var_8_1 - 1), true)
	end
end

function ActivityFundComp:updateComp(arg_9_1, arg_9_2)
	self._curStage = 1

	local var_9_0

	if arg_9_2 == var_0_0.ACTIVITY_TYPE.LEVEL_FUND then
		self.m_typeController:setSelectedIndex(0)

		self._fundType = var_0_0.ACTIVITY_FUND_TYPE.GROWTH
		self._curNum = g.core.model.User:getLevel()

		self.m_descTxt:setText(g.core.lang:get(405604, {
			num = self._curNum
		}))
		self.m_knightPicComp:updateKnight({
			resId = 600020
		})
		self.m_rewardLoader:setURL(g.core.common.Goods:convert({
			value = 6,
			type = var_0_1.TYPE_ITEM
		}).icon)

		var_9_0 = 5000011
	elseif arg_9_2 == var_0_0.ACTIVITY_TYPE.DUNGEON_FUND then
		self.m_typeController:setSelectedIndex(1)

		self._fundType = var_0_0.ACTIVITY_FUND_TYPE.ZHUXIAN
		self._curNum = g.core.model.User.dungeonData:getPassedChapterNum()

		self.m_descTxt:setText(g.core.lang:get(405610, {
			num = self._curNum
		}))
		self.m_zhuxianRewardLoader:setURL(g.core.common.Goods:convert({
			type = var_0_1.TYPE_ITEM,
			value = var_0_1.ITEM.TYPE_ADVANCE_RECRUIT_ITEM
		}).icon)
		self.m_knightPicComp:updateKnight({
			resId = 510050
		})

		var_9_0 = 255
	elseif arg_9_2 == var_0_0.ACTIVITY_TYPE.WUSH_FUND then
		self.m_typeController:setSelectedIndex(2)

		self._fundType = var_0_0.ACTIVITY_FUND_TYPE.WUSHUANG
		self._curNum = g.core.model.User.activityFundData:getWuShuangMaxLayer()

		self.m_descTxt:setText(g.core.lang:get(405611, {
			num = self._curNum
		}))
		self.m_knightPicComp:updateKnight({
			resId = 600050
		})

		var_9_0 = 256
	elseif arg_9_2 == var_0_0.ACTIVITY_TYPE.MYSTERY_FUND then
		self.m_typeController:setSelectedIndex(3)

		self._fundType = var_0_0.ACTIVITY_FUND_TYPE.MYSTERY
		self._curNum = g.core.model.User.mysteryData:getLastPassChapterId()

		self.m_descTxt:setText(g.core.lang:get(405627, {
			num = self._curNum
		}))
		self.m_knightPicComp:updateKnight({
			resId = 700600
		})

		var_9_0 = 798
	end

	if var_9_0 then
		self.m_redPointComp:setId(var_9_0)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp
		})
	end

	local var_9_1 = 250

	self.m_knightPicComp:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-var_9_1 / 2, 0, var_9_1 * 2, 0), 250)

	local var_9_2

	if #g.core.model.User.activityFundData:getFundWelfareDataByType(self._fundType) > 0 then
		self.m_welfareGroup:setVisible(true)
	else
		self.m_welfareGroup:setVisible(false)

		var_9_2 = self._defaultRightX
	end

	if g.core.model.User.activityFundData:getStageByType(self._fundType) > 1 then
		self.m_rightGroup:setX(self._defaultRightX)

		self._curStage = g.core.model.User.activityFundData:getFirstCanRecStage(self._fundType)
	else
		self.m_rightGroup:setX(self._defaultRightX + var_0_2)

		var_9_2 = self._defaultRightX + var_0_2
	end

	self.m_enterTransition:changeParams({
		posx = {
			var_9_2,
			self._defaultRightY
		}
	}):play()
	self:_updateView()
end

function ActivityFundComp:updateRightList(arg_10_1)
	local var_10_0 = g.core.model.User.activityFundData:getStageByType(self._fundType)

	if var_10_0 > 1 then
		self.m_stageList:setNumItems(var_10_0)

		if arg_10_1 then
			self.m_stageList:setSelectedIndex(self._curStage - 1)
		end
	else
		self.m_stageList:setNumItems(0)
	end
end

function ActivityFundComp:_updateView()
	if self._isFirstEnter then
		self._isFirstEnter = true

		self:updateRightList(true)
	end

	self._stageId = g.core.model.User.activityFundData:getRIdByFundTypeAndPeriod(self._fundType, self._curStage)

	local var_11_0 = g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(g.core.const.ConstMgr.RechargeConst.FUND_ID, g.core.model.User.activityFundData:getRechargeDemo(self._fundType, self._stageId).money)

	if not var_11_0.moneyUnit then
		-- block empty
	end

	self.m_priceTxt:setText(var_11_0.moneyUnit .. var_11_0.realMoney)
	self.m_price2Txt:setText(var_11_0.moneyUnit .. var_11_0.realMoney)

	if self._fundType == var_0_0.ACTIVITY_FUND_TYPE.GROWTH then
		self._curNum = g.core.model.User:getLevel()

		self.m_descTxt:setText(g.core.lang:get(405604, {
			num = self._curNum
		}))
	elseif self._fundType == var_0_0.ACTIVITY_FUND_TYPE.ZHUXIAN then
		self._curNum = g.core.model.User.dungeonData:getPassedChapterNum()

		self.m_descTxt:setText(g.core.lang:get(405610, {
			num = self._curNum
		}))
	elseif self._fundType == var_0_0.ACTIVITY_FUND_TYPE.WUSHUANG then
		self._curNum = g.core.model.User.activityFundData:getWuShuangMaxLayer()

		self.m_descTxt:setText(g.core.lang:get(405611, {
			num = self._curNum
		}))
	elseif self._fundType == var_0_0.ACTIVITY_FUND_TYPE.MYSTERY then
		self._curNum = g.core.model.User.mysteryData:getLastPassChapterId()

		self.m_descTxt:setText(g.core.lang:get(405627, {
			num = self._curNum
		}))
	end

	self.m_bugBtnGroup:setVisible(true)

	local var_11_2 = g.core.model.User.activityFundData:isRechargeFund(self._stageId)

	self:_updateList()

	local var_11_3 = 0

	if self._fundData and #self._fundData > 0 then
		for iter_11_0, iter_11_1 in ipairs(self._fundData) do
			if iter_11_1.normal.state == 1 then
				var_11_3 = var_11_3 + 1
			end

			if iter_11_1.advance.state == 1 then
				var_11_3 = var_11_3 + 1
			end
		end
	end

	if var_11_2 then
		if var_11_3 > 1 then
			self.m_stateController:setSelectedIndex(3)
		else
			self.m_stateController:setSelectedIndex(1)
		end
	elseif var_11_3 > 1 then
		self.m_stateController:setSelectedIndex(2)
	else
		self.m_stateController:setSelectedIndex(0)
	end

	local var_11_4

	if var_11_2 then
		self.m_rechargeBtn:setTouchable(false)
		self.m_rechargeBtn:setGrayed(true)
	else
		self.m_rechargeBtn:setTouchable(true)
		self.m_rechargeBtn:setGrayed(false)

		var_11_4 = {}
	end

	var_11_4.num = g.core.model.User.activityFundData:getActiveNumByType(self._fundType)

	self.m_allBuyNum:setText(g.core.lang:get(400504, var_11_4))
	self.m_stageController:setSelectedIndex(self._curStage - 1)
end

function ActivityFundComp:_onOneKeyAward()
	g.core.network.GameNetProxy:send_C2S_Recharge_GetFundRechargeAwardOneKey({
		tp = self._fundType,
		period = self._curStage
	})
end

function ActivityFundComp:_onClickBuy()
	local var_13_0

	if g.core.model.User.activityFundData:isRechargeFund(self._stageId) then
		do return end

		var_13_0 = require("app.view.module.activity.view.ActivityFund.ActivityFuncBuyPop").new
	end

	g.core.module.ModuleManager:pushPopup((require("app.view.module.activity.view.ActivityFund.ActivityFuncBuyPop").new({
		fundType = self._fundType,
		fundStage = self._curStage,
		stageId = self._stageId
	})))
end

function ActivityFundComp:_onClickWelfare()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.activity.view.ActivityFund.ActivityFundWelfarePop").new(self._fundType, {
		fundType = self._fundType,
		fundStage = self._curStage,
		stageId = self._stageId
	})))
end

function ActivityFundComp:_onClickStageItem()
	local var_15_0 = self.m_stageList:getSelectedIndex() + 1

	if self._curStage ~= var_15_0 then
		self._curStage = var_15_0

		self:_updateView()
	end
end

function ActivityFundComp:_onStageListRenderer(arg_16_1, arg_16_2)
	arg_16_2:setCtrlState("stage", {
		index = arg_16_1
	})
end

function ActivityFundComp:_updateAwardCell(arg_17_1, arg_17_2)
	arg_17_2:updateCellView({
		data = self._fundData[arg_17_1 + 1],
		index = arg_17_1 + 1,
		fundType = self._fundType
	})
end

return ActivityFundComp
