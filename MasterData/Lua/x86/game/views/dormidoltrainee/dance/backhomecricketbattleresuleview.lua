local BackHomeCricketBattleResuleView = class("BackHomeCricketBattleResuleView", ReduxView)

function BackHomeCricketBattleResuleView:UIName()
	return "Widget/BackHouseUI/IdolTrainee/IdolBattleResultPopup"
end

function BackHomeCricketBattleResuleView:UIParent()
	return manager.ui.uiPop.transform
end

function BackHomeCricketBattleResuleView:Init()
	self:InitUI()
	self:AddListeners()
end

function BackHomeCricketBattleResuleView:InitUI()
	self:BindCfgUI()

	self.scoreList = {}

	for iter_4_0, iter_4_1 in ipairs(BackHomeCricketConst.SCORE_LIST) do
		self.scoreList[iter_4_0] = BackHomeCricketBattleResuleItem.New(self["scoreItem_" .. iter_4_0])
	end

	self.resultController_ = self.mainControllerEx_:GetController("result")
	self.typeController_ = self.mainControllerEx_:GetController("type")
	self.likeController_ = self.mainControllerEx_:GetController("like")
	self.addfriendController_ = self.mainControllerEx_:GetController("addfriend")
	self.myPortrait_ = CommonHeadPortrait.New(self.myHeadItem_)
	self.enemyPortrait_ = CommonHeadPortrait.New(self.enemyHeadItem_)
end

function BackHomeCricketBattleResuleView:AddListeners()
	self:AddBtnListener(self.reviewBtn_, nil, function()
		local var_6_0 = BackHomeCricketBattleData:GetSingleBattleData()

		if self.enemyID then
			var_6_0.settleType = BackHomeCricketConst.ROOM_TYPE.Video
		end

		DanceGame.GetInstance():Restart(var_6_0)
		JumpTools.OpenPageByJump("/backHomeCricketBattleView")
	end)
	self:AddBtnListener(self.addfriendBtn_, nil, function()
		if self.enemyID then
			FriendsAction:TryToRequestToFriend(self.enemyID, FriendConst.ADD_FRIEND_SOURCE.IDOL_DANCE_GAME)
			self.addfriendController_:SetSelectedState("off")
		end
	end)
	self:AddBtnListener(self.likeBtn_, nil, function()
		if self.enemyID then
			local var_8_0 = PlayerData:GetTodaySendLikeList()

			if table.indexof(var_8_0, self.enemyID) or #var_8_0 >= GameSetting.profile_like_limitation.value[1] then
				ShowTips("PROFILE_LIKE_REPEAT_PROMPT")

				return
			end

			PlayerAction.SendLike(self.enemyID, PlayerAction.SendLikeSrc.IdolDanceGame)
			self.likeController_:SetSelectedState("on")
		end
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		BackHomeCricketBattleData:SetDanceBackCB()
		BackHomeTools:GotoBackHomeRoom(nil, true)
	end)
	self:AddBtnListener(self.retryBtn_, nil, function()
		if self.enemyID then
			local var_10_0 = BackHomeCricketBattleData:GetSingleBattleData()

			BackHomeCricketAction:AskPvPBattleData(self.enemyID, (IdolTraineeData:GetCurPVPStage()))
		else
			BackHomeCricketAction:AskPvEBattleData(BackHomeCricketBattleData:GetSingleBattleData().stageID)
		end
	end)
	self.enemyPortrait_:RegisteClickCallback(function()
		if self.enemyID then
			ForeignInfoAction:TryToCheckForeignDetailInfo(self.enemyID, true)
		end
	end)
end

function BackHomeCricketBattleResuleView:OnEnter()
	self.data = self.params_.data

	self:InitResultData()
	self:RefreshPlayerInfo()
	self:RefreshScoreList()
end

function BackHomeCricketBattleResuleView:OnTop()
	return
end

function BackHomeCricketBattleResuleView:OnExit()
	return
end

