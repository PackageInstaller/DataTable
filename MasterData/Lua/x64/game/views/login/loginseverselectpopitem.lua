local LoginSeverSelectPopItem = class("LoginSeverSelectPopItem", ReduxView)

function LoginSeverSelectPopItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function LoginSeverSelectPopItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function LoginSeverSelectPopItem:InitUI()
	self:BindCfgUI()

	self.selectController = self.m_controller:GetController("select")
	self.playerController = self.m_controller:GetController("player")
	self.maintainController = self.m_controller:GetController("maintain")
end

function LoginSeverSelectPopItem:AddUIListener()
	self:AddBtnListener(nil, self.m_btn, function()
		_G.SELECT_REGION_SEVER_ID = self.data.serverId

		manager.notify:CallUpdateFunc(LOGIN_SEVER_UPDATE)
		PlayerPrefs.SetString("RegionServerId", self.data.serverId)
		self:Back()
	end)
end

function LoginSeverSelectPopItem:SetData(arg_6_1)
	self.data = arg_6_1
	self.m_serverName.text = arg_6_1.serverName

	if arg_6_1.maintain then
		self.maintainController:SetSelectedIndex(1)
	else
		self.maintainController:SetSelectedIndex(0)
	end

	if arg_6_1.serverId == _G.SELECT_REGION_SEVER_ID then
		self.selectController:SetSelectedIndex(1)
	else
		self.selectController:SetSelectedIndex(0)
	end

	if arg_6_1.player and GetSDKLoginInfo() then
		self.playerController:SetSelectedIndex(1)

		self.m_playerName.text = arg_6_1.player.nickName
		self.m_playerLv.text = GetTipsF("REGION_SERVER_PLAYER_LEVEL", arg_6_1.player.currentLevel)
	else
		self.playerController:SetSelectedIndex(0)
	end

	if arg_6_1.newServerFlag == 1 then
		SetActive(self.m_newTag, true)
	else
		SetActive(self.m_newTag, false)
	end
end

function LoginSeverSelectPopItem:Dispose()
	LoginSeverSelectPopItem.super.Dispose(self)
end

return LoginSeverSelectPopItem
