local var_0_0 = class("PushBoxItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.dirctMap_ = {
		"up",
		"right",
		"down",
		"left"
	}
	arg_3_0.selectCon_ = ControllerUtil.GetController(arg_3_0.transform_, "status")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddPressByTimeListener(arg_4_0.gameObject_, 0.1, function()
		manager.notify:Invoke(PUSH_BOX_SELECT, arg_4_0.index_)
	end, function(arg_6_0, arg_6_1, arg_6_2)
		manager.notify:Invoke(PUSH_BOX_SELECT, arg_4_0.index_)

		arg_4_0.pressPos_ = arg_6_1.position
	end, function(arg_7_0, arg_7_1, arg_7_2)
		arg_4_0.endPos_ = arg_7_1.position

		if arg_4_0.dragFunc_ then
			arg_4_0.dragFunc_(arg_4_0.pressPos_, arg_4_0.endPos_)
		end
	end, arg_4_0.index_)
end

function var_0_0.OnEnter(arg_8_0)
	return
end

function var_0_0.SetData(arg_9_0, arg_9_1)
	arg_9_0.isLock_ = false
	arg_9_0.index_ = arg_9_1

	arg_9_0:StopAni()
end

function var_0_0.SetPos(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	arg_10_0.dirct_ = 0
	arg_10_0.coordinateX_ = arg_10_1
	arg_10_0.coordinateY_ = arg_10_2
	arg_10_0.transform_.localPosition = Vector3.New(arg_10_3, arg_10_4, arg_10_0.transform_.localPosition.z)
end

function var_0_0.GetCoordinate(arg_11_0)
	return arg_11_0.coordinateX_, arg_11_0.coordinateY_
end

function var_0_0.SetSelect(arg_12_0, arg_12_1)
	arg_12_0.selectCon_:SetSelectedState(arg_12_1 and "click" or "normal")

	if arg_12_1 then
		local var_12_0, var_12_1, var_12_2, var_12_3 = PushBoxTool:GetCanPassDir(arg_12_0.index_)

		SetActive(arg_12_0.uGo_, var_12_0)
		SetActive(arg_12_0.dGo_, var_12_1)
		SetActive(arg_12_0.lGo_, var_12_2)
		SetActive(arg_12_0.rGo_, var_12_3)
	end
end

function var_0_0.StopAni(arg_13_0)
	arg_13_0.dirct_ = 0

	arg_13_0.ani_:Play("idle", -1, 0)
end

function var_0_0.PlayDirct(arg_14_0, arg_14_1)
	arg_14_0.selectCon_:SetSelectedState("normal")

	local var_14_0 = 0
	local var_14_1 = arg_14_1[1]
	local var_14_2 = arg_14_1[2]

	if var_14_1 == 0 and var_14_2 == 1 then
		local var_14_3 = 1
	elseif var_14_1 == 1 and var_14_2 == 0 then
		local var_14_4 = 2
	elseif var_14_1 == 0 and var_14_2 == -1 then
		local var_14_5 = 3
	elseif var_14_1 == -1 and var_14_2 == 0 then
		local var_14_6 = 4
	end
end

function var_0_0.SetLock(arg_15_0, arg_15_1)
	arg_15_0.isLock_ = arg_15_1
end

function var_0_0.IsLock(arg_16_0)
	return arg_16_0.isLock_
end

function var_0_0.GetCoordinate(arg_17_0)
	return arg_17_0.coordinateX_, arg_17_0.coordinateY_
end

function var_0_0.SetSize(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1 / arg_18_0.transform_.rect.width

	arg_18_0.rect_.localScale = Vector2.New(var_18_0, var_18_0)
end

function var_0_0.RegistDragFunc(arg_19_0, arg_19_1)
	arg_19_0.dragFunc_ = arg_19_1
end

function var_0_0.OnExit(arg_20_0)
	return
end

function var_0_0.Dispose(arg_21_0)
	arg_21_0:RemoveAllListeners()
	arg_21_0.super.Dispose(arg_21_0)
end

return var_0_0
