local var_0_1 = g.core.model.User.UserTitleData
local UserTitleInfoPop = class("UserTitleInfoPop", require("app.fairyGUI.user.UI_UserTitleInfoPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/user/user",
		resName = "UserTitleInfoPop",
		pkgName = "user",
		isFullScreen = true
	}, ...)
end)

function UserTitleInfoPop:ctor(arg_2_1)
	self._titleId = arg_2_1.titleId
	self._titleData = {}
	self._attrsData = {}

	self.m_attrsList:setVirtual()
	self.m_attrsList:setItemRenderer(handler(self, self._onAttrsItemRenderer))
	self:addClickListener(handler(self, self._onClick))

	self._isCanTouchBg = true
end

function UserTitleInfoPop:onLoad()
	self._titleData = var_0_1:getTitleInfoById(self._titleId)
	self._attrsData = var_0_1:getTitleAttrsById(self._titleId)

	self:_updateView()
	self.m_enterTransition:play()
end

function UserTitleInfoPop:_updateView()
	local var_4_0 = self._titleData.isOwn

	self.m_isWearController:setSelectedIndex(self._titleData.weared and 1 or 0)
	self.m_isOwnController:setSelectedIndex(var_4_0 and 1 or 0)
	self.m_nameText:setText(self._titleData.cfgInfo.name)
	self.m_ownTimeText:setText(g.core.common.ServerTime:getTimeString(self._titleData.ownTime))
	self.m_titleIcon:setURL(g.core.common.Path:getTitleIcon(self._titleData.cfgInfo.seen_icon))
	self.m_descText:setText(self._titleData.cfgInfo.title_desc)
	self.m_getText:setText(self._titleData.cfgInfo.description)
	self.m_attrsList:setNumItems(#self._attrsData)
end

function UserTitleInfoPop:_onAttrsItemRenderer(arg_5_1, arg_5_2)
	if self._attrsData[arg_5_1 + 1] then
		arg_5_2:updateAttr({
			name = self._attrsData[arg_5_1 + 1].name,
			value = self._attrsData[arg_5_1 + 1].value
		})
	end
end

function UserTitleInfoPop:_onClick()
	if self._isCanTouchBg then
		self._isCanTouchBg = false

		self.m_backTransition:play(handler(self, function(arg_7_0)
			g.core.module.ModuleManager:popComponent()
		end))
	end
end

return UserTitleInfoPop
