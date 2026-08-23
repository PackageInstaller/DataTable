local var_0_0 = g.core.common.Goods.TYPE_GOLD
local var_0_1 = g.core.model.User.gmPassCardData
local var_0_2 = g.core.utils.Number.getFormatNum
local PassCardNewBuyLevelPop = class("PassCardNewBuyLevelPop", require("app.fairyGUI.newPassCard.UI_PassCardNewBuyLevelPop"), function()
	return fgui.GComponent:create({
		pkgName = "newPassCard",
		isFullScreen = false,
		pkgPath = "ui/newPassCard/newPassCard",
		resName = "PassCardNewBuyLevelPop"
	}, ...)
end)

function PassCardNewBuyLevelPop:ctor()
	self:showAtCenter()

	self._targetLevel = 1

	self.m_buyBtn:addClickListener(handler(self, self._onBuyClick))
	self.m_levelAwardList:setVirtual()
	self.m_levelAwardList:setItemRenderer(handler(self, self._onAwardListRenderer))
end

function PassCardNewBuyLevelPop:onLoad()
	self.m_curLevelTxt:setText(var_0_2(2, var_0_1:getPassCardLv()))

	self._targetLevel = var_0_1:getPassCardLv() + 1
	self._allCanBuyRewards = var_0_1:getUpgradePassCardAward(self._targetLevel)

	self.m_targetLevelTxt:setText(g.core.utils.Number.getFormatNum(2, self._targetLevel))

	local var_3_0 = var_0_1:getMaxPassCardLv() - var_0_1:getPassCardLv()

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
		size = tonumber(var_0_1:getBuyLevelCost(self._targetLevel)[1].size)
	})
	self.m_levelAwardList:setNumItems(#self._allCanBuyRewards)
	self:_scrollList()
end

function PassCardNewBuyLevelPop:_onBuyClick()
	if self.m_resComp:isLack() then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			value = 0,
			type = var_0_0,
			needSize = tonumber(var_0_1:getBuyLevelCost(self._targetLevel)[1].size),
			curSize = g.core.model.User:getFreeGold()
		})
	else
		local var_4_0 = self.m_chooseNumComp:getCurNum()

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(422510),
			desc = g.core.lang:get(422511, {
				price = var_0_1:getBuyLevelCost(self._targetLevel)[1].size,
				level = var_4_0
			}),
			onConfirm = handler(self, function()
				g.core.network.GameNetProxy:send_C2S_PasscardActivity_BuyLevel({
					num = var_4_0
				})
				g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
			end)
		}))
	end
end

function PassCardNewBuyLevelPop:_onAwardListRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateLevelAwardNew(self._allCanBuyRewards[arg_6_1 + 1])
end

function PassCardNewBuyLevelPop:_chooseLevelChange(arg_7_1, arg_7_2)
	if arg_7_2 then
		if arg_7_2.isAdd and self._targetLevel >= self._maxAddLevel + var_0_1:getPassCardLv() then
			return
		end
	elseif arg_7_1 <= 1 and self._targetLevel <= var_0_1:getPassCardLv() + 1 then
		return
	end

	self._targetLevel = var_0_1:getPassCardLv() + arg_7_1

	self.m_targetLevelTxt:setText(var_0_2(2, self._targetLevel))

	self._allCanBuyRewards = var_0_1:getUpgradePassCardAward(self._targetLevel)

	self.m_levelAwardList:setNumItems(#self._allCanBuyRewards)
	self.m_resComp:updateByTVS({
		value = 0,
		type = var_0_0,
		size = var_0_1:getBuyLevelCost(self._targetLevel)[1].size
	})
	self:_scrollList()
end

function PassCardNewBuyLevelPop:_scrollList()
	return
end

return PassCardNewBuyLevelPop
