local var_0_0 = class("SurviveSolo2EnterItem", ReduxView)

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

	arg_3_0.typeCon_ = ControllerUtil.GetController(arg_3_0.transform_, "type")
	arg_3_0.stateCon_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.clearCon_ = ControllerUtil.GetController(arg_3_0.transform_, "clear")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		local var_5_0 = manager.time:GetServerTime()

		if var_5_0 < arg_4_0.startTime_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(arg_4_0.startTime_)))
		elseif var_5_0 >= arg_4_0.stopTime_ then
			ShowTips("TIME_OVER")
		else
			manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. arg_4_0.activityID_, 0)

			local var_5_1 = {
				isSorted = true,
				isHideEffect = true,
				section = ActivitySoloSlayerCfg[arg_4_0.activityID_].stage_id,
				sectionType = BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO,
				activityID = arg_4_0.activityID_
			}
			local var_5_2 = ActivitySoloSlayerCfg[arg_4_0.activityID_]
			local var_5_3 = {}
			local var_5_4 = {}
			local var_5_5 = {}
			local var_5_6 = var_5_2.limit_type[1]

			if var_5_6 == 1 then
				table.insert(var_5_3, var_5_2.limit_type[2])
			elseif var_5_6 == 2 then
				table.insert(var_5_4, var_5_2.limit_type[2])

				var_5_1.recommend_type = var_5_2.limit_type[2]
			elseif var_5_6 == 3 then
				table.insert(var_5_5, var_5_2.limit_type[2])
			end

			HeroData:SaveSortValue(false, 0, var_5_5, var_5_4, var_5_3)
			arg_4_0:Go("/sectionSelectHero", var_5_1)
		end
	end)
end

function var_0_0.RefreshData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.mainActivityID_ = arg_6_1
	arg_6_0.activityID_ = arg_6_2
	arg_6_0.activityData_ = ActivityData:GetActivityData(arg_6_0.activityID_)
	arg_6_0.startTime_ = arg_6_0.activityData_.startTime
	arg_6_0.stopTime_ = arg_6_0.activityData_.stopTime

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshTime(arg_7_0, arg_7_1)
	if arg_7_1 < arg_7_0.startTime_ then
		arg_7_0.stateCon_:SetSelectedState("off")

		arg_7_0.timeLable_.text = GetTips("SOLO_NOT_OPEN")
	elseif arg_7_1 < arg_7_0.stopTime_ then
		arg_7_0.stateCon_:SetSelectedState("on")

		arg_7_0.timeLable_.text = manager.time:GetLostTimeStr2(arg_7_0.stopTime_)
	else
		arg_7_0.stateCon_:SetSelectedState("off")

		arg_7_0.timeLable_.text = GetTips("TIME_OVER")
	end
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.levelText_.text = BattleSoloSlayerCfg[ActivitySoloSlayerCfg[arg_8_0.activityID_].stage_id].name

	local var_8_0 = SurviveSoloData:GetData(arg_8_0.activityID_)

	arg_8_0.clearCon_:SetSelectedState(var_8_0 and var_8_0.time > 0 and "true" or "false")

	local var_8_1 = ActivitySoloSlayerCfg[arg_8_0.activityID_].limit_type[2]

	arg_8_0.typeCon_:SetSelectedState(var_8_1)

	local var_8_2 = manager.redPoint:getTipValue(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. arg_8_0.activityID_)

	SetActive(arg_8_0.redGo_, var_8_2 > 0)
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	arg_10_0.super.Dispose(arg_10_0)
end

return var_0_0
