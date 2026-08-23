local ArenaChallengesNumComp = class("ArenaChallengesNumComp", require("app.fairyGUI.arena.UI_ArenaChallengesNumComp"))
local var_0_1 = g.core.const.ConstMgr.ArenaConst
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.const.ConstMgr.ShopConst

function ArenaChallengesNumComp:ctor()
	self.m_maxNumTxt:setText(g.core.lang:get(302514, {
		num = var_0_1.MAX_NUM_CHALLENGES_STORE
	}))
	self:addClickListener(handler(self, self._onClickBuy))
end

function ArenaChallengesNumComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM, self._updateComp, self)
	self:_updateComp()
end

function ArenaChallengesNumComp:_updateComp()
	local var_3_0 = g.core.model.User.shopData:getLeftCount(1) or 0

	self.m_remainNumTxt:setText(var_3_0)
	self.m_challengEnableController:setSelectedIndex((var_3_0 > 0 or nil) and (var_0_1.CTRL_CHALLENGE_ENABLE_Y or var_0_1.CTRL_CHALLENGE_ENABLE_N))
end

function ArenaChallengesNumComp:_onClickBuy()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseUseBuyPop").new({
		type = var_0_2.TYPE_ITEM,
		value = var_0_2.ITEM.TYPE_ARENA_TOKEN,
		shopId = var_0_3.SHOP_ITEM_ID.ARENA_TOKEN
	}), {
		touchDisappear = true
	})
end

return ArenaChallengesNumComp
