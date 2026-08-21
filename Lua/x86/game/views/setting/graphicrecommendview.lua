local var_0_0 = class("GraphicRecommendView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/LoginInterface/GraphicRecommendUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.qualityIdList_ = {
		3,
		4,
		5
	}

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.toggles_ = {
		arg_4_0.lowToggle_,
		arg_4_0.middleToggle_,
		arg_4_0.highToggle_
	}
	arg_4_0.recommendIconGos_ = {
		arg_4_0.lowRecommendIconGo_,
		arg_4_0.middleRecommendIconGo_,
		arg_4_0.highRecommendIconGo_
	}
	arg_4_0.recommendTips_ = {
		GetTips("GRAPHIC_RECOMMEND_3"),
		GetTips("GRAPHIC_RECOMMEND_2"),
		GetTips("GRAPHIC_RECOMMEND_1")
	}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.okBtn_, nil, function()
		for iter_6_0, iter_6_1 in ipairs(arg_5_0.toggles_) do
			if iter_6_1.isOn then
				local var_6_0 = arg_5_0.qualityIdList_[iter_6_0]

				if arg_5_0.params_.callback ~= nil then
					arg_5_0.params_.callback(iter_6_0, var_6_0)
				end

				return
			end
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	local var_7_0 = SettingData:GetDefaultSetting()

	if GameToSDK.PLATFORM_ID == 4 then
		var_7_0 = 3
	end

	local var_7_1 = table.indexof(arg_7_0.qualityIdList_, var_7_0)

	if var_7_1 then
		SetActive(arg_7_0.recommendIconGos_[var_7_1], true)

		arg_7_0.toggles_[var_7_1].isOn = true
		arg_7_0.recommendText_.text = arg_7_0.recommendTips_[var_7_1]
	end
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
