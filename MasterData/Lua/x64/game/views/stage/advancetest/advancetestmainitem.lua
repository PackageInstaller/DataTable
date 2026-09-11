local AdvanceTestMainItem = class("AdvanceTestMainItem", ReduxView)

function AdvanceTestMainItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
	self:InitUI()
end

function AdvanceTestMainItem:InitUI()
	self.selectController_ = ControllerUtil.GetController(self.transform_, "status")
end

function AdvanceTestMainItem:Dispose()
	AdvanceTestMainItem.super.Dispose(self)
end

function AdvanceTestMainItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self.clickFunc_ then
			self.clickFunc_(self.subStageID)
		end
	end)
end

function AdvanceTestMainItem:RefreshUI(arg_6_1, arg_6_2, arg_6_3)
	self.subStageID = arg_6_1
	self.cacheActivityID = arg_6_3

	self:SetSelectMode(self.subStageID == arg_6_2)

	local var_6_0 = AdvanceTestData:GetHistortyMaxScoreByIndex(AdvanceTestCfg[arg_6_1].stage_type, self.cacheActivityID)

	self.scoreText_.text = var_6_0 == -1 and "" or var_6_0

	local var_6_1 = AdvanceTestCfg[arg_6_1]

	self.stageText_.text = AdvanceTestCfg[arg_6_1].stage_type == 1 and string.format(GetTips("TEST_CHALLENGE_TIPS_6"), (GetTips("TEST_CHALLENGE_SS"))) or var_6_1.stage_type == 2 and string.format(GetTips("TEST_CHALLENGE_TIPS_6"), (GetTips("TEST_CHALLENGE_SSS"))) or var_6_1.stage_type == 3 and string.format(GetTips("TEST_CHALLENGE_TIPS_6"), (GetTips("TEST_CHALLENGE_OMEGA"))) or string.format(GetTips("TEST_CHALLENGE_TIPS_6"), (GetTips("TEST_CHALLENGE_SPE")))
end

function AdvanceTestMainItem:SetSelectMode(arg_7_1)
	if arg_7_1 then
		self.selectController_:SetSelectedState("selected")
	else
		self.selectController_:SetSelectedState("normal")
	end
end

function AdvanceTestMainItem:RegistClickFunc(arg_8_1)
	self.clickFunc_ = arg_8_1
end

return AdvanceTestMainItem
