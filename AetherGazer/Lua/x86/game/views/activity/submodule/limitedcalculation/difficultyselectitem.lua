local var_0_0 = class("DifficultSelectItem", ReduxView)
local var_0_1 = {
	[ActivityConst.SUMMER_LIMITED_CALCULATION] = 4,
	[ActivityConst.ACTIVITY_1_7_LIMITED_CALCULATION] = 4,
	[ActivityConst.ACTIVITY_2_10_LIMITED_CALCULATION] = 4
}

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

	arg_3_0.selectCon_ = ControllerUtil.GetController(arg_3_0.transform_, "select")
	arg_3_0.difficultyCon_ = ControllerUtil.GetController(arg_3_0.transform_, "difficulty")
	arg_3_0.lockController_ = ControllerUtil.GetController(arg_3_0.transform_, "lock")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.Btn_, nil, function()
		if arg_4_0.clickFun_ then
			arg_4_0.clickFun_(arg_4_0.id_)
		end
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.activityID_ = arg_7_1
	arg_7_0.id_ = arg_7_2
	arg_7_0.cfg_ = ActivityLimitCalculationCfg[arg_7_0.id_]
	arg_7_0.difficulty_ = arg_7_0.cfg_.difficulty

	arg_7_0.difficultyCon_:SetSelectedState(arg_7_0.difficulty_)

	arg_7_0.odds_.text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_POINT_RANK"), arg_7_0.cfg_.reward_point / 100)
	arg_7_0.enemyBuff_.text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_ENEMY_LEVEL"), arg_7_0.cfg_.enemy_level)
	arg_7_0.debuff_.text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_PLAYER_LEVEL"), arg_7_0.cfg_.player_level)

	local var_7_0 = false

	if var_0_1[arg_7_1] then
		local var_7_1 = LimitedCalculationData:GetDifficultyList(arg_7_1)[var_0_1[arg_7_1]]

		var_7_0 = arg_7_0.difficulty_ > var_0_1[arg_7_1] and not LimitedCalculationData:IsClearActivity(arg_7_0.activityID_, var_7_1)
	end

	if var_7_0 then
		arg_7_0.lockController_:SetSelectedState("off")
	else
		arg_7_0.lockController_:SetSelectedState("on")
	end
end

function var_0_0.SetSelected(arg_8_0, arg_8_1)
	if arg_8_0.id_ == arg_8_1 then
		arg_8_0.selectCon_:SetSelectedState("selected")
	else
		arg_8_0.selectCon_:SetSelectedState("unselect")
	end
end

function var_0_0.RegisterClickListener(arg_9_0, arg_9_1)
	arg_9_0.clickFun_ = arg_9_1
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0.clickFun_ = nil
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
