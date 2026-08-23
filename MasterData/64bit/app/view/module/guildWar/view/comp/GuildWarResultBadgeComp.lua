local var_0_0 = g.core.model.User.guildWarData
local GuildWarResultBadgeComp = class("GuildWarResultBadgeComp", require("app.fairyGUI.guildWar.UI_GuildWarResultBadgeComp"))

function GuildWarResultBadgeComp:onLoad()
	self.m_enterTransition:play()
end

function GuildWarResultBadgeComp:updateBadgeFightView()
	local var_2_0 = 0

	for iter_2_0, iter_2_1 in pairs((var_0_0:getFightResultBadgeList())) do
		if iter_2_1.value and iter_2_1.value > 0 then
			var_2_0 = var_2_0 + 1

			if self["m_badgeComp" .. var_2_0] then
				self["m_badgeComp" .. var_2_0]:updateCompByFight(iter_2_1, iter_2_0)
			end
		end
	end

	self.m_showBadgeCountController:setSelectedIndex(var_2_0)
end

function GuildWarResultBadgeComp:updateBadgeSeasonView()
	local var_3_0 = 0

	for iter_3_0, iter_3_1 in pairs((var_0_0:getSeasonResultBadgeList())) do
		if iter_3_1.value and iter_3_1.value > 0 and iter_3_1.guild then
			var_3_0 = var_3_0 + 1

			if self["m_badgeComp" .. var_3_0] then
				self["m_badgeComp" .. var_3_0]:updateCompBySeason(iter_3_1, iter_3_0)
			end
		end
	end

	self.m_showBadgeCountController:setSelectedIndex(var_3_0)
end

return GuildWarResultBadgeComp
