local var_0_0 = class("CaptureLensModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/Module/Setting/CaptureFilterModule")

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.scrollHelper = LuaList.New(handler(arg_3_0, arg_3_0.RenderItem), arg_3_0.uiList_, CaptureLensCellModule)
	arg_3_0.onLensChangeHandler = handler(arg_3_0, arg_3_0.OnLensChange)
end

function var_0_0.OnEnter(arg_4_0)
	manager.notify:RegistListener(CAPTURE_GAME_LENS_UPDATE, arg_4_0.onLensChangeHandler)
	SetActive(arg_4_0.gameObject_, true)
	arg_4_0:Render()
end

function var_0_0.InitLensList(arg_5_0)
	arg_5_0.list = {}

	local var_5_0 = CaptureGameSettingData:GetLens()

	table.insert(arg_5_0.list, {
		id = -1,
		isUse = var_5_0 == -1
	})

	for iter_5_0, iter_5_1 in ipairs(ActivitySwimSkinLensCfg.all) do
		local var_5_1 = ActivitySwimSkinLensCfg[iter_5_1]

		table.insert(arg_5_0.list, {
			id = var_5_1.lensId,
			imgPath = var_5_1.imgPath,
			isUse = var_5_0 == var_5_1.lensId
		})
	end
end

function var_0_0.Render(arg_6_0)
	arg_6_0:InitLensList()
	arg_6_0.scrollHelper:StartScroll(#arg_6_0.list)
end

function var_0_0.RenderItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:Render(arg_7_0.list[arg_7_1])
end

function var_0_0.OnLensChange(arg_8_0)
	arg_8_0:Render()
end

function var_0_0.OnExit(arg_9_0)
	manager.notify:RemoveListener(CAPTURE_GAME_LENS_UPDATE, arg_9_0.onLensChangeHandler)
	SetActive(arg_9_0.gameObject_, false)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.scrollHelper:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
