-- chunkname: @IQIGame\\UI\\Login\\UserProtocolWindow.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
end

function m:RemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
end

function m:Show(url, type)
	self.View:SetActive(true)

	if type == 1 then
		UGUIUtil.SetText(self.TitleText, LoginUIApi:GetUserProtocolTitleText())
	elseif type == 2 then
		UGUIUtil.SetText(self.TitleText, LoginUIApi:GetPrivacyPolicyTitleText())
	else
		UGUIUtil.SetText(self.TitleText, LoginUIApi:GetChildPrivacyTitleText())
	end

	if IQIGame.Onigao.Game.Device.isMobile then
		local uniWebViewCom = self.UniWebView:GetComponent("UniWebView")

		uniWebViewCom:SetBackButtonEnabled(false)
		uniWebViewCom:Load(url, false)
		uniWebViewCom:Show()
	else
		UGUIUtil.SetText(self.ContentText, "Not supported on Unity Editor Mode.")
	end
end

function m:Hide()
	self.View:SetActive(false)
end

function m:OnClickConfirmBtn()
	self:Hide()
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
