local DemonChallengeAwardItem = class("DemonChallengeAwardItem", ReduxView)
local JumpTools = import("game.tools.JumpTools")

function DemonChallengeAwardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function DemonChallengeAwardItem:Init()
	self:InitUI()
	self:AddListeners()

	self.itemList_ = LuaList.New(handler(self, self.IndexItem), self.itemListGo_, CommonItem)
	self.controller_ = ControllerUtil.GetController(self.transform_, "conName")
end

function DemonChallengeAwardItem:RefreshData(arg_3_1)
	self.itemInfo_ = arg_3_1

	self:RefreshUI()
end

function DemonChallengeAwardItem:InitUI()
	self:BindCfgUI()
end

function DemonChallengeAwardItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		SubDemonChallengeAction.GetChallengeReward(self.itemInfo_.id, self.itemInfo_.activityId)
	end)
end

function DemonChallengeAwardItem:RefreshUI()
	self.levelIndex_ = table.indexof(DemonChallengeCfg.get_id_list_by_activity_id[self.itemInfo_.activityId], self.itemInfo_.id)
	self.Desctext_.text = GetI18NText(self.levelIndex_ == 1 and GetTips("CLEAR_NORMAL_DIFFICULTY") or self.levelIndex_ == 2 and GetTips("CLEAR_DIFFICULTY") or GetTips("CLEAR_EXTREME_DIFFICULTY"))

	self:RefreshState()
	self:RefreshItem()
end

function DemonChallengeAwardItem:RefreshState()
	local var_8_0 = SubDemonChallengeData:GetChallengeInfo(self.itemInfo_.activityId).challengeInfo
	local var_8_1

	if var_8_0[self.levelIndex_].challenge_state == ActivityConst.DEMON_CHALLENGE_STATE.UNFINISHED then
		var_8_1 = 0
	elseif var_8_0[self.levelIndex_].reward_state == ActivityConst.DEMON_CHALLENGE_REWARD_STATE.UNRECEIVE then
		var_8_1 = 1
	elseif var_8_0[self.levelIndex_].reward_state == ActivityConst.DEMON_CHALLENGE_REWARD_STATE.RECEIVED then
		var_8_1 = 2
	end

	self.controller_:SetSelectedState(tostring(var_8_1))
end

function DemonChallengeAwardItem:RefreshItem()
	self.rewardCfg_ = getRewardFromDropCfg(BattleHeartDemonStageCfg[DemonChallengeCfg[self.itemInfo_.id].stage_id].drop_lib_id, true)

	self.itemList_:StartScroll(#self.rewardCfg_)
end

function DemonChallengeAwardItem:IndexItem(arg_10_1, arg_10_2)
	local var_10_0 = self.rewardCfg_[arg_10_1]

	arg_10_2:RefreshData(rewardToItemTemplate(self.rewardCfg_[arg_10_1]))
	arg_10_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_10_0)
	end)
	arg_10_2:Show(true)
end

function DemonChallengeAwardItem:GetItemInfo()
	return self.itemInfo_
end

function DemonChallengeAwardItem:Dispose()
	if self.itemList_ then
		self.itemList_:Dispose()
	end

	DemonChallengeAwardItem.super.Dispose(self)
end

return DemonChallengeAwardItem
