local var_0_0 = class("OathHeroEnterInfo", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.lvStateController_ = arg_2_0.controller_:GetController("oathLv")
	arg_2_0.oathStateController_ = arg_2_0.controller_:GetController("oathState")
	arg_2_0.showStateController_ = arg_2_0.controller_:GetController("show")

	arg_2_0:AddListeners()
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		OperationRecorder.RecordButtonTouch({
			button_name = "wedding_homepage_touch",
			sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM,
			source = OathConst.OATH_SOURCE_ID.HERO
		})
		OathTools.JumpToOathView(arg_3_0.heroID)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.heroID = arg_5_1
	arg_5_0.heroProxy = arg_5_2

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = OathTools.GetIsOpenOath()
	local var_6_1 = OathTools.GetIsCanOathHero(arg_6_0.heroID)

	if var_6_0 and var_6_1 and OathTools.IsCanShowInHeroInfoView() then
		arg_6_0.showStateController_:SetSelectedState("show")

		local var_6_2 = OathCollectionContentData:GetOathLevel(arg_6_0.heroID)

		arg_6_0.lvText_.text = OathTools.GetOathLvShowTips(var_6_2) or var_6_2

		if var_6_2 == 0 then
			arg_6_0.lvStateController_:SetSelectedState("begin")
		elseif var_6_2 >= OathConst.OATH_MAX_LV then
			arg_6_0.lvStateController_:SetSelectedState("max")
		else
			arg_6_0.lvStateController_:SetSelectedState("normal")
		end

		if OathTools.IsOath(arg_6_0.heroID) then
			arg_6_0.oathStateController_:SetSelectedState("finishOath")
		else
			arg_6_0.oathStateController_:SetSelectedState("noOath")
		end

		arg_6_0.roleImg_.sprite = OathTools.GetOathCharacterEnterSprite(arg_6_0.heroID)

		local var_6_3 = manager.redPoint:getTipBoolean(RedPointConst.OATH_HERO .. arg_6_0.heroID)
		local var_6_4 = RedPointStyle.NORMAL

		if var_6_3 and manager.redPoint:getTipBoolean(RedPointConst.OATH_NEW_HERO .. arg_6_0.heroID) then
			var_6_4 = RedPointStyle.SHOW_NEW_TAG
		end

		manager.redPoint:SetRedPointIndependent(arg_6_0.btn_.transform, var_6_3, nil, var_6_4)
	else
		manager.redPoint:SetRedPointIndependent(arg_6_0.transform_, false)
		arg_6_0.showStateController_:SetSelectedState("hide")
	end
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
