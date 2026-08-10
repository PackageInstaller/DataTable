local var_0_0 = class("TangramGameSmallstageItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.decodeView = arg_1_2

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.stateController = arg_2_0.controller_:GetController("default0")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddPonitListener(arg_3_0.iconImg_.gameObject, function()
		if arg_3_0.RayPointFunc then
			arg_3_0.RayPointFunc(arg_3_0)
		end
	end, function()
		return
	end)
	arg_3_0:AddPressByTimeListener(arg_3_0.iconImg_.gameObject, 0.4, function()
		return
	end, function(arg_7_0, arg_7_1, arg_7_2)
		if arg_3_0.startDragFunc then
			arg_3_0.startDragFunc(arg_3_0, arg_7_1)
		end
	end, function(arg_8_0, arg_8_1, arg_8_2)
		if arg_3_0.endDragFunc then
			arg_3_0.endDragFunc(arg_3_0, arg_8_1)
		end
	end)
	arg_3_0:AddDragListener(arg_3_0.iconImg_.gameObject, function()
		return
	end, function()
		if arg_3_0.onDragFunc then
			arg_3_0.onDragFunc(arg_3_0)
		end
	end, function()
		return
	end)
	arg_3_0:AddBtnListener(arg_3_0.iconBtn_, nil, function()
		if arg_3_0.onClickFunc then
			arg_3_0.onClickFunc(arg_3_0)
		end
	end)
end

function var_0_0.RefreshUI(arg_13_0, arg_13_1)
	arg_13_0.stageID = arg_13_1
	arg_13_0.iconImg_.sprite = getSpriteViaConfig("TangramGameStageIcon", arg_13_1)
	arg_13_0.index = TangramGameData:GetStageIDinListIndex(arg_13_1)

	if arg_13_0.index then
		SetActive(arg_13_0.gameObject_, true)

		if arg_13_0.moveFunc then
			arg_13_0.moveFunc(arg_13_0.index, arg_13_0, false)
		end

		if arg_13_0.decodeView.fiexdPosList[arg_13_0.index] then
			arg_13_0.stateController:SetSelectedState("state1")
		else
			arg_13_0.stateController:SetSelectedState("state0")
		end
	else
		SetActive(arg_13_0.gameObject_, false)
	end
end

function var_0_0.AddItemMoveFunc(arg_14_0, arg_14_1)
	arg_14_0.moveFunc = arg_14_1
end

function var_0_0.AddStartDrag(arg_15_0, arg_15_1)
	arg_15_0.startDragFunc = arg_15_1
end

function var_0_0.AddOnDrag(arg_16_0, arg_16_1)
	arg_16_0.onDragFunc = arg_16_1
end

function var_0_0.EndDrag(arg_17_0, arg_17_1)
	arg_17_0.endDragFunc = arg_17_1
end

function var_0_0.RayPoint(arg_18_0, arg_18_1)
	arg_18_0.RayPointFunc = arg_18_1
end

function var_0_0.AddOnClick(arg_19_0, arg_19_1)
	arg_19_0.onClickFunc = arg_19_1
end

function var_0_0.Dispose(arg_20_0)
	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
