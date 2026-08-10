local var_0_0 = class("CoreVerificationChallengeRankCheckTeamPop", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_verification_new/Mode4/Core_Verification_Mode4_Popup"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stageTabs = {}
	arg_3_0.teamList = LuaList.New(function(...)
		arg_3_0:RenderTeamItem(...)
	end, arg_3_0.teamList_, CoreVerificationChallengeTeamInfoItemMode4)

	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		arg_5_0:Back()
	end)
end

local var_0_1 = 0
local var_0_2 = 100
local var_0_3 = 200

local function var_0_4(arg_8_0)
	return function(arg_9_0, arg_9_1)
		return arg_9_0.extraInfo[arg_9_1 + arg_8_0]
	end
end

local var_0_5 = var_0_4(var_0_1)
local var_0_6 = var_0_4(var_0_2)
local var_0_7 = var_0_4(var_0_3)

local function var_0_8(arg_10_0, arg_10_1)
	return arg_10_0.index < arg_10_1.index
end

local function var_0_9(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_0.stage_team_list) do
		for iter_11_2, iter_11_3 in pairs(iter_11_1) do
			local var_11_2 = var_0_5(arg_11_0, iter_11_2)
			local var_11_3 = var_11_0[var_11_2] or {}

			table.insert(var_11_3, {
				index = iter_11_2,
				stageID = var_11_2,
				heroList = iter_11_3,
				score = var_0_7(arg_11_0, iter_11_2),
				time = var_0_6(arg_11_0, iter_11_2)
			})

			var_11_0[var_11_2] = var_11_3
		end
	end

	for iter_11_4, iter_11_5 in pairs(var_11_0) do
		table.insert(var_11_1, iter_11_4)
		table.sort(iter_11_5, var_0_8)
	end

	table.sort(var_11_1)

	return var_11_0, var_11_1
end

local var_0_10 = class("CoreVerificationChallengeRankCheckTeamPop.StageTabBtn", BaseView)

function var_0_10.Ctor(arg_12_0, arg_12_1)
	arg_12_0.gameObject_ = arg_12_1
	arg_12_0.transform_ = arg_12_1.transform

	arg_12_0:BindCfgUI()

	arg_12_0.selectController = arg_12_0.controllers_:GetController("select")

	arg_12_0:AddBtnListener(arg_12_0.btn_, nil, function()
		arg_12_0:OnClick()
	end)
end

function var_0_10.OnClick(arg_14_0)
	arg_14_0.parentView:RefreshTeams(arg_14_0.stageID)
end

function var_0_10.SetData(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.parentView = arg_15_2
	arg_15_0.stageID = arg_15_1
	arg_15_0.name_.text = CoreVerificationClMode4Cfg[arg_15_0.stageID].stage_name
end

function var_0_10.SetActive(arg_16_0, arg_16_1)
	SetActive(arg_16_0.gameObject_, arg_16_1)
end

function var_0_10.SetSelect(arg_17_0, arg_17_1)
	arg_17_0.selectController:SetSelectedState(arg_17_1 and "true" or "false")
end

function var_0_0.OnEnter(arg_18_0)
	arg_18_0.groupedTeamData, arg_18_0.stageList = var_0_9(arg_18_0.params_.data)
	arg_18_0.selectStageID = arg_18_0.params_.selectStageID or arg_18_0.stageList[1]

	arg_18_0:EnsureStageTabItemCnt(#arg_18_0.stageList)

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.stageList) do
		arg_18_0.stageTabs[iter_18_0]:SetData(iter_18_1, arg_18_0)
	end

	arg_18_0:RefreshTeams(arg_18_0.selectStageID)
end

function var_0_0.OnTop(arg_19_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnBehind(arg_20_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_21_0)
	arg_21_0.teamList:Dispose()

	for iter_21_0, iter_21_1 in pairs(arg_21_0.stageTabs) do
		iter_21_1:Dispose()
	end

	arg_21_0.stageTabs = nil

	var_0_0.super.Dispose(arg_21_0)
end

function var_0_0.EnsureStageTabItemCnt(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.stageTabRoot_
	local var_22_1 = arg_22_0.stageTabBtn_
	local var_22_2 = var_0_10
	local var_22_3 = arg_22_0.stageTabs

	for iter_22_0 = var_22_0.childCount + 1, arg_22_1 do
		local var_22_4 = Object.Instantiate(var_22_1, var_22_0)
	end

	local var_22_5 = var_22_0.childCount

	for iter_22_1 = 1, var_22_5 do
		local var_22_6 = var_22_0:GetChild(iter_22_1 - 1).gameObject

		var_22_3[iter_22_1] = var_22_3[iter_22_1] or var_22_2.New(var_22_6)

		var_22_3[iter_22_1]:SetActive(iter_22_1 <= arg_22_1)
	end
end

function var_0_0.RefreshTeams(arg_23_0, arg_23_1)
	arg_23_0.selectStageID = arg_23_1

	local var_23_0 = arg_23_0.groupedTeamData[arg_23_1]

	arg_23_0.teamList:StartScroll(var_23_0 ~= nil and #var_23_0 or 0)

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.stageTabs) do
		iter_23_1:SetSelect(iter_23_1.stageID == arg_23_1)
	end
end

function var_0_0.RenderTeamItem(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = nullable(arg_24_0.groupedTeamData, arg_24_0.selectStageID, arg_24_1)

	arg_24_2:SetData(var_24_0)
end

return var_0_0
