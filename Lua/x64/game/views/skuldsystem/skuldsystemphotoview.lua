local var_0_0 = class("SkuldSystemPhotoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Skuld/Activity_Skuld_PhotoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	for iter_4_0 = 1, 4 do
		arg_4_0["photoItem" .. iter_4_0 .. "_"] = SkuldSystemPhotoViewItem.New(arg_4_0["photoGo" .. iter_4_0 .. "_"], iter_4_0)
	end
end

function var_0_0.AddUIListeners(arg_5_0)
	return
end

function var_0_0.OnEnter(arg_6_0)
	for iter_6_0 = 1, 4 do
		arg_6_0["photoItem" .. iter_6_0 .. "_"]:RefreshUI()
	end
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()

	for iter_8_0 = 1, 4 do
		arg_8_0["photoItem" .. iter_8_0 .. "_"]:OnExit()
	end
end

function var_0_0.Dispose(arg_9_0)
	for iter_9_0 = 1, 4 do
		arg_9_0["photoItem" .. iter_9_0 .. "_"]:Dispose()
	end

	arg_9_0.super.Dispose(arg_9_0)
end

return var_0_0
