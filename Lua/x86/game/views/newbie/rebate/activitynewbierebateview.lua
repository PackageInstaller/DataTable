local var_0_0 = class("ActivityNewbieRebateView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("UI/Activity/NewbieRechargeReturnUI")

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0:UpdateBar()
	arg_2_0:RefreshUI()
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:RefreshUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.toRechargeBtn_, nil, function()
		JumpTools.GoToSystem("/rechargeMain", {
			childShopIndex = 2,
			page = 3
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0.totalRechargeNum_ = RechargeData:GetTotalRechargeNum()
	arg_7_0.rebateAmount_ = arg_7_0:calculate()

	if arg_7_0.totalRechargeNumText_ ~= nil then
		arg_7_0.totalRechargeNumText_.text = arg_7_0.totalRechargeNum_
	end

	if arg_7_0.rebateAmountText_ ~= nil then
		arg_7_0.rebateAmountText_.text = arg_7_0.rebateAmount_
	end
end

function var_0_0.calculate(arg_8_0)
	local var_8_0 = arg_8_0.totalRechargeNum_
	local var_8_1 = 0

	if var_8_0 > 3000 then
		var_8_1 = var_8_1 + (var_8_0 - 3000) * 1.25
		var_8_0 = 3000
	end

	if var_8_0 > 1000 then
		var_8_1 = var_8_1 + (var_8_0 - 1000) * 1.75
		var_8_0 = 1000
	end

	if var_8_0 > 100 then
		var_8_1 = var_8_1 + (var_8_0 - 100) * 3
		var_8_0 = 100
	end

	if var_8_0 > 6 then
		var_8_1 = var_8_1 + (var_8_0 - 6) * 5
		var_8_0 = 6
	end

	if var_8_0 > 0 then
		var_8_1 = var_8_1 + var_8_0 * 10
	end

	return var_8_1 * 10
end

function var_0_0.Show(arg_9_0, arg_9_1)
	if arg_9_1 == false then
		arg_9_0:OnExit()
	end

	SetActive(arg_9_0.gameObject_, arg_9_1)
end

function var_0_0.UpdateBar(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey({
		view = "activityNewbieRebateIllustrate",
		type = "jump",
		params = {}
	})
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
