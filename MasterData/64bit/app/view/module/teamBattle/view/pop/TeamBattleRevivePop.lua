local TeamBattleRevivePop = class("TeamBattleRevivePop", require("app.fairyGUI.teamBattle.UI_TeamBattleRevivePop"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleRevivePop",
		pkgPath = "ui/teamBattle/teamBattle",
		pkgName = "teamBattle"
	})
end)

function TeamBattleRevivePop:ctor(arg_2_1)
	self._event = arg_2_1
	self._gridId = self._event:getEventInfo().grid
	self._selectIdx = -1

	self:_initRegisterUI()
	self:showAtCenter()
end

function TeamBattleRevivePop:_initRegisterUI()
	self.m_cancelBtn:addClickListener(handler(self, self._onClickCancelBtn))
	self.m_reviveBtn:addClickListener(handler(self, self._onClickReviveBtn))
	self.m_reviveList:setVirtual()
	self.m_reviveList:setItemRenderer(handler(self, self._onReviveItemRender))
	self.m_reviveList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickIcon))
	self.m_enterTransition:play()
	self.m_eff:addEffectSpine({
		name = "eff_ui_teamBattle_popBg",
		anim = "play_shop",
		remove = true,
		isLoop = false
	})
end

function TeamBattleRevivePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_REBORN, self._onS2CTeamBattleReborn, self)

	self._knightList = {}

	for iter_4_0, iter_4_1 in ipairs((g.core.model.User.teamBattleData:getFormationData():getAllKnightList())) do
		if iter_4_1:getHpRatio() <= 0 then
			self._knightList[#self._knightList + 1] = iter_4_1
		end
	end

	self.m_reviveList:setNumItems(#self._knightList)
end

function TeamBattleRevivePop:_onClickCancelBtn()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function TeamBattleRevivePop:_onClickIcon()
	self._selectIdx = self.m_reviveList:getSelectedIndex()
end

function TeamBattleRevivePop:_onClickReviveBtn()
	local var_7_0

	if self._selectIdx < 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(427106))

		do return end

		var_7_0 = {
			grid_id = self._gridId
		}
	end

	var_7_0.knight_id = self._knightList[self._selectIdx + 1]:getServerId()

	g.core.network.GameNetProxy:send_C2S_TeamBattle_Reborn(var_7_0)
end

function TeamBattleRevivePop:_onReviveItemRender(arg_8_1, arg_8_2)
	arg_8_2:updateKnightIcon(self._knightList[arg_8_1 + 1])
end

function TeamBattleRevivePop:_onS2CTeamBattleReborn()
	g.core.module.ModuleManager:tip(g.core.lang:get(427107))
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return TeamBattleRevivePop
