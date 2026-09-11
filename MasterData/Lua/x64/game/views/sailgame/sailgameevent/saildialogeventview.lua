local SailShopEventView = class("SailShopEventView", (import("game.views.sailGame.sailGameEvent.SailGameEventBaseView")))

function SailShopEventView:UIName()
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesHadesEventPopUI"
end

function SailShopEventView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
end

function SailShopEventView:AddUIListener()
	for iter_3_0 = 1, 2 do
		self:AddBtnListener(self[string.format("dialogBtn%d_", iter_3_0)], nil, function()
			self.statusController_:SetSelectedIndex(1)

			self.descText_.text = GetTips("ACTIVITY_SKADI_SEA_OSIRIS_EVENT_REPLY")
		end)
	end

	self:AddBtnListener(self.acceptBtn_, nil, function()
		self:AcceptEvent()
	end)
end

function SailShopEventView:RefreshUI()
	SailShopEventView.super.RefreshUI(self)
	self.statusController_:SetSelectedIndex(0)

	self.dialogText1_.text = GetTips("ACTIVITY_SKADI_SEA_OSIRIS_EVENT_OPTION_1")
	self.dialogText2_.text = GetTips("ACTIVITY_SKADI_SEA_OSIRIS_EVENT_OPTION_2")
end

function SailShopEventView:RefreshReward()
	local var_7_0 = ItemTools.getItemSprite(GameSetting.activity_skadi_sea_osiris_event_reward.value[1])

	if var_7_0 then
		self.rewardIcon_.sprite = var_7_0
	end

	self.rewardNumText_.text = GameSetting.activity_skadi_sea_osiris_event_reward.value[2]

	SetActive(self.rewardPanelGo_, true)
end

function SailShopEventView:AcceptEvent()
	self.tipsIndex_ = SailGameConst.GAME_COMMON_TIPS_INDEX.SUCCESS

	SailGameAction.EventOperate(self.activityID_, self.curStageIndex_, nil)
end

return SailShopEventView
