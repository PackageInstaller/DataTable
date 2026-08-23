local var_0_0 = g.core.model.User.blazingArenaData
local var_0_1 = g.core.const.ConstMgr
local BlazingArenaSweepBtn = class("BlazingArenaSweepBtn", require("app.fairyGUI.blazingArena.UI_BlazingArenaSweepBtn"))

function BlazingArenaSweepBtn:ctor()
	local var_1_0 = self:getSize()

	self.m_effectSpine:addEffectSpine({
		name = "eff_ui_blazingArena_sweepbtnbg",
		anim = "play",
		isLoop = true,
		x = var_1_0.width / 2,
		y = var_1_0.height / 2
	})
	self:addClickListener(handler(self, self._onSelfClick))
end

function BlazingArenaSweepBtn:_onSelfClick()
	if var_0_0:getAttackTimes() > 0 then
		g.core.network.GameNetProxy:send_C2S_BlazingArena_Sweep({})
	else
		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseUseBuyPop").new({
			type = g.core.common.Goods.TYPE_ITEM,
			value = g.core.common.Goods.ITEM.TYPE_BLAZING_ARENA_TOKEN,
			shopId = var_0_1.ShopConst.SHOP_ITEM_ID.BLAZING_ARENA_TOKEN
		}), {
			touchDisappear = true
		})
	end
end

return BlazingArenaSweepBtn
