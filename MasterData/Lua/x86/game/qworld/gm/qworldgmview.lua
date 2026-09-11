local QWorldGmView = class("QWorldGmView", ReduxView)

function QWorldGmView:UIName()
	return "QWWorld/UI/Quest/QWorldGmUI"
end

function QWorldGmView:UIParent()
	return manager.ui.uiMain.transform
end

function QWorldGmView:Init()
	self:InitUI()
	self:AddUIListener()
end

function QWorldGmView:InitUI()
	self:BindCfgUI()
end

function QWorldGmView:AddUIListener()
	self:AddBtnListener(self.addMainBtn_, nil, function()
		self:SendGM(string.format("xt zrw add %s", self.input_.text))
	end)
	self:AddBtnListener(self.finishMainBtn_, nil, function()
		self:SendGM(string.format("xt zrw pass %s", self.input_.text))
	end)
	self:AddBtnListener(self.addSubBtn_, nil, function()
		self:SendGM(string.format("xt rw add %s", self.input_.text))
	end)
	self:AddBtnListener(self.finishSubBtn_, nil, function()
		self:SendGM(string.format("xt rw pass %s", self.input_.text))
	end)
	self:AddBtnListener(self.switchTimeBtn_, nil, function()
		QWorldLuaBridge.Launcher("X510a")
	end)
	self:AddBtnListener(self.switchSceneBtn_, nil, function()
		QWorldLuaBridge.Restart(self.input_.text)
	end)
	self:AddBtnListener(self.teleportBtn_, nil, function()
		local var_12_0 = tonumber(self.input_.text)

		if var_12_0 then
			QWorldTeleport(var_12_0)
		else
			QWorldLuaBridge.TeleportToStageOrigin()
		end
	end)
	self:AddBtnListener(self.seaWarfareBtn_, nil, function()
		self:Go("/seaWarfareGmPanel")
	end)
end

function QWorldGmView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:RefreshUI()
end

function QWorldGmView:OnExit()
	manager.windowBar:HideBar()
end

function QWorldGmView:RefreshUI()
	return
end

function QWorldGmView:SendGM(arg_17_1)
	arg_17_1 = "$ " .. arg_17_1

	print(arg_17_1)
	manager.net:SendWithLoadingNew(27100, {
		content = arg_17_1
	}, 27101, function(arg_18_0, arg_18_1)
		print("Send Msg Return:", arg_18_0.result)
		ShowTips(arg_18_0.result)
	end)
end

function QWorldGmView:Dispose()
	QWorldGmView.super.Dispose(self)
end

return QWorldGmView
