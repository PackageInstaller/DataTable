local var_0_0 = class("HeroSurpassPreviewItem", ReduxView)
local var_0_1 = {
	lockState = {
		lock = "lock",
		normal = "normal"
	},
	showTypeState = {
		special = "special",
		normal = "normal"
	}
}

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.isBigNode_ = arg_1_2

	arg_1_0:InitUI()
end

function var_0_0.SetClickCheckCallback(arg_2_0, arg_2_1)
	arg_2_0.clickCheckCallback = arg_2_1
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()

	arg_3_0.lockController = arg_3_0.controllerexcollection_:GetController("lock")

	if arg_3_0.isBigNode_ then
		arg_3_0.showController = arg_3_0.controllerexcollection_:GetController("showType")
	end
end

function var_0_0.AddUIListener(arg_4_0)
	if arg_4_0.isBigNode_ then
		arg_4_0:AddBtnListener(arg_4_0.checkbtnBtn_, nil, function()
			if arg_4_0.clickCheckCallback then
				arg_4_0:clickCheckCallback()
			end
		end)
	end
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	local var_6_0 = arg_6_1.isBeginStar

	if arg_6_0.showController then
		local var_6_1 = arg_6_1.isBeginStar and var_0_1.showTypeState.special or var_0_1.showTypeState.normal

		arg_6_0.showController:SetSelectedState(var_6_1)
	end

	local var_6_2 = arg_6_1.isLock and var_0_1.lockState.lock or var_0_1.lockState.normal

	arg_6_0.lockController:SetSelectedState(var_6_2)

	local var_6_3 = arg_6_1.cfg

	arg_6_0.heroStarCfg = var_6_3

	local var_6_4, var_6_5 = arg_6_0:UpdateDescShow(arg_6_1.heroCfg, var_6_3)

	if not arg_6_0.isBigNode_ then
		if var_6_4 == "" then
			arg_6_0.textText_.text = var_6_5
		else
			arg_6_0.textText_.text = var_6_4
		end
	else
		SurpassTools.ChangeIconStarSpirte(arg_6_0.iconImg_, var_6_3.star)

		if var_6_5 == "" then
			SetActive(arg_6_0.additem2Go_, false)
		else
			SetActive(arg_6_0.additem2Go_, true)

			arg_6_0.addtext2Text_.text = var_6_5
		end

		local var_6_6 = HeroTools.IsSpHero(arg_6_1.heroCfg and arg_6_1.heroCfg.id or 0)

		SetActive(additem3Go_, var_6_6)

		if var_6_6 then
			local var_6_7 = AstrolabeTools.GetSpAstrolabeNodeBySurpass(arg_6_1.heroCfg.id, var_6_3)

			SetActive(arg_6_0.additem3Go_, var_6_7 ~= 0)

			if HeroAstrolabeCfg[var_6_7] then
				arg_6_0.addtext3Text_.text = string.format("解锁[%s]神格", HeroAstrolabeCfg[var_6_7].name)
			end
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.showgroupTrs_)

		local var_6_8 = arg_6_0.checkbtnTrs_.position

		var_6_8.y = arg_6_0.additem1Go_.transform.position.y
		arg_6_0.checkbtnTrs_.position = var_6_8
	end
end

function var_0_0.UpdateDescShow(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = ""
	local var_7_1, var_7_2 = SurpassTools.GetStarUpAttrShowDesc(arg_7_1, arg_7_2.id)

	for iter_7_0, iter_7_1 in pairs(var_7_1) do
		var_7_0 = string.format("%s%s", var_7_0, iter_7_1)
	end

	return var_7_0, var_7_2
end

function var_0_0.SetActive(arg_8_0, arg_8_1)
	arg_8_0.gameObject_:SetActive(arg_8_1)
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
