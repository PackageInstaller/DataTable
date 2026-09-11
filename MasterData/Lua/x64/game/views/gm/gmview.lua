local GMView = class("GMView", ReduxView)

function GMView:UIName()
	return "UI/GMPanelUI"
end

function GMView:UIParent()
	return manager.ui.uiMain.transform
end

function GMView:OnCtor()
	return
end

function GMView:InitUI()
	self.returnBtn_ = self:FindCom("Button", "BtnBack")
	self.backgroundBtn_ = self:FindCom("Button", "background")
	self.gmBtn1_ = self:FindCom("Button", "GMBtnPanel/BtnGM1")
	self.gmBtn2_ = self:FindCom("Button", "GMBtnPanel/BtnGM2")
	self.gmBtn3_ = self:FindCom("Button", "GMBtnPanel/BtnGM3")
	self.gmBtn4_ = self:FindCom("Button", "GMBtnPanel/BtnGM4")
	self.gmBtn5_ = self:FindCom("Button", "GMBtnPanel/BtnGM5")
	self.gmBtn6_ = self:FindCom("Button", "GMBtnPanel/BtnGM6")
	self.gmBtn7_ = self:FindCom("Button", "GMBtnPanel/BtnGM7")
	self.gmBtn8_ = self:FindCom("Button", "GMBtnPanel/BtnGM8")
	self.gmBtn9_ = self:FindCom("Button", "GMBtnPanel/BtnGM9")
	self.inputField_ = self:FindCom("InputField", "InputPanel/InputField")
	self.sendBtn_ = self:FindCom("Button", "InputPanel/SendBtn")
	self.urlField_ = self:FindCom("InputField", "WindowUrlPanel/InputField")
	self.gotoUrlBtn_ = self:FindCom("Button", "WindowUrlPanel/GotoUrlBtn")
	self.inputTheme_ = self:FindCom("InputField", "ActivityPanel/InputField")
	self.ActivityBtn_ = self:FindCom("Button", "ActivityPanel/ActivityBtn")
end

function GMView:AddUIListener()
	self:AddBtnListener(self.returnBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.backgroundBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.gmBtn1_, nil, function()
		self:SendGMInfo("greenday")
	end)
	self:AddBtnListener(self.gmBtn2_, nil, function()
		self:SendGMInfo("material")
	end)
	self:AddBtnListener(self.gmBtn3_, nil, function()
		self:SendGMInfo("currency")
	end)
	self:AddBtnListener(self.gmBtn4_, nil, function()
		self:SendGMInfo("equip")
	end)
	self:AddBtnListener(self.gmBtn5_, nil, function()
		self:SendGMInfo("servant")
	end)
	self:AddBtnListener(self.gmBtn6_, nil, function()
		self:SendGMInfo("userlevel")
	end)
	self:AddBtnListener(self.gmBtn7_, nil, function()
		self:SendGMInfo("herolevel")
	end)
	self:AddBtnListener(self.gmBtn8_, nil, function()
		self:SendGMInfo("open")
	end)
	self:AddBtnListener(self.gmBtn9_, nil, function()
		self:SendGMInfo("mail")
	end)
	self:AddBtnListener(self.sendBtn_, nil, function()
		if self.inputField_.text == "" then
			return
		end

		local var_17_0 = self.inputField_.text

		if string.sub(self.inputField_.text, 1, 3) == "lua" then
			self.RunScript(string.sub(var_17_0, 4, #var_17_0))

			return
		end

		word = "$ " .. self.inputField_.text
		self.inputField_.text = ""

		self:SendGMInfo(word)
	end)
	self:AddBtnListener(self.ActivityBtn_, nil, function()
		if self.inputTheme_.text == "" then
			self:SendGMInfo("$ bbhd start")

			return
		end

		word = "$ bbhd start " .. self.inputTheme_.text
		self.inputTheme_.text = ""

		self:SendGMInfo(word)
	end)
	self:AddBtnListener(self.gotoUrlBtn_, nil, function()
		if self.urlField_.text == "" then
			return
		end

		local var_19_0 = string.split(self.urlField_.text, ",")

		var_19_0[1] = tonumber(var_19_0[1])

		local var_19_1 = {}

		for iter_19_0, iter_19_1 in ipairs(var_19_0) do
			var_19_1[iter_19_0] = tonumber(iter_19_1) > 0 and tonumber(iter_19_1) or iter_19_1
		end

		JumpTools.JumpToPage2(var_19_1)
	end)
end

function GMView:RunScript(arg_20_1)
	local var_20_0, var_20_1 = pcall(load, self, arg_20_1)

	if not var_20_0 then
		Debug.LogError(var_20_1)

		return
	end

	local var_20_2 = var_20_1

	if var_20_1 == nil then
		return
	end

	local var_20_3, var_20_4 = pcall(var_20_2)

	if not var_20_3 then
		Debug.LogError(var_20_4)
	end
end

local function var_0_1(arg_21_0, arg_21_1)
	print("Send Msg Return:", arg_21_0.result)
	ShowTips(arg_21_0.result)
end

function GMView:SendGMInfo(arg_22_1)
	local var_22_0

	if arg_22_1 == "greenday" then
		var_22_0 = "$ greenday"
	elseif arg_22_1 == "material" then
		var_22_0 = "$ setm all 1000"
	elseif arg_22_1 == "currency" then
		var_22_0 = "$ set all 10000"
	elseif arg_22_1 == "equip" then
		var_22_0 = "$ equipall"
	elseif arg_22_1 == "servant" then
		var_22_0 = "$ allservant"
	elseif arg_22_1 == "userlevel" then
		var_22_0 = "$ lv me 60"
	elseif arg_22_1 == "herolevel" then
		var_22_0 = "$ lv hero all 60"
	elseif arg_22_1 == "open" then
		var_22_0 = "$ zj all"
	elseif arg_22_1 == "mail" then
		var_22_0 = "$ mail 3"
	elseif string.sub(arg_22_1, 1, 2) == "$ " then
		var_22_0 = arg_22_1
	end

	print(var_22_0)
	GMView.SendGM(var_22_0, var_0_1)
end

function GMView:SendGM(arg_23_1)
	manager.net:SendWithLoadingNew(27100, {
		content = self
	}, 27101, arg_23_1)
end

function GMView:Init()
	self:InitUI()
	self:AddUIListener()

	self.activityView_ = GMActivityView.New(self:FindGo("activityGmPanel"))
end

function GMView:OnEnter()
	self.activityView_:OnEnter()
end

function GMView:OnExit()
	self.activityView_:OnExit()
end

function GMView:Dispose()
	GMView.super.Dispose(self)
	self.activityView_:Dispose()

	self.activityView_ = nil
end

return GMView
