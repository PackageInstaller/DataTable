local var_0_0 = class("SummerWaterBattleStatisticsHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.haveHeroController = ControllerUtil.GetController(arg_3_0.transform_, "haveHero")
	arg_3_0.reportController = ControllerUtil.GetController(arg_3_0.transform_, "report")
	arg_3_0.cooperationController = ControllerUtil.GetController(arg_3_0.transform_, "cooperation")
	arg_3_0.friendController = ControllerUtil.GetController(arg_3_0.transform_, "friend")
	arg_3_0.thumbController = ControllerUtil.GetController(arg_3_0.transform_, "thumb")
	arg_3_0.showThumbController = ControllerUtil.GetController(arg_3_0.transform_, "showThumb")
	arg_3_0.offlineController = ControllerUtil.GetController(arg_3_0.transform_, "offline")
	arg_3_0.isThumbsUp = false
	arg_3_0.isReport = false
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.reportBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_STRONGHOLD_CONFIRM_REPORT_TIPS"),
			OkCallback = function()
				arg_4_0.isReport = true

				arg_4_0.reportController:SetSelectedIndex(2)

				local var_6_0 = BattleFieldData:GetServerBattleID()

				CooperationAction.CooperationReport(arg_4_0.player_id, var_6_0)
			end
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.addFriendBtn_, nil, function()
		if not FriendsData:IsCanBeFriend(arg_4_0.player_id) then
			return
		end

		FriendsAction:TryToRequestToFriend(arg_4_0.player_id, FriendConst.ADD_FRIEND_SOURCE.COOPERATION_RESULT)
	end)
	arg_4_0:AddBtnListener(arg_4_0.thumbsBtn_, nil, function()
		arg_4_0.isThumbsUp = true

		CooperationAction.ThumbsUp(arg_4_0.player_id)
	end)
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_1 and arg_9_3 then
		arg_9_0.battleCountDamageNum_.text = tostring(arg_9_3.damage)
		arg_9_0.battleCountCureNum_.text = tostring(arg_9_3.cure)
		arg_9_0.battleCountHurtNum_.text = tostring(arg_9_3.hurt)
		arg_9_0.battleCountDamageImg_.enabled = int64.equals(arg_9_4.damage, arg_9_3.damage) and arg_9_4.damage > int64.zero
		arg_9_0.battleCountCureNumImg_.enabled = int64.equals(arg_9_4.cure, arg_9_3.cure) and arg_9_4.cure > int64.zero
		arg_9_0.battleCountHurtNumImg_.enabled = int64.equals(arg_9_4.hurt, arg_9_3.hurt) and arg_9_4.hurt > int64.zero
		arg_9_0.player_id = arg_9_1.playerID

		local var_9_0 = arg_9_2

		arg_9_0.nickText_.text = arg_9_1.nick
		arg_9_0.battleCountLv_.text = var_9_0.level

		local var_9_1 = var_9_0.skin == 0 and var_9_0.id or var_9_0.skin
		local var_9_2 = SkinCfg[var_9_1]

		arg_9_0.battleCountIcon_.sprite = getSpriteViaConfig("HeroIcon", var_9_2.picture_id)

		arg_9_0.haveHeroController:SetSelectedState("true")
	else
		arg_9_0.haveHeroController:SetSelectedState("false")
	end

	arg_9_0:RefreshState()
end

function var_0_0.SetIsCooperation(arg_10_0, arg_10_1)
	arg_10_0.isCooperation_ = arg_10_1
end

function var_0_0.SetCaptain(arg_11_0, arg_11_1)
	SetActive(arg_11_0.captainGo_, arg_11_1)
end

function var_0_0.SetCustomStaticData(arg_12_0, arg_12_1)
	arg_12_0.staticData_ = arg_12_1.dataDic
	arg_12_0.maxData_ = ActivitySummerWaterData:GetSettleMaxData(ActivitySummerWaterData:GetMainActivityID())
	arg_12_0.battleCountFangfanNum_.text = arg_12_0.staticData_[45] or 0
	arg_12_0.battleCountFangfanImg_.enabled = int64.equals(arg_12_0.maxData_[45] or 0, arg_12_0.staticData_[45]) and arg_12_0.maxData_[45] > 0
	arg_12_0.battleCountZjjNum_.text = arg_12_0.staticData_[59] or 0
	arg_12_0.battleCountZjjImg_.enabled = int64.equals(arg_12_0.maxData_[59] or 0, arg_12_0.staticData_[59]) and arg_12_0.maxData_[59] > 0
end

function var_0_0.RefreshState(arg_13_0)
	if PlayerData:GetPlayerInfo().userID == arg_13_0.player_id or not arg_13_0.isCooperation_ then
		arg_13_0.cooperationController:SetSelectedState("false")
	else
		arg_13_0.cooperationController:SetSelectedState("true")

		if arg_13_0.isThumbsUp then
			arg_13_0.thumbController:SetSelectedState("false")
		else
			arg_13_0.thumbController:SetSelectedState("true")
		end

		if arg_13_0.isReport then
			arg_13_0.reportController:SetSelectedState("false")
		else
			arg_13_0.reportController:SetSelectedState("true")
		end
	end

	arg_13_0:RefreshThumb()
end

function var_0_0.RefreshThumb(arg_14_0)
	local var_14_0 = CooperationData:GetRoomData()
	local var_14_1 = PlayerData:GetPlayerInfo().userID == arg_14_0.player_id

	if var_14_0 then
		local var_14_2 = var_14_0:GetBeLikedPlayerIds(arg_14_0.player_id) or {}

		if #var_14_2 > 0 then
			local var_14_3

			for iter_14_0, iter_14_1 in ipairs(var_14_2) do
				local var_14_4 = var_14_0:GetRoomPlayerData(iter_14_1)

				if var_14_4 then
					if var_14_3 == nil then
						var_14_3 = var_14_4.nick
					else
						var_14_3 = var_14_3 .. "," .. var_14_4.nick
					end
				end
			end

			arg_14_0.thumbsUpLabText_.text = var_14_3 or ""

			if var_14_1 or arg_14_0.isThumbsUp then
				arg_14_0.showThumbController:SetSelectedState("true")
			else
				arg_14_0.showThumbController:SetSelectedState("false")
			end
		else
			arg_14_0.showThumbController:SetSelectedState("false")
		end
	else
		arg_14_0.showThumbController:SetSelectedState("false")
	end
end

return var_0_0
