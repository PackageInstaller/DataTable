local CoreVerificationMode4StageItem = class("CoreVerificationMode4StageItem", BaseView)

function CoreVerificationMode4StageItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CoreVerificationMode4StageItem:Init()
	self:BindCfgUI()

	self.stateController_ = self.controllers_:GetController("state")

	self:AddUIListener()
end

function CoreVerificationMode4StageItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationChallengeStageViewMode4", {
			stageID = self.stageID
		})
	end)
end

local var_0_1 = class("CoreVerificationMode4StageItem.TabItem", BaseView)

function var_0_1:Ctor(arg_5_1)
	self.gameObject_ = arg_5_1
	self.transform_ = arg_5_1.transform

	self:BindCfgUI()

	self.stateController = self.controllers_:GetController("state")
end

function var_0_1:SetData(arg_6_1)
	if arg_6_1 > 0 then
		self.stateController:SetSelectedState("clear")
	else
		self.stateController:SetSelectedState("normal")
	end
end

function var_0_1:SetActive(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function CoreVerificationMode4StageItem:EnsureItemCnt(arg_8_1)
	local var_8_0 = self.teamTabItems

	for iter_8_0 = self.teamStateList_.childCount + 1, arg_8_1 do
		local var_8_1 = Object.Instantiate(self.teamStateTag_, self.teamStateList_)
	end

	for iter_8_1 = 1, self.teamStateList_.childCount do
		var_8_0[iter_8_1] = var_8_0[iter_8_1] or var_0_1.New(self.teamStateList_:GetChild(iter_8_1 - 1).gameObject)

		var_8_0[iter_8_1]:SetActive(iter_8_1 <= arg_8_1)
	end
end

function CoreVerificationMode4StageItem:SetData(arg_9_1, arg_9_2)
	self.stageID = arg_9_1
	self.index = arg_9_2

	if self.index_ and not isNil(self.index_) then
		self.index_.text = string.format("%02d", arg_9_2)
	end

	self.name_.text = CoreVerificationClMode4Cfg[arg_9_1].stage_name

	local var_9_2 = CoreVerificationChallengeMode4Data:GetStageDataByStageID(arg_9_1)

	self.teamTabItems = {}

	self:EnsureItemCnt(CoreVerificationClMode4Cfg[arg_9_1].stage_team)

	local var_9_3 = 0

	for iter_9_0 = 1, CoreVerificationClMode4Cfg[arg_9_1].stage_team do
		local var_9_4 = nullable(var_9_2, "teams", iter_9_0 - 1, "score") or 0

		var_9_3 = var_9_3 + var_9_4

		self.teamTabItems[iter_9_0]:SetData(var_9_4)
	end

	if var_9_3 > 0 then
		self.score_.text = var_9_3

		self.stateController_:SetSelectedState("clear")
	else
		self.stateController_:SetSelectedState("normal")
	end
end

function CoreVerificationMode4StageItem:Dispose()
	for iter_10_0 = 1, #self.teamTabItems do
		self.teamTabItems[iter_10_0]:Dispose()
	end

	CoreVerificationMode4StageItem.super.Dispose(self)
end

return CoreVerificationMode4StageItem
