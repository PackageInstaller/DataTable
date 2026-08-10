local var_0_0 = class("T0CaptureModule", ReduxView)
local var_0_1 = "Widget/System/Main_T0SceneGame/%s/FilterModule"
local var_0_2 = "Widget/System/Main_T0SceneGame/%s/PoseModule"

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0

	if arg_1_2 == 3 then
		var_1_0 = Asset.Load(string.format(var_0_1, T0WorldMgr:GetHeroID()))
	else
		var_1_0 = Asset.Load(string.format(var_0_2, T0WorldMgr:GetHeroID()))
	end

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.switchType = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	if arg_3_0.switchType == 3 then
		arg_3_0.scrollHelper = LuaList.New(handler(arg_3_0, arg_3_0.RenderItem), arg_3_0.uiList_, T0CapturePoseItem)
	else
		arg_3_0.scrollHelper = LuaList.New(handler(arg_3_0, arg_3_0.RenderItem), arg_3_0.poseList_, T0CapturePoseItem)
	end
end

function var_0_0.OnEnter(arg_4_0)
	SetActive(arg_4_0.gameObject_, true)
	arg_4_0:Render()
end

function var_0_0.Render(arg_5_0)
	arg_5_0:InitList()
	arg_5_0.scrollHelper:StartScroll(#arg_5_0.switchList)
end

function var_0_0.InitList(arg_6_0)
	local var_6_0 = T0WorldMgr:GetHeroID()

	arg_6_0.switchList = T0WorldMgr:GetCaptureSwitchList(T0WorldMgr:GetUseSceneType(), arg_6_0.switchType, var_6_0)
end

function var_0_0.RenderItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:Render(arg_7_0.switchList[arg_7_1])
end

function var_0_0.OnExit(arg_8_0)
	SetActive(arg_8_0.gameObject_, false)
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.scrollHelper:Dispose()
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
