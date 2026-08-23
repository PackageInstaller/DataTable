local var_0_0 = g.core.model.User.guildWarData
local GuildWarActionCommandPop = class("GuildWarActionCommandPop", require("app.fairyGUI.guildWar.UI_GuildWarActionCommandPop"), function()
	return fgui.GComponent:create({
		resName = "GuildWarActionCommandPop",
		pkgPath = "ui/guildWar/guildWar",
		pkgName = "guildWar"
	}, ...)
end)

function GuildWarActionCommandPop:ctor()
	local var_2_0 = var_0_0:getGuildMemberGroup()

	self._challengeArr = var_2_0.group1
	self._robArr = var_2_0.group2

	self.m_challengeList:setVirtual()
	self.m_challengeList:setItemRendererAsync1(handler(self, self._onChallengeListRenderer))
	self.m_robList:setVirtual()
	self.m_robList:setItemRendererAsync1(handler(self, self._onRobListRenderer))
	self:showAtCenter()
end

function GuildWarActionCommandPop:onLoad()
	local var_3_0 = #self._challengeArr

	self.m_challengeEmptyController:setSelectedIndex(#self._challengeArr == 0 and 1 or 0)
	self.m_challengeList:setNumItems(var_3_0)

	local var_3_1 = #self._robArr

	self.m_robEmptyController:setSelectedIndex(#self._robArr == 0 and 1 or 0)
	self.m_robList:setNumItems(var_3_1)
end

function GuildWarActionCommandPop:_onChallengeListRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._challengeArr[arg_4_1 + 1])
end

function GuildWarActionCommandPop:_onRobListRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateCell(self._robArr[arg_5_1 + 1])
end

function GuildWarActionCommandPop:_onClickChallengeItem(arg_6_1)
	local var_6_0 = self._challengeArr[arg_6_1:getDataValue() + 1]
end

function GuildWarActionCommandPop:_onClickRobItem(arg_7_1)
	local var_7_0 = self._robArr[arg_7_1:getDataValue() + 1]
end

return GuildWarActionCommandPop
