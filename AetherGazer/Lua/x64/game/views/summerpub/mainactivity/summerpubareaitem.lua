local var_0_0 = class("SummerPubAreaItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index_ = arg_1_2
	arg_1_0.selectHandler_ = arg_1_3

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController_ = arg_3_0.controllerEx_:GetController("default")
	arg_3_0.areaAnim = arg_3_0.transform_:GetChild(0):GetComponent("Animator")

	arg_3_0.selectController_:SetSelectedState("lock")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0:isUnlock() then
			if arg_4_0.selectHandler_ then
				arg_4_0.selectHandler_(arg_4_0.index_, true)
			end
		else
			ShowTips(string.format(GetTips("ERROR_ACTIVITY_ZM_GAME_PRE_MISSION_UNLOCK")))
		end
	end)
end

function var_0_0.isUnlock(arg_6_0)
	local var_6_0 = SummerPubConst.AREA_UNLOCK[arg_6_0.index_]

	if var_6_0 == 0 or SummerPubData:GetClearNumByStageID(var_6_0, SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0 then
		return true
	end

	return false
end

function var_0_0.SetSelect(arg_7_0, arg_7_1)
	if arg_7_0:isUnlock() then
		if (getData("summer_pub_main", "area_anim_" .. arg_7_0.index_) or 0) == 0 and arg_7_0.index_ ~= 1 then
			saveData("summer_pub_main", "area_anim_" .. arg_7_0.index_, 1)
			arg_7_0.selectController_:SetSelectedState("default")

			if arg_7_0.selectHandler_ then
				arg_7_0:StopTimer()

				local var_7_0 = 2

				arg_7_0.timer = Timer.New(function()
					if var_7_0 <= 0 then
						arg_7_0:StopTimer()
					end

					if var_7_0 == 2 then
						arg_7_0.areaAnim:Play("UI_areaBtn_unlok_cx", 0, 0)
					end

					if var_7_0 == 1 then
						arg_7_0.selectHandler_(arg_7_0.index_, true)
					end

					var_7_0 = var_7_0 - 1
				end, 1, 2)

				arg_7_0.timer:Start()
			end
		else
			arg_7_0.selectController_:SetSelectedState("default")

			if arg_7_1 then
				arg_7_0.selectController_:SetSelectedState("select")
			end
		end
	else
		arg_7_0.selectController_:SetSelectedState("lock")
	end
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:StopTimer()
	arg_9_0.super.Dispose(arg_9_0)
end

function var_0_0.StopTimer(arg_10_0)
	if arg_10_0.timer then
		arg_10_0.timer:Stop()

		arg_10_0.timer = nil
	end
end

return var_0_0
