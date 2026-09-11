local CoreVerificationChallengeRankCheckTeamPop = class("CoreVerificationChallengeRankCheckTeamPop", ReduxView)

function CoreVerificationChallengeRankCheckTeamPop:UIName()
	return "Widget/System/Core_verification_new/Mode4/Core_Verification_Mode4_Popup"
end

function CoreVerificationChallengeRankCheckTeamPop:UIParent()
	return manager.ui.uiPop.transform
end

function CoreVerificationChallengeRankCheckTeamPop:Init()
	self:BindCfgUI()

	self.stageTabs = {}
	self.teamList = LuaList.New(function(...)
		self:RenderTeamItem(...)
	end, self.teamList_, CoreVerificationChallengeTeamInfoItemMode4)

	self:AddUIListener()
end

function CoreVerificationChallengeRankCheckTeamPop:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
end

local function var_0_1(arg_8_0)
	return function(arg_9_0, arg_9_1)
		return arg_9_0.extraInfo[arg_9_1 + arg_8_0]
	end
end

local var_0_2 = var_0_1(0)
local var_0_3 = var_0_1(100)
local var_0_4 = var_0_1(200)

local function var_0_5(arg_10_0, arg_10_1)
	return arg_10_0.index < arg_10_1.index
end

local function var_0_6(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_0.stage_team_list) do
		for iter_11_2, iter_11_3 in pairs(iter_11_1) do
			local var_11_2 = var_0_2(arg_11_0, iter_11_2)
			local var_11_3 = var_11_0[var_11_2] or {}

			table.insert(var_11_3, {
				index = iter_11_2,
				stageID = var_11_2,
				heroList = iter_11_3,
				score = var_0_4(arg_11_0, iter_11_2),
				time = var_0_3(arg_11_0, iter_11_2)
			})

			var_11_0[var_11_2] = var_11_3
		end
	end

	for iter_11_4, iter_11_5 in pairs(var_11_0) do
		table.insert(var_11_1, iter_11_4)
		table.sort(iter_11_5, var_0_5)
	end

	table.sort(var_11_1)

	return var_11_0, var_11_1
end

local var_0_7 = class("CoreVerificationChallengeRankCheckTeamPop.StageTabBtn", BaseView)

function var_0_7:Ctor(arg_12_1)
	self.gameObject_ = arg_12_1
	self.transform_ = arg_12_1.transform

	self:BindCfgUI()

	self.selectController = self.controllers_:GetController("select")

	self:AddBtnListener(self.btn_, nil, function()
		self:OnClick()
	end)
end

function var_0_7:OnClick()
	self.parentView:RefreshTeams(self.stageID)
end

function var_0_7:SetData(arg_15_1, arg_15_2)
	self.parentView = arg_15_2
	self.stageID = arg_15_1
	self.name_.text = CoreVerificationClMode4Cfg[self.stageID].stage_name
end

function var_0_7:SetActive(arg_16_1)
	SetActive(self.gameObject_, arg_16_1)
end

function var_0_7:SetSelect(arg_17_1)
	self.selectController:SetSelectedState(arg_17_1 and "true" or "false")
end

function CoreVerificationChallengeRankCheckTeamPop:OnEnter()
	self.groupedTeamData, self.stageList = var_0_6(self.params_.data)
	self.selectStageID = self.params_.selectStageID or self.stageList[1]

	self:EnsureStageTabItemCnt(#self.stageList)

	for iter_18_0, iter_18_1 in ipairs(self.stageList) do
		self.stageTabs[iter_18_0]:SetData(iter_18_1, self)
	end

	self:RefreshTeams(self.selectStageID)
end

function CoreVerificationChallengeRankCheckTeamPop:OnTop()
	manager.windowBar:SwitchBar({})
end

function CoreVerificationChallengeRankCheckTeamPop:OnBehind()
	manager.windowBar:HideBar()
end

function CoreVerificationChallengeRankCheckTeamPop:Dispose()
	self.teamList:Dispose()

	for iter_21_0, iter_21_1 in pairs(self.stageTabs) do
		iter_21_1:Dispose()
	end

	self.stageTabs = nil

	CoreVerificationChallengeRankCheckTeamPop.super.Dispose(self)
end

function CoreVerificationChallengeRankCheckTeamPop:EnsureStageTabItemCnt(arg_22_1)
	local var_22_0 = self.stageTabs

	for iter_22_0 = self.stageTabRoot_.childCount + 1, arg_22_1 do
		local var_22_1 = Object.Instantiate(self.stageTabBtn_, self.stageTabRoot_)
	end

	for iter_22_1 = 1, self.stageTabRoot_.childCount do
		var_22_0[iter_22_1] = var_22_0[iter_22_1] or var_0_7.New(self.stageTabRoot_:GetChild(iter_22_1 - 1).gameObject)

		var_22_0[iter_22_1]:SetActive(iter_22_1 <= arg_22_1)
	end
end

function CoreVerificationChallengeRankCheckTeamPop:RefreshTeams(arg_23_1)
	self.selectStageID = arg_23_1

	self.teamList:StartScroll((self.groupedTeamData[arg_23_1] ~= nil or nil) and (#self.groupedTeamData[arg_23_1] or 0))

	for iter_23_0, iter_23_1 in ipairs(self.stageTabs) do
		iter_23_1:SetSelect(iter_23_1.stageID == arg_23_1)
	end
end

function CoreVerificationChallengeRankCheckTeamPop:RenderTeamItem(arg_24_1, arg_24_2)
	arg_24_2:SetData((nullable(self.groupedTeamData, self.selectStageID, arg_24_1)))
end

return CoreVerificationChallengeRankCheckTeamPop
