local PlayerInfoShowTitleIcon = class("PlayerInfoShowTitleIcon", require("app.fairyGUI.playerInfo.UI_PlayerInfoShowTitleIcon"))

function PlayerInfoShowTitleIcon:ctor()
	self._titleId = nil
	self._isSelf = false

	self:addListener()
end

function PlayerInfoShowTitleIcon:addListener()
	self:addClickListener(handler(self, self._onClickIcon))
end

function PlayerInfoShowTitleIcon:_onClickIcon()
	if self._titleId == nil then
		return
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.user.view.UserTitleInfoNewPop").new({
		titleId = self._titleId,
		isOtherUser = not self._isSelf
	}, {
		touchDisappear = true
	}))
end

function PlayerInfoShowTitleIcon:updateTitleIcon(arg_4_1, arg_4_2)
	self._isSelf = arg_4_2 == true

	if arg_4_1 == nil or arg_4_1 == 0 then
		self.m_qualityBg:setURL(g.core.common.Path:getPlayerInfoTitleQualityBg(0))
		self:setOpaque(false)
		self:setTouchable(false)
	else
		self:setOpaque(true)

		local var_4_0 = g.core.model.User.UserTitleData:getTitleCfgInfoById(arg_4_1)

		self.m_titleLoader:setURL(g.core.common.Path:getTitleMidIcon(var_4_0.seen_icon))
		self.m_qualityBg:setURL(g.core.common.Path:getPlayerInfoTitleQualityBg((math.clamp(var_4_0.quality, 0, 4))))

		self._titleId = arg_4_1

		self:setTouchable(true)

		if var_4_0.effect ~= "0" then
			self.m_effHolder:removeAllEffect()
			self.m_effHolder:addEffectSpine({
				anim = "play",
				isLoop = true,
				name = var_4_0.effect
			})
			self.m_titleLoader:setVisible(false)
		else
			self.m_effHolder:removeAllEffect()
			self.m_titleLoader:setVisible(true)
		end
	end
end

return PlayerInfoShowTitleIcon
