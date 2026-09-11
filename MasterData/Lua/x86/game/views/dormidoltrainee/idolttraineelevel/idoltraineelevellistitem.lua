local IdolTraineeLevelListItem = class("IdolTraineeLevelListItem", ReduxView)

function IdolTraineeLevelListItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function IdolTraineeLevelListItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.stateController_ = self.mainControllerEx_:GetController("state")
end

function IdolTraineeLevelListItem:AddUIListener()
	self:AddBtnListener(self.challengeBtn_, nil, function()
		self.timer = Timer.New(handler(self, function()
			if not IdolTraineeCampBridge.cinemachineBrain.IsBlending then
				JumpTools.OpenPageByJump("/idolTraineeEnterBattleView", {
					pvpBattle_ = false,
					stageID = self.stageID
				})
			end
		end), 0.34, 1):Start()
	end)
end

function IdolTraineeLevelListItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.stageID = arg_6_1

	local var_6_0 = IdolTraineePveBattleCfg[arg_6_1]
	local var_6_1 = IdolTraineeTools:GetChapterScoreList(arg_6_3)
	local var_6_2

	if var_6_1 then
		var_6_2 = var_6_1[arg_6_1]
	end

	if not var_6_2 then
		self.stateController_:SetSelectedState("lock")
	elseif not var_6_2.pass then
		self.stateController_:SetSelectedState("unlock")
	else
		self.stateController_:SetSelectedState("complete")

		self.score_.text = var_6_2.score
	end

	self.levelID_.text = arg_6_3 .. "-" .. arg_6_2
	self.levelName_.text = var_6_0.name
end

function IdolTraineeLevelListItem:Dispose()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	IdolTraineeLevelListItem.super.Dispose(self)
end

return IdolTraineeLevelListItem
