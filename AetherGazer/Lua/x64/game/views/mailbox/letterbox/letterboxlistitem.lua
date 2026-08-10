local var_0_0 = class("LetterBoxListItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	arg_2_0:AddEventListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.posController_ = ControllerUtil.GetController(arg_3_0.transform_, "pos")
	arg_3_0.readController_ = ControllerUtil.GetController(arg_3_0.transform_, "read")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.normalBtn_, nil, function()
		if arg_4_0.handler_ ~= nil then
			arg_4_0.handler_(arg_4_0)
		end
	end)
end

function var_0_0.AddEventListener(arg_6_0)
	arg_6_0:RegistEventListener(LETTER_READ_UPDATE, handler(arg_6_0, arg_6_0.OnLetterReadUpdate))
end

function var_0_0.OnLetterReadUpdate(arg_7_0, arg_7_1)
	if arg_7_1 == arg_7_0.data_.id then
		arg_7_0:UpdateView()
	end
end

function var_0_0.UpdateView(arg_8_0)
	local var_8_0 = string.split(arg_8_0.data_.send_time, ",")

	arg_8_0.yearText_.text = var_8_0[1]
	arg_8_0.monthText_.text = string.format("%02d", var_8_0[2])
	arg_8_0.dayText_.text = var_8_0[3]

	arg_8_0.readController_:SetSelectedState(arg_8_0.data_.isViewed and "read" or "unread")

	arg_8_0.titleText_.text = GetI18NText(arg_8_0.data_.title)
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.data_ = arg_9_2

	arg_9_0.posController_:SetSelectedState(arg_9_1 % 2 == 1 and "down" or "up")
	arg_9_0:UpdateView()
	arg_9_0:BindRedPoint()
end

function var_0_0.BindRedPoint(arg_10_0)
	manager.redPoint:bindUIandKey(arg_10_0.noticePos_, RedPointConst.LETTER_ID .. arg_10_0.data_.id)
end

function var_0_0.UnBindRedPoint(arg_11_0)
	manager.redPoint:unbindUIandKey(arg_11_0.noticePos_)
end

function var_0_0.GetData(arg_12_0)
	return arg_12_0.data_
end

function var_0_0.OnEnter(arg_13_0)
	return
end

function var_0_0.OnExit(arg_14_0)
	return
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0:UnBindRedPoint()
	arg_15_0:RemoveAllListeners()
	arg_15_0:RemoveAllEventListener()
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
