local GuildPlayerInfoCell = class("GuildPlayerInfoCell", require("app.fairyGUI.guild.UI_GuildPlayerInfoCell"))

function GuildPlayerInfoCell:ctor()
	self.getSharedTrans(self, "listCrossbandAUiRightIn", "LongCellFromLeft", self)

	self._rightId = 1
	self._info = nil
	self._canImpeach = false
	self._fromOther = false

	self.m_impeachBtn:addClickListener(handler(self, self._onImpeachClicked))
	self.m_appointBtn:addClickListener(handler(self, self._onAppointClicked))
end

function GuildPlayerInfoCell:updateInfo(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	self._canImpeach = false

	if arg_2_3 then
		self._fromOther = true
	end

	self._info = arg_2_2

	self.m_bgColorController:setSelectedIndex(arg_2_1 % 2)
	self.m_userIconComp:updateAsUser(arg_2_2.user)

	local var_2_0 = arg_2_4

	self.m_showAppointController:setSelectedIndex(1)
	self.m_nameTxt:setText(arg_2_2.user.name)
	self.m_levelTxt:setText("Lv." .. arg_2_2.user.level)

	self._rightId = arg_2_2.position

	local var_2_1 = g.core.model.User.guildData:getRightInfoById(arg_2_2.position)

	self.m_titleTxt:setText(var_2_1.name)
	self.m_powerTxt:setText(arg_2_2.user.fight_value)
	self.m_contributeTxt:setText(arg_2_2.total_contribute)
	self.m_todayContributeTxt:setText(g.core.lang:get(109552, {
		num = arg_2_2.daily_contribute
	}))

	if arg_2_3 then
		self.m_onlineController:setSelectedIndex(0)
	else
		local var_2_2 = arg_2_2.user.offline_time or 0
		local var_2_3 = g.core.common.ServerTime:getTime() - var_2_2

		if arg_2_6 then
			if var_2_2 > 0 then
				local var_2_4 = ""

				if var_2_3 / 3600 <= 1 then
					local var_2_5 = math.floor(var_2_3 / 60)

					if var_2_5 <= 0 then
						var_2_5 = 1
					end

					var_2_4 = g.core.lang:get(109598, {
						num = var_2_5
					})
				else
					var_2_4 = var_2_3 / 86400 <= 1 and g.core.lang:get(109599, {
						num = math.floor(var_2_3 / 3600)
					}) or g.core.lang:get(109600, {
						num = math.floor(var_2_3 / 86400)
					})
				end

				self.m_unOnlineTxt:setText(var_2_4)
				self.m_onlineController:setSelectedIndex(1)
			else
				self.m_onlineController:setSelectedIndex(2)
			end
		else
			self.m_onlineController:setSelectedIndex(0)
		end

		if var_2_2 > 0 then
			self:_updateImpeach(var_2_3)
		end

		if self._info.user.id == g.core.model.User:getId() then
			self.m_showAppointController:setSelectedIndex(1)
		elseif var_2_0 then
			self.m_showAppointController:setSelectedIndex(0)
		elseif arg_2_5 then
			if var_2_1.dissolve > 0 then
				self.m_showAppointController:setSelectedIndex(1)
			else
				self.m_showAppointController:setSelectedIndex(0)
			end
		end
	end
end

function GuildPlayerInfoCell:_updateImpeach(arg_3_1)
	if g.core.model.User.guildData:getGuildId() ~= self._info.user.guild_id then
		return
	end

	if self._rightId ~= 1 then
		return
	end

	if self._info.user.id == g.core.model.User:getId() then
		return
	end

	if arg_3_1 > 0 and math.floor(arg_3_1 / 86400) >= g.core.model.User.guildData:getMyRightInfo().impeach then
		self._canImpeach = true
	end

	if self._canImpeach then
		self.m_onlineController:setSelectedIndex(3)
	end
end

function GuildPlayerInfoCell:_onUserIconClicked(arg_4_1)
	local var_4_0

	if arg_4_1 then
		var_4_0 = {}

		local var_4_1 = arg_4_1:getInput():getTouch()

		var_4_0.x = var_4_1:getLocationInView().x
		var_4_0.y = var_4_1:getLocationInView().y
	end

	if g.core.model.User:getId() == self._info.user.id then
		return
	end

	local var_4_2 = {
		fromGuild = true,
		playerInfo = self._info,
		clickWorldPos = var_4_0
	}

	if self._fromOther then
		var_4_2.fromGuild = false
	end

	print("%%%", self._info)
	g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.InfoUserMenuPop").new(var_4_2), {
		isUpdateBlack = false,
		withoutAni = true
	})
end

function GuildPlayerInfoCell:_onImpeachClicked()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(109589),
		desc = g.core.lang:get(109554, {
			num = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.GUILD_IMPEACH).parameter
		}),
		onConfirm = function()
			g.core.network.GameNetProxy:send_C2S_Guild_Impeach({})
		end
	}))
end

function GuildPlayerInfoCell:_onAppointClicked(arg_7_1)
	local var_7_0 = self:displayObject():convertToWorldSpace(self.m_appointBtn:getPosition())
	local var_7_1 = {
		x = var_7_0.x + 100,
		y = display.height - var_7_0.y
	}

	if var_7_1.y + 125 >= display.height then
		var_7_1.y = var_7_1.y - 125
	end

	self:dispatchCompEvent("AppointBtn_click", {
		clickWorldPos = var_7_1,
		playerInfo = self._info
	})
end

return GuildPlayerInfoCell
