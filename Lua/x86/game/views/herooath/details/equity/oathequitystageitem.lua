local var_0_0 = class("OathEquityStageItem", ReduxView)
local var_0_1 = {
	[true] = {
		[true] = "selectunlock",
		[false] = "selectunlock"
	},
	[false] = {
		[true] = "lock",
		[false] = "unlock"
	}
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.level = arg_1_2

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.stateController_ = arg_2_0.controller_:GetController("state")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.clickCallback_ then
			arg_3_0.clickCallback_()
		end
	end)
end

function var_0_0.SetClickCallback(arg_5_0, arg_5_1)
	arg_5_0.clickCallback_ = arg_5_1
end

function var_0_0.GetLock(arg_6_0)
	return arg_6_0.isLock
end

function var_0_0.GetLockState(arg_7_0)
	if OathCollectionContentData:GetOathLevel(arg_7_0.heroID) >= arg_7_0.level then
		arg_7_0.isLock = false
	else
		arg_7_0.isLock = true
	end
end

function var_0_0.SetData(arg_8_0, arg_8_1)
	arg_8_0.heroID = arg_8_1

	arg_8_0:GetLockState()
	arg_8_0:RefreshController()

	arg_8_0.lvText_.text = OathTools.GetOathLvShowTips(arg_8_0.level) or arg_8_0.level
end

function var_0_0.ChangeSelectState(arg_9_0, arg_9_1)
	if arg_9_0.isSelect == arg_9_1 then
		return
	end

	arg_9_0.isSelect = arg_9_1

	arg_9_0:RefreshController()
end

function var_0_0.RefreshController(arg_10_0)
	local var_10_0 = var_0_1[arg_10_0.isSelect or false][arg_10_0.isLock or false]

	arg_10_0.stateController_:SetSelectedState(var_10_0)
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
