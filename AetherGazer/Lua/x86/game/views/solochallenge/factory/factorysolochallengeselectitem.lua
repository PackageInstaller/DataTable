local var_0_0 = import("game.views.soloChallenge.SoloChallengeSelectItem")
local var_0_1 = class("FactorySoloChallengeSelectItem", var_0_0)

function var_0_1.Init(arg_1_0)
	arg_1_0.affixList_ = {}

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()

	arg_1_0.heroSelectController = ControllerUtil.GetController(arg_1_0.transform_, "heroSelect")
	arg_1_0.lockStateController_ = ControllerUtil.GetController(arg_1_0.transform_, "lock")
	arg_1_0.indexController_ = ControllerUtil.GetController(arg_1_0.transform_, "index")
end

function var_0_1.RefreshTitle(arg_2_0)
	arg_2_0.indexController_:SetSelectedState(tostring(arg_2_0.selectHeroPos_))
end

function var_0_1.RefreshEnemyUI(arg_3_0)
	local var_3_0 = ActivitySoloChallengeCfg[arg_3_0.activityID_].boss_id_list

	arg_3_0.bossIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/MardukUI/boss/solo384x172/" .. var_3_0[arg_3_0.selectHeroPos_])
end

return var_0_1
