local var_0_0 = class("ActivityInviteHeadItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.controller = ControllerUtil.GetController(arg_2_0.transform_, "isSelected")
	arg_2_0.finishController = ControllerUtil.GetController(arg_2_0.transform_, "finish")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.headBtn_, nil, function()
		arg_3_0.delegate_(arg_3_0.index, arg_3_0.data.heroId)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.data = arg_5_1
	arg_5_0.index = arg_5_2
	arg_5_0.delegate_ = arg_5_3
	arg_5_0.selectIndex = arg_5_4

	arg_5_0:UpdateView()
end

function var_0_0.GetController(arg_6_0)
	return arg_6_0.controller
end

function var_0_0.GetFinishController(arg_7_0)
	return arg_7_0.finishController
end

function var_0_0.UpdateView(arg_8_0)
	arg_8_0.headImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" .. tostring(arg_8_0.data.image))

	local var_8_0 = InviteData:GetDataByPara("completeHeroTable")[arg_8_0.data.heroId] or {}
	local var_8_1 = HeroCfg[arg_8_0.data.heroId]

	arg_8_0.nameTxt_.text = GetI18NText(var_8_1.suffix)

	arg_8_0.controller:SetSelectedState(arg_8_0.selectIndex == arg_8_0.index and "true" or "false")
	arg_8_0.finishController:SetSelectedState(#var_8_0 == 7 and "2" or "1")
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
