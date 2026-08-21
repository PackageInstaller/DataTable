local var_0_0 = class("LetterBoxRoleItem", ReduxView)

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

	arg_3_0.isSelectedController_ = ControllerUtil.GetController(arg_3_0.transform_, "isSelected")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.normalBtn_, nil, function()
		if arg_4_0.handler_ ~= nil then
			arg_4_0.handler_(arg_4_0)
		end
	end)
end

function var_0_0.AddEventListener(arg_6_0)
	return
end

function var_0_0.UpdateView(arg_7_0)
	arg_7_0.nameText_.text = GetI18NText(arg_7_0.data_.sender)
	arg_7_0.headIcon_.sprite = ItemTools.getItemSprite(arg_7_0.data_.sender_face)

	arg_7_0.headIcon_:SetNativeSize()
end

function var_0_0.SetSelected(arg_8_0, arg_8_1)
	arg_8_0.isSelectedController_:SetSelectedState(arg_8_1 and "true" or "false")
end

function var_0_0.BindRedPoint(arg_9_0)
	manager.redPoint:bindUIandKey(arg_9_0.noticePos_, RedPointConst.LETTER_SENDER_ID .. arg_9_0.data_.id, {
		x = 0,
		y = 0
	})
end

function var_0_0.UnBindRedPoint(arg_10_0)
	manager.redPoint:unbindUIandKey(arg_10_0.noticePos_)
end

function var_0_0.SetData(arg_11_0, arg_11_1)
	arg_11_0.data_ = arg_11_1

	arg_11_0:UpdateView()
	arg_11_0:BindRedPoint()
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
