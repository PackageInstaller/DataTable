local MsgboxSubPanel = class("MsgboxSubPanel", BaseSubPanel)

function MsgboxSubPanel:Load()
	if self._state ~= MsgboxSubPanel.STATES.NONE then
		return
	end

	self._state = MsgboxSubPanel.STATES.LOADING

	pg.UIMgr.GetInstance():LoadingOn()

	local var_1_0 = PoolMgr.GetInstance()

	var_1_0:GetUI(self:getUIName(), false, function(arg_2_0)
		if self._state == MsgboxSubPanel.STATES.DESTROY then
			pg.UIMgr.GetInstance():LoadingOff()
			var_1_0:ReturnUI(self:getUIName(), arg_2_0)
		else
			self:Loaded(arg_2_0)
			self:Init()
		end

		return
	end)

	return
end

function MsgboxSubPanel:SetWindowSize(arg_3_1)
	setSizeDelta(self.viewParent._window, arg_3_1)

	return
end

function MsgboxSubPanel:UpdateView(arg_4_1)
	self:PreRefresh(arg_4_1)
	self:OnRefresh(arg_4_1)
	self:PostRefresh(arg_4_1)

	return
end

function MsgboxSubPanel:PreRefresh(arg_5_1)
	self.viewParent:commonSetting(arg_5_1)
	self:Show()

	return
end

function MsgboxSubPanel:PostRefresh(arg_6_1)
	self.viewParent:Loaded(arg_6_1)

	return
end

function MsgboxSubPanel:OnRefresh(arg_7_1)
	return
end

function MsgboxSubPanel:closeView()
	pg.MsgboxMgr.GetInstance():hide()

	return
end

return MsgboxSubPanel
