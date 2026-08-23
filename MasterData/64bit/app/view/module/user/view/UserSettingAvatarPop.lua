local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum
local UserSettingAvatarPop = class("UserSettingAvatarPop", require("app.fairyGUI.user.UI_UserSettingAvatarPop"), function()
	return fgui.GComponent:create({
		pkgName = "user",
		resName = "UserSettingAvatarPop",
		pkgPath = "ui/user/user"
	})
end)

function UserSettingAvatarPop:ctor()
	self:getView():center(true)
	self:_initUIListeners()
	self:_reset()

	self._clickTabRecord = {}
end

function UserSettingAvatarPop:_initUIListeners()
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabChange))
	self.m_avatarList:setVirtual()
	self.m_avatarList:doFairyBatching(false)
	self.m_avatarList:setItemRenderer(handler(self, self._onAvatarListItemRender))
	self.m_avatarList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onAvatarListItemClicked))
	self.m_btnChange:addClickListener(handler(self, self._onChangeBtnClicked))
	var_0_2:addEventListener(var_0_3.EVENT_USER_AVTAR_FRAME_TAB_REFRESH_POINT, self._refreshPoint, self)
end

function UserSettingAvatarPop:_resetUI()
	self._enterTrans = self:getView():getTransition("enter")

	self.m_tabList:setNumItems(2)
	self.m_tabList:resizeToFit(2)
end

function UserSettingAvatarPop:_resetOther()
	self._datas = {}
	self._tabIdx = -1
	self._selectIndexs = {
		-1,
		-1
	}
	self._knightBagMap = {}
end

function UserSettingAvatarPop:_reset()
	self:_resetOther()
	self:_resetUI()
end

function UserSettingAvatarPop:_refreshDatas()
	self._datas[1] = g.core.model.User.userAvatarFrameData:getAvatars()

	local var_7_0 = g.core.model.User.userAvatarFrameData:getFrames()

	if self._tabIdx < 0 and g.core.model.User.userAvatarFrameData:getUseFrameIdx() then
		self._lastUseIdx = 1
	elseif self._tabIdx >= 0 and self._lastUseIdx then
		-- block empty
	end

	self._datas[2] = var_7_0

	self:_refreshPoint()
end

function UserSettingAvatarPop:_addCustomListeners()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRAME_INFO, handler(self, self._onSynchronizeFrame), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MODIFY_USER_INFO, handler(self, self._onShowChangeSuccTip), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ITEM_USE, handler(self, self._onUseFrameItemSucc), self)
end

function UserSettingAvatarPop:onLoad()
	self:_addCustomListeners()
	self:_onUseFrameItemSucc()
	self.m_content:setVisible(false)
	g.core.common.Scheduler:newScheduleOnce(handler(self, function()
		self._enterTrans:play()
		self.m_content:setVisible(true)
		self.m_avatarList:transitionShowCells("listCardAUiScaleIn")
	end), 0.2)
end

function UserSettingAvatarPop:_onTabChange()
	local var_11_0 = self.m_tabList:getSelectedIndex()

	if self._tabIdx == var_11_0 then
		return
	end

	self._tabIdx = var_11_0
	self._clickTabRecord[self._tabIdx] = self._clickTabRecord[self._tabIdx] or self._tabIdx

	self:_updateView(true)

	for iter_11_0, iter_11_1 in ipairs((self.m_avatarList:getChildren())) do
		iter_11_1:playSpineEffect()
	end
end

