local var_0_0 = class("GuildActivitySPAffixRInfoItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1.gameObject
	arg_1_0.transform_ = arg_1_1

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.unlockController_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.affixID_ = arg_5_1
	arg_5_0.level_ = arg_5_2
	arg_5_0.unlock_ = arg_5_2 <= arg_5_3

	arg_5_0.unlockController_:SetSelectedState(tostring(arg_5_0.unlock_))

	arg_5_0.descText_.text = getAffixDesc({
		arg_5_0.affixID_,
		arg_5_0.level_
	})
	arg_5_0.levelText_.text = GetTips("LEVEL") .. arg_5_0.level_
end

function var_0_0.OnExit(arg_6_0)
	SetActive(arg_6_0.levelUpAnim_.gameObject, false)
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.gameObject_ = nil
	arg_7_0.transform_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.SetActive(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

function var_0_0.OnUpgrade(arg_9_0)
	SetActive(arg_9_0.levelUpAnim_.gameObject, true)

	local var_9_0 = "TalentUILevelUp"

	arg_9_0.levelUpAnim_:Play(var_9_0, -1, 0)
end

return var_0_0
