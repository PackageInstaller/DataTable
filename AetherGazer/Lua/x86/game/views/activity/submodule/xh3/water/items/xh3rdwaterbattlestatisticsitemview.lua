local var_0_0 = import("game.views.battleResult.statistics.BattleStatisticsHeroItem")
local var_0_1 = class("XH3rdWaterBattleStatisticsItemView", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.haveHeroController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "haveHero")
	arg_1_0.cooperationController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "cooperation")
	arg_1_0.reportController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "report")

	arg_1_0.reportController_:SetSelectedIndex(0)

	arg_1_0.controllers_ = {
		ControllerUtil.GetController(arg_1_0.highGo1_.transform, "zero"),
		ControllerUtil.GetController(arg_1_0.highGo2_.transform, "zero"),
		ControllerUtil.GetController(arg_1_0.highGo3_.transform, "zero"),
		ControllerUtil.GetController(arg_1_0.highGo4_.transform, "zero"),
		ControllerUtil.GetController(arg_1_0.highGo5_.transform, "zero")
	}

	arg_1_0:AddBtnListener(arg_1_0.reportBtn_, nil, function()
		local var_2_0 = BattleFieldData:GetServerBattleID()

		CooperationAction.CooperationReport(arg_1_0.player_.playerID, var_2_0)
		arg_1_0.reportController_:SetSelectedIndex(1)
	end)
end

function var_0_1.SetPlayer(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7, arg_3_8)
	arg_3_0.index_ = arg_3_1
	arg_3_0.scheduleActivityId_ = arg_3_2
	arg_3_0.maxFangfan_ = arg_3_4
	arg_3_0.maxZjj_ = arg_3_5
	arg_3_0.player_ = arg_3_3
	arg_3_0.isCooperation_ = arg_3_6
	arg_3_0.extraData_ = arg_3_7

	arg_3_0:RefreshUI()

	if arg_3_8 then
		SetActive(arg_3_0.captainGo_, true)
	else
		SetActive(arg_3_0.captainGo_, false)
	end
end

function var_0_1.RefreshUI(arg_4_0)
	var_0_1.super.RefreshUI(arg_4_0)

	if arg_4_0.isCooperation_ then
		arg_4_0.cooperationController_:SetSelectedState("true")
	else
		arg_4_0.cooperationController_:SetSelectedState("false")
	end

	if not arg_4_0.player_ or not arg_4_0.heroData_ then
		arg_4_0.nickText_.text = ""

		arg_4_0.reportController_:SetSelectedState("2")

		return
	end

	if arg_4_0.isCooperation_ then
		arg_4_0.reportController_:SetSelectedState("1")

		arg_4_0.nickText_.text = arg_4_0.player_.nick
	else
		arg_4_0.reportController_:SetSelectedState("2")

		local var_4_0 = HeroCfg[arg_4_0.heroData_.id]

		arg_4_0.nickText_.text = string.format("%s·%s", var_4_0.name, var_4_0.suffix)
	end

	local var_4_1 = arg_4_0.extraData_

	if var_4_1 then
		local var_4_2 = 45
		local var_4_3 = 59

		var_4_1[var_4_2] = var_4_1[var_4_2] or 0
		var_4_1[var_4_3] = var_4_1[var_4_3] or 0

		if var_4_1[var_4_2] == 0 then
			arg_4_0.battleCountFangfanNum_.text = "0"

			arg_4_0.controllers_[4]:SetSelectedState("true")
		else
			arg_4_0.battleCountFangfanNum_.text = var_4_1[var_4_2] or 0

			arg_4_0.controllers_[4]:SetSelectedState("false")
		end

		if var_4_1[var_4_3] == 0 then
			arg_4_0.battleCountZjjNum_.text = "0"

			arg_4_0.controllers_[5]:SetSelectedState("true")
		else
			arg_4_0.battleCountZjjNum_.text = var_4_1[var_4_3] or 0

			arg_4_0.controllers_[5]:SetSelectedState("false")
		end

		arg_4_0.battleCountFangfanImg_.enabled = var_4_1[var_4_2] > arg_4_0.maxFangfan_
		arg_4_0.battleCountZjjImg_.enabled = var_4_1[var_4_3] > arg_4_0.maxZjj_
	else
		arg_4_0.battleCountFangfanNum_.text = "0"
		arg_4_0.battleCountZjjNum_.text = "0"
		arg_4_0.battleCountFangfanImg_.enabled = false
		arg_4_0.battleCountZjjImg_.enabled = false

		arg_4_0.controllers_[4]:SetSelectedState("false")
		arg_4_0.controllers_[5]:SetSelectedState("false")
	end
end

return var_0_1
