local var_0_0 = g.core.const.ConstMgr.SpineConst
local var_0_1 = g.core.model.User.userFestivalData
local UserSettingInfoComp = class("UserSettingInfoComp", require("app.fairyGUI.user.UI_UserSettingInfoComp"))

function UserSettingInfoComp:ctor()
	self.m_nameText:disableAutoChange()
	self.m_userIdText:disableAutoChange()
	self.m_switchAvatarBtn:addClickListener(handler(self, self._onSwitchAvatarBtnClicked))
	self.m_btnEdit:addClickListener(handler(self, self._onEditBtnClick))
	self.m_copyBtn:addClickListener(handler(self, self._onCopyBtnClick))
	self.m_setTitleBtn:addClickListener(handler(self, self._onSetTitleBtnClick))
	self.m_birthEditBtn:addClickListener(handler(self, self._onBirthEditBtnClick))
end

function UserSettingInfoComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MODIFY_USER_INFO, handler(self, self._onSynchronizeIconAndName), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TITLE_WEAR, self._updateTitleSlot, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_USER_TITLE_SET_REFRESH_POINT, self._updateSetBtnRed, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_USER_AVTAR_FRAME_TAB_REFRESH_POINT, self._updateAvtarRrameBtnRed, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FESTIVAL_SET_BIRTHDAY, handler(self, self._updateBirthDay), self)
end

function UserSettingInfoComp:updateComp()
	local var_3_0 = g.core.model.User:packUser()

	self:_updateKnightSpine(var_3_0.base_id)
	self:_updateHeadIcon(var_3_0)
	self:_updateName(var_3_0.name)

	local var_3_1 = g.core.model.User.resourceData:getExp()
	local var_3_2 = g.core.model.User:getLevelUpExp()

	self.m_expProgBar:setPercent({
		cur = var_3_1,
		max = var_3_2
	})

	if var_3_2 == 0 then
		self.m_isMaxController:setSelectedIndex(1)
	else
		self.m_isMaxController:setSelectedIndex(0)
		self.m_expText:setText(var_3_1 .. "/" .. var_3_2)
	end

	self.m_userIdText:setText(var_3_0.show_id)
	self.m_levelText:setText(var_3_0.level)
	self.m_fightValueText:setText(var_3_0.fight_value)

	if var_3_0.guild_id and var_3_0.guild_id > 0 then
		self.m_inGuildController:setSelectedIndex(1)
		self.m_guildText:setText(var_3_0.guild_name or "")
	else
		self.m_inGuildController:setSelectedIndex(0)
	end

	self:_updateTitleSlot()
	self:_updateFormation()
	self:_updateSetBtnRed()
	self:_updateAvtarRrameBtnRed()
	self:_updateBirthEditBtnRed()
	self:_updateBirthDay()
end

function UserSettingInfoComp:_updateTitleSlot(arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.TITLE_SYS)

	if var_4_0 then
		if arg_4_3 and arg_4_3.ret == g.core.network.proto.RET_OK then
			g.core.module.ModuleManager:tip(g.core.lang:get(105517))
		end

		self.m_titleShowComp:updateComp()
	end

	self.m_titleIsLockController:setSelectedIndex(var_4_0 and 1 or 0)
end

function UserSettingInfoComp:_updateKnightSpine(arg_5_1)
	local var_5_0 = {
		resId = g.core.model.User:getAssistantResInfo().painted_id
	}

	if not var_5_0.resId then
		var_5_0.baseId = arg_5_1
	end

	self.m_knightPicComp:updateKnight(var_5_0)
	self.m_knightPicComp:setAlphaRect(var_0_0.MASK_TYPE.HORIZON, cc.rect(-250 / 2, 0, 250 * 2, 0), 250)
end

function UserSettingInfoComp:_updateName(arg_6_1)
	arg_6_1 = arg_6_1 or g.core.model.User:packUser().name

	self.m_nameText:setText(arg_6_1)
end

function UserSettingInfoComp:_updateHeadIcon(arg_7_1)
	arg_7_1 = arg_7_1 or g.core.model.User:packUser()

	self.m_playerIcon:updateAsUser(arg_7_1)
	self.m_playerIcon:setTouchCallFunc(handler(self, self._onSwitchAvatarBtnClicked))
end

function UserSettingInfoComp:_updateFormation()
	local var_8_0 = g.core.model.User.knightsData:getFormationKnights()

	for iter_8_0 = 1, 6 do
		self["m_knightIcon" .. iter_8_0]:updateComp(iter_8_0, (not var_8_0[iter_8_0] or var_8_0[iter_8_0] == 0 or nil) and nil, nil, nil, true)
	end
end

function UserSettingInfoComp:_initBirthDayView()
	self:_updateBirthDay()
end

function UserSettingInfoComp:_onSynchronizeIconAndName()
	local var_10_0 = g.core.model.User:packUser()

	self:_updateHeadIcon(var_10_0)
	self:_updateName(var_10_0.name)
end

function UserSettingInfoComp:_onSwitchAvatarBtnClicked()
	self:addPopup(require("app.view.module.user.view.UserSettingAvatarPop").new(), {
		hideContinue = true,
		touchDisappear = true
	})
end

function UserSettingInfoComp:_onEditBtnClick()
	self:addPopup(require("app.view.module.user.view.UserSettingNamePop").new(), {
		hideContinue = true,
		touchDisappear = true
	})
end

function UserSettingInfoComp:_onCopyBtnClick()
	g.core.platform.PlatformProxy:copyToClipboard((self.m_userIdText:getText()))
	g.core.module.ModuleManager:tip(g.core.lang:get(2060))
end

function UserSettingInfoComp:_onSetTitleBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.user.view.UserTitleSetPop").new())
end

function UserSettingInfoComp:_onBirthEditBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.user.view.UserSettingBirthPop").new())
end

function UserSettingInfoComp:_updateSetBtnRed()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_setRedPointComp
	})
end

function UserSettingInfoComp:_updateAvtarRrameBtnRed()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_userFrameRedPointComp
	})
end

function UserSettingInfoComp:_updateBirthEditBtnRed()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_userBirthEditRedPointComp
	})
end

function UserSettingInfoComp:_updateBirthDay()
	local var_19_0 = g.core.model.User:getBirthResetTimes()
	local var_19_1, var_19_2 = var_0_1:getFormatBirthMonthDay()

	self.m_birthEditBtn:setVisible(var_19_0 < 2 and g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BIRTHDAY_CARD))
	self.m_birthSetTimeController:setSelectedIndex(var_19_0)
	self.m_birthTxt:setText(g.core.lang:get(101559, {
		month = var_19_1,
		day = var_19_2
	}))
	self:_updateBirthEditBtnRed()
end

return UserSettingInfoComp
