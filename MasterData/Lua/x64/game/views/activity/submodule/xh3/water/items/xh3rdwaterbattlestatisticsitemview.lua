local XH3rdWaterBattleStatisticsItemView = class("XH3rdWaterBattleStatisticsItemView", (import("game.views.battleResult.statistics.BattleStatisticsHeroItem")))

function XH3rdWaterBattleStatisticsItemView:InitUI()
	self:BindCfgUI()

	self.haveHeroController_ = ControllerUtil.GetController(self.gameObject_.transform, "haveHero")
	self.cooperationController_ = ControllerUtil.GetController(self.gameObject_.transform, "cooperation")
	self.reportController_ = ControllerUtil.GetController(self.gameObject_.transform, "report")

	self.reportController_:SetSelectedIndex(0)

	self.controllers_ = {
		ControllerUtil.GetController(self.highGo1_.transform, "zero"),
		ControllerUtil.GetController(self.highGo2_.transform, "zero"),
		ControllerUtil.GetController(self.highGo3_.transform, "zero"),
		ControllerUtil.GetController(self.highGo4_.transform, "zero"),
		ControllerUtil.GetController(self.highGo5_.transform, "zero")
	}

	self:AddBtnListener(self.reportBtn_, nil, function()
		CooperationAction.CooperationReport(self.player_.playerID, (BattleFieldData:GetServerBattleID()))
		self.reportController_:SetSelectedIndex(1)
	end)
end

function XH3rdWaterBattleStatisticsItemView:SetPlayer(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7, arg_3_8)
	self.index_ = arg_3_1
	self.scheduleActivityId_ = arg_3_2
	self.maxFangfan_ = arg_3_4
	self.maxZjj_ = arg_3_5
	self.player_ = arg_3_3
	self.isCooperation_ = arg_3_6
	self.extraData_ = arg_3_7

	self:RefreshUI()

	if arg_3_8 then
		SetActive(self.captainGo_, true)
	else
		SetActive(self.captainGo_, false)
	end
end

function XH3rdWaterBattleStatisticsItemView:RefreshUI()
	XH3rdWaterBattleStatisticsItemView.super.RefreshUI(self)

	if self.isCooperation_ then
		self.cooperationController_:SetSelectedState("true")
	else
		self.cooperationController_:SetSelectedState("false")
	end

	if not self.player_ or not self.heroData_ then
		self.nickText_.text = ""

		self.reportController_:SetSelectedState("2")

		return
	end

	if self.isCooperation_ then
		self.reportController_:SetSelectedState("1")

		self.nickText_.text = self.player_.nick
	else
		self.reportController_:SetSelectedState("2")

		self.nickText_.text = string.format("%s·%s", HeroCfg[self.heroData_.id].name, HeroCfg[self.heroData_.id].suffix)
	end

	local var_4_0 = self.extraData_

	if self.extraData_ then
		local var_4_1 = 45
		local var_4_2 = 59

		var_4_0[var_4_1] = var_4_0[45] or 0
		var_4_0[var_4_2] = var_4_0[var_4_2] or 0

		if var_4_0[var_4_1] == 0 then
			self.battleCountFangfanNum_.text = "0"

			self.controllers_[4]:SetSelectedState("true")
		else
			if not var_4_0[var_4_1] then
				self.battleCountFangfanNum_.text = 0
			end

			self.controllers_[4]:SetSelectedState("false")
		end

		if var_4_0[var_4_2] == 0 then
			self.battleCountZjjNum_.text = "0"

			self.controllers_[5]:SetSelectedState("true")
		else
			if not var_4_0[var_4_2] then
				self.battleCountZjjNum_.text = 0
			end

			self.controllers_[5]:SetSelectedState("false")
		end

		self.battleCountFangfanImg_.enabled = var_4_0[var_4_1] > self.maxFangfan_
		self.battleCountZjjImg_.enabled = var_4_0[var_4_2] > self.maxZjj_
	else
		self.battleCountFangfanNum_.text = "0"
		self.battleCountZjjNum_.text = "0"
		self.battleCountFangfanImg_.enabled = false
		self.battleCountZjjImg_.enabled = false

		self.controllers_[4]:SetSelectedState("false")
		self.controllers_[5]:SetSelectedState("false")
	end
end

return XH3rdWaterBattleStatisticsItemView