function UserSettingAvatarPop:_updateView(arg_12_1)
	self.m_avatarList:setNumItems(#self._datas[self._tabIdx + 1])

	local var_12_0 = math.max(0, self._selectIndexs[self._tabIdx + 1])

	self.m_avatarList:setSelectedIndex(var_12_0)

	if arg_12_1 and self._selectIndexs[self._tabIdx + 1] ~= -1 then
		self:_updateIconUI(self._tabIdx + 1, var_12_0)
	else
		self:_onAvatarListItemClicked()
	end
end

function UserSettingAvatarPop:_onAvatarListItemRender(arg_13_1, arg_13_2)
	arg_13_2:updateCell(self._datas[self._tabIdx + 1][arg_13_1 + 1], self._tabIdx + 1)
end

function UserSettingAvatarPop:_onAvatarListItemClicked(arg_14_1)
	local var_14_0 = self.m_avatarList:getSelectedIndex()

	if self._selectIndexs[self._tabIdx + 1] == var_14_0 then
		return
	end

	self._selectIndexs[self._tabIdx + 1] = var_14_0

	self:_updateIconUI(self._tabIdx + 1, var_14_0)
end

function UserSettingAvatarPop:_updateIconUI(arg_15_1, arg_15_2)
	local var_15_0 = self._datas[arg_15_1][arg_15_2 + 1]
	local var_15_1 = g.core.model.User:packUser()
	local var_15_2 = self._datas[arg_15_1][arg_15_2 + 1].cfg.time_type

	if arg_15_1 == 2 then
		var_15_1.frame_id = var_15_0.cfg.id

		self.m_tipText:setText(var_15_0.cfg.description)
		self.m_nameText:setText(var_15_0.cfg.name)

		if var_15_2 == 2 then
			local var_15_3 = g.core.model.User:getPropFrameById(var_15_1.frame_id)
			local var_15_4

			if var_15_3 then
				self.m_remainTimeTxt:setText(g.core.lang:get(1303, {
					str = g.core.common.ServerTime:getLeftDHFormat(var_15_3.expired_time)
				}))

				var_15_4 = {}
			end

			var_15_4.day = math.floor(var_15_0.cfg.time_value / 86400)

			self.m_expireTimeTxt:setText(g.core.lang:get(1302, var_15_4))
		end
	else
		var_15_1.frame_id = nil
		var_15_1.avata_id = var_15_0.cfg.id

		self.m_tipText:setText(var_15_0.cfg.description)
		self.m_nameText:setText(var_15_0.cfg.name)

		if var_15_2 == 2 then
			local var_15_5 = g.core.model.User:getPropHeadById(var_15_1.avata_id)
			local var_15_6

			if var_15_5 then
				self.m_remainTimeTxt:setText(g.core.lang:get(1303, {
					str = g.core.common.ServerTime:getLeftDHFormat(var_15_5.expired_time)
				}))

				var_15_6 = {}
			end

			var_15_6.day = math.floor(var_15_0.cfg.time_value / 86400)

			self.m_expireTimeTxt:setText(g.core.lang:get(1302, var_15_6))
		end
	end

	self.m_isLimitTimeController:setSelectedIndex(var_15_2 == 2 and 1 or 0)
	self.m_userIcon:updateAsUser(var_15_1)

	if not var_15_0.isLock then
		self.m_btnStateController:setSelectedIndex(1)

		if self._tabIdx + 1 == 2 and var_15_0.cfg.id == g.core.model.User:getFrameId() then
			self.m_btnChange:setTitle(g.core.lang:get(101551))
		else
			self.m_btnChange:setTitle(g.core.lang:get(101550))
		end

		if self._tabIdx + 1 == 1 and g.core.model.User.userAvatarFrameData:isUseAvatar(var_15_0.cfg.id) then
			self.m_btnStateController:setSelectedIndex(0)
		end
	else
		self.m_btnStateController:setSelectedIndex(2)
	end
end

function UserSettingAvatarPop:_onChangeBtnClicked()
	if self._datas[self._tabIdx + 1][self._selectIndexs[self._tabIdx + 1] + 1].isLock then
		g.core.module.ModuleManager:tip(g.core.lang:get(100528))

		return
	end

	if self._tabIdx + 1 == 2 then
		if self._datas[self._tabIdx + 1][self._selectIndexs[self._tabIdx + 1] + 1].isLock and self._datas[self._tabIdx + 1][self._selectIndexs[self._tabIdx + 1] + 1].cfg.open_type == 3 then
			g.core.network.GameNetProxy:send_C2S_Item_Use({
				num = 1,
				id = self._datas[self._tabIdx + 1][self._selectIndexs[self._tabIdx + 1] + 1].cfg.open_value
			})
		end

		if self._datas[self._tabIdx + 1][self._selectIndexs[self._tabIdx + 1] + 1].cfg.id == g.core.model.User:getFrameId() then
			g.core.network.GameNetProxy:send_C2S_ModifyUserInfo({
				type = 1,
				frame = 0
			})

			return
		end

		if not self._datas[self._tabIdx + 1][self._selectIndexs[self._tabIdx + 1] + 1].isLock then
			g.core.network.GameNetProxy:send_C2S_ModifyUserInfo({
				type = 1,
				frame = self._datas[self._tabIdx + 1][self._selectIndexs[self._tabIdx + 1] + 1].cfg.id
			})
		end
	elseif not self._datas[self._tabIdx + 1][self._selectIndexs[self._tabIdx + 1] + 1].isLock then
		local var_16_0 = self._datas[self._tabIdx + 1][self._selectIndexs[self._tabIdx + 1] + 1].cfg.id

		if self._datas[self._tabIdx + 1][self._selectIndexs[self._tabIdx + 1] + 1].cfg.id == 200000 or var_16_0 == 210000 then
			var_16_0 = 0
		end

		g.core.network.GameNetProxy:send_C2S_ModifyUserInfo({
			type = 3,
			frame = var_16_0
		})
	end
end

function UserSettingAvatarPop:_onClickClose()
	self.m_avatarList:setVisible(false)
	g.core.module.ModuleManager:popComponent()
end

function UserSettingAvatarPop:_onUseFrameItemSucc()
	g.core.network.GameNetProxy:send_C2S_FrameInfo({})
end

function UserSettingAvatarPop:_onShowChangeSuccTip(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	if arg_19_4.type ~= 1 and arg_19_4.type ~= 3 then
		return
	end

	if arg_19_4.type == 1 then
		if arg_19_4.frame > 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(1183))
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(1184))
		end
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(101552))
	end

	self:_onSynchronizeFrame()
