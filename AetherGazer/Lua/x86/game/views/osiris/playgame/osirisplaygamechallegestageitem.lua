local var_0_0 = class("OsirisPlayGameChallegeStageItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.index = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateCon_ = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("state")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.receiveFunc_ then
			arg_4_0.receiveFunc_(arg_4_0.index)
		end
	end)
end

function var_0_0.RefreshView(arg_6_0, arg_6_1)
	local var_6_0 = ActivityGeneralityStageCfg[arg_6_1]

	arg_6_0.titleText_.text = GetI18NText(var_6_0.name)
	arg_6_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureBg/Activity_Osiris/" .. var_6_0.generality)
	arg_6_0.scoreText_.text = 0

	if var_6_0.rank_activity and var_6_0.rank_activity > 0 then
		local var_6_1 = OsirisPlayGameData:GetStageInfoById(var_6_0.stage_id)

		arg_6_0.scoreText_.text = var_6_1.point and var_6_1.point or 0
	end
end

function var_0_0.RefreshState(arg_7_0, arg_7_1)
	arg_7_0.stateCon_:SetSelectedIndex(arg_7_1)
end

function var_0_0.RegisterClickFunc(arg_8_0, arg_8_1)
	arg_8_0.receiveFunc_ = arg_8_1
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
