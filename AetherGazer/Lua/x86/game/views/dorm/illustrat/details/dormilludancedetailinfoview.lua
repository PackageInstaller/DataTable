local var_0_0 = class("DormIlluDanceDetailInfoView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.OnEnter(arg_2_0, arg_2_1)
	arg_2_0:UpdateView(arg_2_1)
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0.danceID_ = 0
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.lockController_ = arg_5_0.mainControllerEx_:GetController("lock")
	arg_5_0.danceID_ = 0
end

function var_0_0.UpdateView(arg_6_0, arg_6_1)
	if arg_6_0.danceID_ == arg_6_1 then
		return
	end

	arg_6_0.danceID_ = arg_6_1
	arg_6_0.isUnlock_ = IdolTraineeData:DanceDIYActionAvailable(arg_6_0.danceID_)

	arg_6_0.lockController_:SetSelectedIndex(arg_6_0.isUnlock_ and 0 or 1)

	arg_6_0.nameText_.text = IdolDanceDIYActionCfg[arg_6_0.danceID_].name
	arg_6_0.typeText_.text = GetTips(IdolTraineeConst.style[IdolDanceDIYActionCfg[arg_6_0.danceID_].type])
	arg_6_0.beatText_.text = IdolDanceDIYActionCfg[arg_6_0.danceID_].beat
	arg_6_0.timeText_.text = manager.time:DescCDTime4(arg_6_0:TryGetActionDuration())

	if not arg_6_0.isUnlock_ then
		local var_6_0 = IdolDanceDIYActionCfg[arg_6_0.danceID_]

		if var_6_0 and var_6_0.unlock_condition then
			local var_6_1 = ConditionCfg[var_6_0.unlock_condition]

			if var_6_1 and var_6_1.desc then
				if var_6_0.need ~= 0 then
					arg_6_0.lockText_.text = string.format(GetI18NText(var_6_1.desc) .. "(%s/%s)", var_6_0.need, HistoryData:GetHistoryData(var_6_0.unlock_condition) or 0, var_6_0.need)
				else
					arg_6_0.lockText_.text = GetI18NText(var_6_1.desc)
				end
			end
		end
	end
end

function var_0_0.TryGetActionDuration(arg_7_0)
	local var_7_0 = nullable(IdolDanceDIYActionCfg, arg_7_0.danceID_, "duration")

	if var_7_0 and var_7_0 > 0 then
		return var_7_0
	end

	local var_7_1 = DormUtils.GetEntityData(DIYBridge.charaEID).cfgID

	return DanceGame.GetSequence(var_7_1, nil, arg_7_0:GetAction()).duration or 0
end

function var_0_0.GetAction(arg_8_0)
	return nullable(IdolDanceDIYActionCfg, arg_8_0.danceID_, "anime_action")
end

return var_0_0
