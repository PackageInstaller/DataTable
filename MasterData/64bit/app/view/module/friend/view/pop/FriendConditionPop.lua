local var_0_0 = g.core.model.User.friendData
local FriendControllerConst = require("app.view.module.friend.const.FriendControllerConst")
local FriendConditionPop = class("FriendConditionPop", require("app.fairyGUI.friend.UI_FriendConditionPop"), function()
	return fgui.GComponent:create({
		pkgName = "friend",
		resName = "FriendConditionPop",
		pkgPath = "ui/friend/friend"
	}, ...)
end)

function FriendConditionPop:ctor()
	self:_initUIListeners()
	self:getView():center(true)
end

function FriendConditionPop:_initUIListeners()
	self.m_confirmBtn:addClickListener(handler(self, self._onChangeCondition))
end

function FriendConditionPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRIEND_SETREQUESTCOND, handler(self, self._onRecSetRequestCond), self)
	self:_updateView()
end

function FriendConditionPop:_updateView()
	self._userLv = g.core.model.User:getLevel()

	local var_5_0 = var_0_0:getApplyCondList()[1]
	local var_5_1

	if var_5_0.value then
		var_5_1 = var_5_0.value or 1
	end

	self._curApplyLv = var_5_1

	self.m_countBtnComp:initMinMaxNum({
		min = 1,
		max = self._userLv,
		cur = var_5_1,
		callback = handler(self, self._changeNumEvent)
	})
end

function FriendConditionPop:_onChangeCondition()
	g.core.network.GameNetProxy:send_C2S_Friend_SetRequestCond({
		cond_type = 1,
		value = self._curApplyLv
	})
end

function FriendConditionPop:_changeNumEvent(arg_7_1)
	if arg_7_1 <= self._userLv then
		self._curApplyLv = arg_7_1
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(1097))
	end
end

function FriendConditionPop:_onRecSetRequestCond()
	g.core.module.ModuleManager:tip(g.core.lang:get(1098))
	g.core.module.ModuleManager:popModule()
end

return FriendConditionPop
