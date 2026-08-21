local var_0_0 = class("CoreVerificationMode4StageItem", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController_ = arg_2_0.controllers_:GetController("state")

	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationChallengeStageViewMode4", {
			stageID = arg_3_0.stageID
		})
	end)
end

local var_0_1 = class("CoreVerificationMode4StageItem.TabItem", BaseView)

function var_0_1.Ctor(arg_5_0, arg_5_1)
	arg_5_0.gameObject_ = arg_5_1
	arg_5_0.transform_ = arg_5_1.transform

	arg_5_0:BindCfgUI()

	arg_5_0.stateController = arg_5_0.controllers_:GetController("state")
end

function var_0_1.SetData(arg_6_0, arg_6_1)
	if arg_6_1 > 0 then
		arg_6_0.stateController:SetSelectedState("clear")
	else
		arg_6_0.stateController:SetSelectedState("normal")
	end
end

function var_0_1.SetActive(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.EnsureItemCnt(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.teamStateList_
	local var_8_1 = arg_8_0.teamStateTag_
	local var_8_2 = var_0_1
	local var_8_3 = arg_8_0.teamTabItems

	for iter_8_0 = var_8_0.childCount + 1, arg_8_1 do
		local var_8_4 = Object.Instantiate(var_8_1, var_8_0)
	end

	local var_8_5 = var_8_0.childCount

	for iter_8_1 = 1, var_8_5 do
		local var_8_6 = var_8_0:GetChild(iter_8_1 - 1).gameObject

		var_8_3[iter_8_1] = var_8_3[iter_8_1] or var_8_2.New(var_8_6)

		var_8_3[iter_8_1]:SetActive(iter_8_1 <= arg_8_1)
	end
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.stageID = arg_9_1
	arg_9_0.index = arg_9_2

	local var_9_0 = CoreVerificationClMode4Cfg[arg_9_1]
	local var_9_1 = var_9_0.activity_id
	local var_9_2 = var_9_0.stage_type

	if arg_9_0.index_ and not isNil(arg_9_0.index_) then
		arg_9_0.index_.text = string.format("%02d", arg_9_2)
	end

	arg_9_0.name_.text = var_9_0.stage_name

	local var_9_3 = CoreVerificationChallengeMode4Data:GetStageDataByStageID(arg_9_1)

	arg_9_0.teamTabItems = {}

	arg_9_0:EnsureItemCnt(var_9_0.stage_team)

	local var_9_4 = 0

	for iter_9_0 = 1, var_9_0.stage_team do
		local var_9_5 = nullable(var_9_3, "teams", iter_9_0 - 1, "score") or 0

		var_9_4 = var_9_4 + var_9_5

		arg_9_0.teamTabItems[iter_9_0]:SetData(var_9_5)
	end

	if var_9_4 > 0 then
		arg_9_0.score_.text = var_9_4

		arg_9_0.stateController_:SetSelectedState("clear")
	else
		arg_9_0.stateController_:SetSelectedState("normal")
	end
end

function var_0_0.Dispose(arg_10_0)
	for iter_10_0 = 1, #arg_10_0.teamTabItems do
		arg_10_0.teamTabItems[iter_10_0]:Dispose()
	end

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
