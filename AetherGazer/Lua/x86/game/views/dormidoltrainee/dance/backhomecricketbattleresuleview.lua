local var_0_0 = class("BackHomeCricketBattleResuleView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/IdolTrainee/IdolBattleResultPopup"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scoreList = {}

	for iter_4_0, iter_4_1 in ipairs(BackHomeCricketConst.SCORE_LIST) do
		arg_4_0.scoreList[iter_4_0] = BackHomeCricketBattleResuleItem.New(arg_4_0["scoreItem_" .. iter_4_0])
	end

	arg_4_0.resultController_ = arg_4_0.mainControllerEx_:GetController("result")
	arg_4_0.typeController_ = arg_4_0.mainControllerEx_:GetController("type")
	arg_4_0.likeController_ = arg_4_0.mainControllerEx_:GetController("like")
	arg_4_0.addfriendController_ = arg_4_0.mainControllerEx_:GetController("addfriend")
	arg_4_0.myPortrait_ = CommonHeadPortrait.New(arg_4_0.myHeadItem_)
	arg_4_0.enemyPortrait_ = CommonHeadPortrait.New(arg_4_0.enemyHeadItem_)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.reviewBtn_, nil, function()
		local var_6_0 = DanceGame.GetInstance()
		local var_6_1 = BackHomeCricketBattleData:GetSingleBattleData()

		if arg_5_0.enemyID then
			var_6_1.settleType = BackHomeCricketConst.ROOM_TYPE.Video
		end

		var_6_0:Restart(var_6_1)
		JumpTools.OpenPageByJump("/backHomeCricketBattleView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.addfriendBtn_, nil, function()
		if arg_5_0.enemyID then
			FriendsAction:TryToRequestToFriend(arg_5_0.enemyID, FriendConst.ADD_FRIEND_SOURCE.IDOL_DANCE_GAME)
			arg_5_0.addfriendController_:SetSelectedState("off")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.likeBtn_, nil, function()
		if arg_5_0.enemyID then
			local var_8_0 = PlayerData:GetTodaySendLikeList()

			if table.indexof(var_8_0, arg_5_0.enemyID) or #var_8_0 >= GameSetting.profile_like_limitation.value[1] then
				ShowTips("PROFILE_LIKE_REPEAT_PROMPT")

				return
			end

			PlayerAction.SendLike(arg_5_0.enemyID, PlayerAction.SendLikeSrc.IdolDanceGame)
			arg_5_0.likeController_:SetSelectedState("on")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.okBtn_, nil, function()
		BackHomeCricketBattleData:SetDanceBackCB()
		BackHomeTools:GotoBackHomeRoom(nil, true)
	end)
	arg_5_0:AddBtnListener(arg_5_0.retryBtn_, nil, function()
		if arg_5_0.enemyID then
			local var_10_0 = IdolTraineeData:GetCurPVPStage()
			local var_10_1 = BackHomeCricketBattleData:GetSingleBattleData()

			BackHomeCricketAction:AskPvPBattleData(arg_5_0.enemyID, var_10_0)
		else
			local var_10_2 = BackHomeCricketBattleData:GetSingleBattleData().stageID

			BackHomeCricketAction:AskPvEBattleData(var_10_2)
		end
	end)
	arg_5_0.enemyPortrait_:RegisteClickCallback(function()
		if arg_5_0.enemyID then
			ForeignInfoAction:TryToCheckForeignDetailInfo(arg_5_0.enemyID, true)
		end
	end)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.data = arg_12_0.params_.data

	arg_12_0:InitResultData()
	arg_12_0:RefreshPlayerInfo()
	arg_12_0:RefreshScoreList()
end

function var_0_0.OnTop(arg_13_0)
	return
end

function var_0_0.OnExit(arg_14_0)
	return
end

function var_0_0.RefreshPlayerInfo(arg_15_0)
	local var_15_0 = PlayerData:GetPlayerInfo()

	if var_15_0 then
		arg_15_0.myPortrait_:RenderHead(var_15_0.portrait)
		arg_15_0.myPortrait_:RenderFrame(var_15_0.icon_frame)

		arg_15_0.myName.text = var_15_0.nick
	end

	local var_15_1 = BackHomeCricketBattleData:GetSingleBattleData()

	if not var_15_1 then
		return
	end

	if var_15_1.enemyID then
		arg_15_0.typeController_:SetSelectedState("game")

		arg_15_0.enemyID = var_15_1.enemyID

		local var_15_2 = IdolTraineeTools:GetEnemyUserData(arg_15_0.enemyID)

		arg_15_0.enemyPortrait_:RenderHead(var_15_2.icon)
		arg_15_0.enemyPortrait_:RenderFrame(var_15_2.icon_frame)

		arg_15_0.enemyName.text = var_15_2.nick

		arg_15_0.addfriendController_:SetSelectedState(FriendsData:IsFriend(arg_15_0.enemyID) and "off" or "on")

		local var_15_3 = PlayerData:GetTodaySendLikeList()

		if table.indexof(var_15_3, arg_15_0.enemyID) then
			arg_15_0.likeController_:SetSelectedState("on")
		else
			arg_15_0.likeController_:SetSelectedState("off")
		end
	elseif var_15_1.settleType == BackHomeCricketConst.ROOM_TYPE.Video then
		arg_15_0.typeController_:SetSelectedState("replay")

		local var_15_4 = IdolTraineeData:GetHistoryBattleData()[var_15_1.battleID]

		arg_15_0.enemyID = var_15_4.userID

		if var_15_4.is_attacker then
			arg_15_0.enemyPortrait_:RenderHead(var_15_4.icon)
			arg_15_0.enemyPortrait_:RenderFrame(var_15_4.icon_frame)

			arg_15_0.enemyName.text = var_15_4.nick
		else
			arg_15_0.myPortrait_:RenderHead(var_15_4.icon)
			arg_15_0.myPortrait_:RenderFrame(var_15_4.icon_frame)

			arg_15_0.myName.text = var_15_4.nick

			arg_15_0.enemyPortrait_:RenderHead(var_15_0.portrait)
			arg_15_0.enemyPortrait_:RenderFrame(var_15_0.icon_frame)

			arg_15_0.enemyName.text = var_15_0.nick
		end

		arg_15_0.enemyID = var_15_4.userID

		arg_15_0.addfriendController_:SetSelectedState(FriendsData:IsFriend(arg_15_0.enemyID) and "off" or "on")

		local var_15_5 = PlayerData:GetTodaySendLikeList()

		if table.indexof(var_15_5, arg_15_0.enemyID) then
			arg_15_0.likeController_:SetSelectedState("on")
		else
			arg_15_0.likeController_:SetSelectedState("off")
		end
	else
		arg_15_0.typeController_:SetSelectedState("pve")
	end
end

function var_0_0.RefreshScoreList(arg_16_0)
	if arg_16_0.scoreList then
		for iter_16_0, iter_16_1 in ipairs(arg_16_0.scoreList) do
			local var_16_0 = {
				type = BackHomeCricketConst.SCORE_LIST[iter_16_0],
				attackData = arg_16_0.attackData,
				defendData = arg_16_0.defendData
			}

			iter_16_1:RefreshUI(var_16_0)
		end
	end
end

function var_0_0.InitResultData(arg_17_0)
	arg_17_0.result = arg_17_0.data.battle_result
	arg_17_0.attackData = BackHomeCricketAction:ParseCricketSettle(arg_17_0.data.attacker_data)
	arg_17_0.defendData = BackHomeCricketAction:ParseCricketSettle(arg_17_0.data.defender_data)

	local var_17_0 = BackHomeCricketBattleData:GetSingleBattleData()

	if var_17_0 and var_17_0.settleType == BackHomeCricketConst.ROOM_TYPE.Video then
		local var_17_1 = IdolTraineeData:GetHistoryBattleData()[var_17_0.battleID]

		if not var_17_1 or var_17_1.is_attacker then
			if arg_17_0.result == 1 then
				arg_17_0.resultController_:SetSelectedState("success")
				manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_enter", "")
				manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_bingo", "")
			elseif arg_17_0.result == 2 then
				arg_17_0.resultController_:SetSelectedState("fail")
				manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_fail", "")
				manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_error", "")
			end
		elseif arg_17_0.result == 2 then
			arg_17_0.resultController_:SetSelectedState("success")
			manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_enter", "")
			manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_bingo", "")
		elseif arg_17_0.result == 1 then
			arg_17_0.resultController_:SetSelectedState("fail")
			manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_fail", "")
			manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_error", "")
		end
	elseif arg_17_0.result == 1 then
		arg_17_0.resultController_:SetSelectedState("success")
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_enter", "")
		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_bingo", "")
	elseif arg_17_0.result == 2 then
		arg_17_0.resultController_:SetSelectedState("fail")
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_fail", "")
		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_error", "")
	end
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0.myPortrait_:Dispose()
	arg_18_0.enemyPortrait_:Dispose()

	if arg_18_0.scoreList then
		for iter_18_0, iter_18_1 in pairs(arg_18_0.scoreList) do
			iter_18_1:Dispose()
		end

		arg_18_0.scoreList = nil
	end

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
