local var_0_0 = class("AshPlotPanel", ReduxView)
local var_0_1 = "Widget/System/Activity_EkChuah/EkChuah_IllustratedUI/Panel/plotPanel"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = GameObject.Instantiate(Asset.Load(var_0_1))
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.transform_.parent = arg_1_1
	arg_1_0.transform_.localPosition = Vector3.zero
	arg_1_0.transform_.localRotation = Quaternion.identity
	arg_1_0.transform_.localScale = Vector3.zero

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.plots = {
		AshPlotModule.New(arg_2_0.plot1Obj_),
		AshPlotModule.New(arg_2_0.plot2Obj_),
		AshPlotModule.New(arg_2_0.plot3Obj_),
		(AshPlotModule.New(arg_2_0.plot4Obj_))
	}
end

function var_0_0.ExitPanel(arg_3_0, arg_3_1)
	arg_3_0.transform_.localScale = Vector3.zero
end

function var_0_0.PlayAnim(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:GetCustomSceneController()

	var_4_0:SwitchToShow()
	var_4_0:PlayHeroAnim("1083ui_dynamic", "Property_Files_2", 0.2)
end

function var_0_0.EnterPanel(arg_5_0, arg_5_1)
	arg_5_0.transform_.localScale = Vector3.one

	arg_5_0:PlayAnim(arg_5_1)

	local var_5_0 = AshSystemData:GetMomoTalkList()
	local var_5_1 = AshSystemData:GetStoryList()

	arg_5_0.plots[1]:Render(var_5_1[1], 1)
	arg_5_0.plots[2]:Render(var_5_0[1], 2)
	arg_5_0.plots[3]:Render(var_5_0[2], 3)
	arg_5_0.plots[4]:Render(var_5_1[2], 4)
end

function var_0_0.Dispose(arg_6_0)
	for iter_6_0 = 1, 4 do
		arg_6_0.plots[iter_6_0]:Dispose()
	end

	GameObject.DestroyImmediate(arg_6_0.gameObject_)
	Asset.Unload(var_0_1)
	arg_6_0.super.Dispose(arg_6_0)
end

return var_0_0
