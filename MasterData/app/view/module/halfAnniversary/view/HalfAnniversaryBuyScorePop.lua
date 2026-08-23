local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User.bagData
local var_0_2 = g.core.model.User.halfAnniversaryData
local HalfAnniversaryBuyScorePop = class("HalfAnniversaryBuyScorePop", require("app.fairyGUI.halfAnniversary.UI_HalfAnniversaryBuyScorePop"), function()
	return fgui.GComponent:create({
		resName = "HalfAnniversaryBuyScorePop",
		pkgPath = "ui/halfAnniversary/halfAnniversary",
		pkgName = "halfAnniversary"
	}, ...)
end)

function HalfAnniversaryBuyScorePop:ctor()
	self:showAtCenter()

	self._targetScore = 1
	self._allScoreRewards = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListRenderer))
	self.m_buyScoreBtn:addClickListener(handler(self, self._onClickBuyScoreBtn))
end

function HalfAnniversaryBuyScorePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WELFAREFUND_BUYSCORE, handler(self, self._updateBuyScoreView), self)
	self:_updateBuyScoreView()
end

function HalfAnniversaryBuyScorePop:_updateBuyScoreView()
	self._allScoreRewards = var_0_2:getAllScoreAwards()
	self._activityCfg = var_0_2:getHalfYearActivityCfg()

	local var_4_0 = var_0_0:convert({
		type = var_0_0.TYPE_ITEM,
		value = self._activityCfg.item_id
	})

	self.m_popPanel:setTitleName(g.core.lang:get(408206, {
		itemStr = var_4_0.name
	}))
	self.m_scoreItemName:setText(var_4_0.name)
	self.m_scoreDescTxt:setText(g.core.lang:get(408207, {
		itemStr = var_4_0.name
	}))

	self._ownScore = var_0_1:getCountById(var_0_0.TYPE_ITEM, self._activityCfg.item_id)

	local var_4_1 = var_0_2:getMapPointAwardsCfg()

	if not var_4_1 or #var_4_1 == 0 then
		return
	end

	local var_4_2 = var_4_1[#var_4_1].need_point

	self._maxScore = var_4_1[#var_4_1].need_point - self._ownScore

	if self._maxScore < 0 then
		self._maxScore = 0
	end

	self.m_curScoreTxt:setText(math.min(self._ownScore, var_4_2))

	self._targetScore = self._ownScore + 1

	self.m_targetScoreTxt:setText(math.min(self._targetScore, var_4_2))

	self._maxAddLevel = self._maxScore

	self.m_chooseNumComp:initMinMaxNum({
		cur = 1,
		min = 1,
		max = self._maxScore,
		callback = handler(self, self._chooseScoreChange)
	})
	self.m_resComp:updateByTVS({
		type = self._activityCfg.cost_type,
		value = self._activityCfg.cost_value,
		size = self._activityCfg.cost_num
	})
	self.m_awardList:setNumItems(#self._allScoreRewards)

	if var_4_2 <= self._ownScore then
		self.m_buyScoreBtn:setGrayed(true)
		self.m_buyScoreBtn:setTouchable(false)
	else
		self.m_buyScoreBtn:setGrayed(false)
		self.m_buyScoreBtn:setTouchable(true)
	end
end

function HalfAnniversaryBuyScorePop:_onClickBuyScoreBtn()
	if self.m_resComp:isLack() then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = self._activityCfg.cost_type,
			value = self._activityCfg.cost_value
		})
	else
		local var_5_0 = self.m_chooseNumComp:getCurNum()

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(408201),
			desc = g.core.lang:get(408202, {
				price = var_5_0 * self._activityCfg.cost_num,
				score = var_5_0
			}),
			onConfirm = handler(self, function()
				g.core.network.GameNetProxy:send_C2S_Welfarefund_BuyScore({
					size = var_5_0
				})
			end)
		}))
	end
end

function HalfAnniversaryBuyScorePop:_onAwardListRenderer(arg_7_1, arg_7_2)
	arg_7_2:updateScoreAward(self._allScoreRewards[arg_7_1 + 1], self._targetScore)
end

function HalfAnniversaryBuyScorePop:_chooseScoreChange(arg_8_1, arg_8_2)
	if arg_8_2 then
		if arg_8_2.isAdd and self._targetScore >= self._maxScore + self._ownScore then
			return
		end
	elseif arg_8_1 <= 1 and self._targetScore <= self._ownScore + 1 then
		return
	end

	self._targetScore = self._ownScore + arg_8_1

	self.m_targetScoreTxt:setText(self._targetScore)
	self.m_awardList:setNumItems(#self._allScoreRewards)
	self.m_resComp:updateByTVS({
		type = self._activityCfg.cost_type,
		value = self._activityCfg.cost_value,
		size = self._activityCfg.cost_num * arg_8_1
	})
end

return HalfAnniversaryBuyScorePop
