local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local var_0_1 = g.core.config.massive_monster_team_info
local var_0_2 = g.core.config.team_battle_monster_info
local TeamBattleLimitBossPop = class("TeamBattleLimitBossPop", require("app.fairyGUI.teamBattle.UI_TeamBattleLimitBossPop"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleLimitBossPop",
		pkgPath = "ui/teamBattle/teamBattle",
		pkgName = "teamBattle"
	})
end)

function TeamBattleLimitBossPop:ctor(arg_2_1, arg_2_2)
	self._event = arg_2_1

	local var_2_0 = arg_2_1:getEventInfo()

	self._eventInfo = var_2_0
	self._monsterId = var_2_0.monsterInfo.monsterId

	self:showAtCenter()
	self:_initRegisterUI()

	if arg_2_2 then
		self.m_battleBtn:setVisible(false)
	end

	self.m_enterTransition:play()
	self.m_eff:addEffectSpine({
		remove = true,
		name = "eff_ui_teamBattle_popBg",
		anim = "play_xiangqing",
		isLoop = false
	})
end

function TeamBattleLimitBossPop:onLoad()
	self:_updateLimitMainView()
	self:newSchedule(handler(self, self.updateTimer), 1)
end

function TeamBattleLimitBossPop:_initRegisterUI()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
	self.m_battleBtn:addClickListener(handler(self, self._onBattleBtnClick))
end

function TeamBattleLimitBossPop:_onAwardItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateIcon(self._awards[arg_5_1 + 1])
end

function TeamBattleLimitBossPop:_updateLimitMainView()
	local var_6_0 = var_0_2.get(self._monsterId)
	local var_6_1 = var_0_1.get(var_6_0.monster_1).knight_id_1

	self.m_knightPicComp:updateKnight({
		baseId = self._eventInfo.monsterInfo.spineId
	})
	self.m_knightPicComp:setAlphaLRDistance(250)

	self._awards = g.core.common.Drops:getGoodsArray(var_6_0.reward)

	self.m_awardList:setNumItems(#self._awards)

	local var_6_2 = self._event:getAllBindBossEvent()

	for iter_6_0, iter_6_1 in ipairs(var_6_2) do
		if iter_6_1:checkAllMemberIsDead() then
			-- block empty
		end
	end

	self.m_diffComp1:updateBossInfo(self._event)

	for iter_6_2, iter_6_3 in ipairs(var_6_2) do
		self["m_diffComp" .. iter_6_2 + 1]:updateBossInfo(iter_6_3)
	end

	self.m_timeComp:setTitle(g.core.common.ServerTime:getLeftSecondsString((self._event:getEndTime())))

	if self._event:getState() == TeamBattleConst.EVENT_STATE.FINISH then
		self.m_isFinishController:setSelectedIndex(1)
	else
		self.m_isFinishController:setSelectedIndex(0)
	end
end

function TeamBattleLimitBossPop:_onBattleBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.TEAM_BATTLE_FORMATION_LAYER, {
		isBoss = true,
		grid = self._event:getEventInfo().grid
	})
end

function TeamBattleLimitBossPop:onUnload()
	self.m_backTransition:play(handler(self, self.onReset))
end

function TeamBattleLimitBossPop:onReset()
	self.m_resetTransition:play()
end

function TeamBattleLimitBossPop:updateTimer()
	self.m_timeComp:setTitle(g.core.common.ServerTime:getLeftSecondsString((self._event:getEndTime())))
end

return TeamBattleLimitBossPop
