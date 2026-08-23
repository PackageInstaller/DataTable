local ThemeThirdBossTalentResetPop = class("ThemeThirdBossTalentResetPop", require("app.fairyGUI.summerThemeThirdBoss.UI_ThemeThirdBossTalentResetPop"), function()
	return fgui.GComponent:create({
		pkgName = "summerThemeThirdBoss",
		resName = "ThemeThirdBossTalentResetPop",
		pkgPath = "ui/summerThemeThirdBoss/summerThemeThirdBoss"
	})
end)

function ThemeThirdBossTalentResetPop:ctor(arg_2_1)
	self:showAtCenter()

	self._bossData = arg_2_1.bossData
	self._resetTalentDict = arg_2_1.talentDict

	self.m_isAllController:setSelectedIndex(arg_2_1.isAll and 1 or 0)
	self:initView()
end

function ThemeThirdBossTalentResetPop:initView()
	self.m_cancelBtn:addClickListener(handler(self, self._onClickCancelBtn))
	self.m_confirmBtn:addClickListener(handler(self, self._onClickConfirmBtn))

	local var_3_0 = 0

	for iter_3_0, iter_3_1 in pairs(self._resetTalentDict) do
		var_3_0 = var_3_0 + iter_3_1:getInfo().activate_size
	end

	self.m_resTip:setText(g.core.lang:get(405955, {
		num = var_3_0
	}))
end

function ThemeThirdBossTalentResetPop:_onClickCancelBtn()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function ThemeThirdBossTalentResetPop:_onClickConfirmBtn()
	g.core.network.GameNetProxy:send_C2S_NewDemonBoss_ResetTalent({
		act_id = self._bossData:getThemeVal(),
		talent_ids = table.keys(self._resetTalentDict)
	})
end

function ThemeThirdBossTalentResetPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_DEMON_BOSS_RESETTALENT, handler(self, self._onResetTalent), self)
end

function ThemeThirdBossTalentResetPop:_onResetTalent()
	g.core.module.ModuleManager:tip(g.core.lang:get(405956))
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return ThemeThirdBossTalentResetPop
