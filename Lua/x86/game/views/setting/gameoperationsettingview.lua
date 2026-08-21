local var_0_0 = class("GameOperationSettingView", ReduxView)

function var_0_0.SetActive(arg_1_0, arg_1_1)
	if arg_1_0.gameObject_ then
		SetActive(arg_1_0.gameObject_, arg_1_1)
	end
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.hander_ = arg_2_1
	arg_2_0.transform_ = arg_2_2.transform
	arg_2_0.gameObject_ = arg_2_2
	arg_2_0.info_ = arg_2_3

	arg_2_0:Init()
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.pageController_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "page")
	arg_4_0.classes_ = {
		GameMobileOperationView,
		GameGamepadOperationView,
		GameKeyboardOperationView
	}
	arg_4_0.gameObjects_ = {
		arg_4_0.mobileGo_,
		arg_4_0.gamepadGo_,
		arg_4_0.keyboardGo_
	}
	arg_4_0.pages_ = {}

	for iter_4_0 = 1, 3 do
		local var_4_0 = arg_4_0.classes_[iter_4_0].New(arg_4_0.gameObjects_[iter_4_0])

		table.insert(arg_4_0.pages_, var_4_0)
	end

	arg_4_0.toggles_ = {
		arg_4_0.toggle1_,
		arg_4_0.toggle2_,
		arg_4_0.toggle3_
	}

	arg_4_0:OnEnter()
end

function var_0_0.AddUIListener(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.toggles_) do
		arg_5_0:AddToggleListener(iter_5_1, function(arg_6_0)
			if arg_6_0 then
				arg_5_0:SwitchToPage(iter_5_0)
			end
		end)
	end
end

function var_0_0.SwitchToPage(arg_7_0, arg_7_1)
	arg_7_0.pageController_:SetSelectedIndex(arg_7_1 - 1)

	for iter_7_0, iter_7_1 in pairs(arg_7_0.pages_) do
		iter_7_1:UpdatePageData()
	end
end

function var_0_0.AddEventListeners(arg_8_0)
	return
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_10_0)
	return
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:AddEventListeners()

	for iter_11_0, iter_11_1 in pairs(arg_11_0.pages_) do
		iter_11_1:OnEnter()
	end
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:RemoveAllEventListener()

	for iter_12_0, iter_12_1 in pairs(arg_12_0.pages_) do
		iter_12_1:OnExit()
	end
end

function var_0_0.SaveData(arg_13_0)
	if arg_13_0.pages_ then
		for iter_13_0, iter_13_1 in pairs(arg_13_0.pages_) do
			iter_13_1:SaveData()
		end
	end
end

function var_0_0.CheckDataChange(arg_14_0)
	if arg_14_0.pages_ then
		for iter_14_0, iter_14_1 in pairs(arg_14_0.pages_) do
			if iter_14_1:CheckDataChange() then
				return true
			end
		end
	end

	return false
end

function var_0_0.RecoverTmpData(arg_15_0)
	if arg_15_0.pages_ then
		for iter_15_0, iter_15_1 in pairs(arg_15_0.pages_) do
			iter_15_1:RecoverTmpData()
		end
	end
end

function var_0_0.OnMainHomeViewTop(arg_16_0)
	return
end

function var_0_0.Dispose(arg_17_0)
	if arg_17_0.pages_ then
		for iter_17_0, iter_17_1 in pairs(arg_17_0.pages_) do
			iter_17_1:Dispose()
		end

		arg_17_0.pages_ = nil
	end

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
