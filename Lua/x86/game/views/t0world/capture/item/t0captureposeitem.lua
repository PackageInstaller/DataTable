local var_0_0 = class("T0CapturePoseItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListener()

	arg_3_0.controller = arg_3_0.controllerEx_:GetController("state")
end

function var_0_0.AddListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.button_, nil, function()
		arg_4_0:OnPoseItemClick()
	end)
end

function var_0_0.Render(arg_6_0, arg_6_1)
	arg_6_0.switchID = arg_6_1

	local var_6_0 = T0WorldCaptureSwitchCfg[arg_6_1]

	arg_6_0.name_.text = GetI18NText(var_6_0.title)

	if T0WorldMgr:GetUseSettingByType(var_6_0.switchType) == arg_6_0.switchID then
		arg_6_0.controller:SetSelectedState("select")
	else
		arg_6_0.controller:SetSelectedState("false")
	end

	if var_6_0.switchType == T0WorldMgr.SwitchTypeEnum.Filter then
		arg_6_0.filterImg_.sprite = T0WorldTools.GetFilterImg(var_6_0.lensPicture)
	end
end

function var_0_0.OnPoseItemClick(arg_7_0)
	local var_7_0 = T0WorldCaptureSwitchCfg[arg_7_0.switchID]

	if T0WorldMgr:GetUseSettingByType(var_7_0.switchType) == arg_7_0.switchID then
		return
	end

	if var_7_0.switchType == T0WorldMgr.SwitchTypeEnum.Face then
		T0WorldMgr:SetCaptureSwitch(arg_7_0.switchID)
	else
		manager.transition:OnlyShowEffect(true, function()
			T0WorldMgr:SetCaptureSwitch(arg_7_0.switchID)
			manager.transition:OnlyShowEffect(false)
		end)
	end

	if var_7_0.voice == "" then
		return
	end

	local var_7_1 = T0WorldMgr:GetHeroID()

	HeroTools.PlaySkinTalk(var_7_1, var_7_0.voice, nil, T0WorldMgr:GetCaptureModel())
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
