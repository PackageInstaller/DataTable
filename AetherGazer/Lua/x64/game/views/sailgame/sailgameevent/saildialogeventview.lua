local var_0_0 = import("game.views.sailGame.sailGameEvent.SailGameEventBaseView")
local var_0_1 = class("SailShopEventView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesHadesEventPopUI"
end

function var_0_1.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.statusController_ = ControllerUtil.GetController(arg_2_0.transform_, "status")
end

function var_0_1.AddUIListener(arg_3_0)
	for iter_3_0 = 1, 2 do
		arg_3_0:AddBtnListener(arg_3_0[string.format("dialogBtn%d_", iter_3_0)], nil, function()
			arg_3_0.statusController_:SetSelectedIndex(1)

			arg_3_0.descText_.text = GetTips("ACTIVITY_SKADI_SEA_OSIRIS_EVENT_REPLY")
		end)
	end

	arg_3_0:AddBtnListener(arg_3_0.acceptBtn_, nil, function()
		arg_3_0:AcceptEvent()
	end)
end

function var_0_1.RefreshUI(arg_6_0)
	var_0_1.super.RefreshUI(arg_6_0)
	arg_6_0.statusController_:SetSelectedIndex(0)

	arg_6_0.dialogText1_.text = GetTips("ACTIVITY_SKADI_SEA_OSIRIS_EVENT_OPTION_1")
	arg_6_0.dialogText2_.text = GetTips("ACTIVITY_SKADI_SEA_OSIRIS_EVENT_OPTION_2")
end

function var_0_1.RefreshReward(arg_7_0)
	local var_7_0 = GameSetting.activity_skadi_sea_osiris_event_reward.value
	local var_7_1 = ItemTools.getItemSprite(var_7_0[1])

	if var_7_1 then
		arg_7_0.rewardIcon_.sprite = var_7_1
	end

	arg_7_0.rewardNumText_.text = var_7_0[2]

	SetActive(arg_7_0.rewardPanelGo_, true)
end

function var_0_1.AcceptEvent(arg_8_0)
	arg_8_0.tipsIndex_ = SailGameConst.GAME_COMMON_TIPS_INDEX.SUCCESS

	SailGameAction.EventOperate(arg_8_0.activityID_, arg_8_0.curStageIndex_, nil)
end

return var_0_1
