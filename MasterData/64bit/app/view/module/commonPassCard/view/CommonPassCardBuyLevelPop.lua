local var_0_0 = g.core.common.Goods.TYPE_GOLD
local var_0_1 = g.core.model.User.commonPassCardDataMgr
local var_0_2 = g.core.utils.Number.getFormatNum
local CommonPassCardBuyLevelPop = class("CommonPassCardBuyLevelPop", require("app.fairyGUI.commonPassCard.UI_CommonPassCardBuyLevelPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/commonPassCard/commonPassCard",
		resName = "CommonPassCardBuyLevelPop",
		pkgName = "commonPassCard",
		isFullScreen = false
	}, ...)
end)

function CommonPassCardBuyLevelPop:ctor(arg_2_1)
	self:showAtCenter()

	self._actId = arg_2_1.activityId
	self._targetLevel = 1

	self.m_buyBtn:addClickListener(handler(self, self._onBuyClick))
	self.m_levelAwardList:setVirtual()
	self.m_levelAwardList:setItemRenderer(handler(self, self._onAwardListRenderer))
end

function CommonPassCardBuyLevelPop:onLoad()
	self._commonPassCardData = var_0_1:getPassCardData(self._actId)

	self.m_curLevelTxt:setText(var_0_2(2, self._commonPassCardData:getPassCardLv()))

	self._targetLevel = self._commonPassCardData:getPassCardLv() + 1
	self._allCanBuyRewards = self._commonPassCardData:getUpgradePassCardAward(self._targetLevel)

	self.m_targetLevelTxt:setText(g.core.utils.Number.getFormatNum(2, self._targetLevel))

	local var_3_0 = self._commonPassCardData:getMaxPassCardLv() - self._commonPassCardData:getPassCardLv()

	self._maxAddLevel = var_3_0

	self.m_chooseNumComp:initMinMaxNum({
		min = 1,
		cur = 1,
		max = var_3_0,
		callback = handler(self, self._chooseLevelChange)
	})
	self.m_resComp:updateByTVS({
		value = 0,
		type = var_0_0,
		size = tonumber(self._commonPassCardData:getBuyLevelCost(self._targetLevel)[1].size)
	})
	self.m_levelAwardList:setNumItems(#self._allCanBuyRewards)
end

function CommonPassCardBuyLevelPop:_onBuyClick()
	if self.m_resComp:isLack() then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			value = 0,
			type = var_0_0,
			needSize = tonumber(self._commonPassCardData:getBuyLevelCost(self._targetLevel)[1].size),
			curSize = g.core.model.User:getFreeGold()
		})
	else
		local var_4_0 = self.m_chooseNumComp:getCurNum()

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(422510),
			desc = g.core.lang:get(422511, {
				price = self._commonPassCardData:getBuyLevelCost(self._targetLevel)[1].size,
				level = var_4_0
			}),
			onConfirm = handler(self, function()
				g.core.network.GameNetProxy:send_C2S_CommonPasscard_BuyLevel({
					id = self._actId,
					num = var_4_0
				})
				g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
			end)
		}))
	end
end

function CommonPassCardBuyLevelPop:_onAwardListRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateLevelAwardNew(self._allCanBuyRewards[arg_6_1 + 1])
end

function CommonPassCardBuyLevelPop:_chooseLevelChange(arg_7_1, arg_7_2)
	if arg_7_2 then
		if arg_7_2.isAdd and self._targetLevel >= self._maxAddLevel + self._commonPassCardData:getPassCardLv() then
			return
		end
	elseif arg_7_1 <= 1 and self._targetLevel <= self._commonPassCardData:getPassCardLv() + 1 then
		return
	end

	self._targetLevel = self._commonPassCardData:getPassCardLv() + arg_7_1

	self.m_targetLevelTxt:setText(var_0_2(2, self._targetLevel))

	self._allCanBuyRewards = self._commonPassCardData:getUpgradePassCardAward(self._targetLevel)

	self.m_levelAwardList:setNumItems(#self._allCanBuyRewards)
	self.m_resComp:updateByTVS({
		value = 0,
		type = var_0_0,
		size = self._commonPassCardData:getBuyLevelCost(self._targetLevel)[1].size
	})
end

return CommonPassCardBuyLevelPop
