local var_0_0 = class("CharChipExtraItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.control_ = arg_1_0.conEx_ and arg_1_0.conEx_:GetController("lock") or nil
	arg_1_0.condItems_ = {}

	SetActive(arg_1_0.condItem_, false)
end

function var_0_0.AddListeners(arg_2_0)
	return
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.extraID_ = arg_3_1
	arg_3_0.nextID_ = arg_3_2
	arg_3_0.sectionProxy_ = arg_3_3

	arg_3_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_4_0)
	arg_4_0.gameObject_.name = arg_4_0.extraID_

	local var_4_0 = ChipCfg[arg_4_0.extraID_]

	arg_4_0.desc_.text = var_4_0.desc

	if arg_4_0.control_ then
		local var_4_1 = false
		local var_4_2 = true

		if arg_4_0.sectionProxy_ then
			var_4_1 = arg_4_0.sectionProxy_:IsCharChipExtraUnlock(arg_4_0.extraID_)
			var_4_2 = arg_4_0.sectionProxy_:IsCharChipCanOperate(arg_4_0.extraID_)
		else
			var_4_1 = ChipTools.IsCharChipExtraUnlock(arg_4_0.extraID_)
		end

		if var_4_1 then
			arg_4_0.control_:SetSelectedState("done")
		elseif arg_4_0.nextID_ == arg_4_0.extraID_ and var_4_2 then
			arg_4_0.control_:SetSelectedState("now")

			arg_4_0.condList_ = ChipCfg[arg_4_0.extraID_].module_condition

			arg_4_0:RefreshCondList()
		else
			arg_4_0.control_:SetSelectedState("lock")
		end
	end

	if arg_4_0.cdInitText_ then
		arg_4_0.cdInitText_.text = var_4_0.cooldown_first
		arg_4_0.cdText_.text = var_4_0.cooldown_com
	end
end

function var_0_0.IndexItemCond(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.condList_[arg_5_1])
end

function var_0_0.RefreshCondList(arg_6_0)
	local var_6_0 = #arg_6_0.condList_

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.condItems_) do
		SetActive(iter_6_1.gameObject_, iter_6_0 <= var_6_0)
	end

	for iter_6_2 = 1, var_6_0 do
		local var_6_1 = arg_6_0.condItems_[iter_6_2]

		if not var_6_1 then
			local var_6_2 = Object.Instantiate(arg_6_0.condItem_, arg_6_0.condListTrans_)

			SetActive(var_6_2, true)

			var_6_1 = CharChipCondItem.New(var_6_2)
			arg_6_0.condItems_[iter_6_2] = var_6_1
		end

		arg_6_0:IndexItemCond(iter_6_2, var_6_1)
	end
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.condItems_) do
		iter_7_1:Dispose()
	end
end

return var_0_0
