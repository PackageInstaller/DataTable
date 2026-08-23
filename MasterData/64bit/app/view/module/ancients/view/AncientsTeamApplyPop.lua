local AncientsTeamApplyPop = class("AncientsTeamApplyPop", require("app.fairyGUI.ancients.UI_AncientsTeamApplyPop"), function()
	return fgui.GComponent:create({
		resName = "AncientsTeamApplyPop",
		pkgPath = "ui/ancients/ancients",
		pkgName = "ancients"
	}, ...)
end)

function var_0_0:ctor()
	self:getView():center(true)
	self.m_List_user:setVirtual(self)
	self.m_List_user:setItemRenderer(handler(self, self._onRenderListUserCell))

	self._simpleUsers = {}
end

function var_0_0:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GETAPPLYLIST, handler(self, self._onRcvGetApplyList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_CONFIRMAPPLY, handler(self, self._onRcvConfirmApply), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onGetCommonSimpleUserSnapshot), self)
	g.core.network.GameNetProxy:send_C2S_Ancient_GetApplyList({})
end

function var_0_0:_updateView()
	self.m_is_emptyController:setSelectedIndex(#self._simpleUsers <= 0 and 1 or 0)
	self.m_List_user:setNumItems(#self._simpleUsers)
end

function var_0_0:_onRenderListUserCell(arg_5_1, arg_5_2)
	arg_5_2:updateCell({
		simpleUser = self._simpleUsers[arg_5_1 + 1]
	})
end

function var_0_0:_onRcvGetApplyList(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self._simpleUsers = arg_6_4.users or {}

	table.sort(self._simpleUsers, function(arg_7_0, arg_7_1)
		return arg_7_0.fight_value > arg_7_1.fight_value
	end)

	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(self._simpleUsers) do
		table.insert(var_6_0, iter_6_1.user_id)
	end

	if g.core.utils.Tools.ancientsFunc.sendSimpleUserSnapshot(var_6_0) then
		self:_updateView()
	end
end

function var_0_0:_onRcvConfirmApply(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	for iter_8_0, iter_8_1 in ipairs(self._simpleUsers) do
		if iter_8_1.user_id == arg_8_4.user_id then
			table.remove(self._simpleUsers, iter_8_0)

			break
		end
	end

	self:_updateView()
end

function var_0_0:_onGetCommonSimpleUserSnapshot(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self:_updateView()
end

return var_0_0
