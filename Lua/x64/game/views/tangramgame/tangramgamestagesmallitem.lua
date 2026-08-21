local var_0_0 = class("TangramGameStageSmallItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.lockController = arg_2_0.showController:GetController("lock")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddPressByTimeListener(arg_3_0.buttonBtn_.gameObject, GameDisplayCfg.dorm_area_swap_time.value[1], function()
		if arg_3_0.clickFunc then
			arg_3_0.clickFunc(arg_3_0.roomID, arg_3_0.oriPos)
		end
	end, function(arg_5_0, arg_5_1, arg_5_2)
		if arg_3_0.startDrag then
			arg_3_0.startDrag(arg_3_0)
		end
	end, function(arg_6_0, arg_6_1, arg_6_2)
		if arg_3_0.endDrag then
			arg_3_0.endDrag(arg_3_0)
		end
	end, arg_3_0.oriPos)
	arg_3_0:AddDragListener(arg_3_0.buttonBtn_.gameObject, function()
		return
	end, function()
		if arg_3_0.onDrag then
			arg_3_0.onDrag(arg_3_0)
		end
	end, function()
		return
	end)
end

function var_0_0.RefreshUI(arg_10_0, arg_10_1)
	arg_10_0.stageID = arg_10_1

	if arg_10_0.stageID then
		local var_10_0, var_10_1 = TangramGameTools:CheckStageIsOpen(arg_10_0.stageID)

		if var_10_0 then
			arg_10_0.lockController:SetSelectedState("false")
		else
			arg_10_0.lockController:SetSelectedState("true")
		end
	end
end

function var_0_0.RegisterStartDrag(arg_11_0, arg_11_1)
	if arg_11_1 then
		arg_11_0.startDrag = arg_11_1
	end
end

function var_0_0.RegisterOnDrag(arg_12_0, arg_12_1)
	if arg_12_1 then
		arg_12_0.onDrag = arg_12_1
	end
end

function var_0_0.RegisterEndDrag(arg_13_0, arg_13_1)
	if arg_13_1 then
		arg_13_0.endDrag = arg_13_1
	end
end

function var_0_0.Dispose(arg_14_0)
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
