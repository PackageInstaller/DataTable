local var_0_0 = class("StrongholdBattleStatisticsHeroItem", ReduxView)

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

	arg_3_0.haveHeroController = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "haveHero")
	arg_3_0.reportController = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "report")
	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "state")
	arg_3_0.friendController = ControllerUtil.GetController(arg_3_0.m_addFriendBtn.transform, "state")
	arg_3_0.showThumbController = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "showThumb")

	arg_3_0.reportController:SetSelectedIndex(0)

	arg_3_0.isThumbsUp = false
	arg_3_0.isReport = false
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_reportBtn, nil, function()
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
	arg_4_0:AddBtnListener(arg_4_0.m_addFriendBtn, nil, function()
		arg_4_0.isAddFriend = true
		arg_4_0.m_addFriendBtn.interactable = false

		arg_4_0.friendController:SetSelectedIndex(1)
		FriendsAction:TryToRequestToFriend(arg_4_0.player_id, FriendConst.ADD_FRIEND_SOURCE.COOPERATION_RESULT)
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_thumbsUpBtn, nil, function()
		arg_4_0.isThumbsUp = true

		CooperationAction.ThumbsUp(arg_4_0.player_id)
	end)
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_1 and arg_9_2 then
		arg_9_0.battleCountDamageNum_.text = tostring(arg_9_2.damage)
		arg_9_0.battleCountCureNum_.text = tostring(arg_9_2.cure)
		arg_9_0.battleCountDamageImg_.enabled = int64.equals(arg_9_3.damage, arg_9_2.damage) and arg_9_3.damage > int64.zero
		arg_9_0.battleCountCureNumImg_.enabled = int64.equals(arg_9_3.cure, arg_9_2.cure) and arg_9_3.cure > int64.zero

		local var_9_0 = arg_9_1.playerID

		arg_9_0.player_id = var_9_0

		local var_9_1 = StrongholdData:GetStrongholdResultData(var_9_0)
		local var_9_2 = StrongholdData:GetStrongholdResultMaxEffectNum()

		if var_9_1 then
			local var_9_3 = var_9_1.select_effect_num

			arg_9_0.battleCountEffectNum_.text = var_9_3
			arg_9_0.battleCountEffectImg_.enabled = var_9_3 == var_9_2 and var_9_3 > 0
		else
			arg_9_0.battleCountEffectNum_.text = "0"
			arg_9_0.battleCountEffectImg_.enabled = false
		end

		local var_9_4 = "--/--"
		local var_9_5 = BattleFieldData:GetBattleResultData().battle_record_dir
		local var_9_6 = var_9_5 and var_9_5[var_9_0]

		if var_9_6 then
			local var_9_7 = var_9_6[51]

			arg_9_0.m_defenseTime1.text = var_9_7 and manager.time:DescCdTime2(var_9_7) or var_9_4

			local var_9_8 = var_9_6[52]

			arg_9_0.m_defenseTime2.text = var_9_8 and manager.time:DescCdTime2(var_9_8) or var_9_4

			local var_9_9 = var_9_6[53]

			arg_9_0.m_defenseTime3.text = var_9_9 and manager.time:DescCdTime2(var_9_9) or var_9_4

			arg_9_0.haveHeroController:SetSelectedIndex(2)
		else
			arg_9_0.m_defenseTime1.text = var_9_4
			arg_9_0.m_defenseTime2.text = var_9_4
			arg_9_0.m_defenseTime3.text = var_9_4

			arg_9_0.haveHeroController:SetSelectedIndex(1)
		end

		local var_9_10 = arg_9_1.heroList[1]

		arg_9_0.m_name.text = arg_9_1.nick
		arg_9_0.m_lvLab.text = var_9_10.level

		local var_9_11 = var_9_10.skin == 0 and var_9_10.id or var_9_10.skin
		local var_9_12 = SkinCfg[var_9_11]

		arg_9_0.m_heroIcon.sprite = getSpriteViaConfig("HeroIcon", var_9_12.picture_id)
	else
		arg_9_0.haveHeroController:SetSelectedIndex(0)
	end

	arg_9_0:RefreshState()
end

function var_0_0.RefreshState(arg_10_0)
	if PlayerData:GetPlayerInfo().userID == arg_10_0.player_id then
		arg_10_0.reportController:SetSelectedIndex(0)
		arg_10_0.stateController:SetSelectedIndex(0)
	else
		if arg_10_0.isAddFriend then
			arg_10_0.m_addFriendBtn.interactable = false

			arg_10_0.friendController:SetSelectedIndex(1)
		else
			local var_10_0 = FriendsData:GetList(1)

			if table.indexof(var_10_0, tostring(arg_10_0.player_id)) then
				arg_10_0.m_addFriendLab.text = GetTips("COOPERATION_ALREADY_FRIEND")
				arg_10_0.m_addFriendBtn.interactable = false

				arg_10_0.friendController:SetSelectedIndex(2)
			else
				arg_10_0.m_addFriendLab.text = GetTips("COOPERATION_ADD_FRIEND")
				arg_10_0.m_addFriendBtn.interactable = true

				arg_10_0.friendController:SetSelectedIndex(0)
			end
		end

		if arg_10_0.isThumbsUp then
			arg_10_0.stateController:SetSelectedIndex(1)
		else
			arg_10_0.stateController:SetSelectedIndex(2)
		end

		if arg_10_0.isReport then
			arg_10_0.reportController:SetSelectedIndex(2)
		else
			arg_10_0.reportController:SetSelectedIndex(1)
		end
	end

	arg_10_0:RefreshThumb()
end

function var_0_0.RefreshThumb(arg_11_0)
	local var_11_0 = CooperationData:GetRoomData()
	local var_11_1 = PlayerData:GetPlayerInfo().userID == arg_11_0.player_id

	if var_11_0 then
		local var_11_2 = var_11_0:GetBeLikedPlayerIds(arg_11_0.player_id) or {}

		if #var_11_2 > 0 then
			local var_11_3

			for iter_11_0, iter_11_1 in ipairs(var_11_2) do
				local var_11_4 = var_11_0:GetRoomPlayerData(iter_11_1)

				if var_11_4 then
					if var_11_3 == nil then
						var_11_3 = var_11_4.nick
					else
						var_11_3 = var_11_3 .. "," .. var_11_4.nick
					end
				end
			end

			arg_11_0.m_thumbsUpLab.text = var_11_3 or ""

			if var_11_1 or arg_11_0.isThumbsUp then
				arg_11_0.showThumbController:SetSelectedIndex(1)
			else
				arg_11_0.showThumbController:SetSelectedIndex(0)
			end
		else
			arg_11_0.showThumbController:SetSelectedIndex(0)
		end
	else
		arg_11_0.showThumbController:SetSelectedIndex(0)
	end
end

return var_0_0
