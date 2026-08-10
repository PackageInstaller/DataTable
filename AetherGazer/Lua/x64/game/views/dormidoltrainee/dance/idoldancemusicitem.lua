local var_0_0 = class("DanceDIYSceneItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selectController = arg_2_0.controllers_:GetController("select")

	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.itemBtn_, nil, function()
		arg_3_0:OnClick()
	end)
end

function var_0_0.SetOnClick(arg_5_0, arg_5_1)
	arg_5_0.onClick = arg_5_1
end

function var_0_0.SetOnSelect(arg_6_0, arg_6_1)
	arg_6_0.onSelect = arg_6_1
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.music = arg_7_1

	arg_7_0:Refresh()
end

function var_0_0.SetSelected(arg_8_0, arg_8_1)
	arg_8_0.selectController:SetSelectedState(arg_8_1 and "true" or "false")
end

function var_0_0.Refresh(arg_9_0)
	local var_9_0 = IdolStageMusicCfg[arg_9_0.music]

	arg_9_0.name_.text = var_9_0.music_name
	arg_9_0.duration_.text = manager.time:DescCdTime2(IdolTraineeTools.GetMusicDuration(arg_9_0.music))
end

function var_0_0.OnClick(arg_10_0)
	if arg_10_0.onClick then
		arg_10_0.onClick(arg_10_0.music)
	end
end

function var_0_0.OnSelect(arg_11_0)
	if arg_11_0.onSelect then
		arg_11_0.onSelect(arg_11_0.music)
	end
end

return var_0_0
