local var_0_0 = class("SectionInfoAffixBar", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	for iter_1_0 = 1, 3 do
		arg_1_0["affixController" .. iter_1_0 .. "_"] = arg_1_0["affixControllerEx" .. iter_1_0 .. "_"]:GetController("lcok")
	end

	arg_1_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_2_0)
	for iter_2_0 = 1, 3 do
		arg_2_0:AddBtnListener(arg_2_0["affixBtn" .. iter_2_0 .. "_"], nil, function()
			if arg_2_0.isMain_ == false or arg_2_0.affix_[iter_2_0].isLock == false then
				return
			end

			local var_3_0

			if iter_2_0 == 1 then
				var_3_0 = string.format(GetTips("MYTHIC_AFFIX_UNLOCK_TIPS"), "A")
			elseif iter_2_0 == 2 then
				var_3_0 = string.format(GetTips("MYTHIC_AFFIX_UNLOCK_TIPS"), "B")
			elseif iter_2_0 == 3 then
				var_3_0 = string.format(GetTips("MYTHIC_AFFIX_UNLOCK_TIPS"), "C")
			end

			ShowTips(var_3_0)
		end)
	end
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.isMain_ = arg_5_1
	arg_5_0.affix_ = arg_5_2
	arg_5_0.titleText_.text = arg_5_3

	local var_5_0 = 0
	local var_5_1 = arg_5_0.isMain_ and 3 or 1

	for iter_5_0 = 1, 3 do
		if iter_5_0 <= var_5_1 then
			SetActive(arg_5_0["affixGo" .. iter_5_0 .. "_"], true)

			if arg_5_0.isMain_ then
				if arg_5_2[iter_5_0].isLock then
					arg_5_0["affixController" .. iter_5_0 .. "_"]:SetSelectedState("true")
				else
					arg_5_0["affixController" .. iter_5_0 .. "_"]:SetSelectedState("false")
				end
			else
				arg_5_0["affixController" .. iter_5_0 .. "_"]:SetSelectedState("false")
			end

			arg_5_0["affixImage" .. iter_5_0 .. "_"].sprite = getAffixSprite(arg_5_2[iter_5_0])
			arg_5_0["affixName" .. iter_5_0 .. "_"].text = getAffixName(arg_5_2[iter_5_0])
			arg_5_0["affixDes" .. iter_5_0 .. "_"].text = getAffixDesc(arg_5_2[iter_5_0])
		else
			SetActive(arg_5_0["affixGo" .. iter_5_0 .. "_"], false)
		end
	end
end

return var_0_0
