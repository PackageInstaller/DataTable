local var_0_0 = class("NewChessTipsItem")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	ComponentBinder.GetInstance():BindCfgUI(arg_3_0, arg_3_0.gameObject_)

	arg_3_0.typeController_ = ControllerUtil.GetController(arg_3_0.transform_, "status")
	arg_3_0.switchDiceController_ = ControllerUtil.GetController(arg_3_0.switchDiceTrans_, "point")
	arg_3_0.diceController_ = ControllerUtil.GetController(arg_3_0.getDiceTrans_, "point")
	arg_3_0.buffItem_ = NewWarChessTipsBuffItem.New(arg_3_0.buffGo_)
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.typeController_:SetSelectedIndex(arg_4_1.tipsType)

	arg_4_0.text_.text = arg_4_1.tipsText

	if arg_4_1.tipsType == NewChessConst.TIPS_TYPE.SWITCH then
		arg_4_0.switchDiceController_:SetSelectedIndex(arg_4_1.tipsDiceNum)
	elseif arg_4_1.tipsType == NewChessConst.TIPS_TYPE.DICE then
		arg_4_0.diceController_:SetSelectedIndex(arg_4_1.tipsDiceNum)
		manager.audio:PlayEffect("minigame_activity_2_6_grid", "minigame_activity_2_6_grid_getdice", "")
	elseif arg_4_1.tipsType == NewChessConst.TIPS_TYPE.BUFF then
		arg_4_0.buffItem_:SetData(1, 0, arg_4_1.tipsBuffEntity)
	end
end

function var_0_0.SetDisposeHandler(arg_5_0, arg_5_1)
	arg_5_0.disposeHandler_ = arg_5_1
end

function var_0_0.SetIsShow(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)

	arg_6_0.isShow_ = arg_6_1

	if arg_6_1 then
		arg_6_0.transform_:SetAsLastSibling()
		arg_6_0:StartTimer()
	end
end

function var_0_0.StartTimer(arg_7_0)
	if arg_7_0.timer_ == nil then
		arg_7_0.timer_ = Timer.New(function()
			arg_7_0:StopTimer()
			arg_7_0:SetIsShow(false)
			arg_7_0.disposeHandler_(arg_7_0.tipsinfo_)
		end, 3, 1)
	end

	arg_7_0.timer_:Start()
end

function var_0_0.StopTimer(arg_9_0)
	if arg_9_0.timer_ then
		arg_9_0.timer_:Stop()

		arg_9_0.timer_ = nil
	end
end

function var_0_0.GetIsShow(arg_10_0)
	return arg_10_0.isShow_
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:StopTimer()

	arg_11_0.disposeHandler_ = nil

	Object.Destroy(arg_11_0.gameObject_)
	arg_11_0.buffItem_:Dispose()
end

return var_0_0
