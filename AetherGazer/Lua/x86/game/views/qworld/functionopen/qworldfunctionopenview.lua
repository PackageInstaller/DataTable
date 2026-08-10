local var_0_0 = import("game.views.qworld.hint.QWorldHintBaseView")
local var_0_1 = class("QWorldFunctionOpenView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/SandPlay/SandPlay_Unlock/SandPlay_Unlock"
end

function var_0_1.InitUI(arg_2_0)
	arg_2_0:AddUIListener()
end

function var_0_1.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btnClose_, nil, function()
		if not arg_3_0.isCanClose_ then
			return
		end

		QWorldNotifyQueue:ImmediatelyNextNotifies()
	end)
end

function var_0_1.SetData(arg_5_0, arg_5_1)
	arg_5_0.functionInfo_ = arg_5_1
end

function var_0_1.RefreshUI(arg_6_0)
	arg_6_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/SandPlay/MiniIcon/" .. arg_6_0.functionInfo_.icon)
	arg_6_0.content_.text = arg_6_0.functionInfo_.function_content
end

function var_0_1.Hide(arg_7_0)
	if arg_7_0.gameObject_ then
		SetActive(arg_7_0.gameObject_, false)
	end

	if arg_7_0.functionInfo_ then
		manager.notify:CallUpdateFunc("CheckQWorldFunctionOpen")
		manager.notify:Invoke(QWORLD_SYSTEM_OPEN, arg_7_0.functionInfo_.id)
		QWorldAction.UnlockFunction(arg_7_0.functionInfo_.id)
	end

	arg_7_0:OnHide()
end

function var_0_1.OnShow(arg_8_0)
	arg_8_0.showTimer_ = nil
	arg_8_0.showTimer_ = Timer.New(function()
		arg_8_0.isCanClose_ = true
	end, 0.5, 1)

	arg_8_0.showTimer_:Start()
	QWorldMgr:ActivePlayerControlWithMain(false)
end

function var_0_1.OnHide(arg_10_0)
	if arg_10_0.showTimer_ then
		arg_10_0.showTimer_:Stop()

		arg_10_0.showTimer_ = nil
	end

	arg_10_0.isCanClose_ = false

	QWorldMgr:ActivePlayerControlWithMain(true)
end

return var_0_1
