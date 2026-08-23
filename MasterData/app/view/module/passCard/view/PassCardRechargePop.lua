local var_0_0 = g.core.model.User
local var_0_1 = g.core.common.Path
local PassCardRechargePop = class("PassCardRechargePop", require("app.fairyGUI.passCard.UI_PassCardRechargePop"), function()
	return fgui.GComponent:create({
		resName = "PassCardRechargePop",
		pkgPath = "ui/passCard/passCard",
		pkgName = "passCard"
	}, ...)
end)

function PassCardRechargePop:ctor()
	self:getView():setSize(display.width, display.height)
	self:showAtCenter()
	self:_initView()
	self.m_closeTouchPanel:addClickListener(handler(self, self._onCloseClick))
end

function PassCardRechargePop:_initView()
	self.m_rechargeItem1:onInitData(1)
	self.m_rechargeItem2:onInitData(2)

	local var_3_0 = var_0_0.passCardData:getCardBaseInfo()

	if var_3_0.baseInfo.bg_small_pic ~= "" then
		self.m_picIcon:setURL((var_0_1:getPassCardBgPic(var_3_0.baseInfo.bg_small_pic)))
	end

	local var_3_1 = var_0_0.passCardData:getChargeSingleAwardDataByRewardType(13).level

	var_3_1 = var_3_1 or 10

	self.m_skinUnlockTxt:setText(g.core.lang:get(405009, {
		level = var_3_1
	}))
end

function PassCardRechargePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._onRecOpRecharge), self)

	if self.m_enterTransition then
		self.m_enterTransition:play()
	end
end

function PassCardRechargePop:_onRecOpRecharge(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self.m_rechargeItem1:updateView()
	self.m_rechargeItem2:updateView()

	if arg_5_4 and arg_5_4.passcard then
		local var_5_0 = arg_5_4.passcard.awards

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseLineTipsPop").new({
			delay = 1,
			englishTitle = "",
			title = g.core.lang:get(405006),
			callBack = function()
				g.core.module.ModuleManager:awardSummary(var_5_0)
			end
		}), {
			blackOpacity = 0.7
		})
	end
end

function PassCardRechargePop:_onCloseClick()
	g.core.module.ModuleManager:popComponent()
end

return PassCardRechargePop
