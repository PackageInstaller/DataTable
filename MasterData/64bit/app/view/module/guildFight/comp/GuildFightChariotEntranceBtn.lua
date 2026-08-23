local var_0_0 = g.core.model.User.GuildFightData
local GuildFightChariotEntranceBtn = class("GuildFightChariotEntranceBtn", require("app.fairyGUI.guildFight.UI_GuildFightChariotEntranceBtn"))

function GuildFightChariotEntranceBtn:ctor()
	self._chariotData = {}
	self._chariotId = nil
	self._scoreInfo = nil

	self:addClickListener(handler(self, self._onTouchClick))
end

function GuildFightChariotEntranceBtn:updateInfo(arg_2_1)
	if arg_2_1 then
		self._chariotData = arg_2_1 or {}

		if not next(self._chariotData) then
			return
		end

		self._chariotId = self._chariotData[1].chariotId
		self._scoreInfo = var_0_0:getScoreInfoById(self._chariotId)

		self:setTitle(self._scoreInfo.name)
		self.m_scoreText:setText(g.core.utils.Number.transFightValue((self:_getMaxPlayerFight())))
		self.m_stepNumText:setText("0" .. self._chariotId)
		self.m_isFnishController:setSelectedIndex(var_0_0:isChariotFinishByData(self._chariotData) and 1 or 0)
	end
end

function GuildFightChariotEntranceBtn:_onTouchClick()
	if g.core.model.User.GuildFightData:getMatchState() or not self._chariotId then
		g.core.module.ModuleManager:tip(g.core.lang:get(109816))

		return
	end

	local var_3_0

	if var_0_0:isChariotFinishByData(self._chariotData) then
		var_3_0 = g.core.lang:get(109807)
	elseif not var_0_0:canFight() then
		var_3_0 = g.core.lang:get(1073)
	end

	if var_3_0 then
		g.core.module.ModuleManager:tip(var_3_0)
	else
		g.core.module.ModuleManager:pushModule(g.view.entrance.GUILD_FIGHT_CHARIOT_BATTLE, {
			chariotId = self._chariotId
		})
	end
end

function GuildFightChariotEntranceBtn:_getMaxPlayerFight()
	local var_4_0 = 0

	for iter_4_0, iter_4_1 in ipairs(self._chariotData) do
		if var_4_0 < iter_4_1.fightValue then
			var_4_0 = iter_4_1.fightValue
		end
	end

	return var_4_0
end

return GuildFightChariotEntranceBtn
