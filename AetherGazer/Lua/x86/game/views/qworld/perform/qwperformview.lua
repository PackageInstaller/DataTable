local var_0_0 = class("QWPerformView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SandPlay/SandPlay_Furniture/SandPlay_InFurniture_HUDUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.isInView = false

	arg_4_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.exitBtn_, nil, function()
		arg_5_0:ExitPerform()
	end)
	arg_5_0:RegistEventListener(QWORLD_ENTER_PERFORM, function(arg_7_0)
		if not arg_7_0 and arg_5_0.isInView then
			arg_5_0:Back()
		end
	end)
end

function var_0_0.OnEnter(arg_8_0)
	CursorTools.LuaSwitchCursor(false)

	arg_8_0.isInView = true
end

function var_0_0.OnExit(arg_9_0)
	CursorTools.LuaSwitchCursor(true)

	arg_9_0.isInView = false
end

function var_0_0.ExitPerform(arg_10_0)
	QWorldMgr:GetQWorldPerformMgr():ForceStopPlayerPerform()
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
