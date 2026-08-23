local ValentinesDayVoteGiftPop = class("ValentinesDayVoteGiftPop", require("app.fairyGUI.valentinesDayVote.UI_ValentinesDayVoteGiftPop"), function()
	return fgui.GComponent:create({
		resName = "ValentinesDayVoteGiftPop",
		pkgPath = "ui/valentinesDayVote/valentinesDayVote",
		pkgName = "valentinesDayVote"
	}, ...)
end)
local var_0_1 = g.core.model.User.valentinesDayVoteData

function ValentinesDayVoteGiftPop:ctor()
	self:showAtCenter()
	self.m_giftList:setVirtual(self)
	self.m_giftList:setItemRenderer(handler(self, self._onGiftListItemRender))
	self.m_closeBtn:addClickListener(handler(self, self._onCloseClick))
	self.m_enterTransition:play()
	self:_updateView()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_OPEN_VOTE_GIFT_POP)
end

function ValentinesDayVoteGiftPop:_onGetGift(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_4.gift then
		g.core.module.ModuleManager:awardSummary(arg_3_4.gift.awards or {}, nil, nil, g.core.lang:get(103004))
	end

	self:_updateView()
end

function ValentinesDayVoteGiftPop:_updateView()
	self._giftList = var_0_1:getGiftArr()

	table.sort(self._giftList, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_0.times - arg_5_0.buyTimes

		if arg_5_0.times == 0 then
			var_5_0 = 999
		end

		local var_5_1 = arg_5_1.times - arg_5_1.buyTimes

		if arg_5_1.times == 0 then
			var_5_1 = 999
		end

		if var_5_0 == var_5_1 == 0 then
			return arg_5_0.sort < arg_5_1.sort
		elseif var_5_0 == 0 or var_5_1 == 0 then
			if var_5_0 == 0 then
				return false
			else
				return true
			end
		else
			return arg_5_0.sort < arg_5_1.sort
		end
	end)
	self.m_giftList:setNumItems(#self._giftList)
	self.m_giftList:transitionShowCells("enter_left", 0.03)
end

function ValentinesDayVoteGiftPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._onGetGift), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._updateView), self)
end

function ValentinesDayVoteGiftPop:_onGiftListItemRender(arg_7_1, arg_7_2)
	arg_7_2:updateView(self._giftList[arg_7_1 + 1])
end

function ValentinesDayVoteGiftPop:_onCloseClick()
	self.m_backTransition:play()
end

return ValentinesDayVoteGiftPop
