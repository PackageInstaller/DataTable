local var_0_0 = class("AutoChessPVESelectStageTabItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.clickFun_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if AutoChessTools.IsAreaUnlock(arg_3_0.areaID_) then
			if arg_3_0.clickFun_ then
				arg_3_0.clickFun_(arg_3_0.areaID_)
			end
		else
			ShowTips("AUTO_CHESS_LATTER_LEVEL_LOCKED")
		end
	end)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
	arg_5_0:InitController()
end

function var_0_0.InitController(arg_6_0)
	arg_6_0.lockController_ = arg_6_0.mainControllerEx_:GetController("lock")
	arg_6_0.selectController_ = arg_6_0.mainControllerEx_:GetController("select")
	arg_6_0.completeController_ = arg_6_0.mainControllerEx_:GetController("Completed")

	arg_6_0.lockController_:SetSelectedState("lock")
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.areaID_ = arg_7_1

	local var_7_0 = AutoChessAreaCfg[arg_7_0.areaID_]

	if not var_7_0 then
		return
	end

	arg_7_0.text2_.text = var_7_0.name

	if AutoChessTools.IsAreaUnlock(arg_7_0.areaID_) then
		if (getData("auto_chess_stage_item", "area_" .. arg_7_0.areaID_) or 0) ~= 0 then
			arg_7_0.lockController_:SetSelectedState("unlock")
		else
			local var_7_1 = 1

			saveData("auto_chess_stage_item", "area_" .. arg_7_0.areaID_, 1)

			arg_7_0.unlockTimer_ = Timer.New(function()
				if var_7_1 == 1 then
					arg_7_0.unlockAnim_:Play("U_nd01_unlook_01", 0, 0)

					var_7_1 = var_7_1 + 1
				else
					arg_7_0.lockController_:SetSelectedState("unlock")
				end
			end, 0.8, 2)

			arg_7_0.unlockTimer_:Start()
		end
	else
		arg_7_0.lockController_:SetSelectedState("lock")
	end

	if AutoChessTools.IsAreaComplete(arg_7_0.areaID_) then
		arg_7_0.completeController_:SetSelectedState("on")
	else
		arg_7_0.completeController_:SetSelectedState("off")
	end
end

function var_0_0.SetSelect(arg_9_0, arg_9_1)
	if arg_9_0.areaID_ == arg_9_1 then
		arg_9_0.selectController_:SetSelectedState("select")
	else
		arg_9_0.selectController_:SetSelectedState("notselect")
	end
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.unlockTimer_ then
		arg_10_0.unlockTimer_:Stop()

		arg_10_0.unlockTimer_ = nil
	end

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
