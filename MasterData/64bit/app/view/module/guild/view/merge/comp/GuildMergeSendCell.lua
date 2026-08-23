local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.model.User.guildData
local GuildMergeSendCell = class("GuildMergeSendCell", require("app.fairyGUI.guild.UI_GuildMergeSendCell"))

function GuildMergeSendCell:ctor()
	self._userMember = nil

	self.m_selectBtn:addClickListener(handler(self, self._onSelectBtnClick))
end

function GuildMergeSendCell:updateSendCell(arg_2_1, arg_2_2, arg_2_3)
	self.m_showViewController:setSelectedIndex(0)
	self.m_showBgController:setSelectedIndex(arg_2_2 % 2)
	self:_updateGuildView(arg_2_1)
	self.m_selectBtn:setSelected(arg_2_3[arg_2_1.user.id] == true)
end

function GuildMergeSendCell:_onSelectBtnClick()
	if self._userMember then
		self:dispatchCompEvent("merge_send_select_user", {
			uid = self._userMember.user.id,
			isSelect = self.m_selectBtn:isSelected()
		})
	end
end

function GuildMergeSendCell:updateSendLookCell(arg_4_1, arg_4_2, arg_4_3)
	self.m_showViewController:setSelectedIndex(1)
	self.m_showBgController:setSelectedIndex(arg_4_2 % 2)
	self:_updateGuildView(arg_4_1)
end

function GuildMergeSendCell:_updateGuildView(arg_5_1)
	self._userMember = arg_5_1

	self.m_userComp:updateAsUser(arg_5_1.user)
	self.m_userName:setText(arg_5_1.user.name)
	self.m_level:setText(g.core.lang:get(2052, {
		level = arg_5_1.user.level
	}))
	self.m_job:setText(var_0_1:getRightInfoById(arg_5_1.position).name)
	self.m_fightValue:setText(arg_5_1.user.fight_value)
	self.m_totalNum:setText(arg_5_1.total_contribute)
	self.m_dayNum:setText(g.core.lang:get(109552, {
		num = arg_5_1.daily_contribute
	}))

	local var_5_0 = arg_5_1.user.offline_time or 0
	local var_5_1 = var_0_0:getTime() - var_5_0

	if var_5_0 > 0 then
		local var_5_2 = ""

		if var_5_1 / 3600 <= 1 then
			local var_5_3 = math.floor(var_5_1 / 60)

			if var_5_3 <= 0 then
				var_5_3 = 1
			end

			var_5_2 = g.core.lang:get(109598, {
				num = var_5_3
			})
		else
			var_5_2 = var_5_1 / 86400 <= 1 and g.core.lang:get(109599, {
				num = math.floor(var_5_1 / 3600)
			}) or g.core.lang:get(109600, {
				num = math.floor(var_5_1 / 86400)
			})
		end

		self.m_onlineState:setText(var_5_2)
		self.m_isOnlineController:setSelectedIndex(0)
	else
		self.m_onlineState:setText(g.core.lang:get(109543))
		self.m_isOnlineController:setSelectedIndex(1)
	end
end

return GuildMergeSendCell
