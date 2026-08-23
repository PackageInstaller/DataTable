local var_0_0 = {
	SCREEN = "#47dfa7",
	YELLOW = "#e18c38",
	RED = "#f44e4e"
}
local var_0_1 = g.core.model.User.guildWarData
local GWFightProgressComp = class("GWFightProgressComp", require("app.fairyGUI.guildWar.UI_GWFightProgressComp"))

function GWFightProgressComp:ctor()
	self._guildScoreLblArr = {
		self.m_guildScoreLbl_1,
		self.m_guildScoreLbl_2,
		self.m_guildScoreLbl_3
	}

	self.m_actionInfoBtn:addClickListener(handler(self, self._onClickActionInfoBtn))
	self.m_actionCommandBtn:addClickListener(handler(self, self._onClickActionCommandBtn))
end

function GWFightProgressComp:updateComp()
	local var_2_0 = var_0_1:getAllGuildStructArr()

	table.sort(var_2_0, var_0_1:getGuildStructSortFunc())

	for iter_2_0, iter_2_1 in ipairs(self._guildScoreLblArr) do
		iter_2_1:updateComp(var_2_0[iter_2_0])
	end

	local var_2_1 = var_0_1:getMyGuildStruct()

	if var_2_1 then
		local var_2_2 = var_0_1:getGuildScorePercentage(var_2_1.guildId)

		self.m_myGuildScoreLbl:updateLabel((g.core.lang:get(308632, {
			num1 = var_2_1:getTodayTotalScore(),
			num2 = var_2_2,
			c3b = self:_getPercentTxtC3bStr(var_2_2)
		})))
		self.m_myGuildDefendScoreLbl:updateLabel(var_2_1.todayDefendScore)
		self.m_myGuildRobScoreLbl:updateLabel(var_2_1.todayRobScore)
		self.m_guildIconLoader:setURL(g.core.common.Path:getGuildMidIconById(var_2_1.guildSnapshot.icon or 5))
	else
		local var_2_3 = {
			num1 = 0,
			num2 = 0
		}

		var_2_3.c3b = self:_getPercentTxtC3bStr(0)

		self.m_myGuildScoreLbl:updateLabel((g.core.lang:get(308632, var_2_3)))
		self.m_myGuildDefendScoreLbl:updateLabel(0)
		self.m_myGuildRobScoreLbl:updateLabel(0)
	end
end

function GWFightProgressComp:_onClickActionInfoBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.guildWar.view.pop.GuildWarActionInfoPop").new(), {
		touchDisappear = false
	})
end

function GWFightProgressComp:_onClickActionCommandBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.guildWar.view.pop.GuildWarActionCommandPop").new(), {
		touchDisappear = false
	})
end

function GWFightProgressComp:_getPercentTxtC3bStr(arg_5_1)
	if arg_5_1 >= 100 then
		return var_0_0.SCREEN
	elseif arg_5_1 >= 50 then
		return var_0_0.YELLOW
	else
		return var_0_0.RED
	end
end

return GWFightProgressComp
