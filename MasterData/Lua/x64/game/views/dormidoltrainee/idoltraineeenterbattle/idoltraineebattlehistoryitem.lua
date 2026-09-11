local IdolTraineeBattleHistoryItem = class("IdolTraineeBattleHistoryItem", ReduxView)

function IdolTraineeBattleHistoryItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function IdolTraineeBattleHistoryItem:Init()
	self:InitUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddUIListener()
end

function IdolTraineeBattleHistoryItem:InitUI()
	self:BindCfgUI()

	self.firendController = self.controller:GetController("type")
	self.resultController = self.controller:GetController("result")
end

function IdolTraineeBattleHistoryItem:RefreshUI(arg_4_1)
	self.battleID = arg_4_1.battleID
	self.userID = arg_4_1.userID
	self.friendType = FriendsData:IsFriend(self.userID) and 1 or 2
	self.name_.text = arg_4_1.nick

	self.commonPortrait_:RenderHead(arg_4_1.icon)
	self.commonPortrait_:RenderFrame(arg_4_1.icon_frame)

	if self.friendType == IdolTraineeConst.friendType.friend then
		self.firendController:SetSelectedState("friend")
	elseif self.friendType == IdolTraineeConst.friendType.stranger then
		self.firendController:SetSelectedState("stranger")
	end

	if arg_4_1.battle_result == 1 then
		self.resultController:SetSelectedState(arg_4_1.is_attacker and "success" or "fail")
	elseif arg_4_1.battle_result == 2 then
		self.resultController:SetSelectedState(arg_4_1.is_attacker and "fail" or "success")
	end
end

function IdolTraineeBattleHistoryItem:AddUIListener()
	self:AddBtnListener(self.replayBtn_, nil, function()
		BackHomeCricketAction.AskBattleHistorySimpleData(self.battleID, function()
			return
		end)
	end)
	self:AddBtnListener(self.tryAgainBtn_, nil, function()
		BackHomeCricketAction:AskPvPBattleData(self.userID, (IdolTraineeData:GetCurPVPStage()))
	end)
	self.commonPortrait_:RegisteClickCallback(function()
		if self.userID then
			ForeignInfoAction:TryToCheckForeignDetailInfo(self.userID)
		end
	end)
end

function IdolTraineeBattleHistoryItem:Dispose()
	self.commonPortrait_:Dispose()

	self.commonPortrait_ = nil
	self.gameObject_ = nil
	self.transform_ = nil

	IdolTraineeBattleHistoryItem.super.Dispose(self)
end

return IdolTraineeBattleHistoryItem
