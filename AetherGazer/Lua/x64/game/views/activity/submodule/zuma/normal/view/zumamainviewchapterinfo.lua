local var_0_0 = class("ZumaMainViewChapterInfo", ReduxView)

var_0_0.controllerListEnum = {
	btnState = {
		before = "state2",
		name = "btn",
		unOpen = "state1",
		canOpen = "state0"
	},
	diffcultState = {
		night = "state1",
		name = "diffcultShow",
		normal = "state0"
	},
	rewardState = {
		repeatShow = "repeat_show",
		name = "rewardState",
		firstGet = "first_get",
		firstShow = "first_show"
	}
}

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.btnStateController = arg_3_0.controllerexcollection_:GetController(var_0_0.controllerListEnum.btnState.name)
	arg_3_0.diffcultShowController = arg_3_0.controllerexcollection_:GetController(var_0_0.controllerListEnum.diffcultState.name)
	arg_3_0.rewardStateController = arg_3_0.controllerexcollection_:GetController(var_0_0.controllerListEnum.rewardState.name)
	arg_3_0.conditionList = {}

	for iter_3_0 = 1, 3 do
		arg_3_0.conditionList[iter_3_0] = ZumaConditionItem.New(arg_3_0[string.format("condition%sGo_", iter_3_0)])
	end

	arg_3_0.rewardIcon1_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
	arg_3_0.rewardIcon2_.sprite = ItemTools.getItemSprite(ZumaConst.TalentCostID)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.ChanllengeBtn_, nil, function()
		ZumaAction.PlayZumaGame(arg_4_0.selectZumaID)
	end)
end

function var_0_0.IsShowPanel(arg_6_0, arg_6_1)
	arg_6_0.isShow = arg_6_1

	SetActive(arg_6_0.gameObject_, arg_6_1)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:UpdateBtnController()
end

function var_0_0.RefreshUI(arg_8_0, arg_8_1)
	ZumaData:SetZumaRead(arg_8_1.activity_id)

	arg_8_0.selectZumaID = arg_8_1.id
	arg_8_0.selectZumaActID = arg_8_1.activity_id

	arg_8_0:IsShowPanel(true)

	arg_8_0.nameText_.text = arg_8_1.name

	local var_8_0 = arg_8_1.difficult

	if var_8_0 == ZumaConst.ZUMA_DIFFICULT.ESAY then
		arg_8_0.difficultText_.text = GetTips("ACTIVITY_ZUMA_LEVEL_DIFFICULTY_1")
	elseif var_8_0 == ZumaConst.ZUMA_DIFFICULT.HARD then
		arg_8_0.difficultText_.text = GetTips("ACTIVITY_ZUMA_LEVEL_DIFFICULTY_2")
	elseif var_8_0 == ZumaConst.ZUMA_DIFFICULT.NIGHT then
		arg_8_0.difficultText_.text = GetTips("ACTIVITY_ZUMA_LEVEL_DIFFICULTY_3")
	end

	local var_8_1 = ZumaData:GetZumaStageScore(arg_8_1.id)

	arg_8_0.rank1Text_.text = var_8_1 and var_8_1 or GetTips("ACTIVITY_ZUMA_NO_DATA")
	arg_8_0.rank2Text_.text = var_8_1 and var_8_1 or GetTips("ACTIVITY_ZUMA_NO_DATA")
	arg_8_0.firstRewardText_.text = arg_8_1.first_reward
	arg_8_0.repeatRewardText_.text = arg_8_1.repeat_reward

	arg_8_0:UpdateTaskList(arg_8_1.activity_point_reward, var_8_1 or 0)
	arg_8_0:UpdateBtnController()
	arg_8_0:UpdateDifficultController()
	arg_8_0:UpdateRewardController()
end

function var_0_0.UpdateBtnController(arg_9_0)
	local var_9_0 = arg_9_0.selectZumaID

	if not var_9_0 then
		return
	end

	local var_9_1 = ActivityData:GetActivityData(arg_9_0.selectZumaActID)

	arg_9_0:StopTimer()

	if not var_9_1 or not var_9_1:IsActivitying() then
		arg_9_0.btnStateController:SetSelectedState(var_0_0.controllerListEnum.btnState.unOpen)
		arg_9_0:AddTimer()
	elseif ZumaData:GetZumaBeforeIsFinish(var_9_0) then
		arg_9_0.btnStateController:SetSelectedState(var_0_0.controllerListEnum.btnState.canOpen)
	else
		arg_9_0.btnStateController:SetSelectedState(var_0_0.controllerListEnum.btnState.before)

		arg_9_0.btnLockText1_.text = GetTips("ACTIVITY_ZUMA_OPEN_FRONT")
		arg_9_0.btnLockText2_.text = GetTips("ACTIVITY_ZUMA_OPEN_FRONT")
	end
end

function var_0_0.AddTimer(arg_10_0)
	arg_10_0:StopTimer()
	arg_10_0:RefreshTime()

	arg_10_0.timer_ = Timer.New(function()
		arg_10_0:RefreshTime()
	end, 1, -1)

	arg_10_0.timer_:Start()
end

function var_0_0.RefreshTime(arg_12_0)
	local var_12_0 = ZumaData:GetZumaStageOpenTime(arg_12_0.selectZumaID)

	if var_12_0 then
		arg_12_0.btnLockText1_.text = var_12_0
		arg_12_0.btnLockText2_.text = var_12_0
	end
end

function var_0_0.StopTimer(arg_13_0)
	if arg_13_0.timer_ then
		arg_13_0.timer_:Stop()

		arg_13_0.timer_ = nil
	end
end

function var_0_0.UpdateDifficultController(arg_14_0)
	local var_14_0 = arg_14_0.selectZumaID

	if not var_14_0 then
		return
	end

	if ActivityZumaLevelCfg[var_14_0].difficult == 3 then
		arg_14_0.diffcultShowController:SetSelectedState(var_0_0.controllerListEnum.diffcultState.night)
	else
		arg_14_0.diffcultShowController:SetSelectedState(var_0_0.controllerListEnum.diffcultState.normal)
	end
end

function var_0_0.UpdateRewardController(arg_15_0)
	local var_15_0 = arg_15_0.selectZumaID

	if not var_15_0 then
		return
	end

	local var_15_1 = ActivityZumaLevelCfg[var_15_0].difficult
	local var_15_2 = ZumaData:GetZumaStageScore(var_15_0)

	if var_15_1 == 3 and var_15_2 then
		arg_15_0.rewardStateController:SetSelectedState(var_0_0.controllerListEnum.rewardState.firstGet)
	elseif var_15_2 then
		arg_15_0.rewardStateController:SetSelectedState(var_0_0.controllerListEnum.rewardState.repeatShow)
	else
		arg_15_0.rewardStateController:SetSelectedState(var_0_0.controllerListEnum.rewardState.firstShow)
	end
end

function var_0_0.UpdateTaskList(arg_16_0, arg_16_1, arg_16_2)
	for iter_16_0, iter_16_1 in pairs(arg_16_1) do
		arg_16_0.conditionList[iter_16_0]:RefreshConditionState(iter_16_1, arg_16_2)
	end
end

function var_0_0.OnExit(arg_17_0)
	arg_17_0:StopTimer()
end

function var_0_0.Dispose(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.conditionList) do
		iter_18_1:Dispose()
	end

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
