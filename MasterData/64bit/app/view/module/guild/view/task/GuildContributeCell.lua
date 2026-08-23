local var_0_0 = g.core.model.User.guildData
local GuildContributeCell = class("GuildContributeCell", require("app.fairyGUI.guild.UI_GuildContributeCell"))

function GuildContributeCell:ctor(arg_1_1)
	self.m_contributeBtn:addClickListener(handler(self, self._onClickSendGift))
end

function GuildContributeCell:updateInfo(arg_2_1, arg_2_2, arg_2_3)
	self._info = arg_2_2

	if arg_2_1 % 2 == 0 then
		self.m_bgColorController:setSelectedIndex(0)
	else
		self.m_bgColorController:setSelectedIndex(1)
	end

	self.m_userIcon:updateAsUser(arg_2_2.user)
	self.m_nameTxt:setText(arg_2_2.user.name)
	self.m_levelTxt:setText("Lv." .. arg_2_2.user.level)
	self.m_careerTxt:setText(g.core.model.User.guildData:getRightInfoById(arg_2_2.position).name)
	self.m_fightValueTxt:setText(arg_2_2.user.fight_value)

	self._uid = self._info.user.id

	self.m_isContributeController:setSelectedIndex(0)

	if g.core.model.User:getId() ~= self._uid then
		if not arg_2_3 then
			self.m_isContributeController:setSelectedIndex(2)
		else
			self.m_isContributeController:setSelectedIndex(self._info.isHasGetGift and 2 or 1)
		end
	end
end

function GuildContributeCell:_onClickSendGift()
	if (g.core.model.User:getSendCount() or 0) >= (var_0_0:getCfg().gift_send_num or 0) then
		g.core.module.ModuleManager:tip(g.core.lang:get(109616))
	elseif self._info.isHasGetGift then
		g.core.module.ModuleManager:tip(g.core.lang:get(109608))
	else
		g.core.network.GameNetProxy:send_C2S_Guild_SendGift({
			member_id = self._uid
		})
	end
end

function GuildContributeCell:_onUserIconClicked()
	return
end

return GuildContributeCell