end

function UserSettingAvatarPop:_onSynchronizeFrame()
	self:_refreshDatas()

	if self._tabIdx < 0 then
		self.m_tabList:setSelectedIndex(math.max(0, self._tabIdx))
		self:_onTabChange()
	else
		self:_updateView(true)
	end
end

function UserSettingAvatarPop:_refreshPoint()
	for iter_21_0, iter_21_1 in ipairs({
		45,
		61
	}) do
		local var_21_0 = self.m_tabList:getChildAt(iter_21_0 - 1):getChild("frameRedPointComp")

		if var_21_0 then
			var_21_0:setId(iter_21_1)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
				redPointComp = var_21_0
			})
		end
	end
end

function UserSettingAvatarPop:onUnload()
	for iter_22_0, iter_22_1 in pairs(self._clickTabRecord) do
		if iter_22_0 == 0 then
			for iter_22_2, iter_22_3 in ipairs(self._datas[iter_22_0 + 1]) do
				if not iter_22_3.isLock then
					g.core.model.User.userAvatarFrameData:changeUseAvatarOrFrame({
						type = 3,
						frame = iter_22_3.cfg.id
					})
				end
			end
		elseif iter_22_0 == 1 then
			for iter_22_4, iter_22_5 in ipairs(self._datas[iter_22_0 + 1]) do
				if not iter_22_5.isLock then
					g.core.model.User.userAvatarFrameData:changeUseAvatarOrFrame({
						type = 1,
						frame = iter_22_5.cfg.id
					})
				end
			end
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_USER_AVTAR_FRAME_TAB_REFRESH_POINT, true, {})
	end
end

return UserSettingAvatarPop
