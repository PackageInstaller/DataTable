local var_0_0 = g.core.model.User.allianceData
local var_0_1 = g.core.common.Path
local AllianceJoinListCell = class("AllianceJoinListCell", require("app.fairyGUI.alliance.UI_AllianceJoinListCell"))

function AllianceJoinListCell:ctor()
	self:initView()
end

function AllianceJoinListCell:initView()
	self:addClickListener(handler(self, self._onJoinBtnClick))
end

function AllianceJoinListCell:_onJoinBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.alliance.view.pop.AllianceInfoPop").new({
		allianceId = self._allianceId
	}), {
		touchDisappear = true
	})
end

function AllianceJoinListCell:updateAllianceCell(arg_4_1)
	self._allianceId = arg_4_1.id

	self.m_name:setText(arg_4_1.name)
	self.m_level:setText(g.core.lang:get(205526, {
		num = arg_4_1.level
	}))

	local var_4_0 = #arg_4_1.guild_ids
	local var_4_1 = var_0_0:getAllianceGuildMaxNumByLv(arg_4_1.level)

	self.m_isFullNumController:setSelectedIndex(var_4_1 <= #arg_4_1.guild_ids and 1 or 0)
	self.m_guildNumText:setText(g.core.lang:get(107056, {
		num = var_4_0,
		maxNum = var_4_1
	}))
	self.m_fightValueText:setText(arg_4_1.fight_value)

	local var_4_2 = var_0_0:getGuildSuggestNum(self._allianceId)

	if var_4_2 > 0 then
		self.m_suggestText:setText(g.core.lang:get(428502, {
			num = var_4_2
		}))
		self.m_hasSuggestController:setSelectedIndex(1)
	else
		self.m_hasSuggestController:setSelectedIndex(0)
	end

	local var_4_3 = g.core.model.User.guildData:getGuildLevel()

	self.m_joinCondText:enableRich()
	self.m_joinCondText:setText(g.core.lang:get(428501, {
		color = var_4_3 >= arg_4_1.apply_level and "#808080" or "#e52e2e",
		level = arg_4_1.apply_level
	}), true, true)
	self.m_flag:setURL(var_0_1:getAllianceFlag128(var_0_0:getFlagRes(arg_4_1.flag)))
	self.m_isApplyController:setSelectedIndex(var_0_0:myIsApply(arg_4_1.id) and 1 or 0)
end

return AllianceJoinListCell
