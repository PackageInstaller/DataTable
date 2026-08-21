local var_0_0 = class("GMView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/GMPanelUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0.returnBtn_ = arg_4_0:FindCom("Button", "BtnBack")
	arg_4_0.backgroundBtn_ = arg_4_0:FindCom("Button", "background")
	arg_4_0.gmBtn1_ = arg_4_0:FindCom("Button", "GMBtnPanel/BtnGM1")
	arg_4_0.gmBtn2_ = arg_4_0:FindCom("Button", "GMBtnPanel/BtnGM2")
	arg_4_0.gmBtn3_ = arg_4_0:FindCom("Button", "GMBtnPanel/BtnGM3")
	arg_4_0.gmBtn4_ = arg_4_0:FindCom("Button", "GMBtnPanel/BtnGM4")
	arg_4_0.gmBtn5_ = arg_4_0:FindCom("Button", "GMBtnPanel/BtnGM5")
	arg_4_0.gmBtn6_ = arg_4_0:FindCom("Button", "GMBtnPanel/BtnGM6")
	arg_4_0.gmBtn7_ = arg_4_0:FindCom("Button", "GMBtnPanel/BtnGM7")
	arg_4_0.gmBtn8_ = arg_4_0:FindCom("Button", "GMBtnPanel/BtnGM8")
	arg_4_0.gmBtn9_ = arg_4_0:FindCom("Button", "GMBtnPanel/BtnGM9")
	arg_4_0.inputField_ = arg_4_0:FindCom("InputField", "InputPanel/InputField")
	arg_4_0.sendBtn_ = arg_4_0:FindCom("Button", "InputPanel/SendBtn")
	arg_4_0.urlField_ = arg_4_0:FindCom("InputField", "WindowUrlPanel/InputField")
	arg_4_0.gotoUrlBtn_ = arg_4_0:FindCom("Button", "WindowUrlPanel/GotoUrlBtn")
	arg_4_0.inputTheme_ = arg_4_0:FindCom("InputField", "ActivityPanel/InputField")
	arg_4_0.ActivityBtn_ = arg_4_0:FindCom("Button", "ActivityPanel/ActivityBtn")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.returnBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.backgroundBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.gmBtn1_, nil, function()
		arg_5_0:SendGMInfo("greenday")
	end)
	arg_5_0:AddBtnListener(arg_5_0.gmBtn2_, nil, function()
		arg_5_0:SendGMInfo("material")
	end)
	arg_5_0:AddBtnListener(arg_5_0.gmBtn3_, nil, function()
		arg_5_0:SendGMInfo("currency")
	end)
	arg_5_0:AddBtnListener(arg_5_0.gmBtn4_, nil, function()
		arg_5_0:SendGMInfo("equip")
	end)
	arg_5_0:AddBtnListener(arg_5_0.gmBtn5_, nil, function()
		arg_5_0:SendGMInfo("servant")
	end)
	arg_5_0:AddBtnListener(arg_5_0.gmBtn6_, nil, function()
		arg_5_0:SendGMInfo("userlevel")
	end)
	arg_5_0:AddBtnListener(arg_5_0.gmBtn7_, nil, function()
		arg_5_0:SendGMInfo("herolevel")
	end)
	arg_5_0:AddBtnListener(arg_5_0.gmBtn8_, nil, function()
		arg_5_0:SendGMInfo("open")
	end)
	arg_5_0:AddBtnListener(arg_5_0.gmBtn9_, nil, function()
		arg_5_0:SendGMInfo("mail")
	end)
	arg_5_0:AddBtnListener(arg_5_0.sendBtn_, nil, function()
		if arg_5_0.inputField_.text == "" then
			return
		end

		local var_17_0 = arg_5_0.inputField_.text

		if string.sub(var_17_0, 1, 3) == "lua" then
			arg_5_0.RunScript(string.sub(var_17_0, 4, #var_17_0))

			return
		end

		word = "$ " .. arg_5_0.inputField_.text
		arg_5_0.inputField_.text = ""

		arg_5_0:SendGMInfo(word)
	end)
	arg_5_0:AddBtnListener(arg_5_0.ActivityBtn_, nil, function()
		if arg_5_0.inputTheme_.text == "" then
			arg_5_0:SendGMInfo("$ bbhd start")

			return
		end

		local var_18_0 = arg_5_0.inputTheme_.text

		word = "$ bbhd start " .. arg_5_0.inputTheme_.text
		arg_5_0.inputTheme_.text = ""

		arg_5_0:SendGMInfo(word)
	end)
	arg_5_0:AddBtnListener(arg_5_0.gotoUrlBtn_, nil, function()
		if arg_5_0.urlField_.text == "" then
			return
		end

		local var_19_0 = arg_5_0.urlField_.text
		local var_19_1 = string.split(var_19_0, ",")

		var_19_1[1] = tonumber(var_19_1[1])

		local var_19_2 = {}

		for iter_19_0, iter_19_1 in ipairs(var_19_1) do
			if tonumber(iter_19_1) > 0 then
				var_19_2[iter_19_0] = tonumber(iter_19_1)
			else
				var_19_2[iter_19_0] = iter_19_1
			end
		end

		JumpTools.JumpToPage2(var_19_2)
	end)
end

function var_0_0.RunScript(arg_20_0, arg_20_1)
	local var_20_0, var_20_1 = pcall(load, arg_20_0, arg_20_1)

	if not var_20_0 then
		Debug.LogError(var_20_1)

		return
	end

	local var_20_2 = var_20_1

	if var_20_2 == nil then
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

function var_0_0.SendGMInfo(arg_22_0, arg_22_1)
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
	var_0_0.SendGM(var_22_0, var_0_1)
end

function var_0_0.SendGM(arg_23_0, arg_23_1)
	local var_23_0 = {
		content = arg_23_0
	}

	manager.net:SendWithLoadingNew(27100, var_23_0, 27101, arg_23_1)
end

function var_0_0.Init(arg_24_0)
	arg_24_0:InitUI()
	arg_24_0:AddUIListener()

	arg_24_0.activityView_ = GMActivityView.New(arg_24_0:FindGo("activityGmPanel"))
end

function var_0_0.OnEnter(arg_25_0)
	arg_25_0.activityView_:OnEnter()
end

function var_0_0.OnExit(arg_26_0)
	arg_26_0.activityView_:OnExit()
end

function var_0_0.Dispose(arg_27_0)
	var_0_0.super.Dispose(arg_27_0)
	arg_27_0.activityView_:Dispose()

	arg_27_0.activityView_ = nil
end

return var_0_0
