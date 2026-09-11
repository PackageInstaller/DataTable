local SailGameEventBaseView = class("SailGameEventBaseView", ReduxView)

function SailGameEventBaseView:UIName()
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesBaseEventPopUI"
end

function SailGameEventBaseView:UIParent()
	return manager.ui.uiPop.transform
end

function SailGameEventBaseView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SailGameEventBaseView:InitUI()
	self:BindCfgUI()
end

function SailGameEventBaseView:AddUIListener()
	if self.cancelBtn_ then
		self:AddBtnListener(self.cancelBtn_, nil, function()
			self:CancelEvent()
		end)
	end

	if self.acceptBtn_ then
		self:AddBtnListener(self.acceptBtn_, nil, function()
			self:AcceptEvent()
		end)
	end
end

function SailGameEventBaseView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.curStageIndex_ = self.params_.stageIndex
	self.eventID_ = self.params_.eventID

	self:RefreshUI()
end

function SailGameEventBaseView:RefreshUI()
	self:RefreshReward()
	self:RefreshTitle()
end

function SailGameEventBaseView:RefreshReward()
	local var_10_0 = SailGameData:GetCurGameData(activityID).eventList[self.curStageIndex_].rewardNum

	if var_10_0 > 0 then
		self.rewardIcon_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id)
		self.rewardNumText_.text = var_10_0

		SetActive(self.rewardPanelGo_, true)
	else
		SetActive(self.rewardPanelGo_, false)
	end
end

function SailGameEventBaseView:RefreshTitle()
	self.titleText_.text = SailGameEventCfg[self.eventID_].name
	self.descText_.text = SailGameEventCfg[self.eventID_].desc

	local var_11_0 = pureGetSpriteWithoutAtlas("TextureConfig/Fishing/FishPortrait/" .. SailGameEventCfg[self.eventID_].picture)

	if var_11_0 then
		self.roleIcon_.sprite = var_11_0
	end
end

function SailGameEventBaseView:CancelEvent()
	self.tipsIndex_ = nil

	SailGameAction.EventOperate(self.activityID_, self.curStageIndex_, SailGameConst.EVENT_COMMON_OPERATE.OVER)
end

function SailGameEventBaseView:AcceptEvent()
	self.tipsIndex_ = SailGameConst.GAME_COMMON_TIPS_INDEX.SUCCESS

	SailGameAction.EventOperate(self.activityID_, self.curStageIndex_, SailGameConst.EVENT_COMMON_OPERATE.OVER)
end

function SailGameEventBaseView:OnEventOperateSuccess()
	SailGameAction.SetEventEndMark(self.activityID_, self.tipsIndex_)
	SailGameTools.GoToGameView(self.activityID_)
end

return SailGameEventBaseView