function BackHomeCricketBattleResuleView:RefreshPlayerInfo()
	local var_15_0 = PlayerData:GetPlayerInfo()

	if var_15_0 then
		self.myPortrait_:RenderHead(var_15_0.portrait)
		self.myPortrait_:RenderFrame(var_15_0.icon_frame)

		self.myName.text = var_15_0.nick
	end

	local var_15_1 = BackHomeCricketBattleData:GetSingleBattleData()

	if not var_15_1 then
		return
	end

	if var_15_1.enemyID then
		self.typeController_:SetSelectedState("game")

		self.enemyID = var_15_1.enemyID

		local var_15_2 = IdolTraineeTools:GetEnemyUserData(self.enemyID)

		self.enemyPortrait_:RenderHead(var_15_2.icon)
		self.enemyPortrait_:RenderFrame(var_15_2.icon_frame)

		self.enemyName.text = var_15_2.nick

		self.addfriendController_:SetSelectedState(FriendsData:IsFriend(self.enemyID) and "off" or "on")

		if table.indexof(PlayerData:GetTodaySendLikeList(), self.enemyID) then
			self.likeController_:SetSelectedState("on")
		else
			self.likeController_:SetSelectedState("off")
		end
	elseif var_15_1.settleType == BackHomeCricketConst.ROOM_TYPE.Video then
		self.typeController_:SetSelectedState("replay")

		local var_15_3 = IdolTraineeData:GetHistoryBattleData()[var_15_1.battleID]

		self.enemyID = var_15_3.userID

		if var_15_3.is_attacker then
			self.enemyPortrait_:RenderHead(var_15_3.icon)
			self.enemyPortrait_:RenderFrame(var_15_3.icon_frame)

			self.enemyName.text = var_15_3.nick
		else
			self.myPortrait_:RenderHead(var_15_3.icon)
			self.myPortrait_:RenderFrame(var_15_3.icon_frame)

			self.myName.text = var_15_3.nick

			self.enemyPortrait_:RenderHead(var_15_0.portrait)
			self.enemyPortrait_:RenderFrame(var_15_0.icon_frame)

			self.enemyName.text = var_15_0.nick
		end

		self.enemyID = var_15_3.userID

		self.addfriendController_:SetSelectedState(FriendsData:IsFriend(self.enemyID) and "off" or "on")

		if table.indexof(PlayerData:GetTodaySendLikeList(), self.enemyID) then
			self.likeController_:SetSelectedState("on")
		else
			self.likeController_:SetSelectedState("off")
		end
	else
		self.typeController_:SetSelectedState("pve")
	end
end

function BackHomeCricketBattleResuleView:RefreshScoreList()
	if self.scoreList then
		for iter_16_0, iter_16_1 in ipairs(self.scoreList) do
			iter_16_1:RefreshUI({
				type = BackHomeCricketConst.SCORE_LIST[iter_16_0],
				attackData = self.attackData,
				defendData = self.defendData
			})
		end
	end
end

function BackHomeCricketBattleResuleView:InitResultData()
	self.result = self.data.battle_result
	self.attackData = BackHomeCricketAction:ParseCricketSettle(self.data.attacker_data)
	self.defendData = BackHomeCricketAction:ParseCricketSettle(self.data.defender_data)

	local var_17_0 = BackHomeCricketBattleData:GetSingleBattleData()

	if var_17_0 and var_17_0.settleType == BackHomeCricketConst.ROOM_TYPE.Video then
		local var_17_1 = IdolTraineeData:GetHistoryBattleData()[var_17_0.battleID]

		if not var_17_1 or var_17_1.is_attacker then
			if self.result == 1 then
				self.resultController_:SetSelectedState("success")
				manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_enter", "")
				manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_bingo", "")
			elseif self.result == 2 then
				self.resultController_:SetSelectedState("fail")
				manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_fail", "")
				manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_error", "")
			end
		elseif self.result == 2 then
			self.resultController_:SetSelectedState("success")
			manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_enter", "")
			manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_bingo", "")
		elseif self.result == 1 then
			self.resultController_:SetSelectedState("fail")
			manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_fail", "")
			manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_error", "")
		end
	elseif self.result == 1 then
		self.resultController_:SetSelectedState("success")
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_enter", "")
		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_bingo", "")
	elseif self.result == 2 then
		self.resultController_:SetSelectedState("fail")
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_fail", "")
		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_error", "")
	end
end

function BackHomeCricketBattleResuleView:Dispose()
	self.myPortrait_:Dispose()
	self.enemyPortrait_:Dispose()

	if self.scoreList then
		for iter_18_0, iter_18_1 in pairs(self.scoreList) do
			iter_18_1:Dispose()
		end

		self.scoreList = nil
	end

	BackHomeCricketBattleResuleView.super.Dispose(self)
end

return BackHomeCricketBattleResuleView
