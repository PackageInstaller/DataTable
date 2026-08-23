local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.model.User.pubgData
local PubgRecoverPop = class("PubgRecoverPop", require("app.fairyGUI.pubg.UI_PubgRecoverPop"), function()
	return fgui.GComponent:create({
		resName = "PubgRecoverPop",
		pkgName = "pubg"
	}, ...)
end)

function PubgRecoverPop:ctor()
	self._mapData = var_0_1:getMapData()

	self:showAtCenter()
	self.m_enterTransition:play()
end

function PubgRecoverPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_RECOVERNOTICE, handler(self, self._onRecoverNotify), self)
	self:newSchedule(handler(self, self._onUpdateRecover), 1)
	self:_onUpdateRecover()
end

function PubgRecoverPop:_onRecoverNotify(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if arg_4_4.user_id == g.core.model.User:getId() then
		self:endTime()
	end
end

function PubgRecoverPop:_onUpdateRecover()
	local var_5_0 = self._mapData:getMyUser():getRecoverTime() - var_0_0:getTime()

	if var_5_0 > 0 then
		if var_5_0 <= 3 then
			self.m_recoverTimeController:setSelectedIndex(var_5_0)
		else
			self.m_recoverTimeController:setSelectedIndex(0)
		end

		self.m_recoverTimeText:setText(var_5_0)
	else
		self.m_recoverTimeText:setText("")

		if var_5_0 <= -3 then
			self:endTime()
		end
	end
end

function PubgRecoverPop:endTime()
	if self._isClose then
		return
	end

	self._isClose = true

	self.m_backTransition:play(handler(self, self._onClickClose))
end

function PubgRecoverPop:_onClickClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return PubgRecoverPop
