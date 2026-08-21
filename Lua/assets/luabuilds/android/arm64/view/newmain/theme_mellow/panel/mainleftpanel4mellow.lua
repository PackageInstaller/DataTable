local var_0_0 = class("MainLeftPanel4Mellow", import("...base.MainFdConcealablePanel"))

function var_0_0.GetBtns(arg_1_0)
	return {
		MainCommissionBtn4Mellow.New(findTF(arg_1_0._tf, "extend"), arg_1_0.event, 0.5),
		MainHideBtn.New(findTF(arg_1_0._tf, "btns/eye"), arg_1_0.event),
		MainCameraBtn.New(findTF(arg_1_0._tf, "btns/cam"), arg_1_0.event),
		MainWordBtn.New(findTF(arg_1_0._tf, "btns/word"), arg_1_0.event),
		MainChangeSkinBtn.New(findTF(arg_1_0._tf, "btns/change"), arg_1_0.event),
		MainResetL2dBtn.New(findTF(arg_1_0._tf, "btns/l2d"), arg_1_0.event),
		MainL2dBoundBtn.New(findTF(arg_1_0._tf, "btns/l2d_bound"), arg_1_0.event)
	}
end

function var_0_0.GetDirection(arg_2_0)
	return Vector2(-1, 0)
end

function var_0_0.CalcLayout(arg_3_0)
	return
end

return var_0_0
