local var_0_0 = class("ZumaTalentInfoView", ReduxView)
local var_0_1 = {
	showState = {
		name = "lock",
		canOpenNotConditon = "canOpenNotConditon",
		isUse = "isUse",
		canOpen = "canOpen",
		lock = "lock"
	}
}

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.showController = arg_2_0.controllerexcollection_:GetController(var_0_1.showState.name)

	arg_2_0:AddBtnListener(arg_2_0.openBtn_, nil, function()
		arg_2_0:OnClickUpTalentBtn()
	end)
	arg_2_0:AddBtnListener(arg_2_0.lockBtn_, nil, function()
		ShowTips("ACTIVITY_ZUMA_TALENT_LOCK")
	end)
end

function var_0_0.OnClickUpTalentBtn(arg_5_0)
	if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_ZUMA) then
		ShowTips("TIME_OVER")

		return
	end

	local var_5_0 = arg_5_0.useTalentID
	local var_5_1 = ActivityZumaTalentCfg[var_5_0]

	if not var_5_1 then
		return
	end

	if var_5_1.need > ZumaData:GetZumaCoin() then
		ShowTips("ACTIVITY_ZUMA_TALENT_COST")

		return
	end

	ZumaAction.OpenZumaTalent(var_5_0)
end

function var_0_0.RefreshTalentInfoUi(arg_6_0, arg_6_1)
	arg_6_0.useTalentID = arg_6_1

	local var_6_0 = ActivityZumaTalentCfg[arg_6_1]

	arg_6_0.costnumText_.text = var_6_0.need
	arg_6_0.talentnameText_.text = var_6_0.name
	arg_6_0.talentDescText_.text = var_6_0.desc

	local var_6_1 = var_6_0.pre_id_list
	local var_6_2 = ""
	local var_6_3 = false

	for iter_6_0, iter_6_1 in pairs(var_6_1) do
		if iter_6_1 ~= 0 then
			var_6_3 = true
			var_6_2 = string.format(GetTips("ACTIVITY_ZUMA_TALENT_UNLOCK_CONDITION"), ActivityZumaTalentCfg[iter_6_1].name)
		end
	end

	arg_6_0.conditiondescireText_.text = var_6_2

	if ZumaData:GetZumaTalentIsOpen(arg_6_1) then
		arg_6_0.showController:SetSelectedState(var_0_1.showState.isUse)
	elseif ZumaData:GetZumaTalentIsCanOpen(arg_6_1) then
		if var_6_3 then
			arg_6_0.showController:SetSelectedState(var_0_1.showState.canOpenNotConditon)
		else
			arg_6_0.showController:SetSelectedState(var_0_1.showState.canOpen)
		end
	else
		arg_6_0.showController:SetSelectedState(var_0_1.showState.lock)
	end
end

return var_0_0
