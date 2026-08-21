local var_0_0 = class("PuzzleNewRegionAnimItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	SetActive(arg_1_0.gameObject_, false)

	arg_1_0.statusController_ = ControllerUtil.GetController(arg_1_0.transform_, "status")
end

function var_0_0.PlayAnim(arg_2_0, arg_2_1)
	arg_2_0.statusController_:SetSelectedIndex(2)
	SetActive(arg_2_0.gameObject_, true)
	AnimatorTools.PlayAnimationWithCallback(arg_2_0.animator_, "XH2ndHeroPublicize_regionItem", function()
		SetActive(arg_2_0.gameObject_, false)

		if arg_2_1 then
			arg_2_1()
		end
	end)
	manager.audio:PlayEffect("minigame_activity_2_1", "minigame_activity_2_1_puzzle_reward", "")
end

return var_0_0
