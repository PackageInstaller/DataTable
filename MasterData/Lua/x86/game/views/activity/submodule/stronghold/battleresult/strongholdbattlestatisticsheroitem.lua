local StrongholdBattleStatisticsHeroItem = class("StrongholdBattleStatisticsHeroItem", ReduxView)

function StrongholdBattleStatisticsHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function StrongholdBattleStatisticsHeroItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function StrongholdBattleStatisticsHeroItem:InitUI()
	self:BindCfgUI()

	self.haveHeroController = ControllerUtil.GetController(self.gameObject_.transform, "haveHero")
	self.reportController = ControllerUtil.GetController(self.gameObject_.transform, "report")
	self.stateController = ControllerUtil.GetController(self.gameObject_.transform, "state")
	self.friendController = ControllerUtil.GetController(self.m_addFriendBtn.transform, "state")
	self.showThumbController = ControllerUtil.GetController(self.gameObject_.transform, "showThumb")

	self.reportController:SetSelectedIndex(0)

	self.isThumbsUp = false
	self.isReport = false
end

function StrongholdBattleStatisticsHeroItem:AddUIListener()
	self:AddBtnListener(self.m_reportBtn, nil, function()
		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_STRONGHOLD_CONFIRM_REPORT_TIPS"),
			OkCallback = function()
				self.isReport = true

				self.reportController:SetSelectedIndex(2)
				CooperationAction.CooperationReport(self.player_id, (BattleFieldData:GetServerBattleID()))
			end
		})
	end)
	self:AddBtnListener(self.m_addFriendBtn, nil, function()
		self.isAddFriend = true
		self.m_addFriendBtn.interactable = false

		self.friendController:SetSelectedIndex(1)
		FriendsAction:TryToRequestToFriend(self.player_id, FriendConst.ADD_FRIEND_SOURCE.COOPERATION_RESULT)
	end)
	self:AddBtnListener(self.m_thumbsUpBtn, nil, function()
		self.isThumbsUp = true

		CooperationAction.ThumbsUp(self.player_id)
	end)
end

function StrongholdBattleStatisticsHeroItem:SetData(arg_9_1, arg_9_2, arg_9_3)
	if arg_9_1 and arg_9_2 then
		self.battleCountDamageNum_.text = tostring(arg_9_2.damage)
		self.battleCountCureNum_.text = tostring(arg_9_2.cure)
		self.battleCountDamageImg_.enabled = int64.equals(arg_9_3.damage, arg_9_2.damage) and arg_9_3.damage > int64.zero
		self.battleCountCureNumImg_.enabled = int64.equals(arg_9_3.cure, arg_9_2.cure) and arg_9_3.cure > int64.zero

		local var_9_0 = arg_9_1.playerID

		self.player_id = arg_9_1.playerID

		local var_9_1 = StrongholdData:GetStrongholdResultData(var_9_0)

		if var_9_1 then
			local var_9_2 = var_9_1.select_effect_num

			self.battleCountEffectNum_.text = var_9_1.select_effect_num
			self.battleCountEffectImg_.enabled = var_9_2 == StrongholdData:GetStrongholdResultMaxEffectNum() and var_9_2 > 0
		else
			self.battleCountEffectNum_.text = "0"
			self.battleCountEffectImg_.enabled = false
		end

		local var_9_3 = "--/--"
		local var_9_4 = BattleFieldData:GetBattleResultData().battle_record_dir
		local var_9_5 = var_9_4 and var_9_4[var_9_0]

		if var_9_4 and var_9_4[var_9_0] then
			self.m_defenseTime1.text = var_9_5[51] and manager.time:DescCdTime2(var_9_5[51]) or var_9_3
			self.m_defenseTime2.text = var_9_5[52] and manager.time:DescCdTime2(var_9_5[52]) or var_9_3
			self.m_defenseTime3.text = var_9_5[53] and manager.time:DescCdTime2(var_9_5[53]) or var_9_3

			self.haveHeroController:SetSelectedIndex(2)
		else
			self.m_defenseTime1.text = var_9_3
			self.m_defenseTime2.text = var_9_3
			self.m_defenseTime3.text = var_9_3

			self.haveHeroController:SetSelectedIndex(1)
		end

		local var_9_9 = arg_9_1.heroList[1]

		self.m_name.text = arg_9_1.nick
		self.m_lvLab.text = var_9_9.level
		self.m_heroIcon.sprite = getSpriteViaConfig("HeroIcon", SkinCfg[(var_9_9.skin == 0 or nil) and (var_9_9.id or var_9_9.skin)].picture_id)
	else
		self.haveHeroController:SetSelectedIndex(0)
	end

	self:RefreshState()
end

function StrongholdBattleStatisticsHeroItem:RefreshState()
	if PlayerData:GetPlayerInfo().userID == self.player_id then
		self.reportController:SetSelectedIndex(0)
		self.stateController:SetSelectedIndex(0)
	else
		if self.isAddFriend then
			self.m_addFriendBtn.interactable = false

			self.friendController:SetSelectedIndex(1)
		elseif table.indexof(FriendsData:GetList(1), tostring(self.player_id)) then
			self.m_addFriendLab.text = GetTips("COOPERATION_ALREADY_FRIEND")
			self.m_addFriendBtn.interactable = false

			self.friendController:SetSelectedIndex(2)
		else
			self.m_addFriendLab.text = GetTips("COOPERATION_ADD_FRIEND")
			self.m_addFriendBtn.interactable = true

			self.friendController:SetSelectedIndex(0)
		end

		if self.isThumbsUp then
			self.stateController:SetSelectedIndex(1)
		else
			self.stateController:SetSelectedIndex(2)
		end

		if self.isReport then
			self.reportController:SetSelectedIndex(2)
		else
			self.reportController:SetSelectedIndex(1)
		end
	end

	self:RefreshThumb()
end

function StrongholdBattleStatisticsHeroItem:RefreshThumb()
	local var_11_0 = CooperationData:GetRoomData()

	if var_11_0 then
		local var_11_1 = var_11_0:GetBeLikedPlayerIds(self.player_id) or {}

		if #var_11_1 > 0 then
			local var_11_2

			for iter_11_0, iter_11_1 in ipairs(var_11_1) do
				local var_11_3 = var_11_0:GetRoomPlayerData(iter_11_1)

				if var_11_3 then
					var_11_2 = var_11_2 == nil and var_11_3.nick or var_11_2 .. "," .. var_11_3.nick
				end
			end

			self.m_thumbsUpLab.text = var_11_2 or ""

			if PlayerData:GetPlayerInfo().userID == self.player_id or self.isThumbsUp then
				self.showThumbController:SetSelectedIndex(1)
			else
				self.showThumbController:SetSelectedIndex(0)
			end
		else
			self.showThumbController:SetSelectedIndex(0)
		end
	else
		self.showThumbController:SetSelectedIndex(0)
	end
end

return StrongholdBattleStatisticsHeroItem
