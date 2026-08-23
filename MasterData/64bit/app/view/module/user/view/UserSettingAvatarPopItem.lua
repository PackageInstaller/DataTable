local var_0_0 = g.core.common.Path
local UserSettingAvatarPopItem = class("UserSettingAvatarPopItem", require("app.fairyGUI.user.UI_UserSettingAvatarPopItem"))

function UserSettingAvatarPopItem:ctor()
	self:addClickListener(handler(self, self._onClicked))
	self.getSharedTrans(self, "listCardAUiScaleIn", "CombineBagList", self)

	self._effectSpine = nil
	self._type = nil
end

function UserSettingAvatarPopItem:updateCell(arg_2_1, arg_2_2)
	self._data = arg_2_1
	self._tabPos = arg_2_2

	local var_2_0 = false
	local var_2_1 = g.core.model.User:packUser()

	self.m_frameRedPointComp:setId(0)
	self.m_frameLoader:setVisible(false)
	self.m_effHolder:setVisible(false)

	if arg_2_2 == 2 then
		var_2_1.frame_id = nil

		if arg_2_1.cfg.resEffect ~= "0" then
			self.m_effHolder:setVisible(true)
			self.m_effHolder:removeAllEffect()

			local var_2_2 = self.m_effHolder:addEffectSpine({
				anim = "play",
				isLoop = true,
				name = arg_2_1.cfg.resEffect
			})

			if arg_2_1.isLock then
				var_2_2:mulColor(true, cc.vec3(0.3, 0.3, 0.3))
			else
				var_2_2:mulColor(false)
			end
		else
			self.m_frameLoader:setIcon((var_0_0:getRoleHeadFrameIcon(arg_2_1.cfg.res)))
			self.m_frameLoader:setVisible(true)
		end

		var_2_0 = g.core.model.User:getFrameId() == arg_2_1.cfg.id

		self.m_frameRedPointComp:setId(60)

		self._type = 1
	else
		var_2_1.avata_id = arg_2_1.cfg.id
		var_2_1.frame_id = nil
		var_2_0 = g.core.model.User.userAvatarFrameData:isUseAvatar(arg_2_1.cfg.id)

		self.m_frameRedPointComp:setId(44)

		self._type = 3
	end

	self.m_iconComp:updateAsUser(var_2_1)
	self.m_isLimitTimeController:setSelectedIndex(arg_2_1.cfg.time_type == 2 and 1 or 0)

	if arg_2_1.isLock then
		self.m_frameLoader:setGloaderMask(true, 0.3)
		self.m_isLockController:setSelectedIndex(1)
	else
		self.m_frameLoader:setGloaderMask(false)
		self.m_isLockController:setSelectedIndex(0)
	end

	if var_2_0 then
		self.m_useController:setSelectedIndex(1)
	else
		self.m_useController:setSelectedIndex(0)
	end

	if self._effectSpine then
		self._effectSpine:setVisible(false)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, true, {
		redPointComp = self.m_frameRedPointComp,
		customData = {
			id = arg_2_1.cfg.id,
			isLock = arg_2_1.isLock
		}
	})
end

function UserSettingAvatarPopItem:_changeMask()
	if self.m_mask:getScale().x ~= 1 then
		self.m_mask:setScale(1)
	elseif self.m_mask:getScale().x == 1 then
		self.m_mask:setScale(1.1)
	end
end

function UserSettingAvatarPopItem:onIconClicked()
	if not self._data.isLock then
		return true
	end

	return false
end

function UserSettingAvatarPopItem:playSpineEffect()
	if not self._effectSpine then
		self._effectSpine = self:addEffectSpine({
			name = "eff_ui_ProfilePicture",
			anim = "play",
			isLoop = false
		})

		local var_5_0 = self:getSize()

		self._effectSpine:setPosition(cc.p(var_5_0.width / 2, var_5_0.height / 2))
	else
		self._effectSpine:setAnimation(0, "play", false)
	end

	self._effectSpine:setVisible(true)
end

function UserSettingAvatarPopItem:_onClicked()
	if not self._data.isLock then
		g.core.model.User.userAvatarFrameData:changeUseAvatarOrFrame({
			frame = self._data.cfg.id,
			type = self._type
		})
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, true, {
			redPointComp = self.m_frameRedPointComp,
			customData = {
				id = self._data.cfg.id,
				isLock = self._data.isLock
			}
		})
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_USER_AVTAR_FRAME_TAB_REFRESH_POINT, true, {})
	end
end

return UserSettingAvatarPopItem
