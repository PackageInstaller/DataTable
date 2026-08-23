local NewSlgS2CityResultUserPop = class("NewSlgS2CityResultUserPop", require("app.fairyGUI.newSlg.UI_NewSlgS2CityResultUserPop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgS2CityResultUserPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgS2CityResultUserPop:ctor(arg_2_1)
	self:showAtCenter()

	arg_2_1 = arg_2_1 or {}
	self._data = arg_2_1.data
	self._listTeam = self:getChild("List_team")

	self._listTeam:setVirtual(self)
	self._listTeam:setItemRenderer(handler(self, self._onRenderListTeamCell))
	self._listTeam:doFairyBatching(false)

	self._isDefCtrl = self:getController("is_def")

	self.m_closeBtn:setClickCallBack(handler(self, self._onClickClose))
	self.m_closeGraph:addClickListener(handler(self, self._onClickClose))
	self.m_enterTransition:play()
end

function NewSlgS2CityResultUserPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._onS2CUserSnapshot, self)

	if not self._data then
		return
	end

	self:_updateView()
end

function NewSlgS2CityResultUserPop:_onClickClose()
	if self._inClose then
		return
	end

	self._inClose = true

	self.m_backTransition:play(handler(self, self.onCloseAnimFinish))
end

function NewSlgS2CityResultUserPop:onCloseAnimFinish()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function NewSlgS2CityResultUserPop:_updateView()
	self._isDef = self._data.is_def

	self._isDefCtrl:setSelectedIndex(self._isDef and 1 or 0)

	local var_6_0 = self._data.users or {}

	self._users = var_6_0

	self._listTeam:setNumItems(#var_6_0)
	self.m_allianceName:setText(g.core.lang:get(429648, {
		name = g.core.model.User.allianceData:getAllianceName()
	}))
	self.m_teamNum:setText(g.core.lang:get(429646, {
		num = #var_6_0
	}))

	local var_6_1 = 0

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		var_6_1 = var_6_1 + (iter_6_1.kill_score or 0) + (iter_6_1.gather_score or 0)
	end

	self.m_totalScore:setText(g.core.lang:get(429647, {
		num = var_6_1
	}))
end

function NewSlgS2CityResultUserPop:_onRenderListTeamCell(arg_7_1, arg_7_2)
	arg_7_2:updateCell(self._users[arg_7_1 + 1], arg_7_1 + 1)
end

function NewSlgS2CityResultUserPop:_onS2CUserSnapshot()
	self._listTeam:setNumItems(#self._users)
end

return NewSlgS2CityResultUserPop
