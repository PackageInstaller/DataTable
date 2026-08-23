local var_0_0 = g.core.model.User.guildData
local GuildMergeUserApplyCell = class("GuildMergeUserApplyCell", require("app.fairyGUI.guild.UI_GuildMergeUserApplyCell"))

function GuildMergeUserApplyCell:ctor()
	self._userMember = nil

	self:initView()
end

function GuildMergeUserApplyCell:initView()
	self.m_selectBtn:addClickListener(handler(self, self._onClickSelect))
end

function GuildMergeUserApplyCell:_onClickSelect()
	if self._userMember then
		self:dispatchCompEvent("merge_change_select_user", {
			uid = self._userMember.user.id,
			isSelect = self.m_selectBtn:isSelected()
		})
	end
end

function GuildMergeUserApplyCell:updateApplyUser(arg_4_1, arg_4_2)
	self.m_showBgController:setSelectedIndex(arg_4_2 % 2)
	self.m_showViewController:setSelectedIndex(0)
	self:_updateUserMember(arg_4_1)
end

function GuildMergeUserApplyCell:updateMyGuildUser(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self.m_showBgController:setSelectedIndex(arg_5_2 % 2)

	if arg_5_3 then
		self.m_showViewController:setSelectedIndex(2)
	else
		self.m_showViewController:setSelectedIndex(1)
		self.m_selectBtn:setSelected(arg_5_4[arg_5_1.user.id] == true)
	end

	self:_updateUserMember(arg_5_1)
end

function GuildMergeUserApplyCell:_updateUserMember(arg_6_1)
	self._userMember = arg_6_1

	self.m_userComp:updateAsUser(arg_6_1.user)
	self.m_userName:setText(arg_6_1.user.name)
	self.m_level:setText(g.core.lang:get(2052, {
		level = arg_6_1.user.level
	}))

	local var_6_0 = var_0_0:getRightInfoById(arg_6_1.position or 0)

	if var_6_0 then
		self.m_job:setText(var_6_0.name)
	else
		self.m_job:setText("")
	end

	self.m_fightValue:setText(arg_6_1.user.fight_value)
end

return GuildMergeUserApplyCell
