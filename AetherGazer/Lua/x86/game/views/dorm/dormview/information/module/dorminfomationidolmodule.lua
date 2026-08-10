DormInfomationModuleBase = import("game.views.dorm.DormView.Information.Module.DormInfomationModuleBase")

local var_0_0 = class("DormInfomationIdolModule", DormInfomationModuleBase)

function var_0_0.ModuleName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/item/Infomation/IdolPanel"
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
		SetActive(arg_4_0.heroHeadObj_, true)

		arg_4_0.heroHeadImg_.spriteSync = "TextureConfig/BackHouseUI/RoleHead/" .. var_4_0[1]
		arg_4_0.heroInfo_.text = var_4_0[2]
	else
		SetActive(arg_4_0.heroHeadObj_, false)

		arg_4_0.heroInfo_.text = GetTips("NONE")
	end

	if var_4_0[3] ~= -1 then
		arg_4_0.maxProperty_.text = var_4_0[3]
	else
		arg_4_0.maxProperty_.text = GetTips("NONE")
	end

	if var_4_0[4] ~= -1 then
		arg_4_0.battleCnt_.text = var_4_0[4]
	else
		arg_4_0.battleCnt_.text = GetTips("NONE")
	end

	if var_4_0[5] ~= -1 then
		arg_4_0.winCnt_.text = var_4_0[5]
	else
		arg_4_0.winCnt_.text = GetTips("NONE")
	end
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
