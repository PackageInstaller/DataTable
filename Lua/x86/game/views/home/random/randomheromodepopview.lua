local var_0_0 = class("RandomHeroModePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Random/RandomAssistantPopUI"
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

	arg_4_0.aniToggle_ = RandomSettingToggleItem.New(arg_4_0.aniToggleGo_)

	arg_4_0.aniToggle_:SetCallback(function()
		if not PlayerData:IsRandomHero() then
			ShowTips("RANDOM_MODE_SETTING_TIPS2")

			return
		end

		arg_4_0.aniBool_ = not arg_4_0.aniBool_

		arg_4_0:RefreshUI()
	end)
end

function var_0_0.AddUIListener(arg_6_0)
	for iter_6_0 = 1, 3 do
		arg_6_0:AddToggleListener(arg_6_0["connect" .. iter_6_0 .. "Tgl_"], function(arg_7_0)
			if arg_7_0 then
				arg_6_0.connectType = iter_6_0 - 1
			end
		end)
	end

	arg_6_0:AddBtnListener(arg_6_0.yesBtn_, nil, function()
		arg_6_0:SaveOrExit()
	end)
	arg_6_0:AddBtnListener(arg_6_0.noBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.connectType = arg_10_0.params_.type
	arg_10_0.connectType = math.min(HomeSceneSettingConst.RANDOM_MODE.COUNT - 1, arg_10_0.connectType)
	arg_10_0["connect" .. arg_10_0.connectType + 1 .. "Tgl_"].isOn = true
	arg_10_0.aniBool_ = PlayerData:IsRandomHeroShowEachDebutAnim()

	arg_10_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0.aniToggle_:SetValue(arg_11_0.aniBool_)
end

function var_0_0.OnExit(arg_12_0)
	return
end

function var_0_0.SaveOrExit(arg_13_0)
	if arg_13_0.connectType and arg_13_0.connectType ~= arg_13_0.params_.type then
		PlayerAction.SetRandomHeroMode(arg_13_0.connectType, function()
			arg_13_0.params_.type = arg_13_0.connectType

			arg_13_0:SaveOrExit()
		end)

		return
	end

	if arg_13_0.aniBool_ ~= PlayerData:IsRandomHeroShowEachDebutAnim() then
		PlayerAction.SetIsRandomHeroShowEachDebutAnim(not PlayerData:IsRandomHeroShowEachDebutAnim(), function()
			arg_13_0.aniBool_ = PlayerData:IsRandomHeroShowEachDebutAnim()

			arg_13_0:SaveOrExit()
		end)

		return
	end

	JumpTools.Back()
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.params_ = nil

	if arg_16_0.aniToggle_ then
		arg_16_0.aniToggle_:Dispose()

		arg_16_0.aniToggle_ = nil
	end

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
