DormInfomationModuleBase = import("game.views.dorm.DormView.Information.Module.DormInfomationModuleBase")

local var_0_0 = class("DormInfomationCanteenModule", DormInfomationModuleBase)

function var_0_0.ModuleName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/item/Infomation/CanteenWeekPanel"
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListener()
end

function var_0_0.AddListener(arg_3_0)
	return
end

function var_0_0.Show(arg_4_0, arg_4_1)
	var_0_0.super.Show(arg_4_0, arg_4_1)

	local var_4_0 = DormInfomationData:GetParams(arg_4_1)

	if var_4_0[1] and var_4_0[1] ~= -1 then
		SetActive(arg_4_0.heroHeadBtn2_, true)
		SetActive(arg_4_0.noneHead2_, false)

		arg_4_0.heroHeadIcon2_.spriteSync = "TextureConfig/BackHouseUI/RoleHead/" .. var_4_0[1]
	else
		SetActive(arg_4_0.heroHeadBtn2_, false)
		SetActive(arg_4_0.noneHead2_, true)
	end

	if var_4_0[2] and var_4_0[2] ~= -1 then
		arg_4_0.mostSale_.text = BackHomeCanteenFoodCfg[var_4_0[2]].name
	else
		arg_4_0.mostSale_.text = GetTips("NONE")
	end

	if var_4_0[3] and var_4_0[3] ~= -1 then
		arg_4_0.varietyCnt_.text = var_4_0[3]
	else
		arg_4_0.varietyCnt_.text = GetTips("NONE")
	end

	if var_4_0[4] and var_4_0[4] ~= -1 then
		arg_4_0.entrustCnt_.text = var_4_0[4]
	else
		arg_4_0.entrustCnt_.text = GetTips("NONE")
	end

	if var_4_0[5] and var_4_0[5] ~= -1 then
		arg_4_0.income_.text = var_4_0[5]
	else
		arg_4_0.income_.text = GetTips("NONE")
	end

	if var_4_0[6] and var_4_0[6] ~= -1 then
		SetActive(arg_4_0.heroHeadBtn_, true)
		SetActive(arg_4_0.noneHead_, false)

		arg_4_0.heroHeadIcon_.spriteSync = "TextureConfig/BackHouseUI/RoleHead/" .. var_4_0[6]
	else
		SetActive(arg_4_0.heroHeadBtn_, false)
		SetActive(arg_4_0.noneHead_, true)
	end

	if var_4_0[7] and var_4_0[7] ~= -1 then
		arg_4_0.charEntrustCnt_.text = var_4_0[7]
	else
		arg_4_0.charEntrustCnt_.text = GetTips("NONE")
	end
end

function var_0_0.CanShow(arg_5_0, arg_5_1)
	local var_5_0 = false
	local var_5_1 = DormInfomationData:GetParams(arg_5_1)

	if var_5_1[1] and var_5_1[1] ~= -1 then
		var_5_0 = true
	end

	if var_5_1[2] and var_5_1[2] ~= -1 then
		var_5_0 = true
	end

	if var_5_1[3] and var_5_1[3] ~= -1 then
		var_5_0 = true
	end

	if var_5_1[4] and var_5_1[4] ~= -1 then
		var_5_0 = true
	end

	if var_5_1[5] and var_5_1[5] ~= -1 then
		var_5_0 = true
	end

	if var_5_1[6] and var_5_1[6] ~= -1 then
		var_5_0 = true
	end

	if var_5_1[7] and var_5_1[7] ~= -1 then
		var_5_0 = true
	end

	return var_5_0
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
