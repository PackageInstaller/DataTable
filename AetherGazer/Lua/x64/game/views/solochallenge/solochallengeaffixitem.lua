local var_0_0 = class("SoloChallengeAffixItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.selectController_ = ControllerUtil.GetController(arg_2_0.transform_, "select")
	arg_2_0.lockStateController_ = ControllerUtil.GetController(arg_2_0.transform_, "lock")
	arg_2_0.equipController_ = ControllerUtil.GetController(arg_2_0.transform_, "equiped")
	arg_2_0.addController_ = ControllerUtil.GetController(arg_2_0.transform_, "add")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.extra_ == false then
			JumpTools.OpenPageByJump("soloChallengeAffix", {
				activityID = arg_4_0.activityID_,
				affixID = arg_4_0.affixID_,
				pos = arg_4_0.pos_,
				stageID = arg_4_0.stageID_
			})

			return
		end

		arg_4_0:SetSelect(true)
	end)

	if arg_4_0.toggle_ ~= nil then
		arg_4_0:AddToggleListener(arg_4_0.toggle_, function(arg_6_0)
			if arg_4_0.selectController_ ~= nil then
				if arg_6_0 then
					arg_4_0.selectController_:SetSelectedState("on")
				else
					arg_4_0.selectController_:SetSelectedState("off")
				end
			end
		end)
	end
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.activityID_ = arg_7_1
	arg_7_0.affixID_ = arg_7_2

	if arg_7_3 ~= nil then
		arg_7_0.toggle_.group = arg_7_3
		arg_7_0.extra_ = true
	else
		arg_7_0.extra_ = false
	end
end

function var_0_0.SetState(arg_8_0, arg_8_1)
	arg_8_0.stageID_ = arg_8_1.stageID
	arg_8_0.pos_ = arg_8_1.pos

	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	if arg_9_0.extra_ then
		arg_9_0:RefreshFightOrder()
	end

	arg_9_0:RefreshLockState()
	arg_9_0:RefreshAffixImage()
	arg_9_0:RefreshEquipState()
end

function var_0_0.RefreshFightOrder(arg_10_0)
	local var_10_0 = SoloChallengeData:GetSelectedDifficultyIndex(arg_10_0.activityID_)

	if arg_10_0.stageID_ ~= -1 then
		local var_10_1 = table.keyof(ActivitySoloChallengeCfg[arg_10_0.activityID_].stage_id[var_10_0][2], arg_10_0.stageID_)

		if var_10_1 ~= nil then
			arg_10_0.orderText_.text = var_10_1
		end
	end
end

function var_0_0.RefreshAffixImage(arg_11_0)
	local var_11_0 = false

	if arg_11_0.affixID_ ~= 0 then
		arg_11_0.icon_.sprite = getAffixSprite(ActivityAffixPoolCfg[arg_11_0.affixID_].affix)
		var_11_0 = true
	end

	if arg_11_0.addController_ ~= nil then
		arg_11_0.addController_:SetSelectedState(tostring(var_11_0))
	end
end

function var_0_0.RefreshEquipState(arg_12_0)
	if arg_12_0.equipController_ ~= nil then
		if arg_12_0.stageID_ ~= -1 then
			arg_12_0.equipController_:SetSelectedState("on")
		else
			arg_12_0.equipController_:SetSelectedState("off")
		end
	end
end

function var_0_0.RefreshLockState(arg_13_0)
	local var_13_0 = false
	local var_13_1 = SoloChallengeData:GetCompletedStageList(arg_13_0.activityID_)
	local var_13_2 = SoloChallengeData:GetSelectedDifficultyIndex(arg_13_0.activityID_)

	if table.keyof(var_13_1[var_13_2], arg_13_0.stageID_) then
		var_13_0 = true
	end

	if var_13_0 then
		arg_13_0.btn_.interactable = false
	else
		arg_13_0.btn_.interactable = true
	end

	if arg_13_0.extra_ and arg_13_0.lockStateController_ ~= nil then
		if var_13_0 then
			arg_13_0.lockStateController_:SetSelectedState("lock")
		else
			arg_13_0.lockStateController_:SetSelectedState("unlock")
		end
	end
end

function var_0_0.SetSelect(arg_14_0, arg_14_1)
	if arg_14_1 == nil then
		return
	end

	if arg_14_0.toggle_ then
		arg_14_0.toggle_.isOn = arg_14_1
	end

	if arg_14_1 == true and arg_14_0.selectCallBack_ then
		arg_14_0.selectCallBack_(arg_14_0.affixID_, arg_14_0.pos_)
	end
end

function var_0_0.RegistSelectCallBack(arg_15_0, arg_15_1)
	arg_15_0.selectCallBack_ = arg_15_1
end

function var_0_0.Dispose(arg_16_0)
	Object.Destroy(arg_16_0.gameObject_)

	arg_16_0.transform_ = nil
	arg_16_0.gameObject_ = nil
	arg_16_0.selectCallBack_ = nil
	arg_16_0.selectController_ = nil
	arg_16_0.lockStateController_ = nil
	arg_16_0.equipController_ = nil

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
