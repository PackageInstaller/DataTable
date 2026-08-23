local var_0_0 = g.core.model.User.UserTitleData
local var_0_1 = g.core.config.talent_skill_info
local UserTitleInfoNewPop = class("UserTitleInfoNewPop", require("app.fairyGUI.user.UI_UserTitleInfoNewPop"), function()
	return fgui.GComponent:create({
		pkgName = "user",
		resName = "UserTitleInfoNewPop",
		pkgPath = "ui/user/user"
	}, ...)
end)

function UserTitleInfoNewPop:ctor(arg_2_1)
	self:showAtCenter()

	self._titleId = arg_2_1.titleId
	self._isOtherUser = arg_2_1.isOtherUser or false
	self._titleData = {}

	self:addClickListener(handler(self, self._onClick))

	self._isCanTouchBg = true
end

function UserTitleInfoNewPop:onLoad()
	if self._isOtherUser then
		local var_3_0 = g.core.config.title_info.get(self._titleId)

		var_3_0.cfgInfo = clone(var_3_0)
		var_3_0.isOwn = true
		var_3_0.weared = false
		self._titleData = var_3_0
	else
		self._titleData = var_0_0:getTitleInfoById(self._titleId)
	end

	self._attrsData = var_0_0:getTitleAttrsById(self._titleId)

	self:_updateView()

	if self.m_enterTransition then
		self.m_enterTransition:play()
	end
end

function UserTitleInfoNewPop:onUnload()
	self:clearEffect()
end

function UserTitleInfoNewPop:_updateView()
	local var_5_0 = self._titleData.weared
	local var_5_1 = self._titleData.isOwn
	local var_5_2 = self._titleData.cfgInfo.time_type

	if self._isOtherUser then
		self.m_isWearController:setSelectedIndex(0)
		self.m_isOwnController:setSelectedIndex(1)
		self.m_isOtherUserController:setSelectedIndex(1)
	else
		self.m_isWearController:setSelectedIndex(var_5_0 and 1 or 0)
		self.m_isOwnController:setSelectedIndex(var_5_1 and 1 or 0)
		self.m_isOtherUserController:setSelectedIndex(0)
		self.m_ownTimeText:setText(g.core.common.ServerTime:getTimeString(self._titleData.ownTime))

		if var_5_1 and var_5_2 == 2 then
			self.m_limitTimeTxt:setText(g.core.common.ServerTime:getLeftDHFormat(self._titleData.ownTime) .. g.core.lang:get(1301))
		end
	end

	self.m_nameText:setText(self._titleData.cfgInfo.name)
	self.m_titleIcon:setURL(g.core.common.Path:getTitleIcon(self._titleData.cfgInfo.seen_icon))
	self.m_descText:setTitle(self._titleData.cfgInfo.title_desc)
	self.m_getText:setText(self._titleData.cfgInfo.description)
	self.m_expireTimeTxt:setText(g.core.lang:get(1302, {
		day = math.floor(self._titleData.cfgInfo.time_value / 86400)
	}))
	self.m_isLimitTimeController:setSelectedIndex(var_5_2 == 2 and 1 or 0)

	if self._titleData.cfgInfo.effect ~= "0" and not self._effect then
		self._effect = require("app.view.common.SpineBase").new({
			resId = "",
			isLoop = true,
			anim = "play",
			path = g.core.common.Path:getEffSpine(self._titleData.cfgInfo.effect)
		})

		self.m_effHolder:addNode(self._effect)
		self.m_titleIcon:setVisible(false)
		self._effect:setGray(not var_5_1)
	end

	local var_5_3 = self._titleData.cfgInfo.activate_talent

	if self._titleData.cfgInfo.activate_talent and var_5_3 ~= 0 then
		self.m_attrTxt:setText(var_0_1.get(var_5_3).description)
	else
		self.m_attrGroup:setVisible(false)
	end
end

function UserTitleInfoNewPop:clearEffect()
	if self._effect then
		self._effect:removeSelf()

		self._effect = nil
	end
end

function UserTitleInfoNewPop:_onClick()
	if self.m_backTransition then
		if self._isCanTouchBg then
			self._isCanTouchBg = false

			self.m_backTransition:play(handler(self, function(arg_8_0)
				g.core.module.ModuleManager:popComponent()
			end))
		end
	else
		g.core.module.ModuleManager:popComponent()
	end
end

return UserTitleInfoNewPop
