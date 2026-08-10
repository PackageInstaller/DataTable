local var_0_0 = class("DormOverviewCanteenTaskModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0.levelmap = {
		"B",
		"A",
		"S"
	}

	arg_2_0:BindCfgUI()
	arg_2_0:AddBtnListener(arg_2_0.btn, nil, function()
		JumpTools.OpenPageByJump("/dormTaskDispatchView", {
			roomID = DormConst.CANTEEN_ID
		})
	end)

	arg_2_0.stateController = arg_2_0.controller:GetController("stata")
	arg_2_0.levelController = arg_2_0.controller:GetController("level")
end

function var_0_0.Render(arg_4_0, arg_4_1)
	arg_4_0:UnbindRedPoint()

	arg_4_0.pos = arg_4_1.pos
	arg_4_0.entrust = arg_4_1

	local var_4_0 = BackHomeCanteenTaskCfg[arg_4_1.id]

	arg_4_0.levelController:SetSelectedState(arg_4_0.levelmap[var_4_0.task_level])

	arg_4_0.heroList = arg_4_1.hero_list

	if #arg_4_0.heroList > 0 then
		local var_4_1 = CanteenEntrustData:CheckHasTimeOverEntrust()
		local var_4_2 = false

		for iter_4_0, iter_4_1 in ipairs(var_4_1) do
			if iter_4_1 == arg_4_0.pos then
				arg_4_0:BindRedPoint()

				var_4_2 = true
			end
		end

		arg_4_0.stateController:SetSelectedState(var_4_2 and "finish" or "sending")
	else
		arg_4_0.stateController:SetSelectedState("delegable")
	end

	DormRedPointTools:UpdateCanteenNotify()
end

function var_0_0.BindRedPoint(arg_5_0)
	manager.redPoint:bindUIandKey(arg_5_0.transform_, string.format("%s_%s", RedPointConst.CANTEEN_DISPATCH_FINISHED, arg_5_0.pos))
end

function var_0_0.UnbindRedPoint(arg_6_0)
	manager.redPoint:unbindUIandKey(arg_6_0.transform_, string.format("%s_%s", RedPointConst.CANTEEN_DISPATCH_FINISHED, arg_6_0.pos))
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:UnbindRedPoint()
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
