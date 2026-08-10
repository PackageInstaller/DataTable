local var_0_0 = class("CaptureHeroSelectModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/Module/Setting/CaptureHeroSelectModule")

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.InitContext(arg_2_0)
	arg_2_0.context = {
		skinList = CaptureGameMgr:GetCurSectionHeroList()
	}
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:InitContext()

	arg_4_0.scrollHelper = LuaList.New(handler(arg_4_0, arg_4_0.RenderItem), arg_4_0.heroHeadModule_, CaptureHeroItemModule)
	arg_4_0.onSkinChangeHandler = handler(arg_4_0, arg_4_0.OnSkinChange)
end

function var_0_0.OnEnter(arg_5_0)
	SetActive(arg_5_0.gameObject_, true)
	arg_5_0.scrollHelper:StartScroll(#arg_5_0.context.skinList)
	manager.notify:RegistListener(CAPTURE_GAME_MULTI_HERO_CHANGE, arg_5_0.onSkinChangeHandler)
end

function var_0_0.RenderItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:RenderView(arg_6_0.context.skinList[arg_6_1])
end

function var_0_0.GetCurHolderIdx(arg_7_0)
	return CaptureGameMgr:GetPlaceHolderMgr():GetCurrentSelect()
end

function var_0_0.OnSkinChange(arg_8_0)
	arg_8_0.scrollHelper:StartScroll(#arg_8_0.context.skinList)
end

function var_0_0.OnExit(arg_9_0)
	SetActive(arg_9_0.gameObject_, false)
	manager.notify:RemoveListener(CAPTURE_GAME_MULTI_HERO_CHANGE, arg_9_0.onSkinChangeHandler)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.scrollHelper:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
