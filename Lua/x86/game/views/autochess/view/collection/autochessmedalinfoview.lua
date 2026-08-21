local var_0_0 = class("AutoChessMedalInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_Main/Activity_OsirisHorus_BadgePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListeners()

	arg_3_0.lockController = arg_3_0.controllers_:GetController("lock")
	arg_3_0.tabController = arg_3_0.controllers_:GetController("tab")
	arg_3_0.gotoFormationController = arg_3_0.controllers_:GetController("formation")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.leftBtn_, nil, function()
		arg_4_0:SwitchMedal(var_0_0.SwitchOp.Prev)
	end)
	arg_4_0:AddBtnListener(arg_4_0.rightBtn_, nil, function()
		arg_4_0:SwitchMedal(var_0_0.SwitchOp.Next)
	end)
	arg_4_0:AddBtnListener(arg_4_0.maskBtn_, nil, JumpTools.Back)
	arg_4_0:AddBtnListener(arg_4_0.formationBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessRecordView", {
			medalID = arg_4_0.id
		})
		OperationRecorder.RecordButtonTouch({
			source = 2,
			button_name = "activity_autochess_record_homepage_touch",
			activity_id = AutoChessData:GetActivityID()
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.tab01Btn_, nil, function()
		arg_4_0.category = AutoChessData.MedalCategory.Basic

		arg_4_0:SetData(arg_4_0.id)
	end)
	arg_4_0:AddBtnListener(arg_4_0.tab02Btn_, nil, function()
		arg_4_0.category = AutoChessData.MedalCategory.Advanced

		arg_4_0:SetData(arg_4_0.id)
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.id = arg_10_0.params_.id or arg_10_0.id or AutoChessMedalCfg.all[1]
	arg_10_0.category = arg_10_0.params_.medalLevel or arg_10_0.category or AutoChessData.MedalCategory.Basic

	arg_10_0:SetData(arg_10_0.id)
end

function var_0_0.SetData(arg_11_0, arg_11_1)
	local var_11_0 = AutoChessMedalCfg[arg_11_1]
	local var_11_1, var_11_2 = AutoChessData:IsMedalUnlocked(arg_11_1)
	local var_11_3 = var_11_1 and arg_11_0.category or AutoChessData.MedalCategory.Locked
	local var_11_4 = var_11_3 == AutoChessData.MedalCategory.Advanced

	arg_11_0:SetMedalIcon()

	arg_11_0.iconStateController_ = arg_11_0.iconController_:GetController("state")

	if var_11_3 == AutoChessData.MedalCategory.Locked then
		arg_11_0.lockController:SetSelectedState("on")
		arg_11_0.tabController:SetSelectedState("off")

		arg_11_0.condition_.text = var_11_0.unlock_desc

		arg_11_0.iconStateController_:SetSelectedState("02")
		arg_11_0.gotoFormationController:SetSelectedState("hide")

		arg_11_0.name_.text = "? ? ? ? ? ?"
	else
		local var_11_5

		arg_11_0.name_.text = var_11_0.name

		local var_11_6 = 0

		if var_11_3 == AutoChessData.MedalCategory.Basic then
			var_11_5 = var_11_0.unlock_desc
			var_11_6 = var_11_2.unlockTime

			arg_11_0.gotoFormationController:SetSelectedState("lock")
			arg_11_0.lockController:SetSelectedState("off")
			arg_11_0.iconStateController_:SetSelectedState("01")
		else
			local var_11_7 = AutoChessData.IsMedalAdvancedFromInfo(var_11_2)

			var_11_5 = var_11_0.upgrade_desc

			arg_11_0.gotoFormationController:SetSelectedState(var_11_7 and arg_11_0:IsHasGloryRecord(arg_11_1) and "unlock" or "lock")
			arg_11_0.lockController:SetSelectedState(var_11_7 and "off" or "on")
			arg_11_0.iconStateController_:SetSelectedState(var_11_7 and "03" or "04")

			var_11_6 = var_11_2.advanceTime
		end

		arg_11_0.time_.text = manager.time:DescCTime(var_11_6, "达成时间 - %Y.%m.%d")
		arg_11_0.desc_.text = var_11_0.desc
		arg_11_0.condition_.text = var_11_5

		arg_11_0.tabController:SetSelectedState(var_11_4 and "tab2" or "tab1")
	end
end

function var_0_0.IsHasGloryRecord(arg_12_0, arg_12_1)
	local var_12_0 = AutoChessData:GetRecordDataList(AutoChessConst.RECORD_TYPE.GLORY) or {}

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if iter_12_1.medalId == arg_12_1 then
			return true
		end
	end

	return false
end

function var_0_0.SetMedalIcon(arg_13_0)
	arg_13_0.iconController_ = nil

	for iter_13_0, iter_13_1 in ipairs(AutoChessMedalCfg.all) do
		if iter_13_1 == arg_13_0.id then
			arg_13_0.iconController_ = arg_13_0["controller" .. iter_13_1 .. "_"]

			SetActive(arg_13_0.iconController_.gameObject, true)
		else
			SetActive(arg_13_0["controller" .. iter_13_1 .. "_"].gameObject, false)
		end
	end
end

local function var_0_1(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_2 - arg_14_1

	if arg_14_0 < arg_14_1 then
		arg_14_0 = arg_14_0 + var_14_0 + 1
	elseif arg_14_2 < arg_14_0 then
		arg_14_0 = arg_14_0 - var_14_0 - 1
	end

	return arg_14_0
end

local function var_0_2(arg_15_0)
	return table.indexof(AutoChessMedalCfg.all, arg_15_0)
end

var_0_0.SwitchOp = {
	Next = 1,
	Prev = -1
}

function var_0_0.SwitchMedal(arg_16_0, arg_16_1)
	local var_16_0 = var_0_2(arg_16_0.id)
	local var_16_1 = var_16_0 and var_0_1(var_16_0 + arg_16_1, 1, #AutoChessMedalCfg.all) or 1

	arg_16_0.id = AutoChessMedalCfg.all[var_16_1]

	arg_16_0:SetData(arg_16_0.id)
end

return var_0_0
