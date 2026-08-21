local var_0_0 = class("SeaWarfareSkillItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController_ = arg_3_0.controllerEx_:GetController("select")
	arg_3_0.lockController_ = arg_3_0.controllerEx_:GetController("lock")
	arg_3_0.recommentController_ = arg_3_0.controllerEx_:GetController("recommend")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.isLock_ then
			ShowTips("GOON_STORY_TO_GET")

			return
		end

		arg_4_0.clickCallback_(arg_4_0.skillID_)
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.skillID_ = arg_6_1
	arg_6_0.isLock_ = SeaWarfareTools.IsSkillLock(arg_6_0.skillID_)
	arg_6_0.isFirstUnLock_ = SeaWarfareTools.IsSkillFirstUnlock(arg_6_0.skillID_)

	if arg_6_0.isFirstUnLock_ then
		SeaWarfareTools.SetSkillFirstUnlockMark(arg_6_0.skillID_)
	end

	if arg_6_0.isLock_ then
		arg_6_0.lockController_:SetSelectedState("on")
	elseif arg_6_0.isFirstUnLock_ then
		arg_6_0.lockController_:SetSelectedState("on")
	else
		arg_6_0.lockController_:SetSelectedState("off")
	end

	if not arg_6_0.isLock_ then
		arg_6_0:RefreshUI()
	end

	arg_6_0:ResetAnim()
	arg_6_0:PlayAnim()
end

function var_0_0.SetSelect(arg_7_0, arg_7_1)
	arg_7_0.selectController_:SetSelectedState(arg_7_1 and "on" or "off")
end

function var_0_0.RefreshLock(arg_8_0)
	arg_8_0.isLock_ = SeaWarfareTools.IsSkillLock(arg_8_0.skillID_)

	arg_8_0.lockController_:SetSelectedState(arg_8_0.isLock_ and "on" or "off")
end

function var_0_0.SetRecommend(arg_9_0, arg_9_1)
	arg_9_0.recommentController_:SetSelectedState(arg_9_1 and not arg_9_0.isLock_ and "on" or "off")
end

function var_0_0.SetClickCallback(arg_10_0, arg_10_1)
	arg_10_0.clickCallback_ = arg_10_1
end

function var_0_0.RefreshUI(arg_11_0)
	local var_11_0 = SeaWarfareSkillCfg[arg_11_0.skillID_]

	arg_11_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/SandPlay_QuanZhou/QuanZhou_Navigation/" .. var_11_0.icon)
	arg_11_0.title_.text = var_11_0.tag
end

function var_0_0.GetSKillID(arg_12_0)
	return arg_12_0.skillID_
end

function var_0_0.PlayAnim(arg_13_0)
	if arg_13_0.isFirstUnLock_ then
		return
	end

	if not arg_13_0.isLock_ then
		arg_13_0:PlayEnterAnim()
	end
end

function var_0_0.PlayEnterAnim(arg_14_0)
	arg_14_0.enterAnimtimer_ = SeaWarfareTools.PlayAnim(arg_14_0.enterAnim_, "UI_namebg")
end

function var_0_0.PlayFirstUnlockAnim(arg_15_0)
	if arg_15_0.isFirstUnLock_ then
		arg_15_0.isFirstUnLock_ = false

		arg_15_0.lockController_:SetSelectedState("off")

		arg_15_0.unlockAnimtimer_ = SeaWarfareTools.PlayAnim(arg_15_0.unlockAnim_, "UI_QuanZhou_Navigation_Skill_Unlock")
	end
end

function var_0_0.ResetAnim(arg_16_0)
	arg_16_0.enterAnim_.enabled = false

	if arg_16_0.enterAnimtimer_ then
		arg_16_0.enterAnimtimer_:Stop()

		arg_16_0.enterAnimtimer_ = nil
	end

	arg_16_0.unlockAnim_.enabled = false

	SetActive(arg_16_0.particleGo_, false)

	if arg_16_0.unlockAnimtimer_ then
		arg_16_0.unlockAnimtimer_:Stop()

		arg_16_0.unlockAnimtimer_ = nil
	end
end

return var_0_0
