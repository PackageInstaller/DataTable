local var_0_0 = class("SailUpgradeIslandPremissItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.statusController_ = ControllerUtil.GetController(arg_2_0.transform_, "status")
end

function var_0_0.Dispose(arg_3_0)
	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.gameObject_ = nil
	arg_3_0.transform_ = nil

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.SetActive(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.ID_ = arg_5_1
	arg_5_0.activityID_ = arg_5_2

	local var_5_0 = ConditionCfg[arg_5_0.ID_]

	if var_5_0.type == 2508 then
		arg_5_0.needNum_ = 1

		local var_5_1 = var_5_0.params[1]

		arg_5_0.curNum_ = SailGameData:GetUnLockBuilding(arg_5_0.activityID_)[var_5_1] == true and 1 or 0

		local var_5_2 = SailGameBuildingCfg[var_5_0.params[1]].name

		arg_5_0.descText_.text = string.format(ConditionCfg[arg_5_0.ID_].desc, var_5_2)
	elseif var_5_0.type == 2509 then
		arg_5_0.needNum_ = var_5_0.params[1]
		arg_5_0.curNum_ = SailGameData:GetCompleteSailTimes(arg_5_0.activityID_)
		arg_5_0.descText_.text = string.format(ConditionCfg[arg_5_0.ID_].desc, var_5_0.params[1])
	end

	arg_5_0.progressText_.text = string.format("%d/%d", arg_5_0.curNum_, arg_5_0.needNum_)

	local var_5_3 = arg_5_0.curNum_ >= arg_5_0.needNum_

	arg_5_0.statusController_:SetSelectedState(var_5_3 and "on" or "off")
	arg_5_0:SetActive(true)
end

function var_0_0.IsComplete(arg_6_0)
	return arg_6_0.curNum_ >= arg_6_0.needNum_
end

return var_0_0
