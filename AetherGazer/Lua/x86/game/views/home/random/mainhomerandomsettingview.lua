local var_0_0 = class("MainHomeRandomSettingView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Random/RandomTabUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.pageType_ = {
		RandomHeroView,
		RandomSceneView
	}
	arg_3_0.pages_ = {}
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0.toggles_ = {}

	for iter_5_0 = 1, 2 do
		arg_5_0.toggles_[iter_5_0] = arg_5_0["toggle_" .. iter_5_0]

		arg_5_0:AddToggleListener(arg_5_0.toggles_[iter_5_0], function(arg_6_0)
			if arg_6_0 then
				arg_5_0:OpenPage(iter_5_0)
			end
		end)
	end
end

function var_0_0.CameraEnter(arg_7_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		0,
		0
	})
	manager.heroRaiseTrack.raiseModel:Finish()
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.type_ = arg_8_0.params_.type

	if arg_8_0.toggles_[arg_8_0.type_].isOn then
		arg_8_0:OpenPage(arg_8_0.type_, true)
	else
		arg_8_0.toggles_[arg_8_0.type_].isOn = true
	end
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0.curPage_:OnTop()
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0.curPage_:OnExit()
end

function var_0_0.OpenPage(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.pages_[arg_11_1]

	if not var_11_0 then
		var_11_0 = arg_11_0.pageType_[arg_11_1].New()
		arg_11_0.pages_[arg_11_1] = var_11_0

		local var_11_1 = var_11_0:UIName()
		local var_11_2 = Asset.Load(var_11_1)

		var_11_0.gameObject_ = Object.Instantiate(var_11_2, arg_11_0.gameObject_.transform)
		var_11_0.transform_ = var_11_0.gameObject_.transform

		var_11_0:Init()
	end

	if arg_11_0.curPage_ == var_11_0 then
		if arg_11_2 then
			var_11_0:OnEnter()
		end

		return
	end

	if arg_11_0.curPage_ then
		arg_11_0.curPage_:OnExit()
		SetActive(arg_11_0.curPage_.gameObject_, false)
	end

	arg_11_0.curPage_ = var_11_0

	SetActive(var_11_0.gameObject_, true)
	var_11_0:OnEnter()
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.params_ = nil

	for iter_12_0, iter_12_1 in pairs(arg_12_0.pages_) do
		iter_12_1:Dispose()
	end

	arg_12_0.pages_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
