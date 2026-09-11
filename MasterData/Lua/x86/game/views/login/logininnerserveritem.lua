local LoginInnerServerItem = class("LoginInnerServerItem", ReduxView)

function LoginInnerServerItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function LoginInnerServerItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function LoginInnerServerItem:InitUI()
	self:BindCfgUI()
end

function LoginInnerServerItem:AddUIListener()
	self:AddBtnListener(nil, self.m_btn, function()
		local var_5_0 = gameContext:GetOpenPageHandler("login")

		if var_5_0 then
			var_5_0.currentServerIndex_ = self.id

			var_5_0:UpdateInnerServer()
		end

		self:Back()
	end)
end

function LoginInnerServerItem:SetData(arg_6_1)
	self.id = arg_6_1.id
	self.m_serverName.text = arg_6_1.name
	self.m_branchName.text = arg_6_1.branch
	self.m_coomitTime.text = arg_6_1.commit_time
end

function LoginInnerServerItem:Dispose()
	LoginInnerServerItem.super.Dispose(self)
end

return LoginInnerServerItem
