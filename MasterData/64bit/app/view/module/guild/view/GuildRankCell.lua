local var_0_0 = g.core.model.User.guildData
local GuildRankCell = class("GuildRankCell", require("app.fairyGUI.guild.UI_GuildRankCell"))

function GuildRankCell:ctor()
	self._guildInfo = nil

	self.m_clickLoader:addClickListener(handler(self, self._onCellClicked))
	self.m_integrationBtn:addClickListener(handler(self, self._onIntegrationClick))
	self.getSharedTrans(self, "enter_up", "CommonLongCellList", self)
end

function GuildRankCell:setData(arg_2_1, arg_2_2, arg_2_3)
	if arg_2_1 % 2 == 0 then
		self.m_bg:setVisible(false)
	else
		self.m_bg:setVisible(true)
	end

	if arg_2_2.rank <= 3 then
		self.m_rankController:setSelectedIndex(arg_2_2.rank)
	else
		self.m_rankController:setSelectedIndex(0)
		self.m_rankTxt:setText(arg_2_2.rank)
	end

	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD, arg_2_2.id)

	self._guildInfo = var_2_0

	if var_2_0 then
		self.m_guildName:setText(var_2_0.name)
		self.m_guildIcon:updateInfo({
			style = 2,
			data = var_2_0
		})
		self.m_guildIcon:setVisible(true)
		self.m_levelTxt:setText(g.core.lang:get(109501, {
			level = var_2_0.level
		}))
		self.m_forceTxt:setText(var_2_0.fight_value)

		local var_2_1 = g.core.model.User.guildData:getCfg(var_2_0.level)

		self.m_memberSize:setText(g.core.lang:get(109544, {
			num1 = var_2_0.member_num,
			num2 = var_2_1.number
		}))

		if var_2_0.member_num == var_2_1.number then
			self.m_fullController:setSelectedIndex(0)
		else
			self.m_fullController:setSelectedIndex(1)
		end

		arg_2_3 = arg_2_3 and var_2_0.id ~= var_0_0:getGuildId()

		if arg_2_3 then
			self.m_isShowBtnController:setSelectedIndex(1)

			local var_2_2, var_2_3 = var_0_0:isShowMergeBtn(self._guildInfo)

			if var_2_2 then
				self.m_integrationBtn:setGrayed(false)
				self.m_showBtnStateController:setSelectedIndex(var_0_0:hasSendMerge(var_2_0.id) and 1 or 0)
			else
				self.m_integrationBtn:setGrayed(true)
				self.m_showBtnStateController:setSelectedIndex(2)
			end
		else
			self.m_isShowBtnController:setSelectedIndex(0)
		end
	else
		self.m_guildName:setText("")
		self.m_guildIcon:setVisible(false)
		self.m_levelTxt:setText("")
		self.m_forceTxt:setText("")
		self.m_memberSize:setText("")
		self.m_fullController:setSelectedIndex(1)
		self.m_isShowBtnController:setSelectedIndex(0)
	end
end

function GuildRankCell:_onCellClicked()
	if self._guildInfo and self._guildInfo.id ~= g.core.model.User.guildData:getGuildId() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.GUILD_JOIN_HALL, {
			child = fgui.UIPackage:createObject("guild", "GuildJoinLeftComp"),
			guildType = g.core.const.ConstMgr.GuildCommonConst.guildType.OTHER_GUILD,
			guildId = self._guildInfo.id
		})
	end
end

function GuildRankCell:_onIntegrationClick()
	local var_4_0, var_4_1 = var_0_0:isShowMergeBtn(self._guildInfo)

	if not var_4_0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(var_4_1))

		return
	end

	if not self._guildInfo then
		return
	end

	if var_0_0:hasSendMerge(self._guildInfo.id) then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.guild.view.merge.GuildMergeLookSendPop").new({
			targetGid = self._guildInfo.id
		}), {
			touchDisappear = true
		})
	else
		g.core.module.ModuleManager:pushPopup(require("app.view.module.guild.view.merge.GuildMergeSendPop").new({
			targetGid = self._guildInfo.id
		}), {
			touchDisappear = true
		})
	end
end

return GuildRankCell
