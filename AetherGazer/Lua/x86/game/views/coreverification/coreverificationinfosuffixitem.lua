local var_0_0 = class("CoreVerificationInfoSuffIxItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()

	arg_1_0.index = 0
	arg_1_0.nowID = 0
	arg_1_0.data = {}
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btnaddBtn_, nil, function()
		arg_4_0.index = Mathf.Clamp(arg_4_0.index + 1, 0, #arg_4_0.data)

		arg_4_0:UpdateTxt(arg_4_0.index, arg_4_0.index)
		arg_4_0.callBack(arg_4_0.itemIndex, arg_4_0.index)
	end)
	arg_4_0:AddBtnListener(arg_4_0.btnsubtractBtn_, nil, function()
		arg_4_0.index = Mathf.Clamp(arg_4_0.index - 1, 0, #arg_4_0.data)

		arg_4_0:UpdateTxt(arg_4_0.index)
		arg_4_0.callBack(arg_4_0.itemIndex, arg_4_0.index)
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0.data = arg_7_1
	arg_7_0.index = arg_7_2 or 0
	arg_7_0.itemIndex = arg_7_3

	arg_7_0:UpdateTxt(arg_7_0.index)

	arg_7_0.callBack = arg_7_4
end

function var_0_0.UpdateTxt(arg_8_0, arg_8_1)
	arg_8_0.btnsubtractBtn_.interactable = arg_8_1 > 0
	arg_8_0.btnaddBtn_.interactable = arg_8_1 < #arg_8_0.data

	if arg_8_0.data then
		local var_8_0 = arg_8_1 == 0 and arg_8_0.data[1] or arg_8_0.data[arg_8_1]
		local var_8_1 = ActivityAffixPoolCfg[var_8_0]

		if arg_8_1 ~= 0 and var_8_1 then
			arg_8_0.nowID = var_8_0
			arg_8_0.pointText_.text = var_8_1.point
			arg_8_0.descText_.text = var_8_1.name
		else
			arg_8_0.nowID = nil
			arg_8_0.pointText_.text = 0
			arg_8_0.descText_.text = var_8_1.name
		end
	end

	arg_8_0.textamountText_.text = arg_8_1
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
