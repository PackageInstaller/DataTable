local var_0_0 = class("GoldMinerSelectLevelItem", ReduxView)

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

	arg_3_0.selectController_ = arg_3_0.controllerEx_:GetController("select")
	arg_3_0.stateController_ = arg_3_0.controllerEx_:GetController("state")
	arg_3_0.starController1_ = arg_3_0.starControllerEx1_:GetController("state")
	arg_3_0.starController2_ = arg_3_0.starControllerEx2_:GetController("state")
	arg_3_0.starController3_ = arg_3_0.starControllerEx3_:GetController("state")
	arg_3_0.isUnlock_ = false
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		JumpTools.OpenPageByJump("goldMinerStageSectionView", {
			activityID = arg_4_0.activityID_,
			isActivityOpen = arg_4_0.isActivityOpen_,
			isUnLock = arg_4_0.isUnlock_
		})

		if arg_4_0.selectHandler_ then
			arg_4_0.selectHandler_(arg_4_0.index_, arg_4_0.activityID_)
		end
	end)
end

function var_0_0.OnEnter(arg_6_0, arg_6_1)
	arg_6_0.activityID_ = arg_6_1
	arg_6_0.cfg_ = ActivityGodEaterGoldminerStageCfg[arg_6_0.activityID_]
	arg_6_0.nameText_.text = arg_6_0.cfg_.name

	arg_6_0:RefreshStatus()
	arg_6_0:RegistEventListener(ACTIVITY_UPDATE, handler(arg_6_0, arg_6_0.OnActivityUpdate))
end

function var_0_0.OnActivityUpdate(arg_7_0, arg_7_1)
	arg_7_0.isActivityOpen_ = ActivityData:GetActivityIsOpen(arg_7_0.activityID_)

	if arg_7_1 == arg_7_0.activityID_ then
		arg_7_0:RefreshStatus()
	end
end

function var_0_0.RefreshStatus(arg_8_0)
	arg_8_0.isActivityOpen_ = ActivityData:GetActivityIsOpen(arg_8_0.activityID_)

	if arg_8_0.isActivityOpen_ then
		local var_8_0 = table.indexof(ActivityGodEaterGoldminerStageCfg.all, arg_8_0.activityID_)

		if var_8_0 == 1 then
			arg_8_0.isUnlock_ = true

			local var_8_1 = GodEaterData:GetStageStar(arg_8_0.activityID_)

			if var_8_1 > 0 then
				arg_8_0.stateController_:SetSelectedState("complet")

				for iter_8_0 = 1, 3 do
					if iter_8_0 <= var_8_1 then
						arg_8_0["starController" .. iter_8_0 .. "_"]:SetSelectedState("light")
					else
						arg_8_0["starController" .. iter_8_0 .. "_"]:SetSelectedState("dark")
					end
				end
			else
				arg_8_0.stateController_:SetSelectedState("normal")
			end
		else
			local var_8_2 = ActivityGodEaterGoldminerStageCfg.all[var_8_0 - 1]

			if GodEaterData:GetStageStar(var_8_2) > 0 then
				arg_8_0.isUnlock_ = true

				local var_8_3 = GodEaterData:GetStageStar(arg_8_0.activityID_)

				if var_8_3 > 0 then
					arg_8_0.stateController_:SetSelectedState("complet")

					for iter_8_1 = 1, 3 do
						if iter_8_1 <= var_8_3 then
							arg_8_0["starController" .. iter_8_1 .. "_"]:SetSelectedState("light")
						else
							arg_8_0["starController" .. iter_8_1 .. "_"]:SetSelectedState("dark")
						end
					end
				else
					arg_8_0.stateController_:SetSelectedState("normal")
				end
			else
				arg_8_0.stateController_:SetSelectedState("lock")
			end
		end
	else
		arg_8_0.stateController_:SetSelectedState("lock")
	end
end

function var_0_0.RefreshSelect(arg_9_0, arg_9_1)
	if arg_9_0.isActivityOpen_ and arg_9_0.isUnlock_ and arg_9_1 == arg_9_0.activityID_ then
		arg_9_0.selectController_:SetSelectedState("true")
	else
		arg_9_0.selectController_:SetSelectedState("false")
	end
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
