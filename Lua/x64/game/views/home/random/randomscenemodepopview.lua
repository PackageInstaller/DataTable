local var_0_0 = class("RandomSceneModePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Random/RandomScenePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	for iter_5_0 = 1, 3 do
		arg_5_0:AddToggleListener(arg_5_0["connect" .. iter_5_0 .. "Tgl_"], function(arg_6_0)
			if arg_6_0 then
				arg_5_0.connectType = iter_5_0 - 1
			end
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.yesBtn_, nil, function()
		if arg_5_0.connectType and arg_5_0.connectType ~= arg_5_0.params_.type then
			HomeSceneSettingAction.SetRandomMode(arg_5_0.connectType, function()
				JumpTools.Back()
			end)
		end

		if arg_5_0.connectType == arg_5_0.params_.type then
			JumpTools.Back()
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.noBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.connectType = arg_10_0.params_.type
	arg_10_0.connectType = math.min(HomeSceneSettingConst.RANDOM_MODE.COUNT - 1, arg_10_0.connectType)
	arg_10_0["connect" .. arg_10_0.connectType + 1 .. "Tgl_"].isOn = true
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.params_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
