local TeamBattleHealPop = class("TeamBattleHealPop", require("app.fairyGUI.teamBattle.UI_TeamBattleHealPop"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleHealPop",
		pkgName = "teamBattle",
		pkgPath = "ui/teamBattle/teamBattle"
	})
end)

function TeamBattleHealPop:ctor(arg_2_1)
	self._event = arg_2_1
	self._gridId = self._event:getEventInfo().grid
	self._knightList = {}

	self:_initRegisterUI()
	self:showAtCenter()
end

function TeamBattleHealPop:_initRegisterUI()
	self.m_cancelBtn:addClickListener(handler(self, self._onClickCancelBtn))
	self.m_healBtn:addClickListener(handler(self, self._onClickHealBtn))
	self.m_hurtList:setVirtual()
	self.m_hurtList:setItemRenderer(handler(self, self._onHurtKnightItemRender))
	self.m_enterTransition:play()
	self.m_eff:addEffectSpine({
		anim = "play_shop",
		remove = true,
		isLoop = false,
		name = "eff_ui_teamBattle_popBg"
	})
end

function TeamBattleHealPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_RECOVERHP, self._onS2CTeamBattleRecoverHp, self)

	self._knightList = {}

	for iter_4_0, iter_4_1 in ipairs((g.core.model.User.teamBattleData:getFormationData():getAllKnightList())) do
		local var_4_0 = iter_4_1:getHpRatio()

		if var_4_0 > 0 and var_4_0 < 1000 then
			self._knightList[#self._knightList + 1] = iter_4_1
		end
	end

	self.m_hurtList:setNumItems(#self._knightList)
end

function TeamBattleHealPop:_onS2CTeamBattleRecoverHp()
	g.core.module.ModuleManager:tip(g.core.lang:get(427108))
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function TeamBattleHealPop:_onClickCancelBtn()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function TeamBattleHealPop:_onClickHealBtn()
	g.core.network.GameNetProxy:send_C2S_TeamBattle_RecoverHp({
		grid_id = self._gridId
	})
end

function TeamBattleHealPop:_onHurtKnightItemRender(arg_8_1, arg_8_2)
	arg_8_2:updateKnightIcon(self._knightList[arg_8_1 + 1])
	arg_8_2:setTouchable(false)
end

return TeamBattleHealPop
