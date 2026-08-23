local var_0_1 = g.core.model.User.commonPassCardDataMgr
local CommonPassCardRechargePop = class("CommonPassCardRechargePop", require("app.fairyGUI.commonPassCard.UI_CommonPassCardRechargePop"), function()
	return fgui.GComponent:create({
		resName = "CommonPassCardRechargePop",
		pkgName = "commonPassCard",
		pkgPath = "ui/commonPassCard/commonPassCard"
	}, ...)
end)

function CommonPassCardRechargePop:ctor(arg_2_1)
	self:getView():setSize(display.width, display.height)
	self:showAtCenter()

	self._actId = arg_2_1.activityId

	self:_initView()
	self.m_closeTouchPanel:addClickListener(handler(self, self._onCloseClick))
end

function CommonPassCardRechargePop:_initView()
	self.m_rechargeItem1:onInitData(1, self._actId)
	self.m_rechargeItem2:onInitData(2, self._actId)

	self._commonPassCardData = var_0_1:getPassCardData(self._actId)

	self.m_picIcon:updateKnight({
		resId = self._commonPassCardData:getActivityCfg().show
	})
end

function CommonPassCardRechargePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._onRecOpRecharge), self)

	if self.m_enterTransition then
		self.m_enterTransition:play()
	end
end

function CommonPassCardRechargePop:_onRecOpRecharge(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self.m_rechargeItem1:updateView()
	self.m_rechargeItem2:updateView()

	if arg_5_4 and arg_5_4.common_passcard then
		local var_5_0 = arg_5_4.common_passcard.awards

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseLineTipsPop").new({
			englishTitle = "",
			delay = 1,
			title = g.core.lang:get(405006),
			callBack = function()
				g.core.module.ModuleManager:awardSummary(var_5_0)
			end
		}), {
			blackOpacity = 0.7
		})
	end
end

function CommonPassCardRechargePop:_onCloseClick()
	g.core.module.ModuleManager:popComponent()
end

return CommonPassCardRechargePop
