local var_0_0 = g.core.model.User.GuildFightData
local GuildFightProgressAwardCell = class("GuildFightProgressAwardCell", require("app.fairyGUI.guildFight.UI_GuildFightProgressAwardCell"))

function GuildFightProgressAwardCell:ctor()
	self._rewardListData = {}

	self.m_rewardList:setVirtual()
	self.m_rewardList:doFairyBatching(false)
	self.m_rewardList:setItemRenderer(handler(self, self._onAwardListRenderer))
	self.m_getBtn:addClickListener(handler(self, self._onClickAwardButton))
end

function GuildFightProgressAwardCell:updateItem(arg_2_1)
	local var_2_0, var_2_1

	if arg_2_1 then
		var_2_0 = arg_2_1.info or {}

		if arg_2_1 then
			var_2_1 = arg_2_1.state or 0
		end
	end

	local var_2_2 = arg_2_1 and arg_2_1.realState
	local var_2_3

	if arg_2_1 then
		var_2_3 = arg_2_1.index or 1
	end

	local var_2_4 = arg_2_1.target_score

	self._index = var_2_3

	self.m_scoreTxt:setText(var_2_4)
	self.m_rewardTitle:setText((g.core.lang:get(109812, {
		num = g.core.utils.Number.toChineseNumber(self._index)
	})))

	if var_2_2 then
		var_2_1 = var_2_2
	end

	self.m_scoreNum:setText((var_2_1 == 0 or nil) and "[color=#e52e2e]" .. arg_2_1.curScore .. "[/color]" .. "/" .. var_2_4)
	self.m_rewardStateController:setSelectedIndex(var_2_1)

	self._rewardListData = var_2_0

	self.m_rewardList:setNumItems(#self._rewardListData)
end

function GuildFightProgressAwardCell:_onAwardListRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._rewardListData[arg_3_1 + 1])
end

function GuildFightProgressAwardCell:_onClickAwardButton()
	local var_4_0 = var_0_0:getGuildIds()

	if not var_4_0[self._index] then
		return
	end

	g.core.network.GameNetProxy:send_C2S_GuildBattle_Award({
		id = var_4_0[self._index]
	})
end

return GuildFightProgressAwardCell
