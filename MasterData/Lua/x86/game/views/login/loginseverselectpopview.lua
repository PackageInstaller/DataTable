local LoginSeverSelectPopView = class("LoginSeverSelectPopView", ReduxView)

function LoginSeverSelectPopView:UIName()
	return "Widget/System/LoginInterface/LoginInterfaceServerPopUI"
end

function LoginSeverSelectPopView:UIParent()
	return manager.ui.uiPop.transform
end

function LoginSeverSelectPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function LoginSeverSelectPopView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, LoginSeverSelectPopItem)
end

function LoginSeverSelectPopView:AddUIListener()
	self:AddBtnListener(nil, self.m_backBtn, function()
		self:Back()
	end)
end

function LoginSeverSelectPopView:OnTop()
	return
end

function LoginSeverSelectPopView:OnEnter()
	local var_8_0 = RegionServerMgr.instance:GetRegionServerInfoList()

	self.server_data_list = {}

	for iter_8_0 = 0, var_8_0.Count - 1 do
		local var_8_1 = {
			serverName = var_8_0[iter_8_0].serverName,
			maintain = var_8_0[iter_8_0].maintain,
			newServerFlag = var_8_0[iter_8_0].newServerFlag,
			serverId = var_8_0[iter_8_0].serverId
		}

		if var_8_0[iter_8_0].gameUserInfoList.Count > 0 then
			var_8_1.player = {
				nickName = var_8_0[iter_8_0].gameUserInfoList[0].nickName,
				currentLevel = var_8_0[iter_8_0].gameUserInfoList[0].currentLevel,
				uid = var_8_0[iter_8_0].gameUserInfoList[0].uid,
				lastLoginTime = var_8_0[iter_8_0].gameUserInfoList[0].lastLoginTime
			}
		end

		table.insert(self.server_data_list, var_8_1)
	end

	self.list:StartScroll(#self.server_data_list)
end

function LoginSeverSelectPopView:OnExit()
	manager.windowBar:HideBar()
end

function LoginSeverSelectPopView:IndexItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(self.server_data_list[arg_10_1])
end

function LoginSeverSelectPopView:Dispose()
	self.list:Dispose()
	LoginSeverSelectPopView.super.Dispose(self)
end

return LoginSeverSelectPopView
