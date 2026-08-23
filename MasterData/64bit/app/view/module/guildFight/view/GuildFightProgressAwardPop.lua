local var_0_0 = g.core.model.User.GuildFightData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum
local GuildFightProgressAwardPop = class("GuildFightProgressAwardPop", require("app.fairyGUI.guildFight.UI_GuildFightProgressAwardPop"), function()
	return fgui.GComponent:create({
		resName = "GuildFightProgressAwardPop",
		pkgPath = "ui/guildFight/guildFight",
		pkgName = "guildFight"
	}, ...)
end)

function GuildFightProgressAwardPop:ctor(arg_2_1)
	self:showAtCenter()

	self.rewardData = {}

	self:addListen(self.m_rewardList)
	self.m_rewardList:setVirtual()
	self.m_rewardList:doFairyBatching(false)
	self.m_rewardList:setItemRendererAsync1(handler(self, self._onListRenderer), 0.02, false)
end

function GuildFightProgressAwardPop:onLoad()
	self:_updateView()
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_GUILD_BATTLE_AWARD, self._onGetAward, self)
end

function GuildFightProgressAwardPop:_updateView()
	local var_4_0 = var_0_0:getBoxNum()

	self:_updateRewardData(var_4_0)
	self.m_scoreTxt:setText((var_0_0:getGuildScore()))
	self.m_rewardList:setNumItems(var_4_0)
end

function GuildFightProgressAwardPop:_updateRewardData(arg_5_1)
	self.rewardData = {}

	local var_5_0 = var_0_0:getAwardInfo()
	local var_5_1 = var_0_0:getGuildScore()

	for iter_5_0 = 1, arg_5_1 do
		local var_5_2 = {}
		local var_5_3, var_5_4 = var_0_0:getBoxState(iter_5_0)

		var_5_2.state = var_5_3
		var_5_2.realState = var_5_4
		var_5_2.info = var_0_0:getAwards(iter_5_0)
		var_5_2.index = iter_5_0
		var_5_2.target_score = var_5_0[iter_5_0].target_score
		var_5_2.curScore = var_5_1

		table.insert(self.rewardData, var_5_2)
	end
end

function GuildFightProgressAwardPop:_onListRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateItem(self.rewardData[arg_6_1 + 1])
end

function GuildFightProgressAwardPop:_onGetAward(arg_7_1, arg_7_2, arg_7_3)
	if arg_7_3 then
		g.core.module.ModuleManager:awardSummary(arg_7_3.awards or {}, true, nil, nil, handler(self, self._updateViewAfterAward))
	end
end

function GuildFightProgressAwardPop:_updateViewAfterAward()
	self:_updateView()
	self:dispatchCompEvent("get_box_award")
end

return GuildFightProgressAwardPop
