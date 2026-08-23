local var_0_0 = g.core.config.team_battle_debuff_info
local TeamBattleTrapPop = class("TeamBattleTrapPop", require("app.fairyGUI.teamBattle.UI_TeamBattleTrapPop"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleTrapPop",
		pkgPath = "ui/teamBattle/teamBattle",
		pkgName = "teamBattle"
	})
end)

function TeamBattleTrapPop:ctor(arg_2_1)
	self._isAutoClose = arg_2_1.auto
	self._id = arg_2_1.buffId

	self:showAtCenter()
	self:setWidth(display.width)

	self._debuffInfo = var_0_0.get(self._id)

	self.m_descTxt:setText(self._debuffInfo.des)
end

function TeamBattleTrapPop:onLoad()
	if self._isAutoClose then
		self.m_enterTransition:play(handler(self, self._onEnterEnd))
	else
		self.m_enterTransition:play()
	end
end

function TeamBattleTrapPop:_onEnterEnd()
	self.m_backTransition:play(handler(self, self._onBackEnd))
end

function TeamBattleTrapPop:_onBackEnd()
	if self._isAutoClose then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

		if self._callback then
			self._callback()
		end
	end
end

return TeamBattleTrapPop
