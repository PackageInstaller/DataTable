local LoginInnerServerView = class("LoginInnerServerView", ReduxView)

function LoginInnerServerView:UIName()
	return "Widget/System/LoginInterface/LoginInterfaceInnerServerUI"
end

function LoginInnerServerView:UIParent()
	return manager.ui.uiMain.transform
end

local var_0_1 = {
	"ALL",
	"内网公共",
	"程序",
	"策划",
	"美术",
	"QA",
	"未分组"
}

function LoginInnerServerView:Init()
	self:InitUI()
	self:AddUIListener()
end

function LoginInnerServerView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, LoginInnerServerItem)

	for iter_4_0, iter_4_1 in pairs(var_0_1) do
		self.m_dropDown.options:Add(UnityEngine.UI.Dropdown.OptionData.New(iter_4_1))
	end

	self.m_dropDown:RefreshShownValue()

	self.m_dropDown.value = 1
	self.m_customport.text = "8102"
end

function LoginInnerServerView:AddUIListener()
	self:AddBtnListener(nil, self.m_backBtn, function()
		self:Back()
	end)
	self:AddToggleListener(self.m_dropDown, function(arg_7_0)
		self:RefreshList()
	end)
	self.m_searchInput.onValueChanged:AddListener(function()
		if self.m_searchInput.text == "" then
			self:RefreshList()
		else
			self:RefreshSearchList(self.m_searchInput.text)
		end
	end)
	self:AddBtnListener(nil, self.m_customBtn, function()
		GATEWAY_ADDR = self.m_customIp.text
		GATEWAY_PORT = self.m_customport.text

		CheckVersion(function()
			manager.net.gateWayConnection_.netStatus = "none"

			LoginAction.GateWayLogin(PlayerPrefs.GetString("AccountID"), PlayerPrefs.GetString("UserPwd"))
		end)
	end)
end

function LoginInnerServerView:OnEnter()
	self.origin_list = self.params_.list

	self:RefreshList()
end

function LoginInnerServerView:RefreshList()
	if var_0_1[self.m_dropDown.value + 1] == "ALL" then
		self.server_list = {}

		for iter_12_0, iter_12_1 in pairs(self.origin_list) do
			table.insert(self.server_list, iter_12_1)
		end
	else
		self.server_list = {}

		for iter_12_2, iter_12_3 in pairs(self.origin_list) do
			if iter_12_3.group == var_0_1[self.m_dropDown.value + 1] then
				table.insert(self.server_list, iter_12_3)
			end
		end
	end

	self.list:StartScroll(#self.server_list)
end

function LoginInnerServerView:RefreshSearchList(arg_13_1)
	self.server_list = {}

	for iter_13_0, iter_13_1 in pairs(self.origin_list) do
		if string.find(iter_13_1.name, arg_13_1) then
			table.insert(self.server_list, iter_13_1)
		end
	end

	self.list:StartScroll(#self.server_list)
end

function LoginInnerServerView:IndexItem(arg_14_1, arg_14_2)
	arg_14_2:SetData(self.server_list[arg_14_1])
end

function LoginInnerServerView:OnExit()
	return
end

function LoginInnerServerView:Dispose()
	self.list:Dispose()
	LoginInnerServerView.super.Dispose(self)
end

return LoginInnerServerView
