local var_0_0 = class("CaptureLensCellModule", ReduxView)

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

	arg_3_0.staticCtx = {
		controller = arg_3_0.controller_:GetController("filter")
	}
	arg_3_0.context = {
		lensId = -1
	}

	arg_3_0:AddListener()
end

function var_0_0.AddListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.clickBtn_, nil, function()
		arg_4_0:OnCellClick()
	end)
end

function var_0_0.OnCellClick(arg_6_0)
	CaptureGameSettingData:SetLens(arg_6_0.context.lensId)
end

function var_0_0.Render(arg_7_0, arg_7_1)
	arg_7_0.context.lensId = arg_7_1.id

	if arg_7_1.id == -1 then
		arg_7_0.filterImg_.gameObject:SetActive(false)

		arg_7_0.description_.text = GetTips("DEFAULT_PRESET")
	else
		local var_7_0 = ActivitySwimSkinLensCfg[arg_7_1.id]

		arg_7_0.description_.text = var_7_0.description

		arg_7_0.filterImg_.gameObject:SetActive(true)

		arg_7_0.filterImg_.sprite = pureGetSpriteWithoutAtlas(CaptureGameTools:GetLensPath(arg_7_1.id))
	end

	arg_7_0.staticCtx.controller:SetSelectedState(arg_7_1.isUse and "state1" or "state0")
end

function var_0_0.OnEnter(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.staticCtx.controller = nil

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
