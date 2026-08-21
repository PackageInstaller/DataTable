local var_0_0 = class("SeaWarfareMarinerItem", ReduxView)

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

	arg_3_0.lockController_ = arg_3_0.controllerEx_:GetController("lock")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.isLock_ then
			ShowTips("GOON_STORY_TO_GET")
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.marinerID_ = arg_6_1
	arg_6_0.isLock_ = SeaWarfareTools.IsSkillLock(arg_6_0.marinerID_)
	arg_6_0.isFirstUnLock_ = SeaWarfareTools.IsSkillFirstUnlock(arg_6_0.marinerID_)

	if arg_6_0.isFirstUnLock_ then
		SeaWarfareTools.SetSkillFirstUnlockMark(arg_6_0.marinerID_)
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

	SetActive(arg_6_0.gameObject_, false)
	arg_6_0:ResetAnim()
end

function var_0_0.RefreshLock(arg_7_0)
	arg_7_0.isLock_ = SeaWarfareTools.IsSkillLock(arg_7_0.marinerID_)

	arg_7_0.lockController_:SetSelectedState(arg_7_0.isLock_ and "on" or "off")
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = SeaWarfareSkillCfg[arg_8_0.marinerID_]

	arg_8_0.icon_.sprite = getSpriteViaConfig("DormHeroHeadIcon", var_8_0.icon)
	arg_8_0.bulletIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/SandPlay_QuanZhou/QuanZhou_Navigation/" .. var_8_0.icon_bullet)
	arg_8_0.desc_.text = var_8_0.desc
end

function var_0_0.PlayAnim(arg_9_0)
	SetActive(arg_9_0.gameObject_, true)

	if arg_9_0.isFirstUnLock_ then
		arg_9_0:PlayFirstUnlockAnim()
	elseif arg_9_0.isLock_ then
		arg_9_0:PlayLockAnim()
	else
		arg_9_0:PlayEnterAnim()
	end
end

function var_0_0.PlayLockAnim(arg_10_0)
	arg_10_0.unlockAnim_.enabled = true

	arg_10_0.unlockAnim_:Update(9999)
end

function var_0_0.PlayEnterAnim(arg_11_0)
	arg_11_0.unlockAnim_.enabled = true
end

function var_0_0.PlayFirstUnlockAnim(arg_12_0)
	arg_12_0.isFirstUnLock_ = false

	arg_12_0.lockController_:SetSelectedState("off")

	arg_12_0.unlockAnimtimer_ = SeaWarfareTools.PlayAnim(arg_12_0.unlockAnim_, "UI_QuanZhou_Navigation_MemberItem_unlock")
end

function var_0_0.ResetAnim(arg_13_0)
	arg_13_0.unlockAnim_.enabled = false

	SetActive(arg_13_0.particleGo_, false)

	if arg_13_0.unlockAnimtimer_ then
		arg_13_0.unlockAnimtimer_:Stop()

		arg_13_0.unlockAnimtimer_ = nil
	end
end

return var_0_0
